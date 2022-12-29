When we talk about applications in general, you'll often hear about *application state*. First, you need to understand what state is and what the types of states are so you can better prepare your application for handling them.

## State

The state of the application is everything that's stored in memory by the time the application is running. A state can have different kinds of things, but we're mostly talking about user data.

To give an example of application state, imagine you have a music player opened. This application has a state. It knows who you are, what you like to hear, and what music you've downloaded. All this information composes part of the application state.

The in-memory state is the information that the application doesn't need to look for anywhere else. The disk state contains the information that the application doesn't have at hand, so it needs to retrieve that from another data source.

### Types of states

There are two types of application states. The first type is the *ephemeral state*, which isn't persistent and will vanish as soon as the application is closed.

Containers have an ephemeral state. All of the data that's stored within their bounds is instantly lost when a container is deleted. Some applications can work with that alone, because they can regenerate the state from other sources and don't need the state to be stored locally. Those applications are called *:::no-loc text="stateless"::: applications*.

In contrast, all the state that isn't ephemeral is called *persistent state*. It continues to exist after the life cycle of a container. Most container technologies that we use (like Docker) have the concept of *volume*, an in-disk location where the state exists. Even if you remove the container and turn it back on, the state remains stored in a safe location and can be used again.

Applications that rely on an external state to be retrieved are called *:::no-loc text="stateful"::: applications*.

## States and Kubernetes

Kubernetes has ways to deal with both stateless and stateful applications. Dealing with stateless apps is easier because we can focus only on the application itself and not on its state (which doesn't exist).

For most stateless applications, a simple deployment workload with a pod would be enough for you to have a fully functioning system and to make the most of your cluster.

Dealing with stateful applications is the opposite. In these cases, you'll need to consider both the application and its state, where the state is stored, and how you can store the state securely and reliably.

This is why Kubernetes also has the concept of *:::no-loc text="PersistentVolumes":::* (PVs) and *:::no-loc text="PersistentVolumeClaims":::* (PVCs).

> [!TIP]
> This module won't discuss the storage concept further, but you can check out all the aspects of storage within Azure Kubernetes Service in the summary.

`PersistentVolumes` are disks that are allocated in nodes to store states from a pod's container. Because Kubernetes is best for distributed apps, all created volumes lie in a pool of *available volumes*. Then a container needs to claim that space for itself.

You can use `PersistentVolumeClaims` to bind a `PersistentVolume` with a pod and use its space to store the needed data.

All database providers are stateful applications. If you're deploying a database provider in your cluster, you'll need a PV and a PVC to store the database data in a safe spot and allow the provider to retrieve that data even if its containers were deleted.

## Best practices for state handling

State is present in most applications. However, a best practice for handling state is to not deal with it at all.

You design any efficient application with the goal of making it highly available and scalable. State goes in the opposite direction. Despite the offers of storage providers and the ease of deployment and use, state doesn't scale easily. It's not highly available either.

### Highly available state

To be highly available, an application must be online at all times. This is done through zone and region replication. Kubernetes is zone aware in most of its workloads. That means you can have several instances of an application that are deployed in different zones. However, disks aren't zone aware.

When you deploy a new `PersistentVolume` object on Kubernetes, this object is bound to a disk on a node. That disk is also bound to a particular zone in a particular region. Using zone or region replication with PVs is complex and requires a lot of maintenance, both to replicate data and to synchronize data.

### Highly scalable state

The other problem is how to make the state scalable. Throughput management solves this problem. Any scalable application should grow its throughput together with the number of users who are connected to it. This is complicated in state management because any external state is essentially a disk, and a disk has a limited input and output rate.

So, database solutions came up with the idea of *:::no-loc text="ReplicaSets":::*. They replicate the whole database into multiple instances. The replication increases the number of disks and, consequently, the I/O for the state.

On every database change, the state needs to be synchronized so that all disks contain the same data. This synchronization is also complex.

### Externalizing the state

To solve both of these problems, Azure has platform as a service (PaaS) solutions like Azure Cosmos DB. These solutions are both highly available and scalable, solving most of the state management problems for you.

Storing state externally and removing the need for maintenance can help you to focus on the application and reduce the overhead of dealing with data integrity in your infrastructure.
