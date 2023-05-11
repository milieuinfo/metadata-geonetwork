--liquibase formatted sql
--changeset joachim:00016 runAlways:true

-- the schematron tables are deleted whenever liquibase runs - so far this seems fine
-- the tables are populated when geonetwork is booting
truncate table schematron cascade;
