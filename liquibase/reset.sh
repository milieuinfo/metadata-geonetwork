# run this script to start from a fresh database
# this removes all data contained within and reruns the liquibase changesets
POSTGRESCONTAINER=vlaanderen-database-1
POSTGRESUSER=geonetwork
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "drop schema if exists public, liquibase cascade"
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "create schema public"
docker exec -it $POSTGRESCONTAINER psql -U $POSTGRESUSER -c "create schema liquibase"
# get the version specified in pom.xml in a readable format
vl_version=$(mvn -f ../vlaanderen/pom.xml help:evaluate -Dexpression=project.version -q -DforceStdout)
# make sure this goes to the local db
# the given passwordhash is for password 'admin'
mvn liquibase:update -Ploc -Dmdv.passwordhash="46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2" -Dgn.system.vlaanderen.version="$vl_version"
