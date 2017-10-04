### Build stage
FROM maven

WORKDIR jmx_exporter

RUN git clone https://github.com/prometheus/jmx_exporter . && \
    mvn package


### Final stage
FROM openjdk:jre-alpine

COPY --from=0 /jmx_exporter/jmx_prometheus_httpserver/target/*.deb ./

RUN apk update && \
    apk add dpkg tar && \
    dpkg -x ./*.deb /

CMD ["jmx_exporter"]

