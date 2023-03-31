---
title: Kubernetes
description: Course Completed on LinkedIn Learning - *Learning Kubernetes* - Kim Schlesinger 
---

## Minikube

Notice that commands that begin with "minikube" handle the actual spinning up and down of the cluster, whereas everything to do with examining and interacting with the cluster is handled by the "kubectl" command. 

### Minikube 

```minikube start``` - Start a cluster. 

```minikube stop``` - Stops your cluster from running.

```minikube delete``` - Delete your cluster. 

```minikube dashboard``` - Displays a dashboard of the current Kubernetes activity (similar to Docker Hub for Docker).

![Minikube Dashboard](/images/minikube-dashboard.png)

```minikube version``` - Checks your version of Minikube. 

```minikube update-check``` - Checks your version of Minikube and displays current version. 

### Kubectl

Most common operations:

- ```kubectl get``` - lists resources

- ```kubectl describe``` - show detailed information about a resource. e.g. ```kubectl describe pods``` lists what containers are inside a pod and what images were used to build those containers. This command can be used for any of the Kubernetes primitives (nodes, pods, deployments).

- ```kubectl logs``` - prints the logs from a container in a pod

- ```kubectl exec``` - executes a command on a container in a pod.

e.g. ```kubectl exec <pod-name> -- env``` lists all environmental variables in a pod. 
```kubectl exec -ti <pod-name> -- bash``` starts a bash session in the pod's container. 




```kubectl get nodes``` - Give you information about your cluster - how many machines are working as nodes in the cluster. In the case of minikube, this will be only one. 

```kubectl cluster-info``` - Shows IP address of Kubernetes control plane. 

```kubectl get namespaces``` - Shows namespaces. Namespaces are a way to isolate and manage applications and services that you want to remain separate. 

```kubectl get pods -A``` - Shows pods. "-A" indicates pods from every name space. 

```kubectl get services -A``` - Shows all services. Services act as load balances within the cluster and direct traffic to pods. 

```kubectl version``` - Check if kubectl is installed and return version. 

### Application Deployment

```kubectl create deployment <name> --image=<website>/<image>:<version>```

e.g. ```kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1```
(include the full repository URL for images hosted outside Docker Hub)

This command:
- searched for a suitable node where an instance of the application could be run 
- scheduled the application to run on that node
- configured the cluster to reschedule the instance on a new node when needed 

```kubectl get deployments``` - lists deployments. 

#### Namespaces

Namespaces help you isolate apps and microservices.

```kubectl apply -f namespace.yaml``` - add namespaces from YAML file

```namespace.yaml```

```
apiVersion: v1
kind: Namespace
metadata:
    name: development
---
apiVersion: v1
kind: Namespace
metadata:
    name: production
```

```kubectl delete -f namespace.yaml``` - Delete namespaces specified in YAML file. 

```kubectl apply -f deployment.yaml``` - Applies a deployment.

```kubectl get deployments -n development``` - Prints all deployments for namespace "development". 

```kubectl get pods -n development``` - Returns all pods for the namespace "development". 

```kubectl delete deploy <deployment-name> -n development``` - Delete specified deployment from namespace. 

```kubectl delete pod <pod-name> -n development``` - Deletes specified pod. Note that a brand new pod will be created in it's place. 

### Pod Health

Kubernetes saves the event logs when a pod is created and you can use these to troubleshoot issues. 

1. Find the pod whose event log you want to view. Run the following command and copy the name of the pod. 

```kubectl get pods -n development```

2. Run the following command:

```kubectl describe pod <pod-name> -n development ```

Data is up the top, event logs are down the bottom. If your pod has been up and running for a while, there won't be anything under event logs, as Kubernetes is satisfied that the pod is healthy. Most issues with pods occur in the first minutes of operation. 

### BusyBox

```kubectl apply -f busybox.yaml``` - Deploys BusyBox in default namespace.

```kubectl get pods``` - Returns pods in default namespace. 

```kubectl get pods -n development -o wide``` - Returns details about pods including IP addresses. 

Creates terminal to BusyBox container with shell. 

```kubectl exec -it <busybox-pod-name> -- /bin/sh```

You can use BusyBox to check if a pod is running correctly. Use this command to get the IP address of a pod:

```kubectl get pods -n development -o wide```

