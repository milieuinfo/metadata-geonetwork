--liquibase formatted sql
--changeset fxprunayre:00027

ALTER TABLE Languages DROP COLUMN isdefault;
ALTER TABLE spg_page ALTER COLUMN link TYPE text;

UPDATE Settings SET value='4.2.6' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
