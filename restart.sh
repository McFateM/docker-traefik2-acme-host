#!/bin/bash
#
docker network create proxy
cd ~/host/acme
docker-compose up -d; docker-compose logs
#docker exec -it acme --issue --dns dns_azure --server https://acme-staging-v02.api.letsencrypt.org/directory -d dgdockerx.grinnell.edu --domain-alias _acme-challenge.leverify.info --key-file /certs/dgdockex.grinnell.edu.key --cert-file /certs/dgdockerx.grinnell.edu.cert --standalone --force
#docker exec -it acme --issue --dns dns_azure --server https://acme-staging-v02.api.letsencrypt.org/directory -d dg-staging.grinnell.edu  --domain-alias _acme-challenge.leverify.info --key-file /certs/dg-staging.grinnell.edu.key --cert-file /certs/dg-staging.grinnell.edu.cert --standalone --force
docker exec -it acme --issue --dns dns_azure -d dgdockerx.grinnell.edu --domain-alias _acme-challenge.leverify.info --key-file /certs/dgdockerx.grinnell.edu.key --cert-file /certs/dgdockerx.grinnell.edu.cert --standalone --force
docker exec -it acme --issue --dns dns_azure -d dg-staging.grinnell.edu  --domain-alias _acme-challenge.leverify.info --key-file /certs/dg-staging.grinnell.edu.key --cert-file /certs/dg-staging.grinnell.edu.cert --standalone --force
#
cd ../traefik
docker-compose up -d; docker-compose logs
cd ../whoami
docker-compose up -d; docker-compose logs
#
cd ../watchtower
docker-compose up -d; docker-compose logs
cd ../portainer
docker-compose up -d; docker-compose logs
#
## For DGDockerX.Grinnell.edu...
cd ../dgdockerx-landing-page
docker-compose up -d; docker-compose logs
cd ../test
docker-compose up -d; docker-compose logs
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
