-- migration schemas
do
$$
  begin
    raise notice 'Creating migration schemas.';
    create schema if not exists migrationgn3mdc;
    create schema if not exists migrationgn3mdv;
    create schema if not exists migration;
  end
$$;

-- now do this manually:
-- === DBEAVER ===
-- 1. import table migration.dp_nodp (DP/noDP.xslx), set all attribute types to 'varchar'
-- 2. import table migration.geosecure (Organisaties.xslx), set all attribute types to 'varchar'
-- 3. import table migration.harvestersettingsmdv (harvestersettings.csv), set all attribute types to 'varchar' (exclude the id columns)
-- 4. migrate all tables (excluding the metadataxml, organisationtocopy) to migrationgn3mdc and migrationgn3mdv respectively
-- - take care to lower case the table names (see 'mapping rules' during export)
-- See ticket https://agiv.visualstudio.com/Metadata/_workitems/edit/186586 (attachments) for the necessary files.

-- fill up the migration folder (M=~/workdata/metadata/migration.gn3)
-- > copy the mdc/mdv metadata_data folders to local (mkdir -p $M/datadir/{new,mdc,mdv})
-- > copy the harvesting images (mkdir -p images/harvesting/{mdc,mdv}) 
-- > copy the static folder to the migration folder ($M/static)
-- before proceeding with the files, need to have run the migration SQL


-- check whether we are finished before proceeding
select count(*) from migrationgn3mdc.metadata; -- 1862 (12/02/2024)
select count(*) from migrationgn3mdv.metadata; -- 10413 (12/02/2024)

