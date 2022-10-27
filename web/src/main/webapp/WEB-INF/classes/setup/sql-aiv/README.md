# Database migration

## The starting point

```sql
SELECT value FROM settings WHERE name LIKE '%platform/version%';
-- = 3.8.3
```


## The SQL migration 

For Metadata Vlaanderen, run [before-startup-mv.sql](before-startup-mv.sql) first.

Run [migration script](before-startup.sql) to move from 3.8.3 to 4.2.2.

Start the application. While starting, hibernate update the database model (eg. creating new sequences per table).

After startup, run the [after startup script](after-startup.sql) to update sequences to current values and migrate status.

Copy data directory to the new application. Then run [after-datadirectory-move.sql](after-datadirectory-move.sql) to update attachments URLs.

## Admin console

If you don't have account, add a default `admin`/`admin` account:

```sql 
INSERT INTO Users (id, username, password, name, surname, profile, kind, organisation, security, authtype, isenabled) VALUES  (1,'admin','46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2','admin','admin',0,'','','','', 'y');
```

Update the following depending on host environment in Admin > Settings:
* update host and port (important if you want to use the OpenAPI test page http://localhost:8080/geonetwork/doc/api - restart is needed)
* reset password (proxy/mail/...)




## API migration

* Remove unused language - keep only dut, fre, ger, eng
  * After the script check remaining languages in http://localhost:8080/geonetwork/srv/eng/admin.console#/settings/languages
* Remove GeoNetwork default categories

  * Check if any records attached to categories (and if any unassigned them)
  http://localhost:8080/geonetwork/srv/eng/catalog.edit#/board?sortBy=dateStamp&sortOrder=desc&isTemplate=%5B%22y%22,%22n%22%5D&resultType=manager&from=1&to=30&languageStrategy=searchInAllLanguages&any=q(_exists_:cat)

  * After the script, check that there is no category anymore http://localhost:8080/geonetwork/srv/eng/admin.console#/classification/categories


## Questions

* Some metadata status refer to non existing records (only in metadata center db)?

```sql
SELECT * FROM metadatastatus WHERE metadataid NOT IN (SELECT id FROM metadata);
```

* The dump contains strange column

```sql
COPY public.metadata (id, data, changedate, createdate, displayorder, doctype, extra, popularity, rating, root, schemaid, title, istemplate, isharvested, harvesturi, harvestuuid, groupowner, owner, source, uuid, "[data]", "[source]"

ALTER TABLE settings DROP COLUMN "[position]";

```

* For metadata Vlaanderen, error on startup due to unknown harvester. Make GeoNetwork more robust in that case cf. https://github.com/geonetwork/core-geonetwork/pull/6642

```
java.nio.file.NoSuchFileException: /data/dev/gn/aiv/web/src/main/webapp/xsl/xml/harvesting/dcatap.xsl
```
