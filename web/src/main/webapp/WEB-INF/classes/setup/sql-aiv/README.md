# Database migration

## The starting point

```sql
SELECT value FROM settings WHERE name LIKE '%platform/version%';
-- = 3.8.3
```


## The SQL migration 

For Metadata Vlaanderen run [before-startup-mv.sql](before-startup-mv.sql) first.

Run [migration script](before-startup.sql) to move from 3.8.3 to 4.2.2.

Start the application. While start hibernate update the database model (eg. creating new sequences per table).

After startup, run the [after startup script](after-startup.sql) to update sequences to current values and migrate status.


## Admin console

If you don't have account, add a default `admin`/`admin` account:

```sql 
INSERT INTO Users (id, username, password, name, surname, profile, kind, organisation, security, authtype, isenabled) VALUES  (1,'admin','46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2','admin','admin',0,'','','','', 'y');
```

Update the following depending on host environment in Admin > Settings:
* update host and port
* reset password (proxy/mail/...)

## API migration


TODO: 
* DateTimeMigrationTask
* Attachements


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
