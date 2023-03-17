DELETE FROM cswservercapabilitiesinfo;
DELETE FROM Settings WHERE name = 'system/csw/contactId';
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/csw/capabilityRecordUuid', '-1', 0, 1220, 'y');


UPDATE Settings SET value='3.10.1' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


UPDATE Settings SET value='3.10.2' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


ALTER TABLE groupsdes ALTER COLUMN label TYPE varchar(255);
ALTER TABLE sourcesdes ALTER COLUMN label TYPE varchar(255);
ALTER TABLE schematrondes ALTER COLUMN label TYPE varchar(255);

-- New setting for server timezone
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/server/timeZone', '', 0, 260, 'n');

DROP INDEX idx_metadatafiledownloads_metadataid;
DROP INDEX idx_metadatafileuploads_metadataid;
DROP INDEX idx_operationallowed_metadataid;

UPDATE Settings SET value='3.10.3' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';



INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/users/identicon', 'gravatar:mp', 0, 9110, 'n');

UPDATE Settings SET value='3.10.4' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';


-- Then we move to 4.x migration scripts
-- 3.11+ have been released in parallel.



DROP TABLE metadatanotifications;
DROP TABLE metadatanotifiers;

DELETE FROM Settings WHERE name LIKE 'system/indexoptimizer%';
DELETE FROM Settings WHERE name LIKE 'system/requestedLanguage%';
DELETE FROM Settings WHERE name = 'system/inspire/enableSearchPanel';
DELETE FROM Settings WHERE name = 'system/autodetect/enable';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/index/indexingTimeRecordLink', 'false', 2, 9209, 'n');

UPDATE metadata
SET data = REGEXP_REPLACE(data, '[a-z]{3}\/thesaurus\.download\?ref=', 'api/registries/vocabularies/', 'g')
WHERE data LIKE '%thesaurus.download?ref=%';

UPDATE settings SET value = '1' WHERE name = 'system/threadedindexing/maxthreads';

UPDATE Settings SET value='4.0.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';




UPDATE Settings SET value='4.0.1' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';



-- Set default timezone to UTC if not set.
UPDATE Settings SET value = 'Etc/UTC' WHERE name = 'system/server/timeZone' AND VALUE = '';

ALTER TABLE guf_userfeedbacks_guf_rating DROP COLUMN GUF_UserFeedbacks_uuid;


UPDATE Settings SET value='4.0.2' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';



-- Changes were back ported to version 3.12.x so they are no longer required unless upgrading from v400, v401, v402 which did not have 3.12.x  migrations steps.
-- So lets try to only add the records if they don't already exists.
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/security/passwordEnforcement/minLength', '6', 1, 12000, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/security/passwordEnforcement/minLength');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/security/passwordEnforcement/maxLength', '20', 1, 12001, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/security/passwordEnforcement/maxLength');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/security/passwordEnforcement/usePattern', 'true', 2, 12002, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/security/passwordEnforcement/usePattern');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/security/passwordEnforcement/pattern', '^((?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).*)$', 0, 12003, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/security/passwordEnforcement/pattern');

UPDATE Settings SET value='4.0.3' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';




DELETE FROM Schematrondes WHERE iddes IN (SELECT id FROM schematron WHERE filename LIKE 'schematron-rules-inspire%');
DELETE FROM Schematroncriteria WHERE group_name || group_schematronid IN (SELECT name || schematronid FROM schematroncriteriagroup WHERE schematronid IN (SELECT id FROM schematron WHERE filename LIKE 'schematron-rules-inspire%'));
DELETE FROM Schematroncriteriagroup WHERE schematronid IN (SELECT id FROM schematron WHERE filename LIKE 'schematron-rules-inspire%');
DELETE FROM Schematron WHERE filename LIKE 'schematron-rules-inspire%';

