---
title: Docker
description: General information regarding Docker
---


## Docker 101 Tutorial 

### Running a Container

```docker run -d -p 80:80 docker/<given-image>```

```-d``` - run the container in detached mode (in the background)

```-p 80:80``` - map port 80 of the host to port 80 of the container

```docker/<given-image>``` - the image to use

Tip: You can combine single character flags, e.g. ```-dp``` in lieu of ```-d -p```

### Building a Container Image 

1. Create a file named ```Dockerfile``` in the same folder as ```package.json```:

```
FROM node:18-alpine
WORKDIR /app
COPY . . 
RUN yarn install --production
CMD ["node", "src/index.js"]
```

2. Open the terminal and navigate to the directory with the ```Dockerfile```:

```docker build -t getting_started .```

The ```-t-`` flag tags the image. It is just a human-readable name for the generated image. 

The ```.``` at the end of the command tells Docker to look for the ```Dockerfile``` in the current directory. 


### Docker Compose

Docker compose dramatically simplifies the defining and sharing of multi-service applications. 

```docker compose up -d``` - start Docker Compose in background (no output in terminal).

```docker compose down``` - tear down your apps. If you also want to remove the volumes, add the ```--volumes``` flag. 

```docker compose logs -f``` - show logs from each of the services interleaved into a single stream (**-f** flag "follows" the log, meaning output will be generated in real time [ctrl+c to exit]).

Specify a single app only with ```docker compose logs -f <app-name>```

**!! CAREFUL !!** - docker-compose.yml must be in same directory as app (same folder as package.json - command must only be run once you have cd'd into that folder also).

### Image Building Best Practices

**Security Scanning**

When you have built an image it is good practice to scan it for security vulnerabilities:

```docker scan getting-started```

**Image Layering**

Layering is how images are built up - one layer at a time. So if a subsequent build changes one layer, but not prior ones, these do not need to be rebuilt. 

** ** 

TODO: Add more entries. 




-----

## Serving Docsify Site using Docker

1. Navigate to relevant folder

```cd Documents/mydocs```

2. Build image from Dockerfile

```docker build -f Dockerfile -t docsify/demo .```

3. Run docker image on port 3000

```docker run -itp 3000:3000 --name=docsify -v $(pwd):/docs docsify/demo```

This will return:

```
Serving /docs now.
Listening at http://localhost:3000
```

Simply navigate to the address to see the site. 

Note: If errors are generated regarding duplicate containers or images named "docsify", you will have to manually delete these in Docker Desktop.

TODO: Ideally we will address this issue when transitioning to some CI/CD model. 


----

## New Stuff from KodeKloud course

Can run each component in separate container, with separate libraries and dependencies. This is beneficial especially when different versions of software are needed for different application (e.g. different python install may be needed).

Much more lightweight than VMs due to all separate containers using the same OS kernel - each VM has its own OS, which introduces much more overhead in terms of processing and disk space (gigabytes rather than megabytes). However, containers may be deployed on VMs (but still less VMs than we would use before).

### Container vs Image

Image is essentially a template (class) used to generate instances of images that have their own processes. 

An image is created using a Dockerfile. The image will work consistently no matter where it is deployed, due to the containerisation. 

### Docker Commands

```docker run <image-name>```

Checks for image locally. If not present, checks Docker Hub and downloads if available. This downloaded image will then be available locally for future use. 

```docker ps```

Lists all running containers and some information about them e.g. container ID, image name, command used to create, generated name and so on. 

To see all containers (running and stopped or exited), use the **-a** flag. 

```docker stop <generated-name> || <container-ID>```

Stops the specified container. Returns the name of the container if successful. 

```docker rm <generated-name> || <container-ID>```

Removes stopped or exited container permanently. 

```docker images```

Returns a list of local images and their sizes. 

```docker rmi <image-name>```

Removes an image from the host. No containers must be using the image.

```docker pull <image-name>```

Pulls and stores the image but does not run it. 



NOTE: A container only lives as long as the process inside it is alive. If the process stops or crash the container will exit.

### Append a command

```docker run ubuntu```

Running this container will cause it to exit immediately. This is because ubuntu is an OS, and is just meant to host an application - with no running process, the container will simply exit. 

```docker run ubuntu sleep 5```

When given a command to execute, the ubuntu instance will remain alive until the command has been completed (which is this instance will be after 5 seconds).

### Exec - execute a command 

```docker exec <container-name> <command>```
e.g. ```docker exec distracted_flint cat /etc/hosts```

Use this syntax to pass a command to a running container. 

# Run - attach and detach

Attached mode (attached to console):
```docker run kodekloud/simple-webapp```

```docker run -d kodekloud/simple-webapp```
**-d** detached mode 
Container runs in background - frees up terminal. 
Can always attach later:
```docker attach <contatiner-id>``

