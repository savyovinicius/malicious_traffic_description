#!/bin/bash
sudo ovs-ofctl replace-flows br0 ../rules/$1.txt
