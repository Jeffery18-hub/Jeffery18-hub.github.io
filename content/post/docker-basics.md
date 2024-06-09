+++  
title = "Docker Basics"  
lastmod = 2024-06-08T23:25:44-06:00  
draft = false  
author = "Jeffery@slc"  
tags = ["devops", "docker"]  
categories = ["Tech/技术"]  
+++

## What is Docker? {#what-is-docker}

Docker, like git in version control, is the most popular implementation in containerization.

Why do we need containers? Because we want consistency in building, running, and shipping applications. In an app, we usually have the code we wrote, third-party dependencies, configuration info, and things about OS(filesystem, networking, etc).  
With the help of containerization, no matter on which machine, our applications will run in the same environment.

## Virtual Machines vs Containers {#virtual-machines-vs-containers}

Containers are isolated environments for running applications, while virtual machines (VMs) are abstractions of physical machines. Compared to VMs, which require installing an entire operating system, containers are lightweight. All containers are separate processes running on the same OS of the host.

## Architecture of Docker {#architecture-of-docker}

Docker Engine acts as a client-server application with:

- A server with a long-running daemon process [`dockerd`](https://docs.docker.com/reference/cli/dockerd)
- APIs that specify interfaces for programs to communicate with and instruct the Docker daemon.
- A command line interface (CLI) client [`docker`](https://docs.docker.com/reference/cli/docker).

The CLI uses [Docker APIs](https://docs.docker.com/engine/api/) to control or interact with the Docker daemon through scripting or direct CLI commands.



## Image {#image}

In Docker, an image is a lightweight, standalone, executable package that includes everything needed  
to run a specific application, including the code, runtime, libraries, environment variables, and configuration files.Docker images are templates used to create Docker containers.

### Features {#features}

1. Layered Structure  
   Docker images consist of a series of read-only layers. Each layer represents a step in the image-building process.  
   The layered structure allows images to share the same base layers(like inheritance in coding), saving storage space.
2. Read-Only Nature  
   Docker images are read-only. When a container starts, a writable layer is added on top of the image.  
   All modifications to the container occur in this writable layer.
3. Version Management  
   Each image has a unique ID (generated from the image content's hash value) and one or more tags (e.g., latest, 1.0) to identify different versions of the image.

## Workflow {#workflow}

Suppose we have a simple node that we want to package as a Docker image and run:

1. Create a Dockerfile in the project:

`From` is like the base class or we can say base layer in the image. And then we copy every from the working directory(where your Dockerfile lies) to the path `/app` of the image. On the third line, we tell docker that the working directory of docker container is `app/`. Finally we run the command `node app.js` in the designated path.

```Dockerfile
FROM node:alpine
COPY . /app
WORKDIR /app
CMD node app.js
```

2. Build the image:  
   The `-t` flag specifies the name and tag for the built image, and `.` indicates that the build context is the current working directory.

```sh
docker build -t my-node-app .
```

3. Run the container:  
   The `-d` flag means detached mode which allows our container running under the hood. The `-p` flag maps the container's port 5000 to the host's port 4000.

```sh
docker run -d -p 4000:5000 my-node-app
```

## References {#references}

1. [https://www.youtube.com/watch?v=pTFZFxd4hOI](https://www.youtube.com/watch?v=pTFZFxd4hOI)
2. [https://www.kenmuse.com/blog/understanding-container-image-layers/](https://www.kenmuse.com/blog/understanding-container-image-layers/)