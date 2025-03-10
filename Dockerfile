# Dockerfile: iperf
# iPerf Docker Image.

LABEL       org.opencontainers.image.source https://github.com/kafouche/iperf

# BUILD STAGE

FROM        ghcr.io/kafouche/alpine:latest as buildstage

ARG         RELEASE=3.18

            # MAKE PACKAGES
RUN         apk --no-cache --update upgrade \
            && apk --no-cache --update add \
                g++ \
                make

            # DOWNLOAD SOURCE
RUN         apk --no-cache --update add \
                curl \
            && curl \
                --location ""https://github.com/esnet/iperf/archive/$RELEASE.tar.gz"" \
                --output /tmp/iperf.tar.gz \
            && mkdir --parents /tmp/iperf \
            && tar --directory=/tmp/iperf --extract --file=/tmp/iperf.tar.gz --gzip --strip-components=1

RUN         cd /tmp/iperf \
            && ./configure \
                --prefix=/usr \
                --sysconfdir=/etc \
                --mandir=/usr/share/man \
                --infodir=/usr/share/info \
                --disable-static \
            && make \
            && make check \
            && make DESTDIR=/tmp/iperf/target install


# RUN STAGE

FROM        ghcr.io/kafouche/alpine:latest

RUN         apk --no-cache --update upgrade

COPY        --from=buildstage /tmp/iperf/target/ /

RUN         adduser -D -G users -h /home/iperf -s /sbin/nologin -S iperf

WORKDIR     /

EXPOSE      5201

USER        iperf

ENTRYPOINT  [ "/usr/bin/iperf3" ]
CMD         [ "--server" ]