**NOTE:** - you just need to provide the first few letters of a container ID, just enough to distinguish it from the other containers.

##**Docker run**

###Run - tag

Running a specific version

```docker run <image>:<version number>```
e.g. ```docker run redis:4.0```

### RUN - STDIN

```docker run -i <app>```

```docker run -it <app>```

**-i** - allows standard input
**-t** - creates a pseudo-terminal for interaction

### RUN - Port mapping

Specifying a IP and port - mapping internal to external port

```docker run -p 80:5000 <app>```
**-p** Port flag. Map host port 80 to container port 5000. You can run as many applications as you like this way, mapping to different ports. 

### RUN - Volume Mapping

Persisting data in docker. Data inside a container is volatile, and will be lost when the container is existed. 

You can map the data to a local storage area:

```docker run -v /opt/datadir:/var/lib/mysql mysql```
<local-dir>:<docker-dir>

### Inspect

```docker inspect <container-name>```

### Container logs 

How to we see the logs of containers run in the background (detached mode?)

```docker logs <container-name>```

### Environment variables

```docker run -e APP_COLOR=blue simple-webapp-color```
**-e** flag - environmental variable 

To check which variables a running container is using, use ```docker inspect```. 

## Creating your own image

**Dockerfile**
```
FROM Ubuntu                     # start from a base OS/image

RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code         ## copies files from local system into docker image

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
# specifies a command that will be run when the image is run as a container
```

```docker build Dockerfile -t <my-app>```
```docker push <username>/<my-app>```

```docker run <image> cat /etc/os-release```

Prints base image from container 


---

Creating a container with a specific name
```
docker run --name <app-name> <image-name>
docker run --name color-app -dp 8383:8080 webapp-color:lite
```

### Commands vs Entrypoint

```
CMD: sleep 5
vs
CMD: ["sleep", "5"]
```

### Links

```docker run --link <container-to-link> <container>```

e.g. ```docker run --link redis:redis <my-app>```
This maps the references redis inside the container to the container with the name regis outside the container. You can also simply write ```regis``` as shorthand and it will have the same effect. 

Not sure whether it's worth including this since it's deprecated. 

## Docker Compose

- TODO talk about different versions, include example files etc. 

# Docker Engine

Docker Engine
- Docker CLI
- REST API
- Docker Daemon

Docker can be controlled remotely via CLI:

```docker -H=10.123.2.1:2375 run nginx```

### Continerization


### Namespaces

Process IDs in container continue on from processes on host - but the container believes that it has it's own namespace system. So external process #6 on the host machine may be mapped to #1 inside the container, despite being the same process in reality. 

### cgroups

By default, containers have full access to all CPU and memory resources on a host machine. You can restrict this:

```docker run --cpus=0.5 ubuntu``` - restricts container to 50% of overall CPU capacity
```docker run memory=100m ubuntu``` - restricts container to 100MB of RAM

## Docker Storage

### File System

```
/var/lib/docker
- aufs
- containers
- image
- volumes
  - data_volume
```

```docker volume create data_volume```

```docker run -v data_volume:/var/lib/mysql mysql```

If you run the second command only, the volume specified will be created automatically. 

Volume mount mounts a volume from the volume directory. 

Bind mount mounts any directory from the file system e.g. 

```docker run -v /data/mysql:/var/lib/mysql mysql```

### Layered architecture

The layered architecture means that Docker doesn't have to keep building the base layers, or other previously generated layers, only recreating the parts that are distinct that that image. The layers creates are read-only. 

The final layer created using the image is the container layer, which is writeable. 

- Copy on write - to make changes to files in the image layer, the file is copied into the container layer and modified there. This modified version stays in the container layer. 

## Docker Networking



**Bridge** - default network (private, internal network created by docker on the host)

**Host** - You can also map the container to the host network

```docker run Ubuntu --network=host```
This will mean ports are common to all containers on host network. 

**None** - no network 

**User-defined networks** - 

```
docker network create \
    --driver bridge \
    --subnet 182.18.0.0/16
    custom-isolated-network
```
```docker network ls``` - show all networks

```docker inspect <container-name>``` - see network associated with container

### Embedded DNS 

```mysql.connect(mysql)```

```docker network ls```

``docker inspect <network>``` - shows information about network, just like with containers 

docker run --name alpine-2 --network=none alpine 

docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network 

```docker run -dp 38080:8080 --name webapp -e DB_Host=mysql-db -e DB_Password=db_pass123 --network wp-mysql-network kodekloud/simple-webapp-mysql```

Run multiple environmental variables requires multiple flags 

Docker.io is the regular registry, but there's lots of other ones publicly available (e.g. Google Container Registry, or gcr.io). There are also private registries, which usually require credentials to access.


```docker run --restart=always <container>```

Container will always restart if it closes. 

```docker image prune -a``` - removes all images without a container associated with them 