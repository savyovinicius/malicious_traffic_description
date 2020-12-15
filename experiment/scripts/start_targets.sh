#!/bin/bash
AUX=$(($1 + 0))

function start_target() {
	docker run --network none --name $1 --rm -d -it --cpus="0.02" mirai_target:kill
	sudo ovs-docker add-port br0 eth1 $1 --ipaddress="192.168.5.$(($i + 99))/24" --gateway="192.168.5.1"
	sleep 40m
	bash target_stop.sh $1
}

for i in $(seq 1 $AUX)
do
	start_target "bb$i" &
done

sh regras.sh a
