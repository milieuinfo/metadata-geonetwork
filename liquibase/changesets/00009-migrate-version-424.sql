--liquibase formatted sql
--changeset joachim:00009
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/publication/profilePublishMetadata', 'Reviewer', 0, 12021, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/publication/profileUnpublishMetadata', 'Reviewer', 0, 12022, 'n');