Copy this IP address. Check the port used by the deployment (not the BusyBox one, the one you are checking) by inspecting the corresponding YAML file. Then run this command inside the BusyBox terminal:

```wget <ip-address>:<port-number>```

This should return some information from the service if it is running correctly. 

To break the connection to the BusyBox terminal, type "exit". 

### Application Logs

```kubectl logs <pod-name> -n development``` - Shows the log of the pods. The pod log shows all HTTP requests, so it should record the "wget" request from the previous BusyBox request (*although I checked and it doesn't, will have to test on a different application TODO*).

### LoadBalancer

How do you expose your application to the internet? Using a Kubernetes service, which is a LoadBalancer that directs traffic from the internet to Kubernetes pods. It maintains a static IP address for the public IP. 

The other two types of K* service are node port and cluster IP. 

```minikube tunnel```

In another tab:

```kubectl apply -f service.yaml```

```kubectl get services -n development```

Shows LoadBalancer with cluster IP and external IP. 

Switch back to the minikube tunnel - it should be asking for your password - enter it. 

Opening a browser window and navigating to the external IP specified by the "services" request above - this should show you information about the pod in the form of a JSON object. 

Close out of the tunnel with Ctrl + C. 

### Resource Limits and Requests

Failing to specify resource limits can cause a pod to use all available resources on a node, causing the worker node to fail. If you create a pod without a set of resource requests, it can be deployed on a node that doesn't have the required processing power/memory amount. 

```
    spec:
      containers:
      - name: pod-info-container
        image: kimschles/pod-info-app:latest
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "500m"
```

Do not schedule this pod unless it has at least this much memory and cpu capacity (requests) - stop running this container if it exceeds these limits (limits). These requirements are essential for preventing outages. 

### Cleaning up your cluster

Delete any Kubernetes resources we created. 

```kubectl delete -f file-name.yaml```

Delete namespaces afterwards:

```kubectl delete -f namespaces.yaml```

Delete cluster:

```minikube delete```

## Kubernetes Architecture

### Kubernetes Control Plane

An instance of Kubernetes is called a **Cluster**. Each cluster has a control plane and at least one worker node. 

The control plane is like the control tower overlooking traffic at an airport, responsible for making sure nodes and pods are created, modified, and deleted without any issues. 

The control plane is made up of several components:
 - Kube API Server - Exposes the Kubernetes API. kubectl and kubeadm are CLI tools used to communicate with the Kubernetes API via HTTP requests. 
 - Run ```kubectl api-resources``` to see all the Kubernetes objects and their API version. 
 - ```kubectl get pods -n kube-system``` to see the Kube API server. This component handles the most requests from the user. 
 - etcd is an open-source, highly available key store, which saves all data about the state of a cluster. It is also run as a pod. 
 - kube scheduler - Identifies newly created pods that have not been assigned a worker node, then chooses a node for the pod to run on. 

### Kubernetes Worker Nodes

Worker nodes are like busy terminals at the airport. Most Kubernetes clusters have at least 3 worker nodes to ensure high availability. This is where pods are run. Each node has three components:

**Kubelet**

- An agent that runs on every worker node
- Makes sure that containers in a pod are running and healthy 
- Communicates directly with the api-server in the control plane

** Container Runtime**

- A Kubelet assigned to a new pod starts a container using the Container Runtime Interface (CRI)

**Kube-proxy**

- Makes sure pods and services can communicate. 
- Each Kube-proxy communicates directly with the Kube-apiserver

### How the control plane and nodes work together 

![my image](/images/kubernetes-comms.jpeg)

## Advanced Topics

### Ways to manage Kubernetes pods

**Deployment**

Deployments are the most common way to deploy containerised applications. They allow you to control the number of replicas. If you have a new version to roll out, you can do that with no-downtime. 

**DaemonSet**

Allows you to run one pod per node, which works well for running pods implementing background processes such as agents. 

**Job**

Creates one or more pods and run the container inside them until it has successfully completed its task. E.g. good for discrete tasks that only require being execute once in a while, not continually running. 

### Running stateful workloads

Handling data storage in Kubernetes. 

1. Connect to a database running outside the cluster. 

2. Kubernetes Persistent Volumes. Exist in the cluster but persist after the cluster is destroyed. New pods will communicate with same volume. 

### Kubernetes Security 

Any internet server is susceptible attack. These are some best practices. 

**Aims of Attacker**

- Steal Data
- Harness computational power of cluster for crypto mining
- DDoS Attack 

**Best Practice**

- Containers should be run as non-root. 
- File system should be read-only. 

```
  securityContent:
    allowPrivilegeEscalation: false
    runAsNonRoot: true
    capabilities:
      drop:
        - ALL
    readOnlyRootFilesystem: true
```

- Scan your Kubernetes YAML manifest with a security tool such as Snyk. 

```snyk iac test deployment.yaml```

- Regularly update the version of Kubernetes you are using. 
- Check the National Security Agency (NSA) [**Kubernetes Hardening Guide**](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF "NSA Kubernetes Hardening Guide"). 

## Further Resources

LinkedIn Learning - *Master Cloud-Native Infrastructure with Kubernetes*

YouTube - KubeCon Conferences

Linux Foundation Kubernetes Certification Exams
- *Kubernetes and Cloud Native Associate exam*
- *Certified Kubernetes Application Developer exam*
- *Certified Kubernetes Administrator exam*

## Definitions
### Cluster

TODO: IMAGE OF CLUSTER
### Pod

*Pods* are the smallest deployable units of computing that you can create and manage in Kubernetes. A *Pod* (as in a pod of whales or a pea pod) is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers. 

Think of it as the smallest useful state of your application. A database container connecting to a web server container in a two node structure may be the smallest deployable unit for that application, as having only one container would render the purpose of the application (to display content on a website retrieved from a database) impossible. 

Each pod is tied to the node where it is schedules, and remains there until termination or deletion. If the node fails, identical pods are scheduled on other available nodes in the cluster. 


### Node

A pod always runs on a node. A Node is a worker machine in Kubernetes and may be either a virtual or physical machine, depending on the cluster. Each Node is managed by the control plane. A Node can have multiple pods, and the Kubernetes control plane automatically handles scheduling the pods across the nodes in the cluster. 

Every Kubernetes Node runs at least:
- Kubelet: a progcess responsible for communication between the Kubernetes control plane and the Node. It manages the pods and the containers running on the machine.
- A container runtime (like Docker) responsible for pulling the container image from a registry, unpacking the container, and running the application. 

TODO: IMAGE OF NODE 

###


_____

## Deployments 

Upgrade pods one at a time - rolling updates (e.g. new nginx version)

If something causes an error, you can roll back

A deployment encompasses everything. 

kind: Deployment 

```kubectl get deployments```

Replicaset created automatically

Deployment
 - ReplicaSet
   - Pods 

What is the difference between Deployments and ReplicaSets? Deployments are higher level, managing ReplicaSets and providing other useful features.

```kubectl get all```

### Update and Rollback

When you first deploy your app, it will be on revision 1 (e.g. nginx:1.7.0). If you need to update the app later, e.g. nginx:1.7.1, this will be revision 2. 

```
kubectl rollout status deployment/myapp-deployment
```

Show rollout status. 

```
kubectl rollout history deployment/myapp-deployment
```

To see revisions and history of Rollout. 

### Deployment Strategy

1. **Recreate Strategy**: Destroy all instances and deploy new instances - this results in application downtime 

2. **RollingUpdate Strategy**: Take down instances one at a time and replace for a seamless transition. 

### kubectl apply

1. Make changes to YAML file
2. ```kubectl apply -f deployment-definition.yml```

or 

```kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1```

### Rollback

```
kubectl rollout undo deployment/myapp-deployment
```
Rolls back to previous revision. 

### kubectl run

```
kubectl run nginx --image=nginx
```

Creates a deployment without a deployment file, only an image name. 


## Kubernetes on Cloud

### Google Cloud Platform 


You can use wildcards e.g.

```kubectl create -f .``` will run all files in folder s

## Kubernetes on Cloud 




### TODO

Rework pages into overview divided into sections:

Kubernetes Overview
Containers - Docker 
Container Orchestration
Kubernetes concepts
Pods
ReplicaSets 
Deployment
Services

Networking in Kubernetes 
Kubernetes Management: Kubectl 
Kubernetes Definition Files - YAML

Kubernetes on Cloud

AWS 
GCP 