-- Changes were back ported to version 3.12.x so they are no longer required unless upgrading from v400, v401, v402, v403 which did not have 3.12.x migrations steps
-- For security reasons, the statements will remain as it will simply change the values back to true if they were previously changed to false.

ALTER TABLE Settings ADD COLUMN encrypted CHAR(1) DEFAULT 'n';
UPDATE Settings SET encrypted='y' WHERE name='system/proxy/password';
UPDATE Settings SET encrypted='y' WHERE name='system/feedback/mailServer/password';
UPDATE Settings SET encrypted='y' WHERE name='system/publication/doi/doipassword';

UPDATE Settings SET value='4.0.4' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';



UPDATE metadata SET data = replace(data, 'WWW:DOWNLOAD-OGC:OWS-C', 'OGC:OWS-C') WHERE data LIKE '%WWW:DOWNLOAD-OGC:OWS-C%';

UPDATE Settings SET internal = 'n' WHERE name = 'system/metadata/prefergrouplogo';

UPDATE Settings SET value='4.0.5' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';



INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/inspire/remotevalidation/nodeid', '', 0, 7212, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/inspire/remotevalidation/apikey', '', 0, 7213, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doipublicurl', '', 0, 100196, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/harvester/enablePrivilegesManagement', 'false', 2, 9010, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/localrating/notificationLevel', 'catalogueAdministrator', 0, 2111, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadatacreate/preferredGroup', '', 1, 9105, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadatacreate/preferredTemplate', '', 0, 9106, 'n');

DELETE FROM Settings WHERE name = 'system/server/securePort';

UPDATE Settings SET value = '0 0 0 * * ?' WHERE name = 'system/inspire/atomSchedule' and value = '0 0 0/24 ? * *';

UPDATE Settings SET value='4.0.6' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';





INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/csvReport/csvName', 'metadata_{datetime}.csv', 0, 12607, 'n');

UPDATE Settings set position = 7213 WHERE name = 'system/inspire/remotevalidation/nodeid';
UPDATE Settings set position = 7214 WHERE name = 'system/inspire/remotevalidation/apikey';
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/inspire/remotevalidation/urlquery', '', 0, 7212, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/import/userprofile', 'Editor', 0, 12001, 'n');

INSERT INTO Users (id, username, password, name, surname, profile, kind, organisation, security, authtype, isenabled) VALUES  (0,'nobody','','nobody','nobody',4,'','','','', 'n');
INSERT INTO Address (id, address, city, country, state, zip) VALUES  (0, '', '', '', '', '');
INSERT INTO UserAddress (userid, addressid) VALUES  (0, 0);

-- WARNING: Security / Add this settings only if you need to allow admin
-- users to be able to reset user password. If you have mail server configured
-- user can reset password directly. If not, then you may want to add that settings
-- if you don't have access to the database.
-- INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/security/password/allowAdminReset', 'false', 2, 12004, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/link/excludedUrlPattern', '', 0, 12010, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadata/thesaurusNamespace', 'https://registry.geonetwork-opensource.org/{{type}}/{{filename}}', 0, 9161, 'n');


ALTER TABLE Settings ADD COLUMN editable CHAR(1) DEFAULT 'y';
UPDATE Settings SET editable = 'y';
UPDATE Settings SET editable = 'n' WHERE name = 'system/userFeedback/lastNotificationDate';
UPDATE Settings SET editable = 'n' WHERE name = 'system/security/passwordEnforcement/pattern';

UPDATE Settings SET value='4.0.7' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';




UPDATE Settings SET value='4.2.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';





INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadataprivs/publicationbyrevieweringroupowneronly', 'true', 2, 9181, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doipattern', '{{uuid}}', 0, 100197, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/delete/profilePublishedMetadata', 'Editor', 0, 12011, 'n');

