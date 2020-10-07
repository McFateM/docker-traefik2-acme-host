---
Host: Defined as ${HOST} in .env
Service: portainer
URL: https://${HOST}/portainer/
---

This document should be used to launch the `portainer` service on ANY host as part of a `docker-traefik2-acme-host` stack.  

> Note that this process should be started only AFTER the `acme` and `traefik` services!

## Preparation

Before entering the prescribed "Command Sequence", below, the user should take steps to copy any pertinent `.env` files from an existing deployment. Try something like this:

  - `rsync -aruvi administrator@static.grinnell.edu:/home/administrator/host/portainer/.env . --progress`

## Command Sequence

  - cd ~/host/portainer
  - cat .env
  - docker-compose up -d; docker-compose logs


