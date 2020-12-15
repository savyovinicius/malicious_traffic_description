#!/bin/bash
AUX=$(($1 + 0))

function stop_target() {
	sudo ovs-docker del-ports br0 $1
	docker stop -t 0 $1
}

for i in $(seq 1 $AUX)
do
	stop_target "bb$i"
done

killall sleep
#killall bash
