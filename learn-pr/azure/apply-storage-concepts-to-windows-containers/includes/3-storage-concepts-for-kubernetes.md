Kubernetes is an open platform that manages container-based applications and their associated networking and storage components. It provides a declarative approach to deployments, backed by a robust set of APIs for management operations.

You can build and run modern, portable, microservices-based applications, using Kubernetes to *orchestrate* and *manage* the availability of the application components.  

## Container management and orchestration

**Container management** is the process of organizing, adding, removing, or updating a significant number of containers. A **container orchestrator** is a system that automatically deploys and manages containerized apps. For example, an orchestrator can dynamically respond to changes in the environment to increase or decrease the deployed instances of the managed app, or it can ensure all deployed container instances get updated if a new version of a service is released.

## Kubernetes architecture

The architecture of Kubernetes is built on clusters. A Kubernetes cluster is divided into two core infrastructure components:

- A *control plane* that provides the core Kubernetes services and orchestration of your application workloads.
- *Nodes* that run your application workloads. Each cluster has at least one node, but you can define the number and size of nodes. A *node pool* is a group of nodes that share the same configuration.

The resources for your application workloads are contained in *pods*. A pod in Kubernetes is an ephemeral resource that represents a single instance of your application. It consists of one or more containers, with shared storage and network resources, and a specification for how to run the containers. A Pod's contents are always co-located and co-scheduled and run in a shared context.

## Persistent storage in Kubernetes

In the previous unit, we learned about the support mechanisms in Windows containers that allow you to provide persistent storage for your applications in a local environment through bind mounts and named volumes. However, volumes and bind mounts have some drawbacks when used in a distributed environment like Kubernetes.  

Volumes and bind mounts are tied to a specific host machine, which means that they are not portable across nodes in a cluster. If a container is scheduled on a different node than the one where its data is stored, it will not be able to access it. Moreover, volumes and bind mounts are not scalable or resilient, as they depend on the availability and capacity of a single host machine.

Kubernetes solves the storage challenges of containers by introducing two abstractions: *persistent volumes* and *persistent volume claims*.

## Persistent volumes

A persistent volume (PV) is a storage resource in the cluster, created and managed by the Kubernetes API that can exist beyond the lifetime of an individual pod. A cluster administrator can statically create a `PersistentVolume`, or the Kubernetes API server can create it dynamically using *Storage Classes*. A PV is a resource in the cluster just like a node is a cluster resource. PVs have a lifecycle independent of any individual Pod that uses the PV.

## Persistent volume claims

A persistent volume claim (PVC) requests storage of a particular `StorageClass`, access mode, and size. The PVC acts as a claim check for the storage resource. The Kubernetes API server can dynamically provision the underlying storage resource if no existing resource can fulfill the claim based on the defined Storage Class.

A `StorageClass` provides a way for administrators to describe the "classes" of storage they offer. Different classes might map to quality-of-service levels, or to backup policies, or to arbitrary policies determined by the cluster administrators. Kubernetes itself is unopinionated about what classes represent.

Once the Kubernetes API server assigns an available storage resource to the pod requesting storage, the PV is bound to a PVC. Persistent volumes are a one-to-one mapping to a persistent volume claim.
