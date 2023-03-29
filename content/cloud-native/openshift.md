---
Title: OpenShift
Description: OpenShift course by KodeKloud "OpenShift for the Absolute Beginner" - O'Reilly
---

## OpenShift Basics

OpenShift is Red Hat's platform as a service container application.

OpenShift Origin is based on top of Docker containers and the Kubernetes cluster manager, with added developer and operational centric tools that enable rapid application development, deployment and lifecycle management.

Kubernetes provides self-healing and auto-scaling for containerised applications - OS abstracts over the underlying Kubernetes to help developers easily deploy and manage their applications, with many tools added to make their job easier. 

## OpenShift Architecture Overview

Pull images from Docker Hub, OpenShift Container Registry (OCR) or others. 

Code Repository - built-in CI/CD pipelines

Picture of OpenShift architecture TODO 

## Setting up Minishift

Easiest way to get started on single machine for developer purposes. 

- VirtualBox
- Minishift.exe
- 

TODO - Decided not to use minishift due to problems getting it working, using sandbox on openshift site

## Management Tools

- Web Console
- Command Line Interface
- REST API 

### Command Line Interface login

```> oc login```

Input username and password in one command: 

```> oc login -u developer -p developer```

```oc logout```
