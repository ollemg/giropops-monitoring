#!/bin/bash
git pull
docker stack rm ollemg
docker stack deploy -c docker-compose.yml ollemg