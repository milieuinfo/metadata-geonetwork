#!/bin/bash
# Run a reindex procedure on the target geonetwork installation
# Dependencies
# - curl

usage="$(basename "$0") [-h] [-b baseurl -u user -p pass -c cookiefile] -- Reindex the target Geonetwork

where:
    -h  show this help text
    -b  the base url of the catalog (default http://localhost:8080)
    -u  the user that authenticates with the api
    -p  password of the above user
    -c  file in which the cookie is temporarily stored (default /tmp/gn-reindex-cookie)

sample usage: ./reindex.sh -u mdv -p admin"

# defaults
cookie_path="/tmp/gn-reindex-cookie"
catalog_url="http://localhost:8080"

# get user input
while getopts ':hb:u:p:c:' option; do
  case "$option" in
  h)
    echo "$usage"
    exit
    ;;
  b)
    catalog_url=$OPTARG
    ;;
  u)
    catalog_user=$OPTARG
    ;;
  p)
    catalog_pass=$OPTARG
    ;;
  c)
    cookie_path=$OPTARG
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
shift $((OPTIND - 1))

# check presence of arguments
if [ -z "$catalog_url" ]; then
  echo 'Missing -b (base catalogurl)' >&2
  exit 1
fi
if [ -z "$catalog_user" ]; then
  echo 'Missing -u (username)' >&2
  exit 1
fi
if [ -z "$catalog_pass" ]; then
  echo 'Missing -p (password)' >&2
  exit 1
fi
if [[ -f "$cookie_path" ]]; then
  echo "Cookie already exists: $cookie_path"
  exit 1
fi

# fetch the cookie and xsrf token
curl -s -c "$cookie_path" -o /dev/null -X POST "$catalog_url/srv/eng/info?type=me"
token=$(grep XSRF-TOKEN "$cookie_path" | cut -f 7)

# check we're authenticated (should see 'authenticated="true"')
info_me=$(curl --silent -X POST -H "X-XSRF-TOKEN: $token" --user "$catalog_user:$catalog_pass" -b "$cookie_path" "$catalog_url/srv/eng/info?type=me")
authed=$(echo "$info_me" | grep -c "authenticated=\"true\"")

if [[ $authed == 1 ]]; then
  echo "authentication ok"
  echo "executing reindex call"
  reindex_path="srv/api/site/index?reset=true"
  response_code=$(curl -s -w "%{http_code}" -X PUT "$catalog_url/$reindex_path" -H "Accept: application/json" -H "X-XSRF-TOKEN: $token" -c $cookie_path -b $cookie_path --user "$catalog_user:$catalog_pass" -o /dev/null)
  if [[ $response_code == "200" ]]; then
    # happy path: cleanup cookie and exit successfully
    echo "reindex successful"
    # TODO wait until reindex has completed (async)
    rm -f "$cookie_path"
    exit 0
  fi
else
  echo "we could not authenticate"
fi

# error fallback: cleanup cookie and exit
rm -f "$cookie_path"
exit 1
