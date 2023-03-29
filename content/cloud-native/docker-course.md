---
title: Docker Course
description: Information from KodeKloud's course *Docker Training Course for the Absolute Beginner*
---

## Docker Commands

##### ```docker run <image>```

e.g. ```docker run nginx```

Creates a single container instance from an image (an image is essentially a template). To run multiple containers using the same image, simply use multiple commands. 

If the image specified is not available locally, it will be downloaded from DockerHub. This will only happen the first time, as subsequent calls will use the local image. 

##### ```docker ps```
e.g. ```docker ps -a"```

Lists all running containers and some basic information such as container ID, name, image used, command run, uptime and so on. Adding the ```-a``` flag means all containers, even those stopped, will be shown. 

##### ```docker stop <container-name/id>```

Stops the container running. Can use name or container id. 

##### ```docker rm <container-name/id>```

Removes a container. Must stop it first (unless using ```-f``` flag (force stop)).

##### ```docker kill <container-name/id>```

Similar to the stop command, but uses the SIGKILL signal rather than the SIGTERM signal. Essentially stop attempts to close a process gracefully through the shutdown process, whereas kill just kills the process. 

```docker images```

See list of downloaded images.

```docker rmi <image>```

Removes an image. Will only be successful if all dependents have been stopped and removed. 

```docker pull <image>```

Pulls an image and stores it on the host without running it. 

```docker run <image> <command> <argument/s>```

Pass command to the instantiated container. For instance, the command ```docker run ubuntu``` will create a container that will die immediately because it has nothing to do - a container will self-extinguish once it has completed it's task (a container with no task will exit immediately).

To append a sleep command to the ubuntu container:
```docker run ubuntu sleep 5```

```docker exec <container-name/id> <command>```
```docker exec unix_cont cat /etc/host```

The exec command can be used to pass instructions on to a running container. 

```docker run -d <container-name>```

Runs container in the background (detached).

```docker attach <container-name/id>```

Reattach to a detached container. 

## Docker Run

```docker run <image>:<version>```
```docker run redis:4.0```

Run a different version of a specified image. This is a version tag. By default, the ":latest" tag is specified. e.g. ```docker run redis``` is implicitly ```docker run redis:latest```. 

You can f all supported tags by looking up the image on DockerHub. 

```docker run -i <image>```
```docker run -it <image>```

The ```-i``` flag creates a container in interactive mode, meaning standard import from your terminal is linked up, so you can enter input. However, to fully connect, add the ```-t``` flag, which allows you to see the prompt from the container terminal. 

```docker run -p <host-port>:<container-port> <image>```
```docker run -p 80:3000 webapp```

Port mapping. Allows you to map port inside the container to port on Docker host. You can run multiple containers with the same app mapped to different ports on the host. 

```docker run -v <external-dir>:<internal-dir> <image>```
```docker run -v /opt/datadir:/var/lib/mysql mysql```

Volume mapping. 

Data inside a container is volatile - once the container is stopped, the information is lost. Data can be persisted outside the container. 

For instance, we may want to preserve MYSQL data stored inside the container at "/var/lib/mysql". We can map this to an external folder as above to keep this when the container dies. 

```docker inspect <container>```

Prints out all information regarding a container in JSON format(this creates verbose output). You can see information such as environmental variables. 

```docker logs <container>```

Shows information logged by a running container. 

```docker run -e <variable-name>=<variable> <image>```
```docker run -e APP_COLOR=blue simple-webapp-color```

Used to pass environmental variables to a container. 

## Docker Images

### Creating your own image

1. Create a dockerfile called Dockerfile with all necessary commands e.g.:

    1. OS - Ubuntu (base image)
    2. Update apt repo
    3. Install dependencies using apt
    4. Install Python dependencies using pip
    5. Copy source code to /opt folder
    6. Run the web server using the "flask" command

INSTRUCTION ARGUMENT format
Layered architecture means altering the Dockerfile does not require a new image to be generated from scratch (check using ```docker history <image>```). Also, if one layer experiences failure, subsequent attempts will resume from the last successful layer. 

```
FROM Ubuntu

RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flash-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run

```

2. Build the image using the build command (remember the period at the end builds from the dockerfile in the present working directory).

```docker build Dockerfile -t <image-name> .```

3. Push the image to DockerHub:

```docker push <image-name>```

## Docker CMD vs ENTRYPOINT

By examining the Dockerfiles for popular images, we can see that the default command is listed under "CMD". For nginx, the default command is nginx - for mysql, mysql. For ubuntu, the default command is "bash" which is not really a process, which is why the container will exit immediately given no command argument (and no terminal attached).

You can override the command by simply adding a command. 

e.g. CMD sleep 5

or CMD ["sleep", "5"]           (JSON format)

With ENTRYPOINT, the command line parameters are **appended** to the entrypoint - with CMD, the command line parameters replace the command. 

For instance - if the ENTRYPOINT is ```sleep```, entering the command ```run sleep-app``` will error out because sleep has not been passed a command. 

