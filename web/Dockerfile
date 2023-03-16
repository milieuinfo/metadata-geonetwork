FROM jetty:9.4.49-jdk8

ENV DATA_DIR /catalogue-data
# run in '/' instead of '/geonetwork' (the default)
ENV WEBAPP_NAME root
ENV JAVA_OPTS -Dorg.eclipse.jetty.annotations.AnnotationParser.LEVEL=OFF \
        -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true \
        -Xms512M -Xss512M -Xmx2G -XX:+UseConcMarkSweepGC \
        # managed by geonetwork.dir
        # -Dgeonetwork.resources.dir=${DATA_DIR}/resources \
        -Dgeonetwork.dir=${DATA_DIR} \
        -Dgeonetwork.codeList.dir=/var/lib/jetty/webapps/${WEBAPP_NAME}/WEB-INF/data/config/codelist \
        # we prefer to pick up the ones from build time, not persisted
        -Dgeonetwork.schema.dir=/var/lib/jetty/webapps/${WEBAPP_NAME}/WEB-INF/data/config/schema_plugins

USER root
RUN apt-get -y update && \
    apt-get -y install --no-install-recommends unzip && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /${DATA_DIR} && \
    chown -R jetty:jetty ${DATA_DIR} && \
    mkdir -p /var/lib/jetty/webapps/${WEBAPP_NAME} && \
    chown -R jetty:jetty /var/lib/jetty/webapps/${WEBAPP_NAME}

USER jetty
ENV GN_FILE geonetwork.war
COPY ./target/${GN_FILE} /var/lib/jetty/webapps/${WEBAPP_NAME}/${GN_FILE}

RUN cd /var/lib/jetty/webapps/${WEBAPP_NAME}/ && \
     unzip -q ${GN_FILE} && \
     rm ${GN_FILE}

COPY ./docker-entrypoint.sh /geonetwork-entrypoint.sh

# necessary on DevOps, +x flag is lost there
USER root
RUN chmod 755 /geonetwork-entrypoint.sh
USER jetty

ENTRYPOINT ["/geonetwork-entrypoint.sh"]

CMD ["java","-jar","/usr/local/jetty/start.jar"]

VOLUME [ "${DATA_DIR}" ]