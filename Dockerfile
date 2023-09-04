# Dockerfile: iperf3
# iPerf3 Network Speed Test.

FROM        alpine:latest

RUN         apk upgrade --no-cache --update \
            && apk --no-cache --update add \
                iperf3

ENV         TZ=Europe/Paris

EXPOSE      5201

ENTRYPOINT  [ "/usr/bin/iperf3" ]
CMD         [ "--server" ]