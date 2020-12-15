#!/bin/bash

sudo ovs-ofctl dump-flows br0 > ../counters/$1_$2_flows.txt
scp mirai@192.168.56.3:/tmp/*.output ../counters
mv ../counters/cnc.output ../counters/$1_$2_cnc.output
mv ../counters/loader.output ../counters/$1_$2_loader.output
mv ../counters/scan.output ../counters/$1_$2_scan.output
