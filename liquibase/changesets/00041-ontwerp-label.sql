--liquibase formatted sql
--changeset joachim:00041

UPDATE StatusValuesDes SET label = 'In ontwerp' WHERE iddes = 1 and langid = 'dut';
