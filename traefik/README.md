---
Host: Defined as ${HOST} in .env
Service: traefik
URL: https://${HOST}/dashboard/
---

This document should be used to launch the `traefik` service on ANY host as part of a `docker-traefik2-acme-host` stack.

> Note that this process should be started only AFTER the `acme` service!

## Preparation

Before entering the prescribed "Command Sequence", below, the user should take steps to...

  - Comment out one of the `CASERVER=` specifications.  Comment out the second one (includes 'staging') for **production**, or the first one for **testing/staging**.

## Command Sequence

```
cd ~/host/traefik
docker-compose up -d; docker-compose logs
```