do
$$
  begin
    raise notice 'Creating geosecuremapped table.';
    drop table if exists migration.geosecuremapped;
    create table migration.geosecuremapped as
    with geo as (select split_part("unieke identifier", ':', 2) ovo,
                        "organisatie contact id"::integer       geosecureid,
                        "naam organisatie"                      orgname,
                        *
                 from migration.geosecure g
                 where "organisatie contact id"::integer >= 0
                   and split_part("unieke identifier", ':', 1) = 'ovo'),
         geoplus as (select geo.geosecureid,
                            geo.orgname,
                            ovo,
                            (select id
                             from migrationgn3mdc.groups gm
                             where gm.referrer = geo.geosecureid
                               and gm.referrer is not null) mdcid,
                            (select id
                             from migrationgn3mdv.groups gm
                             where gm.referrer = geo.geosecureid
                               and gm.referrer is not null) mdvid
                     from geo)
    select *
    from geoplus
    where mdcid is not null
       or mdvid is not null;

    -- add groups that were not in the geosecure list, but were in our instances, with records
    raise notice 'Handle groups not in the geosecure list.';
    with mdvmissing as (select g.id mdvid, g."name" orgname
                        from migrationgn3mdv."groups" g
                        where not exists (select mdvid from migration.geosecuremapped g2 where g2.mdvid = g.id)
                          and exists (select * from migrationgn3mdv.metadata m where m.groupowner = g.id)
                          and g.id > 1)
    insert
    into migration.geosecuremapped (mdvid, orgname)
    select mdvid, orgname
    from mdvmissing;
    with mdcmissing as (select g.id mdcid, g."name" orgname
                        from migrationgn3mdc."groups" g
                        where not exists (select mdcid from migration.geosecuremapped g2 where g2.mdcid = g.id)
                          and exists (select * from migrationgn3mdc.metadata m where m.groupowner = g.id)
                          and g.id > 1)
    insert
    into migration.geosecuremapped (mdcid, orgname)
    select mdcid, orgname
    from mdcmissing;

    -- update previously found groups that did not yet have an ovo code, but were mentioned in the geosecure table
    raise notice 'Give ovocode-less groups an ovocode.';
    with pre as (select g."organisatie contact id"                     geosecureid,
                        max(split_part(g."unieke identifier", ':', 2)) ovo,
                        g."naam organisatie"                           orgname
                 from migration.geosecure g
                        inner join migration.geosecuremapped g2
                                   on g."naam organisatie" = g2.orgname and g2.ovo is null and
                                      g2.geosecureid is null and g."status" = 'Actief'
                 group by g."organisatie contact id", g."naam organisatie")
    update migration.geosecuremapped m
    set geosecureid = pre.geosecureid::integer,
        ovo         = pre.ovo
    from pre
    where pre.orgname = m.orgname
      and m.geosecureid is null
      and m.ovo isnull;

    -- one group that was empty, no ovo code, ... clean up
    raise notice 'Cleanup erroneous groups.';
    delete from migration.geosecuremapped where orgname = 'GDI-MercatorNet' and mdvid = 290;
    update migration.geosecuremapped
    set mdcid = (select mdcid from migration.geosecuremapped where ovo = '0454064819' and mdcid is not null)
    where ovo = '0454064819'
      and mdcid is null;
    delete from migration.geosecuremapped where ovo = '0454064819' and mdvid is null;

    -- give the groups new ids
    raise notice 'Give groups new ids.';
    ALTER TABLE migration.geosecuremapped
      ADD id integer NULL;
    update migration.geosecuremapped
    set id = t.rownr
    from (select row_number() over () + 99 rownr, * from migration.geosecuremapped) t
    where t.ovo = migration.geosecuremapped.ovo;

    -- precreate empty table
    raise notice 'Create migration.users table.';
    drop table if exists migration.users;
    create table migration.users as
    select * from public.users u where id is null;

    raise notice 'Add the users, based on email.';
    with usernames as (select lower(email) email
                       from migrationgn3mdc.users u
                              inner join migrationgn3mdc.email e on e.user_id = u.id
                       union
                       select lower(email) email
                       from migrationgn3mdv.users u
                              inner join migrationgn3mdv.email e on e.user_id = u.id)
    insert
    into migration.users (id, username)
        (select row_number() over () + 99 id, email from usernames);

    raise notice 'Add users details from mdc and mdv.';
    update migration.users mu
    set surname       = u.surname,
        name          = u.name,
        isenabled     = u.isenabled,
        lastlogindate = u.lastlogindate,
        nodeid        = 'srv'
    from migrationgn3mdc.users u
           inner join migrationgn3mdc.email e on u.id = e.user_id
    where lower(mu.username) = lower(e.email)
      and mu.username is not null;
    update migration.users mu
    set surname       = u.surname,
        name          = u.name,
        isenabled     = u.isenabled,
        lastlogindate = u.lastlogindate,
        nodeid        = 'srv'
    from migrationgn3mdv.users u
           inner join migrationgn3mdv.email e on u.id = e.user_id
    where lower(mu.username) = lower(e.email)
      and mu.username is not null;

    raise notice 'Prepare migration.metadata table.';
    drop table if exists migration.metadata;
    create table migration.metadata as
    select * from public.metadata m where false;
    ALTER TABLE migration.metadata
      ADD mdvid integer NULL;
    ALTER TABLE migration.metadata
      ADD mdcid integer NULL;

    -- insert the MDC records
    raise notice 'Copy the metadata.';
    insert into migration.metadata (data, changedate, createdate, displayorder, doctype, extra, popularity, rating,
                                    root, schemaid, title, istemplate, isharvested, harvesturi, harvestuuid, uuid,
                                    mdcid, source, id, groupowner, owner) (select data                                                           data,
                                                                                  changedate,
                                                                                  createdate,
                                                                                  displayorder,
                                                                                  doctype,
                                                                                  extra,
                                                                                  popularity,
                                                                                  rating,
                                                                                  root,
                                                                                  schemaid,
                                                                                  title,
                                                                                  istemplate,
                                                                                  isharvested,
                                                                                  harvesturi,
                                                                                  harvestuuid,
                                                                                  uuid,
                                                                                  id as                                                          mdcid,
                                                                                  (select value from settings where name = 'system/site/siteId') source,
                                                                                  row_number() over () + 99                                      id,
                                                                                  (select g.id
                                                                                   from migration.geosecuremapped g
                                                                                   where g.mdcid = m.groupowner)                                 groupowner,
                                                                                  (select nu.id
                                                                                   from migrationgn3mdc.users ou
                                                                                          inner join migrationgn3mdc.email oe on ou.id = oe.user_id
                                                                                          inner join migration.users nu on lower(oe.email) = lower(nu.username)
                                                                                   where ou.id = m.owner)                                        "owner"
                                                                           from migrationgn3mdc.metadata m
                                                                           where isharvested = 'n'
                                                                             and istemplate = 'n');
    -- insert the MDV records
    insert into migration.metadata (data, changedate, createdate, displayorder, doctype, extra, popularity, rating,
                                    root, schemaid, title, istemplate, isharvested, harvesturi, harvestuuid, uuid,
                                    mdvid, source, id, groupowner, owner) (select data                                                            data,
                                                                                  changedate,
                                                                                  createdate,
                                                                                  displayorder,
                                                                                  doctype,
                                                                                  extra,
                                                                                  popularity,
                                                                                  rating,
                                                                                  root,
                                                                                  schemaid,
                                                                                  title,
                                                                                  istemplate,
                                                                                  isharvested,
                                                                                  harvesturi,
                                                                                  harvestuuid,
                                                                                  uuid,
                                                                                  id as                                                           mdvid,
                                                                                  (select value from settings where name = 'system/site/siteId')  source,
                                                                                  row_number() over () + (select max(id) from migration.metadata) id,
                                                                                  (select g.id
                                                                                   from migration.geosecuremapped g
                                                                                   where g.mdvid = m.groupowner)                                  groupowner,
                                                                                  (select nu.id
                                                                                   from migrationgn3mdv.users ou
                                                                                          inner join migrationgn3mdv.email oe on ou.id = oe.user_id
                                                                                          inner join migration.users nu on lower(oe.email) = lower(nu.username)
                                                                                   where ou.id = m.owner)                                         "owner"
                                                                           from migrationgn3mdv.metadata m
                                                                           where isharvested = 'n'
                                                                             and istemplate = 'n');

    -- set group owner to 'digitaal vlaanderen' where records don't have a group owner
    raise notice 'Set Digitaal Vlaanderen as owner of ownerless records.';
    update migration.metadata
    set groupowner = (select id from migration.geosecuremapped where ovo = 'OVO002949')
    where groupowner is null;

    -- figure out what the last metadatastatus is... preparation to actually map to the records and to the user
    raise notice 'Create metadatastatus table and populate.';
    drop table if exists migration.metadatastatus;
    create table migration.metadatastatus as
    with lastchangedate as (select metadataid, max(changedate) lastchangedate
                            from migrationgn3mdc.metadatastatus ms
                            group by ms.metadataid),
         laststatus as (select l.metadataid,
                               l.lastchangedate,
                               (select max(ms.statusid)
                                from migrationgn3mdc.metadatastatus ms
                                where ms.metadataid = l.metadataid
                                  and ms.changedate = l.lastchangedate) maxstatusid,
                               (select max(ms.userid)
                                from migrationgn3mdc.metadatastatus ms
                                where ms.metadataid = l.metadataid
                                  and ms.changedate = l.lastchangedate) maxuserid
                        from lastchangedate l)
    select ls.lastchangedate   changedate,
           m.id                metadataid,
           ls.maxstatusid      oldstatus,
           sv.name             oldstatusname,
           statusmapping.newid newstatus,
           sv2.name            newstatusname,
           ls.maxuserid        olduserid,
           true                mdc
    from laststatus ls
           inner join migration.metadata m on ls.metadataid = m.mdcid
           left join (values (0, 1),
                             (1, 1),
                             (2, 2),
                             (3, 3),
                             (4, 4),
                             (5, 5),
                             (6, 1),
                             (7, 4),
                             (8, 8),
                             (9, 5),
                             (10, 2),
                             (11, 2),
                             (12, 2),
                             (13, 2),
                             (14, 2)) statusmapping (oldid, newid) on statusmapping.oldid = ls.maxstatusid
           left join migrationgn3mdc.statusvalues sv on ls.maxstatusid = sv.id
           left join public.statusvalues sv2 on statusmapping.newid = sv2.id;

    with lastchangedate as (select metadataid, max(changedate) lastchangedate
                            from migrationgn3mdv.metadatastatus ms
                            group by ms.metadataid),
         laststatus as (select l.metadataid,
                               l.lastchangedate,
                               (select max(ms.statusid)
                                from migrationgn3mdv.metadatastatus ms
                                where ms.metadataid = l.metadataid
                                  and ms.changedate = l.lastchangedate) maxstatusid,
                               (select max(ms.userid)
                                from migrationgn3mdv.metadatastatus ms
                                where ms.metadataid = l.metadataid
                                  and ms.changedate = l.lastchangedate) maxuserid
                        from lastchangedate l)
    insert
    into migration.metadatastatus (changedate, metadataid, oldstatus, oldstatusname, newstatus, newstatusname,
                                   olduserid, mdc)
    select ls.lastchangedate   changedate,
           m.id                metadataid,
           ls.maxstatusid      oldstatus,
           sv.name             oldstatusname,
           statusmapping.newid newstatus,
           sv2.name            newstatusname,
           ls.maxuserid        olduserid,
           false               mdc
    from laststatus ls
           inner join migration.metadata m on ls.metadataid = m.mdvid
           left join (values (0, 1), (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1)) statusmapping (oldid, newid)
                     on statusmapping.oldid = ls.maxstatusid
           left join migrationgn3mdv.statusvalues sv on ls.maxstatusid = sv.id
           left join public.statusvalues sv2 on statusmapping.newid = sv2.id;

    --select * from migrationgn3mdc.statusvalues s;
    --0	0	unknown		y	workflow
    --1	2	draft	recordUserAuthor	y	workflow
    --2	8	approved	recordUserAuthor	y	workflow
    --3	9	retired	recordUserAuthor	y	workflow
    --4	3	submitted	recordProfileReviewer	y	workflow
    --5	5	rejected	recordUserAuthor	y	workflow
    --6	1	justcreated		y	workflow
    --7	4	submittedforagiv		y	workflow
    --8	6	approvedbyagiv		y	workflow
    --9	7	rejectedbyagiv		y	workflow
    --10	10	retiredforagiv		y	workflow
    --11	12	removedforagiv		y	workflow
    --12	13	removed		y	workflow
    --13	11	rejectedforretire		y	workflow
    --14	14	rejectedforremove		y	workflow

    --select * from migrationgn3mdv.statusvalues s;
    --0	0	unknown		y	workflow
    --1	1	draft	recordUserAuthor	y	workflow
    --2	3	approved	recordUserAuthor	y	workflow
    --3	5	retired	recordUserAuthor	y	workflow
    --4	2	submitted	recordProfileReviewer	y	workflow
    --5	4	rejected	recordUserAuthor	y	workflow
    --6	5	justcreated		y	workflow

    --select * from public.statusvalues s;
    --0	0	unknown		y	workflow
    --1	1	draft	recordUserAuthor	y	workflow
    --2	3	approved	recordUserAuthor	y	workflow
    --3	5	retired	recordUserAuthor	y	workflow
    --4	2	submitted	recordProfileReviewer	y	workflow
    --5	4	rejected		y	workflow
    --8	0	approved_for_published	recordUserAuthor	y	workflow
    --10	0	submitted_for_retired	recordUserAuthor	y	workflow
    --11	0	submitted_for_removed	recordUserAuthor	y	workflow
    --12	0	removed	recordUserAuthor	y	workflow
    --13	0	rejected_for_retired	recordUserAuthor	y	workflow
    --14	0	rejected_for_removed	recordUserAuthor	y	workflow
  end
