It's important to include storage performance considerations in your architecture. Just like network latency, poor performance at the storage layer can impact your end users experience. How would you optimize your data storage? What things do you need to consider to ensure that you're not introducing storage bottlenecks into your architecture? In this unit we'll take a look at how to optimize your storage performance in your architecture.

## Optimize virtual machine storage performance

Let's first take a look at optimizing storage for virtual machines. Disk storage plays a critical role in the performance of your virtual machines, and selecting the right disk type for your application in an important decision.

Different applications are going to have different storage requirements. Your application may be sensitive to latency of disk reads and writes or it may require the ability to handle a large number of input/output operations per second (IOPS) or greater overall disk throughput.

When building an IaaS workload, which type of disk should you use? There are four options:

* **Local SSD storage** - Each VM has a temporary disk that is backed by local SSD storage. The size of this varies depending on the size of the virtual machine. Since this disk is local SSD, the performance is high, but data may be lost during a maintenance event or a redeployment of the VM. This disk is only suitable for temporary storage of data that you do not need permanently. This disk is great for the page or swap file, and for things like tempdb in SQL Server. There is no charge for this storage, it's included in the cost of the VM.

* **Standard Storage HDD** - This is spindle disk storage and may fit well where your application is not bound by inconsistent latency or lower levels of throughput. A dev/test workload where guaranteed performance isn't needed is a great use case for this disk type.

* **Standard Storage SSD** - This is SSD backed storage and has the low latency of SSD but lower levels of throughput. A non-production webserver would be good use case for this disk type.

* **Premium Storage SSD**  may be suitable for those workloads that are going into production, require the greatest reliability and demand consistent low latency or need high levels of throughput and IOPS. Since these have greater performance and reliability, these are recommended for all production workloads.

Premium Storage can only attach to specific Virtual Machine (VM) sizes. Those VMs are the ones that have an S in the name, for example D2s_v3 or Standard_F2s_v2. Any virtual machine type (with or without an s in the name) can attach standard storage HDD or SSD drives.

Disks can be striped using [Storage Spaces Direct][storage-spaces-direct] to increase the throughput and IOPS by spreading disk activity across multiple disks. Using disk striping allows you to really push the limits of performance for disks, and is often seen in high performance database systems and other systems with intensive storage requirements.

When relying on virtual machine workloads you'll need to evaluate the performance requirements of your application to determine the underlying storage you'll provision for your virtual machines.

## Optimize storage performance for your application

Ultimately, storage performance is how fast you can access your data. While you can use differing storage technologies to improve the raw disk performance, you can also address the performance of access to data at the application layer. Let's take a look at a few ways you can do this.

### Caching

A common approach to improve application performance is to integrate a caching layer between your application and your data store. A cache typically stores data in memory and allows for very fast retrieval. This data can be frequently accessed data, data you specify from a database, or temporary data such as user state. You'll have control over the type of data stored, how often it refreshes and when it expires. By co-locating this cache in the same region as your application and database, you'll reduce the overall latency between the two. Pulling data out of the cache will almost always be faster than retrieving the same data from a database, so by using a caching layer you can substantially improve the overall performance of your application.

![Cache](cache.png)

Azure Redis Cache is a caching service on Azure. It's based upon the open-source Redis Cache and allows you to store data in-memory. As data is stored in-memory, it can likely be accessed faster than the back-end datastore. Azure Redis Cache is a Platform as a Service (PaaS) and is fully managed by Microsoft. You select the performance tier that you require and [configure your application to use the service][redis-cache-dotnetcore-example].

There are a series of [caching recommended practices][caching-best-practices] documented on the Azure Architecture Center.

### Polyglot persistence

Polyglot persistence is another way of saying "Use different data storage technologies to handle your storage requirements".

Consider an e-commerce example, you may store application assets in a blob store, product reviews, and recommendations in a NoSQL store and user profile/account data in a SQL database.

![polyglotPersistence](polyglotpersistence.png)

This is important as different data stores are designed for certain use cases, or may be more accessible because of cost. As an example, storing blobs in a SQL Database may be costly and slower to access than directly from a blob store.

Using many backing stores increases solution complexity. Consider how you meet your non-functional requirements across those data stores, and how service degradation impacts your overall application. Also consider how data is kept consistent between those data stores. Typically, eventual consistency is used to keep data stores in sync in a distributed scenario, but several different consistency models are available, depending on the service.

Eventual consistency means that replica data stores will eventually converge if there are no further writes. If a write is made to one of the data stores, then there's no guarantee that the other data stores will provide up-to-date information. Eventual consistency enables higher scale because there is a low latency for reads and writes, rather than waiting to check if information is consistent across all stores.

## Lamna Healthcare example

Lamna Healthcare's patient booking system is hosted across two Azure regions, West Europe and Australia East. They're using virtual machines as the front-end nodes to deploy their website, and have Azure SQL DB deployed in West Europe as primary and Australia East as a readable secondary. Their front-end nodes don't require high levels of disk throughput, but do require consistent latency performance, production reliability and have used Premium SSD backed storage.

They are hosting an Azure redis cache locally in each Azure region to store the common user requests and availability of doctors. Caching has been implemented to optimize the performance of the most common data read activities observed on the application.

## Summary

We've covered a few examples on how you can improve storage performance in your infrastructure layer by choosing the right disk architecture and at the application level through the use of caching and selecting the right data platform for your data. A properly architected solution will ensure that access to data performs as well as possible. Now let's take a look at how we can identify performance issues in an architecture.

## Knowledge Check

What is Polyglot Persistence?

* Using different data structures in our application
* A way to keep connections alive for data transfers
* Using different data technologies for different purposes in our application (Correct)
* An approach to deal with transient data faults

Redis Cache can be used to improve the performance of our application by storing a snap-shot of data in memory:

* True (Correct)
* False

<!-- links -->
[caching-best-practices]: https://docs.microsoft.com/en-us/azure/architecture/best-practices/caching
[redis-cache-dotnetcore-example]: https://docs.microsoft.com/en-gb/azure/redis-cache/cache-dotnet-core-quickstart
[throttling-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/throttling
[storage-spaces-direct]: https://docs.microsoft.com/en-gb/windows-server/storage/storage-spaces/storage-spaces-direct-overview
[storage-limitations]: https://docs.microsoft.com/en-us/azure/azure-subscription-service-limits#storage-limits
