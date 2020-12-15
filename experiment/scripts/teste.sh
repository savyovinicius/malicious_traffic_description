#!/bin/bash

#bash start_targets.sh 112; sleep 10s; bash load_bot.sh 19; bash regras.sh mtd; bash run_bot.sh 19; bash attacks.sh; bash stop_targets.sh 112; bash get_counters.sh 1ne10 mtd10

function run_scenario() {
	SERVER="192.168.56.3"

	bash start_targets.sh 112;
	sleep 10s
	bash load_all_bots.sh 112;
	bash regras.sh $1;
	bash run_all_bots.sh 112;
	bash attacks.sh;
	bash stop_targets.sh 112;
	bash get_counters.sh all$2 $3$2;
	ssh mirai@$SERVER "sudo reboot";
}

echo "all 1"
run_scenario all 1 mtd2 > logsall1mtd2.txt
echo "all 1"
run_scenario all 2 mtd2 > logsall2mtd2.txt
echo "all 1"
run_scenario all 3 mtd2 > logsall3mtd2.txt
echo "all 1"
run_scenario all 4 mtd2 > logsall4mtd2.txt
echo "all 1"
run_scenario all 5 mtd2 > logsall5mtd2.txt
echo "all 1"
run_scenario all 6 mtd2 > logsall6mtd2.txt
echo "all 1"
run_scenario all 7 mtd2 > logsall7mtd2.txt
echo "all 1"
run_scenario all 8 mtd2 > logsall8mtd2.txt
echo "all 1"
run_scenario all 9 mtd2 > logsall9mtd2.txt
echo "all 1"
run_scenario all 10 mtd2 > logsall10mtd2.txt