$$;


-- ===== START =====
-- prep target env
-- 1. scale down geonetwork / apirecordsservice
-- 2. drop schemas public / liquibase
do
$$
  begin
    raise notice 'Creating necessary schemas.';
    create schema if not exists public;
    create schema if not exists liquibase;
  end
$$;
-- 3. now run liquibase to get a fresh GN4 db (execute-on-env.sh)

do
$$
  declare
    debug bool := true;
  begin
    raise notice 'Start copying migration data to actual tables.';

    raise notice 'Truncate target tables where applicable.';
    delete from public.email where user_id > 10;
    delete from public.useraddress where userid > 10;
    delete from public.address where id > 10;
    delete from public.usergroups where true;
    delete from public.users where id > 10;
    truncate table public.metadata cascade;
    truncate table public.metadatastatus cascade;
    truncate table public.operationallowed cascade;
    truncate table public.harvestersettings cascade;
    delete from public.groupsdes where iddes > 99;
    delete from public.groups where id > 99;

    raise notice 'Copy users.';
    insert into public.users (id, isenabled, lastlogindate, name, organisation, profile, nodeid, surname, username,
                              password)
      (select id,
              isenabled,
              lastlogindate,
              name,
              organisation,
              5,
              nodeid,
              surname,
              username,
              md5(random()::text)
       from migration.users);

    raise notice 'Copy emails.';
    insert into public.email (user_id, email) (select id, username from public.users);

    raise notice 'Copy groups.';
    insert into public.groups (id, orgcode, name, vltype) (select id, ovo, orgname, 'metadatavlaanderen'
                                                           from migration.geosecuremapped);
    insert into public.groups (id, orgcode, name, vltype) (select (select max(id) from public.groups) + row_number() over (),
                                                                  orgcode,
                                                                  'DataPublicatie ' || name,
                                                                  'datapublicatie'
                                                           from public.groups);
    insert into public.groupsdes (iddes, label, langid)
      (select id, name, unnest(array ['fre', 'dut', 'eng', 'ger']) lang from public.groups where id > 10);

    raise notice 'Copy metadata.';
    insert into public.metadata (id, data, changedate, createdate, displayorder, doctype, extra, popularity, rating,
                                 root, schemaid, title, istemplate, isharvested, harvesturi, harvestuuid, groupowner,
                                 owner, source, uuid)
      (select id,
              data,
              changedate,
              createdate,
              displayorder,
              doctype,
              extra,
              popularity,
              rating,
              root,
              schemaid,
              title,
              istemplate,
              isharvested,
              harvesturi,
              harvestuuid,
              groupowner,
              owner,
              source,
              uuid
       from migration.metadata);
  end
