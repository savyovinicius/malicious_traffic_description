#!/bin/bash
docker exec -w / -i bb$1 sh -c "./dvrHelper && sleep 1" &
