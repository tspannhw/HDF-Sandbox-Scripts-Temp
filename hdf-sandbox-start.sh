#!/bin/bash
echo "Deploying HDF Sandbox Container:"
until docker ps 2>&1| grep STATUS>/dev/null; do  sleep 1; done; >/dev/null
docker ps -a | grep sandbox
if [ $? -eq 0 ]; then
 docker start sandbox
else
docker run -v hadoop:/hadoop --name sandbox --hostname "sandbox.hortonworks.com" --privileged -d -p 12181:2181 -p 3000:3000 -p 4200:4200 -p 4557:4557 -p 6080:6080 -p 8000:8000 -p 8080:8080 -p 8744:8744 -p 8886:8886 -p 8888:8888 -p 8993:8993 -p 19000:9000 -p 9090:9090 -p 9091:9091 -p 9089:9089 42111:42111 -p 61888:61888 -p 15100:15100 -p 15101:15101 -p 15102:15102 -p 15103:15103 -p 15104:15104 -p 15105:15105 -p 17000:17000 -p 17001:17001 -p 17002:17002 -p 17003:17003 -p 17004:17004 -p 17005:17005 -p 8081:8081 -p 8090:8090 -p 9088:9088 -p 16667:6667 -p 7777:7777 -p 7788:7788 -p 7789:7789 -p 2222:22 sandbox:v2 /usr/sbin/sshd -D
fi
docker exec -d sandbox service mysqld start
docker exec -t sandbox service postgresql start
docker exec -t sandbox service ambari-server start
docker exec -t sandbox service ambari-agent start

sleep 20
echo "Successfully Started Sandbox Container"
