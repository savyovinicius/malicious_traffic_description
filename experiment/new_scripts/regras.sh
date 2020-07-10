#!/bin/bash
sudo ovs-ofctl replace-flows br0 ../new_rules/$1.txt
