FROM alpine:edge

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories
RUN apk update

# RUN apk add mongodb=3.4.4-r0

RUN apk add --no-cache mongodb \
    build-base \
    gcc \
    git bash git nano mongodb-tools

VOLUME /data/db
EXPOSE 27017 28017

COPY dockerfiles/executables/run.sh /usr/bin/runmongo
RUN chmod +x /usr/bin/runmongo

ENTRYPOINT [ "/usr/bin/runmongo" ]
#CMD [ "mongod", "--bind_ip", "0.0.0.0" , "--wiredTigerCacheSizeGB=20"]
CMD [ "mongod", "--bind_ip", "0.0.0.0" ]
