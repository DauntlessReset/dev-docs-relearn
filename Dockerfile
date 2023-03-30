## Dockerfile to serve Hugo in a local docker container

# Using latest version but specifying to protect against future compatibility issues. 
FROM nginx:1.23.3-alpine

COPY /public /usr/share/nginx/html