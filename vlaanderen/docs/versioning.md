# Versioning

See [the changelog readme file](./CHANGELOG.md) for an overview of the past versions and ongoing development effort.

Update `pom.xml` to reflect changes to the current version. This is picked up by the DevOps pipeline to automatically tag the built docker image. The version can be easily extracted from the `pom.xml` file by executing ` mvn help:evaluate -Dexpression=project.version -q -DforceStdout`.

Specific `-SNAPSHOT` versions are used to indicate work in progress, to be solidified in the actual version when it's deemed ready. This way multiple merge requests can be bundled into a single version. 

## Bump script

The script `finalise-version.sh` helps switching from one version to the next. It can do two things:
- finish off a SNAPSHOT version
- start the newly bumped version

The `pom.xml` file is automatically added. The changelog file is modified accordingly.

Sample usage:
```bash
# when on 1.0.9-SNAPSHOT...
./finalise-version.sh -b patch
# ... this creates two remote branches: feature/finalise-1.0.9 and feature/start-1.0.10-SNAPSHOT

# when on 1.0.9-SNAPSHOT...
./finalise-version.sh -b minor
# ... this creates two remote branches: feature/finalise-1.0.9 and feature/start-1.1.0-SNAPSHOT
```
