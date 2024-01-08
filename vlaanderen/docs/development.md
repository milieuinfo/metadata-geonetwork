# Local

Local setup contains a number of preset values. 

## Users

The following username / password combinations are provided through liquibase:

- `mdv` // `admin` (global admin)
- `editor` // `Editor$1` (editor account for digitaal vlaanderen)
- `reviewer` // `Reviewer$1` (reviewer account for datapublicatie digitaal vlaanderen)


# Core upgrade

When upgrading to a new version of `core-geonetwork`, follow these steps:

1. create `upgrade/xxx` branch
2. merge `main` of https://github.com/geonetwork/core-geonetwork
3. upgrade `MetadataDcatAp` to make sure it has a the right GeoNetwork version
  - in that repo, create a `feature/upgrade-x` branch
  - modify the `pom.xml` file with the new version
  - merge the branch into `gn-4`
4. upgrade the `dcat2` submodule to make use of the new version
5. check the database migration scripts that were added since the last core merge
6. test the branch: build and run