-- cf. https://www.un.org/en/about-us/member-states/turkiye (run this manually if it applies to your catalogue)
-- UPDATE metadata SET data = replace(data, 'Turkey', 'Türkiye') WHERE data LIKE '%Turkey%';
UPDATE Settings SET value='log4j2.xml' WHERE name='system/server/log';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/localrating/notificationGroups', '', 0, 2112, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadataprivs/publication/notificationLevel', '', 0, 9182, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadataprivs/publication/notificationGroups', '', 0, 9183, 'n');

UPDATE Settings SET value='4.2.1' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';



DELETE FROM Settings WHERE name = 'system/downloadservice/leave';
DELETE FROM Settings WHERE name = 'system/downloadservice/simple';
DELETE FROM Settings WHERE name = 'system/downloadservice/withdisclaimer';

UPDATE Settings SET value='4.2.2' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';





UPDATE Settings SET position = '9165' WHERE name = 'system/server/sitemapLinkUrl';
UPDATE Settings SET name = 'metadata/url/sitemapLinkUrl' WHERE name = 'system/server/sitemapLinkUrl';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/url/sitemapDoiFirst', 'false', 2, 9166, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/url/dynamicAppLinkUrl', NULL, 0, 9167, 'y');


UPDATE harvestersettings SET value = replace(value, 'gmiTogmd', 'iso19139:convert/fromISO19115-2') WHERE value LIKE 'gmiTogmd%';
UPDATE harvestersettings SET value = replace(value, 'DIF-to-ISO19139', 'iso19139:convert/fromDIF-GCMD') WHERE value LIKE 'DIF-to-ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'EsriGeosticker-to-ISO19139', 'iso19139:convert/fromESRI-Geosticker') WHERE value LIKE 'EsriGeosticker-to-ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'ISO19115-to-ISO19139', 'iso19139:convert/fromISO19115') WHERE value LIKE 'ISO19115-to-ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCCSWGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCCSWGetCapabilities') WHERE value LIKE 'OGCCSWGetCapabilities-to-ISO19119_ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCSLD-to-ISO19139', 'iso19139:convert/fromOGCSLD') WHERE value LIKE 'OGCSLD-to-ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCSOSGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCSOSGetCapabilities') WHERE value LIKE 'OGCSOSGetCapabilities-to-ISO19119_ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCWCSGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCWCSGetCapabilities') WHERE value LIKE 'OGCWCSGetCapabilities-to-ISO19119_ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCWFSGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCWFSGetCapabilities') WHERE value LIKE 'OGCWFSGetCapabilities-to-ISO19119_ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCWMC-OR-OWSC-to-ISO19139', 'iso19139:convert/fromOGCWMC-OR-OWSC') WHERE value LIKE 'OGCWMC-OR-OWSC-to-ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCWMSGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCWMSGetCapabilities') WHERE value LIKE 'OGCWMSGetCapabilities-to-ISO19119_ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCWPSGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCWPSGetCapabilities') WHERE value LIKE 'OGCWPSGetCapabilities-to-ISO19119_ISO19139%';
UPDATE harvestersettings SET value = replace(value, 'OGCWxSGetCapabilities-to-ISO19119_ISO19139', 'iso19139:convert/fromOGCWxSGetCapabilities') WHERE value LIKE 'OGCWxSGetCapabilities-to-ISO19119_ISO19139%';

UPDATE harvestersettings SET value = replace(value, 'OGCWFSDescribeFeatureType-to-ISO19110', 'iso19110:convert/fromOGCWFSDescribeFeatureType') WHERE value LIKE 'OGCWFSDescribeFeatureType-to-ISO19110%';

