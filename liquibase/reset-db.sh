# run this script to start from a fresh database
# this removes all data contained within and reruns the liquibase changesets
POSTGRESCONTAINER=metadatageonetwork-database-1
POSTGRESUSER=geonetwork
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "drop schema if exists public, liquibase cascade"
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "create schema public"
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "create schema liquibase"
mvn liquibase:update