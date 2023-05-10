--liquibase formatted sql
--changeset joachim:00011

-- custom statusvalues
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (8,'approved_for_published','y', 0, 'workflow', 'recordUserAuthor');
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (10,'submitted_for_retired','y', 0, 'workflow', 'recordUserAuthor');
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (11,'submitted_for_removed','y', 0, 'workflow', 'recordUserAuthor');
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (12,'removed','y', 0, 'workflow', 'recordUserAuthor');
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (13,'rejected_for_retired','y', 0, 'workflow', 'recordUserAuthor');
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (14,'rejected_for_removed','y', 0, 'workflow', 'recordUserAuthor');

-- translations
UPDATE StatusValuesDes SET label = 'Ontwerp' WHERE iddes = 1 and langid = 'dut';
UPDATE StatusValuesDes SET label = 'Goedgekeurd en gepubliceerd' WHERE iddes = 2 and langid = 'dut';
UPDATE StatusValuesDes SET label = 'Gedepubliceerd' WHERE iddes = 3 and langid = 'dut';
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (8, 'dut','Klaar voor publicatie');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (10,'dut','Ingediend voor depubliceren');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (11,'dut','Ingediend voor verwijderen');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (12,'dut','Verwijderd');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (13,'dut','Afgekeurd voor depubliceren');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (14,'dut','Afgekeurd voor verwijderen');

INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (8, 'eng','Ready for publication by Digitaal Vlaanderen');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (10,'eng','Submitted for un-publishing');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (11,'eng','Submitted for removal');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (12,'eng','Deleted');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (13,'eng','Rejected by Digitaal Vlaanderen validator and not unpublished');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (14,'eng','Rejected by Digitaal Vlaanderen validator and not deleted');

INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (8, 'fre','Prêt pour publication par Digitaal Vlaanderen');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (10,'fre','Soumis pour dépublication');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (11,'fre','Soumis à l''enlèvement');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (12,'fre','Enlevé');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (13,'fre','Rejeté par le validateur de Digitaal Vlaanderen et non publié');
INSERT INTO StatusValuesDes (iddes, langid, label) VALUES (14,'fre','Rejeté par le validateur de Digitaal Vlaanderen et non supprimé');
