---
Host: Defined as ${HOST} in .env
Service: traefik
URL: https://${HOST}/dashboard/
---

This document should be used to launch the `traefik` service on ANY host as part of a `docker-traefik2-acme-host` stack.

> Note that this process should be started only AFTER the `acme` service!

## Preparation

Before entering the prescribed "Command Sequence", below, the user should take steps to copy any pertinent `.env` files from an existing deployment. Try something like this:

  - `rsync -aruvi administrator@static.grinnell.edu:/home/administrator/host/traefik/.env . --progress`

## Command Sequence

  - cd ~/host/traefik
  - docker-compose up -d; docker-compose logs
