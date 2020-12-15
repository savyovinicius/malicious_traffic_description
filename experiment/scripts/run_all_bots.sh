#!/bin/bash
AUX=$(($1 + 0))

for i in $(seq 1 $AUX)
do
	docker exec -w / -i bb$i sh -c "./dvrHelper"
done
