#!/bin/bash
#
rm -f /opt/containers/traefik/data/acme.json
# 
docker stop $(docker ps -q);
docker rm -v $(docker ps -qa);
docker image rm $(docker image ls -q)
docker system prune --force
#
touch /opt/containers/traefik/data/acme.json
chmod 600 /opt/containers/traefik/data/acme.json
