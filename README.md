# docker-traefik2-acme-host

Generalized Docker server stack modified to use Traefik v2.2 based on guidance in [Traefik 2.0 + Docker -- a Simple Step by Step Guide](https://medium.com/@containeroo/traefik-2-0-docker-a-simple-step-by-step-guide-e0be0c17cfa5). This project is culmination of several that came before it. Those earlier projects are documented, in chronological order, within the following posts:

  - [My dockerized-server Config](https://static.grinnell.edu/blogs/McFateM/posts/042-my-dockerized-server-config/)
  - [Dockerized Traefik Host Using ACME DNS-01 Challenge](https://static.grinnell.edu/blogs/McFateM/posts/071-dockerized-traefik-using-acme-dns-01/)
  - [Simplified Testing of Traefik 2 with ACME DNS-01 Challenge](https://static.grinnell.edu/blogs/McFateM/posts/074-simplified-testing-traefik-2-with-acme-dns-01/)
  - [Traefik and Acme.sh Instead of DNS-01](https://static.grinnell.edu/blogs/McFateM/posts/079-traefik-and-acme.sh-instead-of-dns-01/)

Significant portions of this `README.md` file can be found in the capstone to this work, [Host Config: docker-traefik2-acme-host](https://static.grinnell.edu/blogs/McFateM/posts/080-host-config-docker-traefik2-acme-host/).

## Stack Contents

This project stack includes the following elements/services:

  - **acme** - A configured version of the [neilpang/acme.sh](https://hub.docker.com/r/neilpang/acme.sh) image to obtain and manage the stack's TLS certificates.
  - **traefik** - A Traefik v2 reverse proxy to manage addressing and web traffic. Available at: `https://[host]/dashboard/`
  - **portainer** - A Portainer instance to provide Docker resource management for this host. Available at: `https://[host]/portainer/`
  - **watchtower** - A WatchTower instance to provide automatic updates of containers from images registered in this stack as they are pushed to DockerHub.
  - **whoami** - A simple WhoAmI instance provided as a sample for typical deployment. Available at: `https://[host]/whoami/`
  - **landing-page** - In September 2020 this project landed at https://dgdockerx.grinnell.edu where a landing page was added.

```
Note: As this project was pushed to https://dgdockerx.grinnell.edu I took steps to replace old `administrator@static...` references below with `islandora@dgdockerx...`.
```
## Initial Use

This project is intended to serve as a template for creation and maintenance of an application stack on a Dockerized server or host.  Follow these steps to deploy the project and create a new stack on any Linux (presumably Ubuntu or CentOS) server/host:

  - Open a terminal on the Linux server.
  - Set 'home' as your working directory.
    - `cd ~`
    - Note that instead of using your 'home' directory, you could choose `/opt` since that is where application stacks commonly exist in Linux. However, doing so will require that most of the following commands will have to be run with `sudo` or as `root`.
  - Clone this project to create a new `host` sub-directory in your working directory.
    - `git clone https://github.com/McFateM/docker-traefik2-acme-host host`
    - `cd host`
  - Visit the `certs` directory and review/edit the `certs.toml` file as necessary.
    - `cd certs`
    - `nano certs.toml`
  - Begin with `acme` and study any `README.md` or server-specific `.md` files there, like `STATIC.md` or `DGDOCKER3.md`.
    - `cd ../acme`
    - `mdv README.md` or `mdv DGDOCKER3.md`  _If `mdv` is not available use `cat` and substitute in the server-specifc name as necessary._
  - Copy any `.env` file needed for this service.  In the case of `acme` it's probably necessary to do this:
    - `rsync -aruvi islandora@dgdockerx.grinnell.edu:/home/administrator/host/acme/.env . --progress`
      - For services other than `acme` you will need to change the corresponding portion of the target path.
    - Verify that `.env` exists, open it and inspect, then change and save the contents if necessary.
    - Edit other files as directed and perform the prescibed command(s) found in the `README.md` or equivalent.
  - Repeat the above process in each of the remaining directories, preferably in this order:
    - **traefik** - `cd ../traefik`
    - **watchtower** - `cd ../watchtower`
    - **portainer** - `cd ../portainer`
    - **whoami** - `cd ../whoami`

## Additional Services

A server, host, or application stack running only the aforementioned elements is pretty mundane, so presumably there are more services destined for your host.  Each new service will require its own sub-directory beneath `~/host` with a `docker-compose.yml` file at a minimum.  That file can be initially patterned after `~/host/whoami/docker-compose.yml` since it contains most of the constructs that you are likely to need.  You should also create a `README.md` file and be sure to include elements like those found at the top of `~/host/whoami/README.md`.

Services typically either have a subdomain of their own, like [https://rootstalk.grinnell.edu](https://rootstalk.grinnell.edu), or they use "path" addressing off of the server's root subdomain, like [https://static.grinnell.edu/whoami/](https://static.grinnell.edu/whoami/).

### Path Addressing

If the service utilizes "path" addressing, such that it's URL ends with a `/some-path/`, like `https://static.grinnell.edu/whoami/`, then be sure you keep all of the "labels" found in `docker-compose.yml`. In such an instance it's unlikely that you need to add anything else since you probably do not need to modify the `./certs/certs.toml` file.

### Subdomain Addressing

If your service has a subdomain of its own, like `https://rootstalk.grinnell.edu`, then you can remove some of the "labels" for 'middleware' from `docker-compose.yml`, and keep just a simple "Host" label. However, you'll need to edit the service's fully qualified domain name (FQDN) into the `./certs/certs.toml` file and it will have to appear in portions of the `docker exec...` command that you'll want to include in your `README.md` file.

### Need More Info?

If you're struggling with the details of either scenario, send an email to [digital@grinnell.edu](mailto:digital.grinnell.edu) and ask for guidance or a working example.

## Maintenance

Once you have your application stack up-and-running, routine maintenance should be pretty straightforward. All that generally required is that you make changes to a service and push the changes to _DockerHub_.  Watchtower is typically engaged to monitor changes in each service's corresponding _DockerHub_ repo and it will update containers in the stack with new images as they are posted.

If a service has to be modified and/or restarted otherwise, usually all that's necessary is to pull the changes into the appropriate service sub-directory, and issue a `docker-compose up -d` command there.  The new service image should be pulled in and deployed as a service container as a result.

## History

Much of what follows is **OBSOLETE**. It was lifted from some of this project's predecessor `README.md` files without modification in order to preserve some of the early history of this work.


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

## EVERYTHING Below This Point is OBSOLETE

> As of 10-June-2020... Do NOT use the following!

### To Initialize the Host

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

### Adding Portainer

Lkewise on `static.grinnell.edu`:

```
sudo su
cd /opt/containers/portainer
docker-compose up -d
```

Note that successful configuration of the `https://static.grinnell.edu/portainer` address was gleaned from the post: [Proxy Portainer under sub path](https://community.containo.us/t/proxy-portainer-under-sub-path/3601).

###  Launching Application Stacks On static.grinnell.edu

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
