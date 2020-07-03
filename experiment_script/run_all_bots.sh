#!/bin/bash
AUX=$(($1 + 0))

function run_bot() {
	docker exec -w / -i $1 sh -c "./dvrHelper"
}

for i in $(seq 1 $AUX)
do
	run_bot "bb$i" &
done
