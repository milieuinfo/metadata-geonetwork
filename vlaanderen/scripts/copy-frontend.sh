#!/bin/bash
# watch the frontend files for modification and update the deployment when they change

# the folder to copy from and to keep watch on
SOURCE=../../web-ui/src/main/resources/catalog
# the folder to which the new files are being copied
TARGET=../../web/target/geonetwork/catalog

# account to perform admin-level management
ADMIN_USER=mdv
ADMIN_PASS=admin

# clear the last cookie
rm -f /tmp/cookie;
# get the XSRF token
# -f: fail silently (this call always returns a 403)
curl -f -c /tmp/cookie -X "POST" -S "http://localhost:8080/srv/eng/info?type=me"
XSRF_TOKEN=$(grep XSRF /tmp/cookie | cut -f 7)

# check login
# curl -X POST "http://localhost:8080/srv/eng/info?type=me" -H "X-XSRF-TOKEN: $XSRF_TOKEN" --user $ADMIN_USER:$ADMIN_PASS -b /tmp/cookie

# attempt to do a refresh on change
inotifywait -e close_write,moved_to,create -m -r --include "\.(js|css|html|htm|json)$" $SOURCE |
while read -r directory events filename; do
  # notification
  echo "file changed: $filename in $directory"

  # sync the folder
  rsync --progress -a $SOURCE $TARGET

  # refresh cache
  if [[ "$filename" =~ \.(js|html|css|htm)$ ]]; then
      echo "Web file change detected"
      curl http://localhost:8080/static/wroAPI/reloadModel
      curl http://localhost:8080/static/wroAPI/reloadCache
  fi

  # delete the translation cache while we're at it -- doesn't work?
  if [[ "$filename" =~ \.json$ ]]; then
      echo "Locale file change detected"
      curl -X "DELETE" http://localhost:8080/srv/api/i18n/cache -H "X-XSRF-TOKEN: $XSRF_TOKEN" -H 'Accept: application/json, text/plain, */*' --user $ADMIN_USER:$ADMIN_PASS -b /tmp/cookie
  fi
done
