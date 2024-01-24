# Migration Geonetwork 3 to Geonetwork 4

The following actions need to be taken when migrating to Geonetwork 4.

## languageCode codeList

Make sure the languageCode is defined by the right codeList. [Related PR](https://agiv.visualstudio.com/Metadata/_workitems/edit/178751/).

Database updates:
```sql
update metadata set
  data = replace(data, '<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands</gmd:LanguageCode>', '<gmd:LanguageCode codeList="https://www.loc.gov/standards/iso639-2/" codeListValue="dut">Nederlands</gmd:LanguageCode>')
where data like '%<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands</gmd:LanguageCode>%';
update metadata set
  data = replace(data, '<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands; Vlaams</gmd:LanguageCode>', '<gmd:LanguageCode codeList="https://www.loc.gov/standards/iso639-2/" codeListValue="dut">Nederlands; Vlaams</gmd:LanguageCode>')
where data like '%<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands; Vlaams</gmd:LanguageCode>%';

-- check other faulty occurrences?
select * from metadata where data like '%codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode"%';
```

## Tools needed for the migration

- DBeaver
- kubectl

## Migration steps

### 1. Copy raw data from old node to a new schema in GN 4 database

- Create 2 new schemas `migrationgn3mdc` and `migrationgn3mdv` and `migration` in the GN 4 database
- In both of these schema, imports the tables `email`, `groups`, `metadata`, `metadatastatus`, `statusvalues`, `usergroups`, `user` using the export functionality of DBeaver
- Create a new table `geosecure` from the [Organizaties.xsls](assets/Organisaties.xlsx) document, containing the mapping between PROD Geosecure ID's and OVO codes

```SQL
-- prep temporary schema
create schema migrationgn3mdc;
create schema migrationgn3mdv;
create schema migration;
```
### 2. Pre-create the groups

Create a unique list of all groups with their OVO code, Geosecure ID, technical ID in MDC and technical ID in MDV.  
For groups without Geosecure ID or OVO code, augment them using the `geosecure` filtered on organization name.  

Insert that list into a new table `geosecuremapped`.

```SQL
-- migrate: email / groups / metadata / metadatastatus / statusvalues / usergroups / users
-- > mdc:groups > gn3mdcgroups
-- > mdv:groups > gn3mdvgroups

-- open issues
-- > what about groups that could not be found in geosecure?

select count(*) from migrationgn3mdc.metadata gm;

-- group migration - create a table that has a mapping of geosecure groups to their original mdc and mdv groups
with geo as (
    select split_part("Unieke identifier", ':', 2) ovo, "Organisatie Contact Id"::integer geosecureid, "Naam organisatie" orgname, *
    from migration.geosecure g where "Organisatie Contact Id"::integer >= 0 and split_part("Unieke identifier", ':', 1) = 'ovo'
), geoplus as (
    select geo.geosecureid, geo.orgname, ovo,
           (select id from migrationgn3mdc.groups gm where gm.referrer = geo.geosecureid and gm.referrer is not null) mdcid,
           (select id from migrationgn3mdv.groups gm where gm.referrer = geo.geosecureid and gm.referrer is not null) mdvid
    from geo)
select * into migration.geosecuremapped from geoplus where mdcid is not null or mdvid is not null;

-- are there groups with the same referrer? geosecureid?
-- select referrer from migrationgn3mdv.groups group by referrer having count(*) > 1;
-- select referrer from migrationgn3mdc.groups group by referrer having count(*) > 1;

-- add groups that were not in the geosecure list, but were in our instances, with records
with mdvmissing as (
    select g.id mdvid, g."name" orgname
    from migrationgn3mdv."groups" g
    where
        not exists (select mdvid from migration.geosecuremapped g2 where g2.mdvid = g.id) and
        exists (select * from migrationgn3mdv.metadata m where m.groupowner = g.id)
      and g.id > 1
) insert into migration.geosecuremapped (mdvid, orgname) select mdvid, orgname from mdvmissing;
with mdcmissing as (
    select g.id mdcid, g."name" orgname
    from migrationgn3mdc."groups" g
    where
        not exists (select mdcid from migration.geosecuremapped g2 where g2.mdcid = g.id) and
        exists (select * from migrationgn3mdc.metadata m where m.groupowner = g.id)
      and g.id > 1
) insert into migration.geosecuremapped (mdcid, orgname) select mdcid, orgname from mdcmissing;

-- check that there's no overlapping groups
-- select * from migration.geosecuremapped g where mdcid is not null and mdvid is not null and geosecureid is null;

-- select g."Organisatie Contact Id" geosecureid, split_part(g."Unieke identifier", ':', 2) ovo, g."Naam organisatie" orgname, *
-- from migration.geosecure g inner join migration.geosecuremapped g2 on g."Naam organisatie" = g2.orgname and g2.ovo is null and g2.geosecureid is null and g."Status" = 'Actief';

-- update previously found groups that did not yet have an ovo code, but were mentioned in the geosecure table
with pre as (
    select g."Organisatie Contact Id" geosecureid, max(split_part(g."Unieke identifier", ':', 2)) ovo, g."Naam organisatie" orgname
    from migration.geosecure g inner join migration.geosecuremapped g2 on g."Naam organisatie" = g2.orgname and g2.ovo is null and g2.geosecureid is null and g."Status" = 'Actief'
    group by g."Organisatie Contact Id", g."Naam organisatie"
)
update migration.geosecuremapped m set geosecureid = pre.geosecureid::integer, ovo = pre.ovo
from pre
where pre.orgname = m.orgname and m.geosecureid is null and m.ovo isnull;

-- one group that was empty, no ovo code, ... clean up
delete from migration.geosecuremapped where orgname = 'GDI-MercatorNet' and mdvid = 290;
update migration.geosecuremapped set mdcid = (select mdcid from migration.geosecuremapped where ovo = '0454064819' and mdcid is not null) where ovo = '0454064819' and mdcid is null;
delete from migration.geosecuremapped where ovo = '0454064819' and mdvid is null;
```

### 3. Pre-create users

With ACM/IDM, users are identified based on their email address (to be later modified for stable ID ideally provided by ACM/IDM).  
Create a `migrations.users` tables with an added `mdvid` and `mdcid` column.  
Based on email address, merged users from MDC & MDV and insert them with their corresponding ID into the `migration.users` tables, making sure the username is modified to now be the email address.  
Users with no metadata owned are skipped for the sake of reducing eventual manual fix as much as possible, they should be recreated automatically at first login.  

Multiple users with the same email address are present in GN3. Since we now rely on the mail address to map users together from old to new, these users will be merged in the process.
Technical users's ID is re-generated based on an incrementing number starting from 100.

```SQL

```

### 4. Pre-create metadata

Create a `migration.metadata` table and insert all metadata from both environments filtering out the harvested and template records.  
Metadata `owner` and `groupowner` are mapped to their corresponding new ID's.
At this stage, all metadata are assigned to the "DV" group. We don't have a split just yet.  

For the status, since GN3 MDV & GN3 MDC and GN4 all uses a different set of workflow status, we must map every old status to new ones.  
To simplify the process, only 3 possible mapping will be possible: 

- All status before the "approved and published" should be set to "draft" and non-public
- The "approved and published" and all submission or rejection for status changes is mapped to "approved and published" and the record is published
- The "un-published" records are mapped to "un-published" and are non-public

### 5. Import all the pre-created data

TODO

### 6. DP & non-DP groups

- For each group, create a new DP variant of the group
- Based on the CSV document attached to the ticket [#186360](https://agiv.visualstudio.com/Metadata/_workitems/edit/186360), assigne each metadata to the correct group variant

### Thumbnail

- TODO
- Update metadata XML content to fix thumbnail URL based on target environment
