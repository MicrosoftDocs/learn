# Optimize storage performance

## Motivation

We think of three common components that underpin applications - storage, compute, and networking. Many applications store state in some way, so storage is critical to our application's performance. In this unit, we will discuss some of the considerations that should be made from a storage perspective.

## Infrastructure Based

Let's first discuss the underlying infrastructure being used. If you're implementing a Platform as a Service (PaaS) based architecture, then this section may not be as relevant to you as you have less control. Even so, it's still worth familiarizing yourself with some of these concepts.

The first point to understand is that your application will have some form of requirements. Your application may be sensitive to latency (the delay between an operation being sent, for example, read/write and it being executed) or it may require a large number of IOPs (Input/Output per second because of a large number of disk operations). As an example, something like SQL Server would likely require low latency and High IO requirements.

When building an IaaS workload, which type of disk should you use? There are three options:

* Standard Storage HDD may fit well where your application is not bound by inconsistent latency or lower levels of throughput (IOPS). A Dev/Test workload where guaranteed performance isn't needed may be a good example.

* Standard Storage SSD may fit into those scenarios. Where your application is bound by consistent latency requirements but still requires a lower level of throughput (IOPS). A webserver could be considered as a relevant example.

* Premium Storage SSD  may be suitable for those workloads that are going into production, require consistent latency or need high levels of throughput (IOPS). A relatable example would be SQL Server as it relies upon disk operations.

Premium Storage can only attach to specific Virtual Machine (VM) sizes. Those VMs are the ones that have an S in the name, for example D2s_v3 or Standard_F2s_v2. Any virtual machine type (with or without an s in the name) can attach standard storage HDD or SSD drives.

Disks can be striped using [Storage Spaces Direct][storage-spaces-direct] to increase the throughput (IPOS) provided by a single disk, as well as providing additional scalability.  Having multiple Managed Disks spread over multiple Azure Storage Accounts enables you to scale beyond the throughput [limits of Azure storage][storage-limitations] which is critical for large SQL workloads or those with higher IO requirements.

## Application based

Let's move away from the Infrastructure and consider the application layer, agnostic of the underlying implementation.

Implementing caching inside A common approach to improve application performance is adopting caching. A cache temporarily copies frequently accessed data to some fast storage. You'll want to co-locate this cache in the same region as your application to reduce the network latency between the two. Reducing the round-trip delay can improve response times of your application, as data is accessible much more quickly.

## Caching

Azure Redis Cache is a way to implement caching on Azure. It's based upon the open-source Redis Cache and allows you to store data in-memory. As data is stored in-memory, it can likely be accessed faster than the back-end datastore. Azure Redis Cache is a Platform as a Service (PaaS) which means it's managed by Microsoft. You select the performance tier that you require and [configure your application to use the service][redis-cache-dotnetcore-example].

There are a series of [caching recommended practices][caching-best-practices] documented on the Azure Architecture Center.

## Polyglot Persistence

Polyglot persistence is another way of saying "Use different data storage technologies to handle your storage requirements".

Consider an e-commerce example, you may store application assets in a blob store, product reviews, and recommendations in a NoSQL store and user profile/account data in a SQL database.

This is important as different data stores are designed for certain use cases, or may be more accessible because of cost. As an example, storing blobs in a SQL Database may be costly and slower to access than directly from a blob store.

Using many backing stores increases solution complexity. Consider how you meet your non-functional requirements across those data stores, and how service degradation impacts your overall application. Also consider how data is kept consistent between those data stores. Typically, eventual consistency is used to keep data stores in sync in a distributed scenario.

Eventual consistency means that replica data stores will eventually converge if there are no further writes. If a write is made to one of the data stores, then there's no guarantee that the other data stores will provide up-to-date information. Eventual consistency enables higher scale because there is a low latency for reads and writes, rather than waiting to check if information is consistent across all stores.

### Lamna Healthcare Example

Lamna Healthcare's patient booking system is hosted across two Azure regions (West Europe and North Europe). They're using virtual machines as the front-end nodes to deploy their website, and have Azure SQL DB deployed in West Europe (primary) and North Europe (readable secondary). Their front-end nodes don't require high levels of disk throughput, but do require consistent latency performance and have used Standard SSD backed storage.

They are hosting an Azure redis cache locally in each Azure region to store the common user requests and availability of doctors. Caching has been implemented to optimize the performance of the most common data read activities observed on the application.

We've covered a few examples on how you can improve storage performance in your infrastructure layer and at the application level. Familiarize yourself with the individual Azure services that you are evaluating in your own solution and understand the typical usage scenarios for these sources.

<!-- links -->
[caching-best-practices]: https://docs.microsoft.com/en-us/azure/architecture/best-practices/caching
[redis-cache-dotnetcore-example]: https://docs.microsoft.com/en-gb/azure/redis-cache/cache-dotnet-core-quickstart
[throttling-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/throttling
[storage-spaces-direct]: https://docs.microsoft.com/en-gb/windows-server/storage/storage-spaces/storage-spaces-direct-overview
[storage-limitations]: https://docs.microsoft.com/en-us/azure/azure-subscription-service-limits#storage-limits
