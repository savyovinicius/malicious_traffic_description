#!/bin/bash
docker run --network none --name bb --rm -d -it mirai_target
sudo ovs-docker add-port br0 eth1 bb --ipaddress="192.168.5.104/24" --gateway="192.168.5.1"
docker exec -it bb /bin/sh
