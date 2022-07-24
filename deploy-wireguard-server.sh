#!/bin/bash

#@hos7ein

### Install required packages:
yum install -y epel-release elrepo-release
yum install -y yum-plugin-elrepo
yum install -y kmod-wireguard #wireguard-tools

### Deploy wireguard container:
docker run -d \
  --name=wireguard \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -e SERVERURL=<Your_IP> \
  -e SERVERPORT=<Your_Port> \
  -e PEERS=4  \
  -e PEERDNS=auto \
  -e INTERNAL_SUBNET=10.13.13.0 \
  -e ALLOWEDIPS=0.0.0.0/0 \
  -p <Your_port>:51820/udp \
  -v /path/to/appdata/config:/config \
  -v /lib/modules:/lib/modules \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --restart unless-stopped \
  ghcr.io/linuxserver/wireguard
