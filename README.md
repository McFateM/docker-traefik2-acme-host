# docker-traefik2-host

Generalized Docker server modified to use Traefik v2.2 based on guidance in [Traefik 2.0 + Docker -- a Simple Step by Step Guide](https://medium.com/@containeroo/traefik-2-0-docker-a-simple-step-by-step-guide-e0be0c17cfa5). Original concept as documented in [My dockerized-server Config](https://dlad.summittdweller.com/en/posts/042-my-dockerized-server-config/).

At last check, 27-Apr-2020, the previous version of this project was used on:

  - https://static.grinnell.edu  : Grinnell College hosted server
  - https://summittdweller.com   : Personal DigitalOcean VPS (`digital-ocean-containrrr` branch)

On 30-Apr-2020 this project is being built for initial use on:

  - https://static.grinnell.edu : Grinnell College Libraries server for misc. "static" applications
    - Host for https://static.grinnell.edu - The server landing page
    - Host for https://vaf.grinnell.edu - The Visualizing Abolition and Freedom (VAF) static site
    - Host for https://vaf-kiosk.grinnell.edu - The VAF kiosk site
    - Host for https://rootstalk-static.grinnell.edu - The FUTURE Rootstalk e-zine site

As of 30-Apr-2020 the dashboards for GC's `static.grinnell.edu` server are:

  - http://static.grinnell.edu/dashboard/
  - https://static.grinnell.edu/portainer/


The aforementioned guide, [Traefik 2.0 + Docker -- a Simple Step by Step Guide](https://medium.com/@containeroo/traefik-2-0-docker-a-simple-step-by-step-guide-e0be0c17cfa5), builds an environment destined to live in `/opt/containers`, and this project does the same.

## To Initialize the Host

The project and _Traefik_ were initiated on `static.grinnell.edu` like so:

```
sudo su
docker stop $(docker ps -q); docker system prune --force
cd /opt
git clone https://github.com/McFateM/docker-traefik2-host containers
touch /opt/containers/traefik/data/acme.json
chmod 600 /opt/containers/traefik/data/acme.json
docker network create proxy
cd /opt/containers/traefik
docker-compose up -d
```

## Adding Portainer

Lkewise on `static.grinnell.edu`:

```
sudo su
cd /opt/containers/portainer
docker-compose up -d
```

Note that successful configuration of the `https://static.grinnell.edu/portainer` address was gleaned from the post: [Proxy Portainer under sub path](https://community.containo.us/t/proxy-portainer-under-sub-path/3601).

##  Launching Application Stacks On static.grinnell.edu

@TODO: Modify the following for Traefik v2

```
# static.grinnell.edu - The server landing page: rewritten for Traefik v2
NAME=static-landing-page
HOST=static.grinnell.edu
IMAGE="mcfatem/static-landing"
docker container run -d --name static-landing-page \
    --label "traefik.enable=true" \
    --label "traefik.http.routers.static-landing-page.rule=Host('static.grinnell.edu') || (Host('static.grinnell.edu') && Path('/landing-page'))" \
    --label traefik.docker.network=proxy \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network proxy \
    --restart always \
  mcfatem/static-landing

# vaf.grinnell.edu - The VAF site
docker container run -d --name vaf \
    --label traefik.backend=vaf \
    --label traefik.docker.network=web \
    --label "traefik.frontend.rule=Host:vaf.grinnell.edu" \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network web \
    --restart always \
  mcfatem/vaf

# vaf-kiosk.grinnell.edu - The VAF kiosk site
docker container run -d --name vaf-kiosk \
    --label traefik.backend=vaf-kiosk \
    --label traefik.docker.network=web \
    --label "traefik.frontend.rule=Host:vaf-kiosk.grinnell.edu" \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network web \
    --restart always \
  mcfatem/vaf-kiosk
```

## Attempting To Use Traefik v2
