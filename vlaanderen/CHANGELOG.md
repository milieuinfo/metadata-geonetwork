# Changelog
All notable changes to this project will be documented in this file. These changes are specific to Vlaanderen, important [core-geonetwork](https://github.com/geonetwork/core-geonetwork) changes are linked or embedded.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [8.1.11-SNAPSHOT]

### vlaanderen

### core-geonetwork
- Merged 4.4.2-SNAPSHOT - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31500)
  - Fix for duplicates-check in validation of related records - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31075) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7567)
- Improved label for vertical extent - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31519) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7604)


## [8.1.10] - 2024-01-05
- Clearing iso19110 title on duplication - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30873)
- Translations iso19110 editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30873)
- Footer tweaks - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31200)

### vlaanderen
- Translations - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31081) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31123)

### core-geonetwork
- Fixed minor UI bug when listing languages - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/31081) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7568)

## [8.1.9] - 2023-12-14

### vlaanderen
- Remove thumbnails on import - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30536)
- Header/footer improvements - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30526)
- Schematron rule for temporalExtent + translations - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30160)
- Fixed bug related to adding conform keywords on save - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30468)
- Correctly saving gmd:date in editor for quality measurements - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30832)
- Added gmd:source and the contained gmd:sourceStep objects to record view - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30633)
- Add `topLevelProtocol` to index and replace "Service Protocole" with it - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30757)
- Improve slightly layout of status workflow dropdown - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30757)
- Implement fixed order for status workflow facet - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30757)
- Run INSPIRE validation after save/close - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30546)

### core-geonetwork
- Configurable icon for static pages - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30491) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7536)
- Translation of indexingErrorMsg - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30080) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7531)


## [8.1.8] - 2023-12-08
- Added custom mailing to workflow notifications - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30315) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30496)
- Header/footer improvements, responsiveness - [pr](https://agiv.visualstudio.com/DefaultCollection/Metadata/_git/MetadataGeonetwork/pullrequest/29987)
- Translations - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30481) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30641)
- Added GDI vlaanderen keywords at harvest of OGC services - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29983)
- Added default dateTime for processStep in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30565)
- Clean display of resourceTitle in the case of multiple values - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30574)
- Tweaks to servicetype view - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/30637)


## [8.1.7] - 2023-11-23

### vlaanderen
- Dataset identifier now added for new records - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29827)
- Added "Add Geographic keyword" transformation - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29829)
- Lengthened 1089 conformance title - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29793)
- Cleaned up quality section - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29782)
- Changing group owner now disallowed - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29768)
- Added custom header and footer - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29876) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29898)
- Add additional information to the index & the relation API used by the microservice during RDF DCAT2 conversion - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29880)

### core-geonetwork
- Styling fixes - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29747) / [core-pr](https://github.com/geonetwork/core-geonetwork/pull/7502)
- Merged v4.4.1 release - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29891) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7508) / [changelog-core](https://docs.geonetwork-opensource.org/4.4/overview/change-log/version-4.4.1/)
  - Add more db information to the site information page
  - Fix cookies path when deployed on root "/" context
  - Security / Jolokia update
- Added capability to validate after harvesting - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27953) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7370)
 


## [8.1.6] - 2023-11-17

### vlaanderen
- Label fixes - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28988) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29360) / [pr3](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29489)
- Search options & facet label fixes - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29375)
- Index scope as topic category for iso19110 - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29215)
- Removed mdc portal, added messaging to clarify DataPublicatie group - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29525)
- Allow editing thumbnails in side panel - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29591)
- Showing usergroups in login menu - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29697)
- Implement relation API for DCAT metadata - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29671)
  - Add RDF resource URI to index for ISO-19139 and DCAT2 records
  - Add resource URI pattern configuration for CSW and geonet harvesters
  - Augment `related` object from relation API with `rdfResourceURI` & `domain`
  - Implement relation linking in DCAT2 plugin
- Editors can now edit records that were created by admins - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29714)
- gmd:LanguageCode now uses iso639-2 - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29726)

### core-geonetwork
- Modified display of draft copies - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7477) / [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29234)
- Fix `linkServiceToDataset` directive default filter on resource type - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7489)


## [8.1.5] - 2023-11-08

### vlaanderen
- Added schema plugin translations - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28984)
- Added group owner detail to record cards - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29051)
- Tweaked workflow status labels - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29193)
- Embedded feature catalog information reintroduced - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28306)
- Avoiding invalid record when adding data quality report - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29162)
- Handle empty lineage section in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29161)
- Fixed thesaurus selection bug in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29156)
- Added constraints in ISO editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27995)
- Enable addition of temporal extent in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29166)
- Hiding inapplicable spatial resolution for services - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29198)

### core-geonetwork
- Added Data Quality information to record view - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7469) / [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29153)
- Record view improvements - [pr-core1](https://github.com/geonetwork/core-geonetwork/pull/7473) / [pr-core2](https://github.com/geonetwork/core-geonetwork/pull/7472) / [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29194)


## [8.1.4] - 2023-10-25
- Removed DataPublicatie portal - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28851)
- Workflow optimisation - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28849)


## [8.1.3] - 2023-10-24

### vlaanderen
- Added WCS-2.0.0 as OGC-WCS service type - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28482)
- Added missing hover labels for search buttons - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28193)
- Enabled subportals - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28552)

