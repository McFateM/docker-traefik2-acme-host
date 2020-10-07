---
Host: Defined as ${HOST} in .env
Service: watchtower
URL: None
---

This document should be used to launch the `watchtower` service on ANY host as part of a `docker-traefik2-acme-host` stack.  

>  Note that this process should be started only AFTER the `traefik` service!  

## Preparation

Check that the `.env` file exists in `~/host/watchtower` and that it's contents are correctly specified for THIS server!  Try this:

  - `rsync -aruvi administrator@static.grinnell.edu:/home/administrator/host/watchtower/.env . --progress`

## Command Sequence

  - cd ~/host/watchtower
  - cat .env
  - docker-compose up -d; docker-compose logs

## Output

After a few minutes the email address specified in `.env` should receive a notification that looks something like this:

  - 2020-06-10 18:33:11 (info): Starting Watchtower and scheduling first run: 2020-06-10 18:38:11 +0000 UTC m=+300.238090223
