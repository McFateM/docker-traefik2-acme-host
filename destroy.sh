#!/bin/bash
#
docker stop $(docker ps -q);
docker rm -v $(docker ps -qa);
# docker image rm $(docker image ls -q)
docker system prune --force
