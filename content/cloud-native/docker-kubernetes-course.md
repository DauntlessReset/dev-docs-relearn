---
title: Docker & Kubernetes
description:  Notes from course on FreeCodeCamp - *Docker and Kubernetes* - Guy Barrette
---

## Microservices Concepts

### Microservices Architecture

A variant of the service-oriented architecture (SOA) structural style - arranges an application as a collection of loosely coupled services. 

In a microservices architecture, services are fine-grained and the protocols are lightweight. 

### Monolithic Architecture

- Built as a single unit
- Deployed as a single unit
- Duplicated on each server
- Example: Three tier application, separated into different sections, but tightly coupled

-------Layers--------
Web - Business - Data 

### Microservices

- Segregates functionality into smaller separate services each with a single responsibility
- Scaled out by deploying each service independently
- Loosely coupled
- Can be worked on more easily by multiple teams 

Scaling up and down is very easy with microservices. Additionally, recovery from crashes etc is much more seamless. 

### Monolith to Microservices

- Break your application/system into small units
- Use the *strangler pattern* 

### Microservices Anti-Patterns

- Microservices != Magic Pixie Dust
- Risk of unnecessary complexity
- Risk that changes impact numerous services 
- Risk of complex security 
- Take it step by step and have checks in place to ensure you're not doing too much at once and making mistakes

### Microservices - Benefits

- Improved fault isolation
- Eliminate vendor or technology lock-in
- Ease of understanding
- Smaller and faster deployments
- Scalability

### Microservices - Drawbacks

- Complexity is added to resolve complexity issues
- Testing may appear simpler but may not be
- Deployment may appear simpler but is it
- Multiple databases
- Latency added to all calls
- Transient errors: a call may fail, but work when retried 15 ms later
- Multiple points of failure
- Security: can be additional risks

## Cloud Native 

Definition: TODO

### Concepts

- Speed and agility: instantaneous responsiveness, new features, no downtime, accelerated innovation, rapid release of features, stability/performance
- Architecture - Clean Code, Domain Drive Design, Microservices Principles and Kubernetes Patterns 
- Infrastructure becomes immutable and disposable
- Provisioned in minutes and destroyed on demand
- Never updated or repaired by re-provisioned 

Cloud Native Trail Map (CNCF) - Breaks the journey into measurable steps with key milestones. 

Cloud Native Computing Foundation (CNCF) 
cncf.io



## Kubernetes or K8s

Declarative object configuration files 

### YAML

Dictionary: unordered collection
List: ordered collection

Lines beginning with a ```#``` are comments. 

#### Pods with YAML

Kubernetes uses YAML files to creates objects. 

Always contains 4 fields (required):

```
apiVersion:
kind:
metadata:

spec:
```


```
pod-definition.yaml
```
```
apiVersion: v1
kind: Pod
metadata:
    name: myapp-pod
    labels:                 # you can add anything under here, user-defined
        app: myapp          # any value you wish
        type: front-end

spec:
    containers:             # list/array
    - name: nginx-container
        image: nginx        # image type from Docker Hub  

```

Then run: 
```
kubectl create -f pod-definition.yml
```

``` 
kubectl get pods
```

```
kubectl describe pod myapp-pod
```


kubectl edit pod <pod-name> - shows full yaml file generated by kubernetes

### Controllers and ReplicaSets

To prevent users from losing access to our application, we like to have multiple run pods at the same time. 

The Replication Controller helps us to run multiple instances of a pod in the same cluster, thus providing high availability. Even with a single pod, it helps by bringing up a new pod when one fails, as it always ensures that the correct number of pods is running. 

It also helps with load balancing, spreading the load across multiple pods and nodes. 

Replica Set is the new, recommended way to set up replication. 


```rc-definition.yml```

```
apiVersion: v1
kind: ReplicationController
metadata:                # rep controller
  name: myapp-rc
  labels:
    app: myapp
    type: front-end
spec:                    # rep controller
  replicas: 3
  template:
    metadata:            # pod
      name: myapp-pod
      labels:
        app: myapp
        type: pod
    spec:                # pod
      containers:
      - name: nginx-container
        image: nginx

```
Note: definitions nested together

```kubectl create -f rc-definition.yml```

```kubectl get replicationcontroller```

```kubectl get pods```

#### ReplicaSet

Now ```apps/v1```. 

```selector``` allows you to specify other pods that were not covered in the replica set definition - if you skip it, it will just cover the ones in the definition (it is not required in Replica Controller, but **is** required in Replica Set).

#### Labels and Selectors

Labels are used to ensure we can keep track of pods. For instance, our pod may be labeled as such:

```
metadata:
  name: myapp-pod
  labels:
    tier: front-end
```

As all pods spawned through this definition will be labelled as ```tier: front-end```, we can simply tell our ReplicaSet to be responsible for them using the ```selector``` definition:

```replicaset-definition.yml```

```
selector: 
  matchLabels:
    tier: front-end
```

#### Scaling with ReplicaSet

1. Can update the number of replicas in the replicaset-definition.yaml (e.g. change 3 to 6), then run the replace command:

```
kubectl replace -f replicaset-definition.yml```
```

2.  Can scale directly from the command line without touching the YAML file:

```
kubectl scale --replicas=6 -f replicaset-definition.yml
```

```
kubectl scale --replicas=6 replicaset myapp-replicaset
```