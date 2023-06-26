# Changelog
All notable changes to this project will be documented in this file. These changes are specific to Vlaanderen, important [core-geonetwork](https://github.com/geonetwork/core-geonetwork) changes are linked or embedded.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2]
- Adding download link for RDF
- Enabled 'pin as favorite' functionality
- **core**
  - [Work in progress: high availability](https://github.com/geonetwork/core-geonetwork/pull/6990)
  - [High availability fix, allow configuration of separate html cache directory](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24976)

## [1.0.1] - 2023-06-15
- Vlaanderen Geonetwork version now visible and automatically updating
- Implement DCAT-ap metadata editor.
- **core** 
  - [merged core-geonetwork 4.2.5-SNAPSHOT changes](https://agiv.visualstudio.com/Metadata/_git/MetadataGeonetwork/pullrequest/24644)
    - Minor fixes and updates
    - Font-awesome library upgrade, minor icon changes
  - Fix issue in editor where reference to an element would be lost and recreated
  - Fix issue where `geonet` edit element where added multiple times
  - Fixed nullpointer bug in LocaleRedirects (pr #24802)

## [1.0.0] - 2023-06-09
- Introduced semver versioning

## [0.0.0] - <2023-06
- Modified workflow with custom states
- Customised editor view
- Added liquibase versioning for database versioning, disabling Geonetwork-managed updates
- **core**
  - Upgraded to core-geonetwork 4.2.5-SNAPSHOT
  - [Default tab configuration](https://github.com/geonetwork/core-geonetwork/pull/6986)
  - [Onhover mode for tooltips](https://github.com/geonetwork/core-geonetwork/pull/6987)
  - [Workflow improvements](https://github.com/geonetwork/core-geonetwork/pull/7011)
  - [Config / add property file overlay](https://github.com/geonetwork/core-geonetwork/pull/6954), setting auto hibernate on startup
  - [Workflow / On Cancel / Properly remove draft from index](https://github.com/geonetwork/core-geonetwork/pull/7101)
  - [Removal of magic numbers in workflow labels](https://github.com/geonetwork/core-geonetwork/pull/7104)
