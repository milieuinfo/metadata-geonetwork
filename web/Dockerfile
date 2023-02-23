FROM jetty:9.4.49-jdk8

ENV DATA_DIR /catalogue-data
ENV JAVA_OPTS -Dorg.eclipse.jetty.annotations.AnnotationParser.LEVEL=OFF \
        -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true \
        -Xms512M -Xss512M -Xmx2G -XX:+UseConcMarkSweepGC \
        -Dgeonetwork.resources.dir=${DATA_DIR}/resources \
        -Dgeonetwork.data.dir=${DATA_DIR} \
        -Dgeonetwork.codeList.dir=/var/lib/jetty/webapps/root/WEB-INF/data/config/codelist \
        -Dgeonetwork.schema.dir=/var/lib/jetty/webapps/root/WEB-INF/data/config/schema_plugins

USER root
RUN apt-get -y update && \
    apt-get -y install --no-install-recommends unzip && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /${DATA_DIR} && \
    chown -R jetty:jetty ${DATA_DIR} && \
    rm -rf /var/lib/jetty/webapps/root && \
    mkdir -p /var/lib/jetty/webapps/root && \
    chown -R jetty:jetty /var/lib/jetty/webapps/root

USER jetty
ENV SOURCE_WAR geonetwork.war
ENV TARGET_WAR root.war
COPY ./target/${SOURCE_WAR} /var/lib/jetty/webapps/root/${TARGET_WAR}

RUN cd /var/lib/jetty/webapps/root/ && \
     unzip -q ${TARGET_WAR} && \
     rm ${TARGET_WAR}

COPY ./docker-entrypoint.sh /geonetwork-entrypoint.sh

# necessary on DevOps, +x flag is lost there
USER root
RUN chmod 755 /geonetwork-entrypoint.sh
USER jetty

ENTRYPOINT ["/geonetwork-entrypoint.sh"]

CMD ["java","-jar","/usr/local/jetty/start.jar"]

VOLUME [ "${DATA_DIR}" ]