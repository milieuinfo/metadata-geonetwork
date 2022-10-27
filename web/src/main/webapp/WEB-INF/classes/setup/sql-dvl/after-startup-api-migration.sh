export CATALOG=http://localhost:8080/geonetwork
export CATALOGUSER=admin
export CATALOGPASS=admin

# Connect
rm -f /tmp/cookie;
curl -s -c /tmp/cookie -o /dev/null -X POST "$CATALOG/srv/eng/info?type=me";
export TOKEN=`grep XSRF-TOKEN /tmp/cookie | cut -f 7`;
curl -X POST -H "X-XSRF-TOKEN: $TOKEN" --user $CATALOGUSER:$CATALOGPASS -b /tmp/cookie \
  "$CATALOG/srv/eng/info?type=me"


# Remove unused languages
for l in spa cat rus por chi nor fin ara ita tur vie pol slo
do
  curl -X DELETE "$CATALOG/srv/api/languages/$l" \
 -H "X-XSRF-TOKEN: $TOKEN" -c /tmp/cookie -b /tmp/cookie --user $CATALOGUSER:$CATALOGPASS
done


# Remove categories
for l in 1 2 3 4 5 6 7 8 9 10 12 13
do
  curl -X DELETE "$CATALOG/srv/api/tags/$l" \
 -H "X-XSRF-TOKEN: $TOKEN" -c /tmp/cookie -b /tmp/cookie --user $CATALOGUSER:$CATALOGPASS
done
