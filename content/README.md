# README

Author: Giles Wheeldon
Date: 09/03/2023

## Overview

This repository is created to allow myself to document my learnings around Git, Docker, NodeJS and other technologies while simultaneously gaining hands on experience with Git, MacOS, the terminal, markdown language, Visual Studio Code and extensions, and so on. 

## Requirements

- Terminal
- Git
- Visual Studio Code
- Hugo installation
- Docker
- Browser (to view static site)

## Quickstart

0. Install required software:

```brew install hugo```
```docker pull klakegg/hugo``` - required to serve the static site in a container

1. Download the repository:

```git clone https://LEA-Data-Engineering@dev.azure.com/LEA-Data-Engineering/Nexus%20Bridge/_git/giles-hugo-docs```

2. The terminal will prompt you for a password. Navigate to the [repository website](https://dev.azure.com/LEA-Data-Engineering/Nexus%20Bridge/_git/giles-hugo-docs). Click **Clone**, then use the button **Generate Git Credentials**. Copy the password and use it when prompted. 

3. Navigate to the folder using the terminal, e.g:

```cd giles-hugo-docs```

4a. To serve the documents, you can simply type:

```hugo serve```

The documents will be served on local port 1313 by default.

4b. To launch the site using a docker container, navigate to the repository folder using the terminal and run the following command:

```docker run --rm -v $(pwd):/src -dp 1313:1313 klakegg/hugo:0.101.0 server```

This will run the hugo server in detached mode (meaning it will leave the terminal free).

Alternatively, run:

```docker run --rm -it -v $(pwd):/src -p 1313:1313 klakegg/hugo:0.101.0 server```

This will allow you to see inside the running container and monitor any changes. 

5. Launch a browser window and enter the url:

```localhost:1313```

From here you can view and navigate the generated web site. 

## Adding content to the site

Simply modify the markdown files in the content folder using markdown. To add a new page, copy one of the existing pages into the appropriate content folder, give it a new name and add the content. Ensure you update the header information to be reflective of the new content, and update the corresponding ```_index.md``` file which will be in the same folder. 

To add a link in the index file, follow the format listed in the index file for other pages. 

### Adding images

Put your new images in the /static/images directly. These should be listed as LFS files under git (TODO - add section regarding this).

For images to appear correctly in preview use:

```![image](../../static/images<image-name)```

However, to show images on the actual deployed site, you must use:

```![image](/images<image-name).```

This will appear broken in preview but will work on the deployed site. 

## Deploying site via shell script

There are two shell scripts that have been created to deploy the hugo site. One uses the ```hugo``` command to build the entire html site and deploy it into a docker container (this will be for publishing the site). The Second shell script file simply uses the ```hugo serve``` command to host a dynamic version of the site that doesn't require generation of HTML files. 

Option 1 - build.sh

1. Open a terminal session.
2. Navigate into the hugo site directory.
3. Type "sh build.sh". This runs a script file that does a number of things:
- Checks whether Docker is running and starts the process if it isn't
- Checks for old containers, stopping and removing them if necessary
- Removes the generated files from the Public folder 
- Builds the site using the ```hugo``` command
- Builds a new Docker image based on Dockerfile
- Runs a server in a container that hosts the generated Hugo pages
4. To access the site, enter the following URL in a browser: ```localhost:3000```

Option 2 - Hugo Serve Option (WIP)

- To be advised when shell script is working 