Entering ```run sleep-app 5``` will pass the argument 5 to the sleep entrypoint, effectively running ```sleep 5```. ßß

To modify the entrypoint at command time, use the entrypoint command:

```docker run --entrypoint sleep2.0 ubuntu-sleeper 10```

## Docker Networking

Three networks: 

Bridge (default) - mapped to different (specified) port on host
none
host - mapped to same port on host

```docker run ubuntu --network=host```

### User defined networks 

```
docker network create \
--driver bridge \
--subnet 182.18.0.0/16
```

```docker network ls```

List all docker networks. See which network a container is attached to with ```docker inspect <container>```. 

```mysql.connect(<container>)```


## Docker Storage

Where does docker store files on the local system? e.g. data related to containers and images. 

```
/var/lib/docker
    volumes
        data_volume
```


The files in the image layer are READ ONLY - they can only be modified by running the build command again e.g. if you need to modify the source code. Any modifications made in the container are made to the container layer only, and will not be persisted in the image layer (e.g. modification of source code, addition of a text file, etc).

```docker volume create data_volume```

```docker run -v data_volume:/var/lib/mysql mysql```

Running the second command without running the first will create the specified volume folder automatically. This process is called "volume mounting".

```docker run -v /data/mysql:/var/lib/mysql mysql```

This is called "bind mounting". This is when a folder outside of the volumes folder is mounted. Doing this means you need to use the whole path, not just the relative path. 

Should use ```--mount``` instead and state everything explicitly. 

```
docker run --mount type=bind source=/data/mysql \
target =/var/lib/mysql mysql
```

## Docker Compose

Configurations in YAML files. 

How can we run several different apps simultaneously to create an intricate service (an application stack)?


```docker-compose.yml```:

```
redis:
    image: redis
db:
    image:postgres:9.4
vote:
    image: voting-app
    ports:
        - 5000:80
    links:
        - redis
result:
    image: result
    ports:
        - 5001:80
    links:
        - db
worker:
    image: worker   ## or build: ./worker (if not built)
    links:
        - db
        - redis

```

```docker-compose up```

Instead of running a bunch of build commands, you can just put them into a docker compose:

![image](/images/docker_compose.jpeg)

### Links

```docker run --link <app-ref>:<app-name> <app>```

```docker run postgres --link db:db result-app```

aka

```docker run postgress --link db result-app```

### Docker compose - versions

**Version 2** 
Can now use section "Services" for all different apps. Also, don't need to use links. Added ```depends_on``` property where you can specify whether an app depends on another to start properly.

e.g.

```
version 2           # must specify version on first line for 2 and 3
services:
    redis:
        image: redis
...
```

### Separating networks 

Add after services:

```

result:
    image: result
    networks:
        - front-end
        - back-end

networks:
    front-end:
    back-end:

```

## Docker Registry

Central repository of all Docker images. 

```docker run <user-name>/<image-repo>```

e.g. ```docker run nginx/nginx```

DockerHub is not the only one e.g google.io. Registries can be public or private. 

You can deploy your own local private registry. 

e.g. ```docker push localhost:5000/my-image```

## Docker Engine

**Docker Engine**
- Docker CLI
- REST API
- Docker Daemon

 Two processes cannot have the same process ID (PID). However, a container does not know about host processes, and starts with PID 1, even if that is taken up on the host machine. So basically they are given a local PID (starting with 1), and a PID assigned by the host (starting at the natural increment depending on the processes running on the host). This process is possible because the container has it's own namespace. 

 ### Sharing resources

 By default, a container has unlimited access to host resources. 

 ```docker run --cpus-.5 ubuntu``` - limits CPU to 50%
 ```docker run --memory=100m ubuntu``` - limits RAM to 100MB

## Docker on Mac

*Skipped Docker on Windows*

Most Mac users use Docker Desktop for Mac. Uses HyperKit vitualisation technology (enables running of linux containers on Mac). 

## Container Orchestration

Orchestration is necessary to keep a close eye on the load, heath and performance of your containers. What happens if a container crashes? What happens if the host crashes?

- Easy to deploy 100s or 1000s of instances of app
- Across multiple hosts (high availability, fault tolerance)
- Load balancing
- Scale up or down, additional hosts added 
- Networking across different hosts, sharing storage 

Examples are Docker Swarm, Kubernetes, Mesos. 

### Docker Swarm

In Docker Swarm, one host (or more) is the swarm manager, while the others are workers.

```docker swarm init``` - Swarm Manager
```docker swarm join --token <token>``` - Node Worker

How to run a command across all nodes?

```docker service create --replicas=9 my-web-server```

### Kubernetes

```kubectl run --replicas=1000 my-web-server```

```kubectl rolling-update my-web-server --image=web-server:2

```kubectl rolling-update my-web-server --rollback```

A node is a machine (physical or virtual) in which kubernetes software runs. A cluster is a set of nodes grouped together. 

The master is a node with control components installed, which is responsible for orchestration. 

## Docker Tips

- you don't need to write the whole ID number to refer to a specific container - just enough so that it can be distinctly selected from the other containers 

- specify version

capture best practices for docker 

