--liquibase formatted sql
--changeset joachim:00028

UPDATE Settings SET value='4.4.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
