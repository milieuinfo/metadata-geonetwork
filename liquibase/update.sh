# get the version specified in pom.xml in a readable format
vl_version=$(mvn -f ../vlaanderen/pom.xml help:evaluate -Dexpression=project.version -q -DforceStdout)
# execute liquibase update with sane values
# > 'loc': make sure this goes to the local db
# >  the given passwordhash is for password 'admin'
# > add -X for debug output
mvn liquibase:update -Ploc -Dmdv.passwordhash="46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2" -Dgn.system.vlaanderen.version="$vl_version"