$$;

--raise notice 'Copy metadatastatus.';
with thedata as (select metadataid,
                        newstatus,
                        changedate,
                        case
                          when mdc
                            then (select distinct uu.id
                                  from migration.metadatastatus m
                                         inner join migrationgn3mdc.users u on m.olduserid = u.id
                                         inner join migrationgn3mdc.email e on e.user_id = u.id
                                         inner join migration.users uu on lower(uu.username) = lower(e.email)
                                  where u.id = ms.olduserid)
                          else (select distinct uu.id
                                from migration.metadatastatus m
                                       inner join migrationgn3mdv.users u on m.olduserid = u.id
                                       inner join migrationgn3mdv.email e on e.user_id = u.id
                                       inner join migration.users uu on lower(uu.username) = lower(e.email)
                                where u.id = ms.olduserid)
                          end userid
                 from migration.metadatastatus ms)
insert
into public.metadatastatus (metadataid, statusid, changedate, userid, changemessage, owner, uuid)
  (select metadataid,
          newstatus,
          changedate,
          userid,
          'gn3migration',
          userid,
          (select uuid from migration.metadata m where m.id = thedata.metadataid)
   from thedata);

do
$$
  declare
    debug bool := true;
  begin
    raise notice 'Assign records to DP groups.';
    with dprecords as (select m2.id
                       from migration.dp_nodp dn
                              inner join migrationgn3mdc.metadata m on dn.uuid = m."uuid"
                              inner join migration.metadata m2 on m2.mdcid = m.id
                       where dn."dp/nodp" = 'DP'),
         dpmapping as (select mdv.id mdvid, dp.id dpid
                       from groups mdv
                              inner join groups dp on mdv.orgcode = dp.orgcode
                       where mdv.vltype = 'metadatavlaanderen'
                         and dp.vltype = 'datapublicatie')
    update public.metadata m
    set groupowner = (select dpid from dpmapping where mdvid = m.groupowner)
    where m.id in (select id from dprecords);
  end
$$;


-- post-process cleanup
do
$$
  begin
    raise notice 'Publish records with status 8';
    insert into public.operationallowed (groupid, metadataid, operationid)
      (select 1 groupid, m.metadataid, unnest(array [0,1,3,5,6]) operationid
       from public.metadatastatus m
       where m.statusid = 2);

    raise notice 'Create a status for records that do not have one yet - this enables the workflow.';
    insert into public.metadatastatus (id, metadataid, owner, userid, uuid, statusid, changemessage, changedate)
      (select row_number() over () + (select max(id) from public.metadatastatus) id,
              m.id                                                               metadataid,
              m.owner,
              m.owner                                                            userid,
              m.uuid,
              1                                                                  statusid,
              'gn3migration-enableworkflow'                                      changemessage,
              to_char(now(), 'YYYY-MM-DDThh24:MI:SS')                            changedate
       from public.metadata m
       where not exists (select * from public.metadatastatus ms where ms.metadataid = m.id));
  end
$$;



