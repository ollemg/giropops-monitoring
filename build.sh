#!/bin/bash
git pull
docker stack rm ollemg
docker stack -c docker-compose.yml ollemg