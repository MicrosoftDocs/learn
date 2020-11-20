When we talk about applications in general, you'll hear the words "Application State" often. First, you need to understand what is the state and what are the types of states so you can better prepare your application for handling that.

## State

The state of the application is everything that is stored in-memory by the time such application is running. A state can have different kinds of things, but we're mostly talking about user data.

To give and example of application state, imagine you are with your music player opened. This application has a state, it knows who you are, what you like to hear, and what music you've downloaded in your machine. All this information composes part of the application state.

The in-memory-state is the information the application doesn't need to look anywhere else, while disk-state contains the information that the application doesn't have at hand, so it needs to retrieve that from another data source.

### Types of state

There are two types of application states. The first type is the ephemeral state, which is the state that isn't persistent and will vanish as soon as the application is closed.

Containers have an *ephemeral state* because all the data that is stored within their bounds is instantly lost when the container is deleted. Some applications can work with that alone, since they can regenerate the state from other sources, so they don't need it to be stored locally. Those applications are called *:::no-loc text="stateless"::: applications*.

In contrast, all the state that isn't ephemeral is called *persistent state*. It continues to exist after the life cycle of a container. Most container technologies we use (like Docker) have the concept of *volume*, an in-disk location where the state lies on.

So, even if you remove the container and then turn it back on, the state remains stored in a safe location and can be used once again.

Applications that rely on an external state to be retrieved are called *:::no-loc text="stateful"::: applications*.

## States and Kubernetes

Kubernetes also has ways to deal both with stateless and stateful applications. Dealing with stateless apps is easier because we can focus only in the application itself and not in its state, since it doesn't have one.

For most stateless applications, a simple deployment workload with a pod would be enough for you to have a fully functioning system and to make the most out of your cluster.

Dealing with stateful applications is the opposite. In these cases, you'll need to worry about both the application and its state, where is it stored and how can you store it securely and reliably.

This is why Kubernetes also has the concept of *:::no-loc text="PersistentVolumes":::* (PVs) and *:::no-loc text="PersistentVolumeClaims":::* (PVCs).

> [!TIP]
> The storage concept will not be further discussed in this module, but you can check out all the aspects of storage within AKS in the summary.

`PersistentVolumes` are disks that are allocated in Nodes to store states from a pod's container. Since Kubernetes is thought for distributed apps, all created volumes lie in a pool of "available volumes", then a container needs to claim that space for itself.

This is why there are the `PersistentVolumeClaims`, so you can bind a `PersistentVolume` with a Pod and use its space to store the needed data.

All database providers are stateful applications, if you're deploying one in your cluster, you'll need a PV and a PVC to store the database data in a safe spot and allow it to retrieve that data even if its containers were deleted.

## Best practices of state handling

State is present in the vast majority of all applications. However, the best practice we can have when dealing with state isn't to deal with the state at all.

You design any efficient application with the goal of making it highly available and scalable. State goes in the opposite direction. Despite the huge offer of storage providers and the ease of deploy and use, state doesn't scale easy, and it's not highly available either.

### Highly available state

To be highly available, an application must be online at all times, and this is done using zone and region replication, Kubernetes is zone-aware in most of its workloads, which means you can have several instances of an application that are deployed in different zones, however disks aren't.

When you deploy a new `PersistentVolume` object on Kubernetes, this object is bound to a disk on a Node, that is also bound in a particular zone in a particular region. Which means that using zone or region replication with PVs is complex and require a lot of maintenance, both to replicate and to synchronize the data.

### Highly scalable state

The other problem is how to make it scalable. This problem is solved by throughput management. Any scalable application should grow its throughput together with the number of users connected to it. Again, this is complicated in state management because, essentially, any external state is a disk, and a disk has a limited input and output rate.

So, database solutions came up with the idea of *:::no-loc text="ReplicaSets":::*. This replicates the whole database into multiple instances, which increases the number of disks and, consequently, the I/O for the state.

However, on every database change the state needs to be synchronized so all disks contain the same data, and this is also complex.

### Externalize the state

To solve both of these problems, Azure has PaaS solutions like CosmosDB that are both highly available and scalable, solving most of the state management problems for us.

Storing state externally and removing the need for maintenance makes you able to focus on the application and reduce the overhead of dealing with data integrity in your infrastructure.
