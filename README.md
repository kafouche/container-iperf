# iPerf

This image is based on *Alpine Linux* latest stable image.

## Ports

| Port   | Description          |
|--------|----------------------|
| `5201` | Default Server Port. |

## Run

The following `code blocks` are only there as **examples**.

### Manual

**Docker**

```
docker run --detach \
    --name iperf \
    --network bridge \
    --publish 5201:5201/tcp \
    --restart unless-stopped \
    ghcr.io/kafouche/iperf:latest
```

```
docker exec --interactive --tty iperf iperf3 -c X.X.X.X
```

**Podman**

```
podman run --detach \
    --name iperf \
    --network bridge \
    --publish 5201:5201/tcp \
    --restart unless-stopped \
    localhost/kafouche/iperf:latest
```

```
podman exec --interactive --tty iperf iperf3 -c X.X.X.X
```

### Composer
```
---
version: "3"

services:
  owntone:
    container_name: "iperf"
    image: "ghcr.io/kafouche/iperf:latest"
    network_mode: bridge
    ports:
      - 5201:5201/tcp
    restart: unless-stopped
```