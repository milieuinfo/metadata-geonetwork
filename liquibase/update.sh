# run this scripts as:
# > bash update.sh loc
# > bash update.sh dev
# > bash update.sh bet
# make sure you have a liquibase.properties file with the right values for the corresponding profile, or override the values inside with environment variables

# get the profile
profile=$1

# check namespace validity
valid_profiles=("loc" "dev" "bet")
if ! [[ " ${valid_profiles[*]} " =~ ${profile} ]]; then
  echo "namespace should be either one of: ${valid_profiles[*]}"
  exit 1
fi

# get the version specified in pom.xml in a readable format
vl_version=$(mvn -f ../vlaanderen/pom.xml help:evaluate -Dexpression=project.version -q -DforceStdout)
# execute liquibase update with sane values
# > add -X for debug output
mvn liquibase:update -P "${profile}" -Dgn.system.vlaanderen.version="$vl_version"
