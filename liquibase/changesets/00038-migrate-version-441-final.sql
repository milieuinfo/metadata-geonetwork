--liquibase formatted sql
--changeset joachim:00038

-- see v441/migrate-default.sql
UPDATE Settings SET value='4.4.1' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';
