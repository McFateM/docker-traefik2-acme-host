#!/bin/bash
#
docker network create proxy
cd /opt/docker-traefik2-acme-host/acme
docker-compose up -d; docker-compose logs
docker exec -it acme --issue --dns dns_azure --server https://acme-staging-v02.api.letsencrypt.org/directory -d dgdocker3.grinnell.edu --domain-alias _acme-challenge.leverify.info --key-file /certs/dgdocker3.grinnell.edu.key --cert-file /certs/dgdocker3.grinnell.edu.cert --standalone --force
#
## Terminate prematurely during testing.
return
#
cd ../traefik
docker-compose up -d; docker-compose logs
cd ../whoami
docker-compose up -d; docker-compose logs
#
#cd ../watchtower
#docker-compose up -d; docker-compose logs
#cd ../portainer
#docker-compose up -d; docker-compose logs
#
## For DGDocker3.Grinnell.edu...
#cd ../landing
#docker-compose up -d; docker-compose logs
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
