When talking about applications in general, you might often hear about the *application state*. In this unit, we review the definition of state and the different types of states so you can better prepare your application for handling them.

## State

The state of the application is everything that's stored in memory by the time the application is running. The state can involve various things, but we mostly focus on the user data.

To give an example of application state, imagine you have a music player opened. This application has a state. It knows who you are, what you like to hear, and what music you've downloaded. All this information is part of the application state.

The in-memory state is the information that the application doesn't need to look for anywhere else. The disk state contains the information that the application doesn't have at hand, so it needs to retrieve that from another data source.

### Types of states

There are two types of application states. The first type is the *ephemeral state*, which isn't persistent and vanishes as soon as the application is closed.

Containers have an ephemeral state. All of the data stored within them is instantly lost when the container is deleted. Some applications can work with that alone, because they can regenerate the state from other sources and don't need the state to be stored locally. Those applications are called *:::no-loc text="stateless"::: applications*.

All the remaining state that isn't ephemeral is called *persistent state*. Persistent state continues to exist after the lifecycle of a container. Most container technologies that we use have the concept of *volume*, an in-disk location where the state exists. Even if you remove the container and turn it back on, the state remains stored in a safe location and can be used again.

Applications that rely on an external state to be retrieved are called *:::no-loc text="stateful"::: applications*.

## States and Kubernetes

Kubernetes can handle both stateless and stateful applications. Stateless apps are easier because we can focus only on the application itself and not on its state (since it doesn't exist).

For most stateless applications, a simple deployment workload with a pod would be enough for you to have a fully functioning system and to make the most of your cluster.

Dealing with stateful applications is the opposite. In these cases, you need to consider the application and its state, where the state is stored, and how you can store the state securely and reliably.

This is why Kubernetes also has the concept of *:::no-loc text="PersistentVolumes":::* (PVs) and *:::no-loc text="PersistentVolumeClaims":::* (PVCs).

> [!TIP]
> This module doesn't discuss storage concepts further, but you can refer to the Azure Kubernetes Service resources in the summary to learn more.

`PersistentVolumes` are disks that are allocated in nodes to store states from a pod's container. Because Kubernetes is best for distributed apps, all created volumes lie in a pool of *available volumes*. Containers then claim that space for themselves. You can use `PersistentVolumeClaims` to bind a `PersistentVolume` with a pod and use its space to store the needed data.

All database providers are stateful applications. If you're deploying a database provider in your cluster, you need a PV and a PVC to store the database data in a safe spot and allow the provider to retrieve that data even if its containers were deleted.

## Best practices for state handling

State is present in most applications. However, a best practice for handling state is to not deal with it at all.

You design any efficient application with the goal of making it highly available and scalable. State goes in the opposite direction. Despite the options provided by storage providers and the ease of deployment and use, state doesn't scale easily. It's not highly available either.

### Highly available state

To be highly available, an application must be online at all times. This is done through zone and region replication. Kubernetes is zone aware in most of its workloads. That means you can have several instances of an application that are deployed in different zones. However, disks aren't zone aware.

When you deploy a new `PersistentVolume` object on Kubernetes, it's bound to a disk on a node. That disk is also bound to a particular zone in a particular region. Using zone or region replication with PVs is complex and requires a lot of maintenance, both to replicate and to synchronize data.

### Highly scalable state

To be highly scalable, an application should grow its throughput together with the number of users who are connected to it. This is complicated in state management because any external state is essentially a disk, and a disk has a limited input and output rate. Throughput management helps solve this problem.

Database solutions came up with the idea of *:::no-loc text="ReplicaSets":::*, which replicate the whole database into multiple instances. The replication increases the number of disks *and* the I/O for the state.

On every database change, the state needs to be synchronized so that all disks contain the same data. This synchronization is also complex.

### Externalizing the state

Azure has platform as a service (PaaS) solutions, like Azure Cosmos DB, that are highly available and scalable and solve most of the state management problems for you.

Storing state externally and removing the need for maintenance can help you to focus on the application and reduce the overhead of dealing with data integrity in your infrastructure.
