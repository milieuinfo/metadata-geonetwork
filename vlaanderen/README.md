# Metadata Vlaanderen

This section serves as an appendix to the current Geonetwork documentation. The `vlaanderen` subfolder contains additions
to the core that are either useful in our environment (e.g. scripts) or vlaanderen-specific.


# Docker

A full dockerised setup is available. 

It comprises:
- geonetwork
- elasticsearch
- ogc-api-records-service
- postgresql
- liquibase

The docker configuration is also used in the Cypress end-2-end tests. 

## Full stack for local setup
Run Geonetwork, freshly built, with all dependencies. Volumes and default port bindings are included in the default `docker-compose.override.yml` file, automatically used.
`docker-compose up -d` 
Clean up with:
`docker-compose down -v`

## Only run dependencies
Add a 'profile' in an override (see `docker-compose.loc.example.yml`). This allows excluding certain containers from a 
docker compose setup. Then, run the override as follows:
`docker-compose -f docker-compose.yml -f docker-compose.loc.example.yml --profile full up -d`

## Customise
Have a custom override by copying an existing one and specifying it as shown above.


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
