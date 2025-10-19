# Dockerfile: iperf
# Kafouche iPerf Image.

FROM        ghcr.io/kafouche/alpine:latest

LABEL       org.opencontainers.image.authors="kafouche"
LABEL       org.opencontainers.image.base.name="ghcr.io/kafouche/iperf:latest"
LABEL       org.opencontainers.image.ref.name="ghcr.io/kafouche/alpine"
LABEL       org.opencontainers.image.source="https://github.com/kafouche/container-iperf"
LABEL       org.opencontainers.image.title="iPerf3"

# ------------------------------------------------------------------------------

RUN         apk --no-cache --update upgrade \
            && apk --no-cache --update add \
              iperf3

RUN         addgroup -S iperf \
            && adduser -D -G iperf -h /var/lib/iperf -H -s /sbin/nologin -S iperf

WORKDIR     /

EXPOSE      5201

USER        iperf

ENTRYPOINT  [ "/usr/bin/iperf3" ]
CMD         [ "--server" ]
