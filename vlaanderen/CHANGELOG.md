# Changelog
All notable changes to this project will be documented in this file. These changes are specific to Vlaanderen, important [core-geonetwork](https://github.com/geonetwork/core-geonetwork) changes are linked or embedded.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.6-SNAPSHOT]

## [1.1.5] - 2023-11-08

### vlaanderen
- Added schema plugin translations - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28984)
- Added group owner detail to record cards - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29051)
- Tweaked workflow status labels - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29193)
- Embedded feature catalog information reintroduced - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28306)
- Avoiding invalid record when adding data quality report - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29162)
- Handle empty lineage section in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29161)
- Fixed thesaurus selection bug in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29156)
- [Added constraints in ISO editor](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27995)
- Enable addition of temporal extent in editor - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29166)
- Hiding inapplicable spatial resolution for services - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29198)

### core-geonetwork
- Added Data Quality information to record view - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7469) / [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29153)
- Record view improvements - [pr-core1](https://github.com/geonetwork/core-geonetwork/pull/7473) / [pr-core2](https://github.com/geonetwork/core-geonetwork/pull/7472) / [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/29194)


## [1.1.4] - 2023-10-25
- Removed DataPublicatie portal - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28851)
- Workflow optimisation - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28849)


## [1.1.3] - 2023-10-24

### vlaanderen
- Added WCS-2.0.0 as OGC-WCS service type - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28482)
- Added missing hover labels for search buttons - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28193)
- Enabled subportals - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28552)

### core-geonetwork
- Merged core-geonetwork 4.4.1-SNAPSHOT
- Handle empty code list values - [pr-core](https://metadata.vlaanderen.be/srv/dut/catalog.search#/metadata/f1e77b4f-a174-4e2d-9af7-fe7f548b5a5c)


## [1.1.2] - 2023-10-16
- Ordering workflow statuses in logical way - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27923)
- Publishing draft now sets group owner correctly - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/28255)
 

## [1.1.1] - 2023-09-29

### vlaanderen
- Backporting lineage and legal constraints formatter - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27955)

### core-geonetwork
- Improved handling of empty record titles - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27607) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7362)
- Merged core-geonetwork 4.4.0-SNAPSHOT - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27898)
  - Introducing HA capabilities, e.g., harvester modifications
- Multiple status handling - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/27969) / [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7366)
- ISO19110 improvements - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/7365)


## [1.1.0] - 2023-09-26

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


## [1.0.4] - 2023-09-04
- Synced translations files with Transifex nl_BE - [pr1](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25634) / [pr2](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/26995) / [docs](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork?path=/vlaanderen/docs/translation.md&version=GBdevelop)
- Remove unused core metadata templates from ISO19139 plugin to avoid including them when loading the templates


## [1.0.3] - 2023-07-14

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


## [1.0.2] - 2023-06-26

### vlaanderen
- Adding download link for RDF
- Adding VL/INSPIRE conformity keywords upon validation
- Enabled 'pin as favorite' functionality

### core-geonetwork
- High availability fix, allow configuration of separate html cache directory - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24976)
- High availability fix, define schema publication dir - [pr](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/25025)
- Work in progress: high availability - [pr-core](https://github.com/geonetwork/core-geonetwork/pull/6990)


## [1.0.1] - 2023-06-15

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


## [1.0.0] - 2023-06-09

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
