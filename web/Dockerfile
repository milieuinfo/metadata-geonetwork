FROM jetty:9.4.49-jdk8

ENV DATA_DIR /catalogue-data
ENV JAVA_OPTS -Dorg.eclipse.jetty.annotations.AnnotationParser.LEVEL=OFF \
        -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true \
        -Xms512M -Xss512M -Xmx2G -XX:+UseConcMarkSweepGC \
        -Dgeonetwork.resources.dir=${DATA_DIR}/resources \
        -Dgeonetwork.data.dir=${DATA_DIR} \
        -Dgeonetwork.codeList.dir=/var/lib/jetty/webapps/geonetwork/WEB-INF/data/config/codelist \
        -Dgeonetwork.schema.dir=/var/lib/jetty/webapps/geonetwork/WEB-INF/data/config/schema_plugins

USER root
RUN apt-get -y update && \
    apt-get -y install --no-install-recommends unzip && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /${DATA_DIR} && \
    chown -R jetty:jetty ${DATA_DIR} && \
    mkdir -p /var/lib/jetty/webapps/geonetwork && \
    chown -R jetty:jetty /var/lib/jetty/webapps/geonetwork

USER jetty
ENV GN_FILE geonetwork.war

COPY ./target/geonetwork.war /var/lib/jetty/webapps/geonetwork/geonetwork.war

RUN ls /var/lib/jetty/webapps/geonetwork/

RUN cd /var/lib/jetty/webapps/geonetwork/ && \
     unzip -q geonetwork.war && \
     rm geonetwork.war

RUN ls /var/lib/jetty/webapps/geonetwork/

COPY ./docker-entrypoint.sh /geonetwork-entrypoint.sh
ENTRYPOINT ["/geonetwork-entrypoint.sh"]

CMD ["java","-jar","/usr/local/jetty/start.jar"]

VOLUME [ "${DATA_DIR}" ]