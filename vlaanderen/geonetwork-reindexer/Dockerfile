FROM alpine:3.18.0
RUN apk update
RUN apk add bash
RUN apk add curl
COPY reindex.sh /
CMD ["bash", "/reindex.sh", "-u", "mdv", "-p", "admin", "-b", "http://geonetwork:8080"]
