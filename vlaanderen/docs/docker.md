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

## Scaled version
To test a scaled-up version, make use of `docker-compose.scaled.yml`. The following snippet illustrates usage:

```bash
# run 4 instances
docker-compose --verbose -f docker-compose.yml -f docker-compose.scaled.yml up --scale geonetwork=4 geonetwork -d
# open all scaled geonetworks in one go (http://localhost:{8085-8088}/):
docker ps --format json --filter "name=geonetwork" | jq ".Ports" | sed -E "s/.*:([0-9]{4})->.*/http:\/\/localhost:\1/" | while read -r url; do xdg-open "$url"; done
```

**Warning**: some work remains to be done to make this completely functional.

## Only run dependencies
Add a 'profile' in an override (see `docker-compose.loc.example.yml`). This allows excluding certain containers from a 
docker compose setup. Then, run the override as follows:
`docker-compose -f docker-compose.yml -f docker-compose.loc.example.yml --profile full up -d`

## Customise
Have a custom override by copying an existing one and specifying it as shown above.
