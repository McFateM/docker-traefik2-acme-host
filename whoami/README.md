---
Host: Defined as ${HOST} in .env
Service: whoami
URL: https://${HOST}/whoami/
---

This document should be used to launch the `whoami` service on ANY host as part of a `docker-traefik2-acme-host` stack.

> Note that this process should be started only AFTER the `acme` and `traefik` services!

## Preparation

Before entering the prescribed "Command Sequence", below, the user should take steps to...

  - Check the definition of `HOST` in the `.env` file.
  
## Command Sequence

```
cd ~/host/whoami
cat .env
docker-compose up -d; docker-compose logs
```
