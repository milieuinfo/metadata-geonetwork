--liquibase formatted sql
--changeset joachim:00033

-- see v440/migrate-default.sql
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/batchediting/accesslevel', 'Editor', 0, 12020, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/batchediting/accesslevel');

-- see v441/migrate-default.sql
UPDATE Settings SET value='4.4.1' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
