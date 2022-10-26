# Database migration

## The starting point

```sql
SELECT value FROM settings WHERE name LIKE '%platform/version%';
-- = 3.8.3
```

## The SQL migration 

Run [migration script](before-startup.sql) to move from 3.8.3 to 4.2.2.

Start the application. While start hibernate update the database model (eg. creating new sequences per table).

After startup, run the [after startup script](after-startup.sql) to update sequences to current values and migrate status.

TODO:
* Check encryption

```sql 
UPDATE settings SET value = '' WHERE encrypted = 'y';
```

## Admin console

If you don't have account, add a default `admin`/`admin` account:

```sql 
INSERT INTO Users (id, username, password, name, surname, profile, kind, organisation, security, authtype, isenabled) VALUES  (1,'admin','46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2','admin','admin',0,'','','','', 'y');
```


Update the following depending on host environment in Admin > Settings:
* update host and port

## API migration


TODO: 
* DateTimeMigrationTask
* Attachements


## Questions

* Some metadata status refer to non existing records?

```sql
SELECT * FROM metadatastatus WHERE metadataid NOT IN (SELECT id FROM metadata);
```
