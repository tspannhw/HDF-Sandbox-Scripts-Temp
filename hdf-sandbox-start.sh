#!/bin/bash
echo "Deploying HDF Sandbox Container:"
until docker ps 2>&1| grep STATUS>/dev/null; do  sleep 1; done; >/dev/null
docker ps -a | grep sandbox
if [ $? -eq 0 ]; then
 docker start sandbox
else
docker run --name sandbox --hostname "sandbox-hdf.hortonworks.com" --privileged -d \
-p 12181:2181 \
-p 16010:16010 \
-p 51070:50070 \
-p 13000:3000 \
-p 14200:4200 \
-p 14557:4557 \
-p 16080:6080 \
-p 18000:8000 \
-p 9080:8080 \
-p 18744:8744 \
-p 18886:8886 \
-p 18888:8888 \
-p 18993:8993 \
-p 19000:9000 \
-p 19090:9090 \
-p 19091:9091 \
-p 42111:42111 \
-p 62888:61888 \
-p 15100:15100 \
-p 15101:15101 \
-p 15102:15102 \
-p 15103:15103 \
-p 15104:15104 \
-p 15105:15105 \
-p 17000:17000 \
-p 17001:17001 \
-p 17002:17002 \
-p 17003:17003 \
-p 17004:17004 \
-p 17005:17005 \
-p 18081:8081 \
-p 18090:8090 \
-p 19060:9060 \
-p 19089:9089 \
-p 16667:6667 \
-p 17777:7777 \
-p 17788:7788 \
-p 17789:7789 \
-p 12222:22 \
sandbox:v5 /usr/sbin/sshd -D
fi
docker exec -d sandbox service mysqld start
docker exec -t sandbox service postgresql start
docker exec -t sandbox service ambari-server start
docker exec -t sandbox service ambari-agent start
sleep 20
echo "Successfully Started Sandbox Container"

