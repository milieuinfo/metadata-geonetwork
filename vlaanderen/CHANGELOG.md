# Changelog

All notable changes to this project will be documented in this file. These changes are specific to Vlaanderen, important
[core-geonetwork](https://github.com/geonetwork/core-geonetwork) changes are linked or embedded.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres
to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2-SNAPSHOT] (to finalise)
- Adding download link for RDF
- Enabled 'pin as favorite' functionality

## [1.0.1] - 2023-06-15
- [core] Merged core-geonetwork 4.2.5 changes (pr #24644)
  - minor fixes and updates
  - font-awesome library upgrade, slight changes in icons
- Vlaanderen Geonetwork version now visible and automatically updating
- Implement DCAT-ap metadata editor.
- [core] Fix issue in editor where reference to an element would be lost and recreated
- [core] Fix issue where `geonet` edit element where added multiple times
- [core] Fixed nullpointer bug in LocaleRedirects (pr #24802)

## [1.0.0] - 2023-06-09
- Introduced semver versioning

## [0.0.0] - <2023-06
TODO: document roughly what has been done since the start of the sprints on GN4

- Modified workflow with custom states
- Customised editor view
- Added liquibase versioning for database versioning, disabling Geonetwork-managed updates
- [core] Upgraded to core-geonetwork 4.2.5
- [core] Contributions to core
  - [Default tab configuration](https://github.com/geonetwork/core-geonetwork/pull/6986)
  - [Onhover mode for tooltips](https://github.com/geonetwork/core-geonetwork/pull/6987)
  - [Workflow improvements](https://github.com/geonetwork/core-geonetwork/pull/7011/files/68cea61c151e77351f7b8b7dc78e8c50c2597d0b..6210965c0b24c56e75478e5dde0d50add2dab66e)
  - [Config / add property file overlay](https://github.com/geonetwork/core-geonetwork/pull/6954/files) (setting auto hibernate on startup)
  - [Workflow / On Cancel / Properly remove draft from index](https://github.com/geonetwork/core-geonetwork/pull/7101)
  - [Removal of magic numbers in workflow labels](https://github.com/geonetwork/core-geonetwork/pull/7104)
