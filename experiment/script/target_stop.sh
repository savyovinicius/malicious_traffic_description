#!/bin/bash
sudo ovs-docker del-ports br0 $1
docker stop $1
