# GeoNetwork Open-source

# Build Health

[![Build Status](https://github.com/geonetwork/core-geonetwork/actions/workflows/linux.yml/badge.svg?branch=main)](https://github.com/geonetwork/core-geonetwork/actions/workflows/linux.yml?query=branch%3Amain)

# Features

* Immediate search access to local and distributed geospatial catalogues
* Uploading and downloading of data, graphics, documents, pdf files and any other content type
* An interactive Web Map Viewer to combine Web Map Services from distributed servers around the world
* Online editing of metadata with a powerful template system
* Scheduled harvesting and synchronization of metadata between distributed catalogs
* Support for OGC-CSW 2.0.2 ISO Profile, OAI-PMH, SRU protocols
* Fine-grained access control with group and user management
* Multi-lingual user interface

# Documentation

User documentation is managed in the [geonetwork/doc](https://github.com/geonetwork/doc) repository covering all releases of GeoNetwork.

The `docs` folder includes [geonetwork/doc](https://github.com/geonetwork/doc) as a git submodule. This documentation is compiled into html pages during a release for publishing on the [geonetwork-opensource.org](http://geonetwork-opensource.org) website.

Developer documentation located in README.md files in the code-base:

* General documentation for the project as a whole is in this README.md
* [Software Development Documentation](/software_development/README.md) provides instructions for setting up a development environment, building Geonetwork, compiling user documentation, and making a releases
* Module specific documentation can be found in each module (assuming there is module specific documentation required)


# Metadata Vlaanderen

It is perhaps wise to keep track of some Metadata Vlaanderen-specific notes or comments. This section could serve as an appendix to the curernt Geonetwork documentation.

## Setup
- Run `git submodule update --init --recursive` before building.
- Run `mvn clean package -DskipTests -Pwar` for a clean package that can be run on Jetty.
- Run `docker-compose build geonetwork` to build the docker image for geonetwork.
- Run `docker-compose` to bring a complete dev stack up, based on the above image.
  - use `docker-compose up` to exclude geonetwork, but run all other services
  - use `docker-compose --profile full up` to run the full stack, including the geonetwork image
- Override settings (see, e.g., `docker-compose.dev.example.yaml`)
  - make a copy and remove `.example` (this file is ignored in `.gitignore`) 
  - use `docker compose -f docker-compose.yml -f docker-compose.dev.yml` to override settings to your liking
  
## Java and Maven

Java 8 is needed to compile Geonetwork. The compiler is defined in the `pom.xml` file, but won't be picked up automatically if the current `java` version is not 8. 

Configure `.m2/toolchains.xml` as follows to make maven pick up the right version, without having to set `JAVA_HOME` specifically for this project.

```xml
<?xml version="1.0" encoding="utf-8"?>
<toolchains xmlns="http://maven.apache.org/TOOLCHAINS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:schemaLocation="http://maven.apache.org/TOOLCHAINS/1.1.0 http://maven.apache.org/xsd/toolchains-1.1.0.xsd">
 <!-- JDK toolchains -->
 <toolchain>
   <type>jdk</type>
   <provides>
     <version>8</version>
     <vendor>openjdk</vendor>
   </provides>
   <configuration>
     <jdkHome>/usr/lib/jvm/java-8-openjdk</jdkHome>
   </configuration>
 </toolchain>
 <toolchain>
   <type>jdk</type>
   <provides>
     <version>11</version>
     <vendor>openjdk</vendor>
   </provides>
   <configuration>
     <jdkHome>/usr/lib/jvm/java-11-openjdk</jdkHome>
   </configuration>
 </toolchain>
</toolchains>
```

## Notes
- `mvn clean install -DskipTests -T 16` would run multi-core (on 16 cores)

## Liquibase
Liquibase is used to version the Geonetwork database. It describes all updates in 'changesets'. There are three types:
- `core-geonetwork` migrations (as we are disabling the native auto-migration of core-geonetwork)
- hibernate model changes
- our own custom changes, to be executed on top
- 
See [the liquibase documentation](/liquibase/README.md) for further info.