-- =========
-- =========
-- WARNING: SET ENVIRONMENT
-- =========
-- =========
do
$$
  declare
    _env      varchar := 'bet'; -- dev/bet/prd
    _hostname varchar := (select case
                                   when _env = 'prd' then 'metadata.vlaanderen.be'
                                   when _env = 'bet' then 'metadata.beta-vlaanderen.be'
                                   when _env = 'dev' then 'metadata.dev-vlaanderen.be' end);
  begin
    raise notice 'Executing change on environment %, hostname %', _env, _hostname;

    -- blanket replace for specific metadatacenter refs
    update metadata
    set data = replace(data,
                       'https://metadata.vlaanderen.be/metadatacenter/srv/dut/resources.get',
                       'https://' || _hostname || '/srv/dut/resources.get');

    raise notice 'Update hostname for metadatacenter attachment links.';
    update metadata
    set data = regexp_replace(data,
                              '<gco:CharacterString>https://metadata.vlaanderen.be/metadatacenter([^<]*?/attachments/[^<]*?)</gco:CharacterString>',
                              '<gco:CharacterString>https://' || _hostname || '\1</gco:CharacterString>',
                              'g')
    where isharvested = 'n';
    raise notice ' > Remaining records: %', (select count(*)
                                             from metadata
                                             where isharvested = 'n'
                                               and data ~
                                                   '.*<gco:CharacterString>https://metadata.vlaanderen.be/metadatacenter([^<]*?/attachments/[^<]*?)</gco:CharacterString>.*');

    -- resources.get is not functional anymore - replace by attachment syntax through api
    raise notice 'Updating deprecated resources.get syntax for attachments.';
    update metadata
    set data = regexp_replace(data,
                              '<gco:CharacterString>https://metadata.vlaanderen.be/srv/dut/resources.get\?uuid=([^<]+?)&amp;fname=([^<]+?)</gco:CharacterString>',
                              '<gco:CharacterString>https://' || _hostname ||
                              '/srv/api/records/\1/attachments/\2</gco:CharacterString>',
                              'g');
    raise notice ' > Remaining records: %', (select count(uuid)
                                             from metadata
                                             where data ~
                                                   '<gco:CharacterString>https://metadata.vlaanderen.be/srv/dut/resources.get\?uuid=([^<]+?)&amp;fname=([^<]+?)</gco:CharacterString>');

    -- another broken type of resources.get
    -- https://metadata.vlaanderen.be/srv/dut/resources.get?uuid=288be5c6-d70d-45d3-a31d-265c86cc9202/attachments/VHA_zones_metadata_1406814837398.jpg
    raise notice 'Updating resources.get with missing fname.';
    update metadata
    set data = regexp_replace(data,
                              '<gco:CharacterString>https://metadata.vlaanderen.be/srv/dut/resources.get\?uuid=([^<]+?)/attachments/([^<]+?)</gco:CharacterString>',
                              '<gco:CharacterString>https://' || _hostname ||
                              '/srv/api/records/\1/attachments/\2</gco:CharacterString>',
                              'g');
    raise notice ' > Remaining records: %', (select count(uuid)
                                             from metadata
                                             where data ~
                                                   '<gco:CharacterString>https://[^/]+/srv/dut/resources.get\?uuid=([^<]+?)/attachments/([^<]+?)</gco:CharacterString>');

    -- any hostname, but not the right format (resources.get uuid= fname=) to thumbnails
    raise notice 'Update malfunctioning resources.get link to attachment.';
    update metadata
    set data = regexp_replace(data,
                              '<gco:CharacterString>https://([^/]+?)/srv/dut/resources.get\?uuid=([^&]+)&amp;fname=([^<]+?)</gco:CharacterString>',
                              '<gco:CharacterString>https://' || _hostname ||
                              '/srv/api/records/\2/attachments/\3</gco:CharacterString>',
                              'g')
    where isharvested = 'n';
    raise notice ' > Remaining matches: %',(select count(*)
                                            from metadata
                                            where isharvested = 'n'
                                              and regexp_like(data,
                                                              '.*<gco:CharacterString>https://([^/]+?)/srv/dut/resources.get\?uuid=([^&]+?)&amp;fname[^<]+?</gco:CharacterString>.*'));

    -- do MDC initially, perhaps there's some native ones as well?
    -- > old https://metadata.vlaanderen.be/metadatacenter/srv/eng/thesaurus.download?ref=external.theme.gemet
    -- > new https://metadata.dev-vlaanderen.be/srv/api/registries/vocabularies/external.theme.GDI-Vlaanderen-trefwoorden
    raise notice 'Fix mdc thesaurus.download hrefs.';
    update metadata
    set data = regexp_replace(data,
                              'xlink:href="https://metadata.vlaanderen.be/metadatacenter/srv/[a-z]{3}/thesaurus.download\?ref=([^"]+?)"',
                              'xlink:href="https://' || _hostname || '/srv/api/registries/vocabularies/\1"',
                              'g')
    where isharvested = 'n';
    raise notice ' > Remaining matches: %',(select count(*)
                                            from metadata
                                            where isharvested = 'n'
                                              and regexp_like(data,
                                                              '.*xlink:href="https://metadata.vlaanderen.be/metadatacenter/srv/[a-z]{3}/thesaurus.download\?ref=([^"]+?)".*'));


    -- catalog.search wrong urls
    -- > old https://metadata.vlaanderen.be/metadatacenter/srv/dut/catalog.search#/metadata/54877caf-3024-42b6-ad98-91d8434b9cda
    -- > new https://metadata.dev-vlaanderen.be/srv/dut/catalog.search#/metadata/b8e76bbd-8fa0-4804-a3a2-8cdeeed88896
    raise notice 'Fix catalog.search refs to /metadatacenter.';
    update metadata
    set data = regexp_replace(data,
                              '"https://metadata.vlaanderen.be/metadatacenter/srv/dut/catalog.search#/metadata/([^"]+?)"',
                              '"https://' || _hostname || '/srv/dut/catalog.search#/metadata/\1"',
                              'g')
    where isharvested = 'n';
    raise notice ' > Remaining matches: %',(select count(*)
                                            from metadata
                                            where isharvested = 'n'
                                              and regexp_like(data,
                                                              '.*"https://metadata.vlaanderen.be/metadatacenter/srv/dut/catalog.search#/metadata/([^"]+?)".*'));

    -- metadatacenter references in, e.g., operatesOn
    -- <srv:operatesOn uuidref="A64FA5C6-E988-4018-8B36-EE41B1BD316A" xlink:href="https://metadata.vlaanderen.be/metadatacenter/srv/dut/csw?request=GetRecordById&amp;service=CSW&amp;constraintLanguage=CQL_TEXT&amp;version=2.0.2&amp;resultType=results&amp;ElementSetName=full&amp;typenames=csw:Record&amp;id=C4FF31DC-9AB2-46A4-848B-4C345BBDDC57&amp;OUTPUTSCHEMA=http://www.isotc211.org/2005/gmd" />
    raise notice 'Replace metadatacenter CSW refs by correct hostname.';
    update metadata
    set data = regexp_replace(
      data,
      'https://metadata.vlaanderen.be/metadatacenter(/srv/dut/csw\?request=GetRecordById&amp;service=CSW&amp;constraintLanguage=CQL_TEXT&amp;version=2.0.2&amp;resultType=results&amp;ElementSetName=full&amp;typenames=csw:Record&amp;id=[^&]+&amp;OUTPUTSCHEMA=http://www.isotc211.org/2005/gmd)',
      'https://' || _hostname || '\1',
      'g')
    where isharvested = 'n';
    raise notice ' > Remaining matches: %',(select count(*)
                                            from metadata
                                            where isharvested = 'n'
                                              and regexp_like(data,
                                                              'https://metadata.vlaanderen.be/metadatacenter(/srv/dut/csw\?request=GetRecordById&amp;service=CSW&amp;constraintLanguage=CQL_TEXT&amp;version=2.0.2&amp;resultType=results&amp;ElementSetName=full&amp;typenames=csw:Record&amp;id=[^&]+&amp;OUTPUTSCHEMA=http://www.isotc211.org/2005/gmd)'));

    -- fix featureCatalogueCitation hrefs that use the wrong outputSchema (should be http://www.isotc211.org/2005/gfc)
    -- <gmd:featureCatalogueCitation uuidref="2B178D0C-7898-47B9-B134-29AC8C268287" xlink:href="https://metadata.vlaanderen.be/metadatacenter/srv/dut/csw?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=http://www.isotc211.org/2005/gmd&amp;elementSetName=full&amp;id=2B178D0C-7898-47B9-B134-29AC8C268287">
    raise notice 'Fix feature catalogueCitation hrefs.';
    update metadata
    set data = regexp_replace(data,
                              '(<gmd:featureCatalogueCitation uuidref="[^">]+?" xlink:href="https://)metadata.vlaanderen.be/metadatacenter(/srv/dut/csw\?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=)http://www.isotc211.org/2005/gmd(&amp;elementSetName=full&amp;id=[^">]+?">)',
                              '\1' || _hostname || '\2http://www.isotc211.org/2005/gfc\3',
                              'g')
    where isharvested = 'n';
    raise notice ' > Remaining matches: %',(select count(*)
                                            from metadata
                                            where isharvested = 'n'
                                              and regexp_like(data,
                                                              '(<gmd:featureCatalogueCitation uuidref="[^">]+?" xlink:href="https://)metadata.vlaanderen.be/metadatacenter(/srv/dut/csw\?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=)http://www.isotc211.org/2005/gmd(&amp;elementSetName=full&amp;id=[^">]+?">)'));
    raise notice 'Fix feature catalogueCitation hrefs (same as above, but with empty tag).';
    update metadata
    set data = regexp_replace(data,
                              '(<gmd:featureCatalogueCitation uuidref="[^">]+?" xlink:href="https://)metadata.vlaanderen.be/metadatacenter(/srv/dut/csw\?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=)http://www.isotc211.org/2005/gmd(&amp;elementSetName=full&amp;id=[^">]+?"\s*/>)',
                              '\1' || _hostname || '\2http://www.isotc211.org/2005/gfc\3',
                              'g')
    where isharvested = 'n';
    -- orig 27 leftovers: {50134be3-f0cd-47c5-8f6e-4a0936287947,889a8851-a366-4487-b61c-4778356e4cec,a8ea3875-e233-4d3c-8c15-f39c960fb938,db0dca59-1838-4a5a-b9bd-9e2b943e6cf7,74b2534d-a8e6-4e4b-99d7-987b4829ff8d,fa7ee6f6-940a-4995-801a-7f40a445172e,8ad91579-8807-47ef-8c1e-e13706db4015,748e1c89-7f0d-4d2f-ab03-7989ad98e4bd,5f6ec1f9-97e9-4a48-91b7-2146b428ce86,a61ddb05-7a72-4115-b9ce-8276b4674d6d,dd399003-7fde-4c95-9d0c-237f5ff198ad,8bd65b06-8f35-4506-9e73-1ba480878e40,0c3aa132-8b95-4ed0-9457-85f1a5b9663b,e3fdf3a5-aae7-4db6-b212-690b377f31d7,b850e91e-c024-49a6-85e9-fcd006072e38,6d09cff0-fb56-4e66-ad6d-15b7a019da32,a1d60920-ed59-4546-808a-e13fd0f754d7,4a5369f9-0d53-4f4e-8e53-eb30cbceec35,1bff5f22-a81b-407f-9df7-cb0dbf81e1c3,6631ea6e-7958-4f0e-a83f-593010313b2d,96d40e2d-ee0e-4ddb-8619-abe1c3f5693d,c8488765-f84a-4ad3-99bd-e16cbd105516,bb3ef134-407a-4aa0-9390-4948cc53957b,f7342071-e411-48a6-b338-fba8f97dbb3f,ed53f693-fc9c-432d-ad8f-f84625f06bb0,eccd774f-83b0-488c-9ba5-97efa724e13e,e1461107-9b15-4775-bdf5-7c92baa99ed0}
    raise notice ' > Remaining matches: %',(select count(*)
                                            from metadata
                                            where isharvested = 'n'
                                              and regexp_like(data,
                                                              '(<gmd:featureCatalogueCitation uuidref="[^">]+?" xlink:href="https://)metadata.vlaanderen.be/metadatacenter(/srv/dut/csw\?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=)http://www.isotc211.org/2005/gmd(&amp;elementSetName=full&amp;id=[^">]+?"\s*/>)'));
  end
$$;


-- harvester settings
do
$$
  begin
    -- first copy the mdc harvestersettings as they are
    insert into harvestersettings (id, encrypted, name, value, parentid)
      (select id, 'n', name, value, parentid from migrationgn3mdc.harvestersettings);

    -- below is the procedure that we used to do the export of the harvestersettings, for the non-ogcwxs configs that were manually set up by Stijn in beta gn4
    -- create table migration.harvestersettingscopy as (select * from migrationgn3mdv.harvestersettings h);
    -- delete from migration.harvestersettingscopy h where parentid = 1 and value = 'ogcwxs' and name = 'node';
    -- delete from migration.harvestersettingscopy where id = 191753; -- 'Joachim Test'
    -- keep doing this till nothing remains
    -- delete from migration.harvestersettingscopy where parentid is not null and parentid not in (select id from migration.harvestersettingscopy);
    -- now export the copy table to a csv for use in the migration
    -- select * from migration.harvestersettingscopy h;

    -- now take mdv harvestersettings as well, but bump the ids
    insert into harvestersettings (id, encrypted, name, value, parentid)
      (select id + (select max(id) from migration.harvestersettingsmdv),
              'n',
              name,
              value,
              parentid + (select max(id) from migration.harvestersettingsmdv)
       from migration.harvestersettingsmdv h);
    -- reassign the top level node for the other settings
    update harvestersettings set parentid = 1 where parentid = 1 + (select max(id) from migration.harvestersettingsmdv);
    -- remove the mdv top level node
    delete
    from harvestersettings
    where id = 1 + (select max(id) from migration.harvestersettingsmdv) and name = 'harvesting';
    -- update the dcat xslt
    update harvestersettings
    set value = 'schema:dcat2:convert/fromSPARQL-DCAT-with-open-keywords'
    where value = 'schema:dcat2:convert/fromSPARQL-DCAT';

    -- now apply modifications
    update harvestersettings
    set value = (select id from users where username = 'geraldine.nolf@vlaanderen.be')
    where name = 'ownerUser';

    update harvestersettings
    set value = (select id from users where username = 'geraldine.nolf@vlaanderen.be')
    where name = 'ownerId';

 -- update ownerGroup only for ogcwxs harvesters

    update harvestersettings h
    set value = (select id from groups where name = 'Digitaal Vlaanderen')
    from harvestersettings h1
           join harvestersettings h2 on h1.id = h2.parentid
           join harvestersettings h3 on h2.id = h3.parentid
    where h1.name = 'node'
      and h1.value = 'ogcwxs'
      and h3.name = 'ownerGroup'
      and h.id = h3.id
      


    update harvestersettings set encrypted = 'y' where name = 'password';

    -- update validate only for ogcwxs harvesters
    update harvestersettings h
    set value = 'COMPUTE_VALIDATION_AFTER_HARVEST'
    from harvestersettings h1
           join harvestersettings h2 on h1.id = h2.parentid
           join harvestersettings h3 on h2.id = h3.parentid
    where h1.name = 'node'
      and h1.value = 'ogcwxs'
      and h3.name = 'validate'
      and h.id = h3.id;

    -- update importxslt only for ogcwxs harvesters
    update harvestersettings h
    set value = 'none'
    from harvestersettings h1
           join harvestersettings h2 on h1.id = h2.parentid
           join harvestersettings h3 on h2.id = h3.parentid
    where h1.name = 'node'
      and h1.value = 'ogcwxs'
      and h3.name = 'importxslt'
      and h.id = h3.id;

    -- update logo only for ogcwxs harvesters
    update harvestersettings h
    set value = 'MD_VL_Klein.png'
    from harvestersettings h1
           join harvestersettings h2 on h1.id = h2.parentid
           join harvestersettings h3 on h2.id = h3.parentid
    where h1.name = 'node'
      and h1.value = 'ogcwxs'
      and h3.name = 'icon'
      and h.id = h3.id;


    -- beta modified run time harvesters (only ogcwxs)
    -- start 17:00, every minute
    with cte as
           (select h3.id                                   as id,
                   h3.value                                as oldValue,
                   concat(
                     '0 ',
                     mod(row_number() over (order by (select 1)), 60), -- minutes
                     ' ',
                     (row_number() over (order by (select 1))) / 60 + 17, -- hours (starts with 17 UTC time)
                     ' ? * *'
                   )                                       as newValue,
                   row_number() over (order by (select 1)) as rownNr
            from harvestersettings h1
                   join harvestersettings h2 on h1.id = h2.parentid
                   join harvestersettings h3 on h2.id = h3.parentid
            where h1.name = 'node'
              and h1.value = 'ogcwxs'
              and h3.name = 'every'
            order by h1.id)
    update harvestersettings h
    set value = newValue
    from cte
    where h.id = cte.id;

    perform setval('harvest_history_id_seq', (SELECT max(id) + 1 FROM harvesthistory));
    perform setval('harvester_setting_id_seq', (SELECT max(id) + 1 FROM harvestersettings));
  end
$$;

-- fix language code, necessary fix
do
$$
  begin
    update metadata
    set data = replace(data,
                       '<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands</gmd:LanguageCode>',
                       '<gmd:LanguageCode codeList="https://www.loc.gov/standards/iso639-2/" codeListValue="dut">Nederlands</gmd:LanguageCode>')
    where data like
          '%<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands</gmd:LanguageCode>%'
      and isharvested = 'n';
    update metadata
    set data = replace(data,
                       '<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands; Vlaams</gmd:LanguageCode>',
                       '<gmd:LanguageCode codeList="https://www.loc.gov/standards/iso639-2/" codeListValue="dut">Nederlands; Vlaams</gmd:LanguageCode>')
    where data like
          '%<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands; Vlaams</gmd:LanguageCode>%'
      and isharvested = 'n';
  end
$$;

-- reset sequences, execute after all modifications were performed
do
$$
  begin
    perform setval('address_id_seq', (SELECT max(id) + 1 FROM address));
    perform setval('files_id_seq', (SELECT max(id) + 1 FROM files));
    perform setval('group_id_seq', (SELECT max(id) + 1 FROM groups));
    perform setval('gufkey_id_seq', (SELECT max(id) + 1 FROM guf_keywords));
    perform setval('gufrat_id_seq', (SELECT max(id) + 1 FROM guf_rating));
    perform setval('harvest_history_id_seq', (SELECT max(id) + 1 FROM harvesthistory));
    perform setval('harvester_setting_id_seq', (SELECT max(id) + 1 FROM harvestersettings));
    perform setval('inspire_atom_feed_id_seq', (SELECT max(id) + 1 FROM inspireatomfeed));
    perform setval('iso_language_id_seq', (SELECT max(id) + 1 FROM isolanguages));
    perform setval('link_id_seq', (SELECT max(id) + 1 FROM links));
    perform setval('linkstatus_id_seq', (SELECT max(id) + 1 FROM linkstatus));
    perform setval('mapserver_id_seq', (SELECT max(id) + 1 FROM mapservers));
    perform setval('metadata_category_id_seq', (SELECT max(id) + 1 FROM categories));
    perform setval('metadata_filedownload_id_seq', (SELECT max(id) + 1 FROM metadatafiledownloads));
    perform setval('metadata_fileupload_id_seq', (SELECT max(id) + 1 FROM metadatafileuploads));
    perform setval('metadata_id_seq', (SELECT max(id) + 1 FROM metadata));
    perform setval('metadata_identifier_template_id_seq', (SELECT max(id) + 1 FROM metadataidentifiertemplate));
    perform setval('metadatastatus_id_seq', (SELECT max(id) + 1 FROM metadatastatus));
    perform setval('operation_id_seq', (SELECT max(id) + 1 FROM operations));
    perform setval('rating_criteria_id_seq', (SELECT max(id) + 1 FROM guf_ratingcriteria));
    perform setval('schematron_criteria_id_seq', (SELECT max(id) + 1 FROM schematroncriteria));
    perform setval('schematron_id_seq', (SELECT max(id) + 1 FROM schematron));
    perform setval('selection_id_seq', (SELECT max(id) + 1 FROM selections));
    perform setval('status_value_id_seq', (SELECT max(id) + 1 FROM statusvalues));
    perform setval('user_id_seq', (SELECT max(id) + 1 FROM users));
    perform setval('user_search_id_seq', (SELECT max(id) + 1 FROM usersearch));
  end
$$;



-- MANUAL
-- 1. execute 186360-gn4-thumbnail-migration.kt
-- 2. copy the new folder
--   - remove the folder from the target pod (rm -rf /geonetwork-data/data)
--   - copy the generated `new` folder to the target pod, execute in metadata_data folder
--     - kubectl --cluster pre-md-cluster-aks get pod -n bet | grep geonetwork
--     - kubectl -n bet cp . $gnpod:/geonetwork-data/data
-- 3. copy the harvester logos from two folders (~/workdata/metadata/migration.gn3/images/harvesting/mdv)
--   - kubectl -n dev cp . $gnpod:/geonetwork-data/resources/images/harvesting/
-- 4. copy the logos folder
--   - kubectl -n dev cp . $gnpod:/geonetwork-data/resources/images/logos/
-- 5. import templates in geonetwork

-- TODO
-- > figure out records that are 'draft' but publicly available, these should be put to 'published / approved'
-- > is thesaurus correctly migrated?
--   > https://metadata.dev-vlaanderen.be/srv/eng/thesaurus.download?ref=external.theme.gemet
--   > https://metadata.vlaanderen.be/metadatacenter/srv/eng/thesaurus.download?ref=external.theme.gemet
-- > modify a user to upper case email, then log in again
-- > foreign keys for: metadatastatus, operationallowed
-- > what about groups that could not be found in geosecure?

-- TEST
-- static thumbnails:
-- >  https://metadata.dev-vlaanderen.be/srv/dut/catalog.search#/metadata/B4F95D00-67E7-488A-9B51-8A6EC8204A4A
-- > check that there's no overlapping groups
--   - select * from migration.geosecuremapped g where mdcid is not null and mdvid is not null and geosecureid is null;
--   - select * from migration.geosecuremapped g;
