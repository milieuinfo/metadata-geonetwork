--liquibase formatted sql
--changeset fxprunayre:00015

DELETE FROM isolanguagesdes
  WHERE langid NOT IN (
    SELECT id FROM languages
  );

DELETE FROM isolanguagesdes
  WHERE iddes NOT IN (
    SELECT id FROM isolanguages WHERE code IN (
      SELECT id FROM languages));

DELETE FROM isolanguages
  WHERE code NOT IN (SELECT id FROM languages);
