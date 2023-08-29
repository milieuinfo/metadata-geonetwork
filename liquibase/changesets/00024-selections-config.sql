--liquibase formatted sql
--changeset fxprunayre:00024

DELETE FROM selectionsdes WHERE iddes = (SELECT id FROM selections WHERE name = 'WatchList');
DELETE FROM selections WHERE name = 'WatchList';
