--liquibase formatted sql
--changeset joachim:00023

-- Update translations for status values
UPDATE StatusValuesDes SET label = 'Entwurf' WHERE iddes = 1 AND langid = 'ger';
UPDATE StatusValuesDes SET label = 'Genehmigt' WHERE iddes = 2 AND langid = 'ger';
UPDATE StatusValuesDes SET label = 'Übermittelt' WHERE iddes = 4 AND langid = 'ger';
UPDATE StatusValuesDes SET label = 'Abgelehnt' WHERE iddes = 5 AND langid = 'ger';
