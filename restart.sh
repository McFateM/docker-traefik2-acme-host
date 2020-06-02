#!/bin/bash
#
docker network create proxy
cd /opt/containers/traefik
docker-compose up -d; docker-compose logs
cd ../watchtower
docker-compose up -d; docker-compose logs
cd ../portainer
docker-compose up -d; docker-compose logs
#
## For DGDocker3.Grinnell.edu...
cd ../landing
docker-compose up -d; docker-compose logs
#
## For Static.Grinnell.edu...
# cd ../static-landing-page
# docker-compose up -d; docker-compose logs
# cd ../rootstalk-static
# docker-compose up -d; docker-compose logs
# cd ../vaf
# docker-compose up -d; docker-compose logs
# docker-compose --file docker-compose.kiosk.yml up -d; docker-compose logs
#
echo "Dumping traefik.log..."
docker exec -it traefik cat /var/log/traefik.log
