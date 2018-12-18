It's important to include storage performance considerations in your architecture. Just like network latency, poor performance at the storage layer can impact your end-users' experience. How would you optimize your data storage? What things do you need to consider to ensure that you're not introducing storage bottlenecks into your architecture? Here, we'll take a look at how to optimize your storage performance in your architecture.

## Optimize virtual machine storage performance

Let's first look at optimizing storage for virtual machines. Disk storage plays a critical role in the performance of your virtual machines, and selecting the right disk type for your application is an important decision.

Different applications are going to have different storage requirements. Your application may be sensitive to latency of disk reads and writes or it may require the ability to handle a large number of input/output operations per second (IOPS) or greater overall disk throughput.

When building an IaaS workload, which type of disk should you use? There are four options:

- **Local SSD storage** - Each VM has a temporary disk that is backed by local SSD storage. The size of this disk varies depending on the size of the virtual machine. Since this disk is local SSD, the performance is high, but data may be lost during a maintenance event or a redeployment of the VM. This disk is only suitable for temporary storage of data that you do not need permanently. This disk is great for the page or swap file, and for things like tempdb in SQL Server. There is no charge for this storage. It's included in the cost of the VM.

- **Standard storage HDD** - This is spindle disk storage and may fit well where your application is not bound by inconsistent latency or lower levels of throughput. A dev/test workload where guaranteed performance isn't needed is a great use case for this disk type.

- **Standard storage SSD** - This is SSD backed storage and has the low latency of SSD but lower levels of throughput. A non-production web server would be a good use case for this disk type.

- **Premium storage SSD** - This SSD backed storage is well-suited for those workloads that are going into production, require the greatest reliability and demand consistent low latency, or need high levels of throughput and IOPS. Since these disks have greater performance and reliability capabilities, they are recommended for all production workloads.

Premium storage can attach only to specific virtual machine (VM) sizes. Premium storage capable sizes are designated with an "s" in the name, for example D2**s**_v3 or Standard_F2**s**_v2. Any virtual machine type (with or without an "s" in the name) can attach standard storage HDD or SSD drives.

Disks can be striped using a striping technology (such as Storage Spaces Direct on Windows or mdadm on Linux) to increase the throughput and IOPS by spreading disk activity across multiple disks. Using disk striping allows you to really push the limits of performance for disks, and is often seen in high-performance database systems and other systems with intensive storage requirements.

When relying on virtual machine workloads, you'll need to evaluate the performance requirements of your application to determine the underlying storage you'll provision for your virtual machines.

## Optimize storage performance for your application

While you can use differing storage technologies to improve the raw disk performance, you can also address the performance of access to data at the application layer. Let's take a look at a few ways you can do this.

### Caching

A common approach to improve application performance is to integrate a caching layer between your application and your data store. A cache typically stores data in memory and allows for fast retrieval. This data can be frequently accessed data, data you specify from a database, or temporary data such as user state. You'll have control over the type of data stored, how often it refreshes, and when it expires. By co-locating this cache in the same region as your application and database, you'll reduce the overall latency between the two. Pulling data out of the cache will almost always be faster than retrieving the same data from a database, so by using a caching layer you can substantially improve the overall performance of your application. The following illustration shows how an application retrieves data from a database, stores it in a cache, and uses the cached value as needed.

![An illustration showing that retrieving data from cache is faster than retrieving from a database.](../media/4-cache.png)

Azure Cache for Redis is a caching service on Azure that stores data in memory. It's based upon the open-source Redis cache and is a fully managed service offering by Microsoft. You select the performance tier that you require and configure your application to use the service.

### Polyglot persistence

Polyglot persistence is the usage of different data storage technologies to handle your storage requirements.

Consider an e-commerce example. You may store application assets in a blob store, product reviews and recommendations in a NoSQL store, and user profile or account data in a SQL database. The following illustration shows how an application might use multiple data storage techniques to store different types of data.

![An illustration showing usage of different data storage methods within the same application to increase performance and reduce cost.](../media/4-polyglotpersistence.png)

This is important, as different data stores are designed for certain use cases or may be more accessible because of cost. As an example, storing blobs in a SQL database may be costly and slower to access than directly from a blob store.

Maintaining data consistency across distributed data stores can be a significant challenge. The issue is that strategies such as serialization and locking only work well if all application instances share the same data store, and the application is designed to ensure that the locks are very short-lived. However, if data is partitioned or replicated across different data stores, locking and serializing data access to maintain consistency can become an expensive overhead that impacts the throughput, response time, and scalability of a system. Therefore, most modern distributed applications do not lock the data that they modify, and they take a rather more relaxed approach to consistency, known as eventual consistency.

Eventual consistency means that replica data stores will eventually converge if there are no further writes. If a write is made to one of the data stores, reads from another may provide slightly out-of-date data. Eventual consistency enables higher scale because there is a low latency for reads and writes, rather than waiting to check if information is consistent across all stores.

## Lamna Healthcare example

Lamna Healthcare's patient booking system is hosted across two Azure regions, West Europe and Australia East. They're using virtual machines as the front-end nodes to deploy their website, and have Azure SQL DB deployed in West Europe as primary and Australia East as a readable secondary. Their front-end nodes don't require high levels of disk throughput, but do require consistent latency performance and production reliability and have used Premium SSD backed storage.

They are hosting an Azure Cache for Redis locally in each Azure region to store the common user requests and availability of doctors. Caching has been implemented to optimize the performance of the most common data read activities observed on the application.

We've covered a few examples of how you can improve storage performance in your infrastructure layer by choosing the right disk architecture and at the application level through the use of caching and selecting the right data platform for your data. A properly architected solution will ensure that access to data performs as well as possible.