#!/bin/bash

sudo ovs-ofctl dump-flows br0 | grep n_packets=[^0] > ../new_counters/$1_$2_flows.txt
scp mirai@192.168.56.3:/tmp/*.output ../new_counters
mv ../new_counters/cnc.output ../new_counters/$1_$2_cnc.output
mv ../new_counters/loader.output ../new_counters/$1_$2_loader.output
mv ../new_counters/scan.output ../new_counters/$1_$2_scan.output
