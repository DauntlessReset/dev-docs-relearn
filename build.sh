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

IMAGE=my-nginx
CONTAINER=hugo-publish

# Stop and remove old container

CONTAINER_STOPPED=$(docker stop $CONTAINER)
CONTAINER_REMOVED=$(docker rm $CONTAINER)

if [ ! -z "$CONTAINER_STOPPED" ] && [ $CONTAINER_STOPPED == $CONTAINER ]; then
    echo "Container $CONTAINER successfully stopped."
fi
if [ ! -z "$CONTAINER_REMOVED" ] && [ $CONTAINER_REMOVED == $CONTAINER ]; then
    echo "Container $CONTAINER successfully removed."
fi

# Remove generated static site files
rm -r public 

# Build static site
hugo

# Build docker image
docker build . -t $IMAGE

# Instantiate container
docker run -dp 3000:80 --name $CONTAINER $IMAGE && echo "Site is available at localhost:3000"

