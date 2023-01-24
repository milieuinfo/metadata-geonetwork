# Liquibase

A database versioning tool. It applies a set of changes to a given database and keeps track which changesets have been applied.

- Make it easy to keep environments in sync
- Include in a pipeline, automated deployments
- Provide a clean dev environment easily

# Initial run

Make sure you have a clean database:
- delete/create schema 'public' (not necessary if geonetwork hasn't started yet)
- create schema 'liquibase'

Afterwards, run `mvn liquibase:update` in the folder `liquibase/`.

# Sync data from Azure

Before moving completely to postgres we need to be able to sync data from the Azure SQL databases into our Postgres database.

Work in progress: figure out a process that works well.

1. Create a postgresql database with an empty `public` schema.
2. In `liquibase/`, run `mvn liquibase:update` to generate the current dev database.
3. Truncate all relevant tables (see script below), which impacts the following:
    - "address" 
    - "email"
    - "guf_rating"
    - "guf_rating"
    - "guf_userfeedback_keyword"
    - "guf_userfeedbacks"
    - "guf_userfeedbacks_guf_rating"
    - "metadata"
    - "metadatacateg"
    - "metadatadraft"
    - "metadatafileuploads"
    - "metadatafiledownloads"
    - "users"
    - "useraddress"
    - "usergroups"
    - "usersavedselections"
    - "usersearch"
    - "usersearch_group"
    - "usersearchdes"
5. Copy the content of an Azure SQL Geonetwork database.
   - Use dBeaver, connect to both databases (source: AzureSQL, target: Postgres).  
   - Select all as source tables the truncated tables (see above)
     - Click `export data`
     - Export target: `Database table(s)`
     - Skip `create` actions. 

## Truncate relevant tables

```sql
truncate metadata cascade;
truncate users cascade;
truncate address cascade;
truncate metadatafileuploads cascade;
truncate metadatafiledownloads cascade;
```

## Update sequence values
Also see file `after-startup.sql`.
Note that in Postgres, there is no direct link between the primary key and the sequence. It's handled by Hibernate (?).

```sql
SELECT setval('address_id_seq', (SELECT max(id) + 1 FROM address));
SELECT setval('csw_server_capabilities_info_id_seq', (SELECT max(idfield) FROM cswservercapabilitiesinfo));
SELECT setval('files_id_seq', (SELECT max(id) + 1 FROM files));
SELECT setval('group_id_seq', (SELECT max(id) + 1 FROM groups));
SELECT setval('gufkey_id_seq', (SELECT max(id) + 1 FROM guf_keywords));
SELECT setval('gufrat_id_seq', (SELECT max(id) + 1 FROM guf_rating));
SELECT setval('harvest_history_id_seq', (SELECT max(id) + 1 FROM harvesthistory));
SELECT setval('harvester_setting_id_seq', (SELECT max(id) + 1 FROM harvestersettings));
SELECT setval('inspire_atom_feed_id_seq', (SELECT max(id) + 1 FROM inspireatomfeed));
SELECT setval('iso_language_id_seq', (SELECT max(id) + 1 FROM isolanguages));
SELECT setval('link_id_seq', (SELECT max(id) + 1 FROM links));
SELECT setval('linkstatus_id_seq', (SELECT max(id) + 1 FROM linkstatus));
SELECT setval('mapserver_id_seq', (SELECT max(id) + 1 FROM mapservers));
SELECT setval('metadata_category_id_seq', (SELECT max(id) + 1 FROM categories));
SELECT setval('metadata_filedownload_id_seq', (SELECT max(id) + 1 FROM metadatafiledownloads));
SELECT setval('metadata_fileupload_id_seq', (SELECT max(id) + 1 FROM metadatafileuploads));
SELECT setval('metadata_id_seq', (SELECT max(id) + 1 FROM metadata));
SELECT setval('metadata_identifier_template_id_seq', (SELECT max(id) + 1 FROM metadataidentifiertemplate));
SELECT setval('operation_id_seq', (SELECT max(id) + 1 FROM operations));
SELECT setval('rating_criteria_id_seq', (SELECT max(id) + 1 FROM guf_ratingcriteria));
SELECT setval('schematron_criteria_id_seq', (SELECT max(id) + 1 FROM schematroncriteria));
SELECT setval('schematron_id_seq', (SELECT max(id) + 1 FROM schematron));
SELECT setval('selection_id_seq', (SELECT max(id) + 1 FROM selections));
SELECT setval('status_value_id_seq', (SELECT max(id) + 1 FROM statusvalues));
SELECT setval('user_id_seq', (SELECT max(id) + 1 FROM users));
SELECT setval('user_search_id_seq', (SELECT max(id) + 1 FROM usersearch));
```