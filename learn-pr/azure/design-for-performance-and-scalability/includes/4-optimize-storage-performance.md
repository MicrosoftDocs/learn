# Optimize storage performance

## Motivation

When we think about applications, we can think of 3 common components that underpin them - storage, compute and networking. Storage is critical to our application's performance, especially as most applications have to consider storing user state in some way. In this unit, we will discuss some of the considerations that should be made from a storage perspective.

## Infrastructure Based

Let's first discuss the underlying infrastructure that you are using. If you are implementing a Platform as a Service (PaaS) based architecture, then this section may not be as relevant to you because you have less control of some of these decisions. Having said that, it is still worth familiarizing yourself with some of these concepts.

The first point to understand is that your application will have some form of requirements. Your application may be sensitive to latency (the delay between an operation being sent, e.g. read/write and it being executed) or it may require a large amount of IOPs (Input/Output per second due to a large amount of disk operations). As an example, something like SQL Server would likely require low latency and High IO requirements.

If you are deploying an Infrastructure as a Service (IaaS) workload (virtual machines), What type of disk should you use? (Standard HDD, Standard SSD or Premium SSD)

* Standard Storage HDD

  This may fit into those scenarios where your application is not bound by inconsistent latency or lower levels of throughput (IOPS).

* Standard Storage SSD

  This may fit into those scenarios Where your application is bound by consistent latency requirements but still requires a lower level of throughput (IOPS).

* Premium Storage SSD

  This may be suitable for those workloads that are going into production and require consistent latency as well as high levels of throughput (IOPS). An example of this would be SQL Server.

It is worth being aware that Premium Storage can only attach to specific Virtual Machine (VM) SKUs. Those VMs are the ones which have an S in the name, for example D2s_v3 or Standard_F2s_v2. Any virtual machine type (with or without an s in the name) can attach standard storage HDD or SSD drives.

## Application based

Let's move away from the Infrastructure and consider the application layer, agnostic of the underlying implementation.

A common approach to improve application performance is adopting caching. A cache temporarily copies frequently accessed data to some fast storage. You will want to co-locate this cache in the same region as your application to reduce the network latency between the two (similar to what we discussed in unit 3). This can improve response times of your application, as data is accessible much more quickly.

## Caching

Azure Redis Cache is a way that you could implement that on Azure. Azure Redis Cache is based upon the open-source Redis Cache, and allows you to store data in-memory which will be faster to access than your back-end datastore, likely from a disk. Azure Redis Cache is a Platform as a Service (PaaS) option, which means it is managed by Microsoft. You simply select the performance tier that you require and [configure your application to use the service][redis-cache-dotnetcore-example].

There are a series of [caching best practices][caching-best-practices] documented on the Azure Architecture Centre.

## Polyglot Persistence

Polyglot persistence is another way of saying "Use different data storage technologies to handle your various storage requirements".

For example, you may want to store your application assets in one blob store, application logs in another blob store and your user profile data in one database (e.g. SQL, NoSQL).

The reason that this is so important is that different data stores are designed for certain use cases. In addition, certain data stores may cost more to run than others. For example, storing blobs in a SQL Database may be costly and slower to access than directly from a blob store.

However, using multiple backing stores increases complexity from an architectural perspective. You will need to consider how you meet your non-functional requirements across all of those data stores, and understand how degradation of these services impacts your overall application. As well as increased complexity architecturally, you will also need to consider how data is kept consistent between those data stores. Typically, eventual consistency is used to keep data stores in sync in a distributed scenario.

Eventual consistency means that replica data stores will converge eventually if no further writes are executed. However, if a write is made to one of the data stores, then there is no guarantee that the other data stores will provide accurate (i.e. the most up to date) information. This enables higher scale because there is a low latency for reads and writes, rather than waiting to check if information is consistent across all stores.

### Lamna Healthcare Example

Lamna Healthcare have been implementing a patient booking system across multiple Azure regions (West Europe and North Europe). They are using virtual machines in the front end nodes to deploy their website, and have Azure SQL DB deployed in West Europe (primary) and North Europe (readable secondary). They are aware that their front end nodes do not require high levels of disk throughput, but do require consistent latency performance and have adopted for Standard SSD backed storage.

Rather than read directly to their database read replica, they have decided to optimise application performance and host an Azure redis cache locally in each Azure region to store the most common user requests and free/busy availability of doctors.

We have covered a few examples areas where you can the storage layer of your application for performance and scalability. It is worth familiarizing yourself with the individual Azure services that you are considering to implement in your own solution and understanding the typical usage scenarios for these sources.

<!-- links -->
[caching-best-practices]: https://docs.microsoft.com/en-us/azure/architecture/best-practices/caching
[redis-cache-dotnetcore-example]: https://docs.microsoft.com/en-gb/azure/redis-cache/cache-dotnet-core-quickstart
[throttling-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/throttling