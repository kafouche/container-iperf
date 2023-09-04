# iPerf3
This image is based on *Alpine Linux* latest stable image.

## Image
### Environment
| Parameter | Description                                          |
|-----------|------------------------------------------------------|
| `TZ`      | Set container's timezone (*default*: `Europe/Paris`) |

### Network Ports
| Port      | Description                  |
|-----------|------------------------------|
| `5201`    | Default server tcp/udp port. |


## Build
```
docker build -t kafouche/iperf3:latest .
```


## Run
The following `code blocks` are only there as **examples**.
### Manual
```
docker run --detach \
    --env-file $(pwd)/.env \
    --name iperf3 \
    --network bridge \
    --publish 5201:5201 \
    --restart unless-stopped \
    kafouche/iperf3:latest
```

### Composer
```
---
version: "3"

services:
    iperf3:
        container_name: iperf3
        image: "kafouche/iperf3:latest"
        network_mode: bridge
        ports:
          - 5201:5201
        restart: unless-stopped
```
