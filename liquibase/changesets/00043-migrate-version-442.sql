--liquibase formatted sql
--changeset joachim:00043-migrate-version-442

-- see v441/migrate-default.sql
ALTER TABLE groups ALTER COLUMN name TYPE varchar(255);
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/pdfReport/headerLogoFileName', '', 0, 12508, 'y' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/pdfReport/headerLogoFileName');

-- see v442/migrate-default.sql
UPDATE Settings SET value='4.4.2' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('region/getmap/useGeodesicExtents', 'false', 2, 9591, 'n');
-- done in 00041: ALTER TABLE public.spg_page ADD icon varchar NULL;
