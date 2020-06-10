---
Host: static.grinnell.edu
Service: acme
---

This document should be used to launch the `acme` service on host `static.grinnell.edu`.

> Note that this process should be started FIRST when relaunching the application stack on any host!

## Preparation

Before entering the prescribed "Command Sequence", below, the user should take steps to...

  - Comment out one of the `CASERVER=` specifications.  Comment out the second one (includes 'staging') for **production**, or the first one for **testing/staging**.
  - Make sure that the `-d`, `--key-file`, and `--cert-file` flags all specify `static.grinnell.edu`.

## Command Sequence

```
# CASERVER=https://acme-v02.api.letsencrypt.org/directory
CASERVER=https://acme-staging-v02.api.letsencrypt.org/directory
docker network create proxy
cd ~/host/acme
docker-compose up -d; docker-compose logs
docker exec -it acme --issue --dns dns_azure --server ${CASERVER} -d static.grinnell.edu --domain-alias _acme-challenge.leverify.info --key-file /certs/static.grinnell.edu.key --cert-file /certs/static.grinnell.edu.cert --standalone --force
```
