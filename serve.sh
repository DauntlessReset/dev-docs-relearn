#!/bin/bash

# Check if Docker is running

if ! docker images > /dev/null 2>&1; then
    echo "Opening Docker, please be patient..." & open -a Docker
else 
    echo "Docker process detected."
fi

##open --hide --background -a Docker 

# Wait for Docker to open 

while ! docker info > /dev/null 2>&1;
do
    :   # do nothing
done

IMAGE=alpine-server
CONTAINER=hugo-server

# Stop and remove old container

CONTAINER_STOPPED=$(docker stop $CONTAINER)
CONTAINER_REMOVED=$(docker rm $CONTAINER)

if [ ! -z "$CONTAINER_STOPPED" ] && [ $CONTAINER_STOPPED == $CONTAINER ]; then
    echo "Container $CONTAINER successfully stopped."
fi
if [ ! -z "$CONTAINER_REMOVED" ] && [ $CONTAINER_REMOVED == $CONTAINER ]; then
    echo "Container $CONTAINER successfully removed."
fi

# Build docker image
docker build -t $IMAGE -f DockerfileServe .

# Instantiate container
docker run -it -p 1313:1313 -v $(pwd):/hugo --name $CONTAINER $IMAGE 
