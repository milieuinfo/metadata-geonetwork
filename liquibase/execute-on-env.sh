#!/bin/bash
usage="$(basename "$0") [-h] [-n namespace] -- Execute liquibase on the given namespace.

where:
    -h  show this help text
    -n  the namespace of the target database

Make sure you have the following environment variables set to satisfy the changesets:
- LIQUIBASE_GN_SYSTEM_FEEDBACK_MAILSERVER_PASSWORD
- LIQUIBASE_MDV_PASSWORDHASH
- LIQUIBASE_MAILPIT_HOST
- LIQUIBASE_MAILPIT_PORT
"

valid_namespaces=("dev" "bet" "prd")
while getopts ':hn:' option; do
  case "$option" in
  h)
    echo "$usage"
    exit
    ;;
  n)
    namespace=$OPTARG
    ;;
  :)
    printf "missing argument for -%s\n" "$OPTARG" >&2
    echo "$usage" >&2
    exit 1
    ;;
  \?)
    printf "illegal option: -%s\n" "$OPTARG" >&2
    echo "$usage" >&2
    exit 1
    ;;
  esac
done
shift "$((OPTIND - 1))"

# check namespace validity
if ! [[ " ${valid_namespaces[*]} " =~ ${namespace} ]]; then
  echo "namespace should be either one of: ${valid_namespaces[*]}"
  exit 1
fi

# check presence of arguments
if [ -z "$namespace" ]; then
  echo 'Missing -n' >&2
  exit 1
fi
# check presence of environment variables
if [ -z "$LIQUIBASE_GN_SYSTEM_FEEDBACK_MAILSERVER_PASSWORD" ]; then
  echo 'Missing LIQUIBASE_GN_SYSTEM_FEEDBACK_MAILSERVER_PASSWORD' >&2
  exit 1
fi
if [ -z "$LIQUIBASE_MDV_PASSWORDHASH" ]; then
  echo 'Missing LIQUIBASE_MDV_PASSWORDHASH' >&2
  exit 1
fi
if [ -z "$LIQUIBASE_GN_SYSTEM_VLAANDEREN_VERSION" ]; then
  echo 'Missing LIQUIBASE_GN_SYSTEM_VLAANDEREN_VERSION' >&2
  exit 1
fi
if [ -z "$LIQUIBASE_MAILPIT_PORT" ]; then
  echo 'Missing LIQUIBASE_MAILPIT_PORT' >&2
  exit 1
fi
if [ -z "$LIQUIBASE_MAILPIT_HOST" ]; then
  echo 'Missing LIQUIBASE_MAILPIT_HOST' >&2
  exit 1
fi

# set the cluster
if [ "$namespace" == "prd" ]; then
  cluster=prd-md-cluster-aks
else
  cluster=pre-md-cluster-aks
fi

# run the liquibase update
deployment=deployment/postgres-geonetwork
localport=54345
targetport=5432

# set up port forward in background
kubectl --cluster "$cluster" --namespace "$namespace" port-forward deployment/postgres-geonetwork $localport:$targetport &
# wait till port forward is running
sleep 5

# now run liquibase - the namespaces are the same as the available contexts
# don't forget the context: this defines what changesets are run!
mvn liquibase:update -P "$namespace" \
 -Dgn.system.feedback.mailServer.password="$LIQUIBASE_GN_SYSTEM_FEEDBACK_MAILSERVER_PASSWORD" \
 -Dgn.system.vlaanderen.version="$LIQUIBASE_GN_SYSTEM_VLAANDEREN_VERSION" \
 -Dmdv.passwordhash="$LIQUIBASE_MDV_PASSWORDHASH" \
 -Dmailpit.host="$LIQUIBASE_MAILPIT_HOST" \
 -Dmailpit.port="$LIQUIBASE_MAILPIT_PORT" \
 -Dliquibase.url=jdbc:postgresql://localhost:$localport/geonetwork
mvnstatus=$?
echo "mvn exit code: $mvnstatus"

# kill the previous background process: kubectl port forward
kill $!

# finish
echo "Liquibase update finished."

# return the mvn status - this is what we want to see succeed
exit $mvnstatus