UPDATE harvestersettings SET value = replace(value, 'CKAN-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromJsonCkan') WHERE value LIKE 'CKAN-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'DKAN-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromJsonDkan') WHERE value LIKE 'DKAN-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'ESRIDCAT-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromJsonLdEsri') WHERE value LIKE 'ESRIDCAT-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'ISO19115-3-2014-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromISO19115-3.2014') WHERE value LIKE 'ISO19115-3-2014-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'ISO19139-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromISO19139') WHERE value LIKE 'ISO19139-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'ISO19139-to-ISO19115-3-2018-with-languages-refactor', 'iso19115-3.2018:convert/fromISO19139-with-languages-refactor') WHERE value LIKE 'ISO19139-to-ISO19115-3-2018-with-languages-refactor%';
UPDATE harvestersettings SET value = replace(value, 'OPENDATASOFT-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromJsonOpenDataSoft') WHERE value LIKE 'OPENDATASOFT-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'SPARQL-DCAT-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromSPARQL-DCAT') WHERE value LIKE 'SPARQL-DCAT-to-ISO19115-3-2018%';
UPDATE harvestersettings SET value = replace(value, 'udata-to-ISO19115-3-2018', 'iso19115-3.2018:convert/fromJsonUdata') WHERE value LIKE 'udata-to-ISO19115-3-2018%';

DROP TABLE Thesaurus;


UPDATE Settings SET value='4.2.3' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';




UPDATE Settings SET value='4.2.4' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';





-- AIV Specific
DELETE FROM settings_ui;

CREATE TABLE metadatastatus_383 AS SELECT * FROM metadatastatus;

DROP TABLE metadatastatus;

UPDATE settings SET value = '' WHERE encrypted = 'y';

UPDATE Settings SET value = 'Europe/Brussels' WHERE name = 'system/server/timeZone';



-- Thesaurus update
UPDATE metadata
  SET data = replace(data, 'external.theme.inspire-theme', 'external.theme.httpinspireeceuropaeutheme-theme')
  WHERE data LIKE '%external.theme.inspire-theme%' AND isHarvested = 'n';

UPDATE metadata
  SET data = replace(data, 'external.theme.SpatialScope', 'external.theme.httpinspireeceuropaeumetadatacodelistSpatialScope-SpatialScope')
  WHERE data LIKE '%external.theme.SpatialScope%' AND isHarvested = 'n';

UPDATE metadata
  SET data = replace(data, 'external.theme.featureconcept', 'external.theme.httpinspireeceuropaeufeatureconcept-featureconcept')
  WHERE data LIKE '%external.theme.featureconcept%' AND isHarvested = 'n';


UPDATE metadata
SET data = replace(data, 'external.theme.PriorityDataset', 'external.theme.httpinspireeceuropaeumetadatacodelistPriorityDataset-PriorityDataset')
WHERE data LIKE '%external.theme.PriorityDataset%' AND isHarvested = 'n';


UPDATE metadata
SET data = replace(data, 'external.theme.inspire-service-taxonomy', 'external.theme.httpinspireeceuropaeumetadatacodelistSpatialDataServiceCategory-SpatialDataServiceCategory')
WHERE data LIKE '%external.theme.inspire-service-taxonomy%' AND isHarvested = 'n';


UPDATE metadata
SET data = replace(data, 'external.theme.inspire-service-type', 'external.theme.httpinspireeceuropaeumetadatacodelistSpatialDataServiceType-SpatialDataServiceType')
WHERE data LIKE '%external.theme.inspire-service-type%' AND isHarvested = 'n';


UPDATE metadata
SET data = replace(data, 'external.theme.TopicCategory', 'external.theme.httpinspireeceuropaeumetadatacodelistTopicCategory-TopicCategory')
WHERE data LIKE '%external.theme.TopicCategory%' AND isHarvested = 'n';


UPDATE metadata
  SET data = replace(data, '>GEMET - Concepten, versie 2.4<', '>GEMET<')
  WHERE data LIKE '%>GEMET - Concepten, versie 2.4<%' AND isHarvested = 'n';


UPDATE metadata
  SET data = replace(data, '>INSPIRE - Spatial scope<', '>Spatial scope<')
  WHERE data LIKE '%>INSPIRE - Spatial scope<%' AND isHarvested = 'n';

