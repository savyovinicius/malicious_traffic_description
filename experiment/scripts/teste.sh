#!/bin/bash

#bash start_targets.sh 112; sleep 10s; bash load_bot.sh 19; bash regras.sh mtd; bash run_bot.sh 19; bash attacks.sh; bash stop_targets.sh 112; bash get_counters.sh 1ne10 mtd10

function run_scenario() {
	#SERVER="192.168.56.3"
	#SERVER="216.58.202.227"
	SERVER="216.58.202.229"

	until ssh mirai@$SERVER "cp Mirai-Source-Code/mirai/release/mirai.x86 ./dvrHelper"; do sleep 5 ; done;
	#until ssh mirai@$SERVER "wget http://216.58.202.229/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"; do sleep 5 ; done;
	bash start_targets.sh 112;
	bash regras.sh $1;
	until ssh mirai@$SERVER "sudo ./dvrHelper";  do sleep 5 ; done;
	bash attacks.sh;
	bash stop_targets.sh 112;
	bash get_counters.sh edge$2 $3$2;
	ssh mirai@$SERVER "sudo reboot";
}

echo "open 2"
run_scenario all 2 open > logsedge2open.txt
echo "mud 2"
run_scenario mud 2 mud > logsedge2mud.txt
echo "mtd 2"
run_scenario mtd 2 mtd > logsedge2mtd.txt
echo "open 3"
run_scenario all 3 open  > logsedge3open.txt
echo "mud 3"
run_scenario mud 3 mud  > logsedge3mud.txt
echo "mtd 3"
run_scenario mtd 3 mtd  > logsedge3mtd.txt
echo "open 4"
run_scenario all 4 open > logsedge4open.txt
echo "mud 4"
run_scenario mud 4 mud  > logsedge4mud.txt
echo "mtd 4"
run_scenario mtd 4 mtd  > logsedge4mtd.txt
echo "open 5"
run_scenario all 5 open > logsedge5open.txt
echo "mud 5"
run_scenario mud 5 mud  > logsedge5mud.txt
echo "mtd 5"
run_scenario mtd 5 mtd  > logsedge5mtd.txt
echo "open 6"
run_scenario all 6 open > logsedge6open.txt
echo "mud 6"
run_scenario mud 6 mud  > logsedge6mud.txt
echo "mtd 6"
run_scenario mtd 6 mtd  > logsedge6mtd.txt
echo "open 7"
run_scenario all 7 open > logsedge7open.txt
echo "mud 7"
run_scenario mud 7 mud  > logsedge7mud.txt
echo "mtd 7"
run_scenario mtd 7 mtd  > logsedge7mtd.txt
echo "open 8"
run_scenario all 8 open > logsedge8open.txt
echo "mud 8"
run_scenario mud 8 mud  > logsedge8mud.txt
echo "mtd 8"
run_scenario mtd 8 mtd  > logsedge8mtd.txt
echo "open 9"
run_scenario all 9 open > logsedge9open.txt
echo "mud 9"
run_scenario mud 9 mud  > logsedge9mud.txt
echo "mtd 9"
run_scenario mtd 9 mtd  > logsedge9mtd.txt
echo "open 10"
run_scenario all 10 open > logsedge10open.txt
echo "mud 10"
run_scenario mud 10 mud  > logsedge10mud.txt
echo "mtd 10"
run_scenario mtd 10 mtd  > logsedge10mtd.txt
