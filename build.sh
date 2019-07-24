#!/bin/bash
git pull
docker stack rm ollemg
images=docker ps -a | awk '{print $1}'
for i in "${images[*]}" do
docker rm $i;
done
docker stack deploy -c docker-compose.yml ollemg