### core-geonetwork
- Merged core-geonetwork 4.4.1-SNAPSHOT
- Handle empty code list values - [pr-core](https://metadata.vlaanderen.be/srv/dut/catalog.search#/metadata/f1e77b4f-a174-4e2d-9af7-fe7f548b5a5c)


## [8.1.2] - 2023-10-16
- Ordering workflow statuses in logical way - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27923)
- Publishing draft now sets group owner correctly - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28255)
 


## [8.1.1] - 2023-09-29

### vlaanderen
- Backporting lineage and legal constraints formatter - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27955)

### core-geonetwork
- Improved handling of empty record titles - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27607) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7362)
- Merged core-geonetwork 4.4.0-SNAPSHOT - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27898)
  - Introducing HA capabilities, e.g., harvester modifications
- Multiple status handling - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27969) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7366)
- ISO19110 improvements - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7365)


## [8.1.0] - 2023-09-26

### vlaanderen

- Backport facets and search options from old application - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/26987)
- Display groups by pair in the editor group dropdown - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/26988)
- Workflow tweaks and fixes - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27062)
- Fixing scheduler for high availability setups - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27084)
- Improved status information in admin panel - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27311)
- Running replica GeoNetwork instances - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27534)

### core
- Merged core-geonetwork 4.4.0-SNAPSHOT - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/26874)
  - Upgraded to Java 11


## [8.0.4] - 2023-09-04
- Synced translations files with Transifex nl_BE - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25634) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/26995) / [docs](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork?path=/vlaanderen/docs/translation.md&version=GBdevelop)
- Remove unused core metadata templates from ISO19139 plugin to avoid including them when loading the templates


## [8.0.3] - 2023-07-14

### vlaanderen

- Backport changes & customization made on the ISO19139 update-fixed-info.xsl & OGC Web service harvester logic
- Fix DCAT editor issues with date field
- Added capability to disable harvester scheduling - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25303)

### core
- Record view / Contact / Move website to popup - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7220)
- Record view / Lineage & Quality section improvements - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7180)
- Record view / Display geographic identifier and description if any.  - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7221)
- Standard / ISO19139 / Indexing / Temporal range in GML 3.2.0 - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7218)
- Merged core-geonetwork 4.2.6-SNAPSHOT changes - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25576)
  - minor fixes, including workflow
- Add cardinality for ISO19110 - [pr](https://github.com/geonetwork/core-geonetwork/pull/7182) - [pr-core](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25115)
- Improve performance of large forms - [pr-core](https://github.com/geonetwork/docker-geonetwork/pull/107/files#diff-bed7ab158ecf2f50be93c45dd9ae77da44d0689a155d95771d091515fb6d1ba7R84-R85)
- Replace title by empty value when creating or duplicating a metadata
- Change UI config to show absolute modification in the UI instead of relative elapsed time
- Backport changes mode on the `update-info-on-duplicate.xsl` for ISO19139
- Update codelist dut label for `gmd:CI_DateTypeCode`
- Enforce values for metadataStandardName and metadataStandardVersion during edition


## [8.0.2] - 2023-06-26

### vlaanderen
- Adding download link for RDF
- Adding VL/INSPIRE conformity keywords upon validation
- Enabled 'pin as favorite' functionality

### core-geonetwork
- High availability fix, allow configuration of separate html cache directory - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24976)
- High availability fix, define schema publication dir - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25025)
- Work in progress: high availability - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/6990)


## [8.0.1] - 2023-06-15

### vlaanderen
- Vlaanderen Geonetwork version now visible and automatically updating
- Implement DCAT-ap metadata editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24798)

### core-geonetwork
- Merged core-geonetwork 4.2.5-SNAPSHOT changes - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24644)
  - Minor fixes and updates
  - Font-awesome library upgrade, minor icon changes
- Fix issue in editor where reference to an element would be lost and recreated
- Fix issue where `geonet` edit element where added multiple times
- Fixed nullpointer bug in LocaleRedirects - [vlaanderen](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24802)


## [8.0.0] - 2023-06-09

### vlaanderen
- Introduced semver versioning
- Add XML view/download options - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24005)
- Added custom workflow - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/22731)
- Added liquibase versioning for database versioning, disabling Geonetwork-managed updates - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/20246)
- Cleanup of start-page "browse by" options - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/23629)
- Customised facets - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/18729)
- Customised editor view
- Introduce ACM/IDM as default authentication layer - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/21672)
- Introducing Cypress e2e testing - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24170)
- Introduce DCAT editor - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/22851) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/23974)
- Introducing DCAT plugin - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/18131) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/22605)
- Modified workflow with custom states
- Porting 2005/2007 schemas and enforce default - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/18689)
- Porting ISO editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/21740)
- Porting thesauri of previous deployment - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/18736)

### core-geonetwork
- Allow disabling the 'search map' - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7071) / [pr](https://agiv.visualstudio.com/Metadata/_workitems/edit/170315/)
- Allow disabling automatic database migration - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/21726)
- Config / add property file overlay, setting auto hibernate on startup - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/6954)
- Copy resources to data dir - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7110) / [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/23983)
- Default tab configuration - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/6986)
- Onhover mode for tooltips - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/6987)
- Removal of magic numbers in workflow labels - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7104)
- Merged **core-geonetwork 4.2.5-SNAPSHOT**
  - Index performance improved, related to thesaurus and thumbnails
- Workflow / On Cancel / Properly remove draft from index - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7101)
- Workflow improvements - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7011)
