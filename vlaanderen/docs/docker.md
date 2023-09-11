# Docker

A full dockerised setup is available. 

It comprises:
- geonetwork
- elasticsearch
- ogc-api-records-service
- postgresql
- liquibase

The docker configuration is also used in the Cypress end-2-end tests. 

## Only dependencies
When running Geonetwork in your IDE, docker can be used to only run the dependencies (databases, microservices, ...).
The following command brings them up:
`docker-compose up -d`

## Full stack for local setup
Run Geonetwork, freshly built, with all dependencies. Volumes and default port bindings are included in the default `docker-compose.override.yml` file, automatically used.
`docker-compose --profile full up -d` 
Clean up with:
`docker-compose down -v --remove-orphans`

## Scaled version
To test a scaled-up version, make use of the `scaled` profile. This enables a harvester-enabled geonetwork instance and
additional harvester-disabled instances.

```bash
# run 3 instances, of which one is a harvester
docker-compose --profile scaled up --scale geonetwork-replica=2 -d
# open all geonetwork instances in one go (http://localhost:xxxx/):
docker ps --format json --filter "name=geonetwork" | jq ".Ports" | sed -E "s/.*:([0-9]{4})->.*/http:\/\/localhost:\1/" | while read -r url; do xdg-open "$url"; done
```

**Warning**: some work remains to be done to make this completely functional.

## Only run dependencies
Add a 'profile' in an override (see `docker-compose.loc.example.yml`). This allows excluding certain containers from a 
docker compose setup. Then, run the override as follows:
`docker-compose -f docker-compose.yml -f docker-compose.loc.example.yml --profile full up -d`

## Customise
Have a custom override by copying an existing one and specifying it as shown above.
