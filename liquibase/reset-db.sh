# run this script to start from a fresh database
# this removes all data contained within and reruns the liquibase changesets
POSTGRESCONTAINER=metadatageonetwork-database-1
POSTGRESUSER=geonetwork
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "drop schema if exists public, liquibase cascade"
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "create schema public"
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "create schema liquibase"
# make sure this goes to the local db
# the given passwordhash is for password 'admin'
mvn liquibase:update -P loc -Dmdv.passwordhash="46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2"
