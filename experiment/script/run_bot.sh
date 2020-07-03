#!/bin/bash
docker exec -w / -it bb$1 sh -c "./dvrHelper && sleep 1" &
