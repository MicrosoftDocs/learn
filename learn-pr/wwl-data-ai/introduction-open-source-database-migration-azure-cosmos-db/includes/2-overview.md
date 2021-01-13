If you have a functional on-premises database, why should you consider moving it into a cloud service, such as Azure? Similarly, why consider implementing a new database system in Azure? Many companies perform this migration because it's easy and cheap to create a highly available and scalable service in the cloud.

In your IoT technology company, you're spending a lot of administrative time running NoSQL databases on various on-premises systems, including Cassandra and MongoDB. You think you can reduce that work by migrating the databases into Azure, but you want to know more about the support Azure has for semi-structured data and how much work would be required to complete the migration. You don't want to modify the IoT devices' software to support this migration, other than simple reconfiguration.

Here, you will learn about the features and technologies in Azure that you can use to host NoSQL databases.

### Availability

The availability guaranteed by Azure service-level agreements (SLAs) depends on the precise details of your implementation—but they're always high. For example, for Azure Cosmos DB in a single region, Microsoft guarantees 99.99% availability with no additional cost. If deployed in multiple regions, Microsoft increases this guarantee to 99.999% for both read and write availability.

If you wanted to achieve this availability in an on-premises network, you would have to architect a system that's resilient to hardware failures. You would need:

- Multiple physical servers.
- A load balancer that could reroute queries if there's a server failure.
- A storage area network that shares data between servers or a way to replicate data between servers.
- Resilient network hardware.
- An environmentally controlled datacenter.
- Uninterruptible power supplies and backup generators.

All these components are expensive and require skill to implement and run. They would also consume significant administrative resources. With Azure, these requirements are already solved; you just create the database, and high availability is built in.

### Scalability

If your user base grows, system demand grows with it. Every on-premises system has a maximum capacity—if you approach that limit, you must increase it by adding more hardware. You can't add capacity instantaneously. Instead, you must purchase the hardware, install the necessary operating system and software, apply updates, and then add the data to the new database instance. All these things take time.

Also remember that high demand is often temporary. For example, if you run a successful marketing campaign, you might see a peak in traffic, followed by a return to lower demand. In an on-premises set-up, you have to design the system for these peaks. By designing for peak load, it means that the system is under-utilized most of the time but still runs up bills and requires maintenance.

These challenges are much easier to overcome in the cloud. If your system reaches its capacity, you can respond quickly—for example, by moving to a larger tier or adding virtual machines. If demand drops, you'll quickly save money by removing capacity. In Azure, you only pay for the capacity you use.

## What is Cosmos DB?

Azure Cosmos DB is a cloud-based multi-model, globally distributed database system from Microsoft. Because the database is hosted in Azure Cosmos DB, it is always available and online and can be hosted in a datacenter close to users to provide low latency. Furthermore, Azure enables Cosmos DB to be elastically scaled up and down. Scaling up and down provides the capacity and performance that is required without paying for unused resources.

As well as hosting data close to users with more than 54 regions in the public cloud, you can add further Azure regions to your Cosmos DB solution at any time. By adding regions, you will then have automatic replication and the ability to host data close to users even if that user base is globally distributed. This replication uses a multi master model and so there does not need to be a publisher and subscribers. The model will appear to users as if they are all using a single centralized database.

By integrating with Azure and replicating across multiple regions, Cosmos DB provides a service level agreement (SLA) for 99.999% availability. Cosmos DB is used by many Microsoft products and services including Skype, Xbox, and Microsoft 365, and has therefore been thoroughly tested over a long period of time since its inception as Project Florence in 2010 and then public availability as Azure DocumentDB.

Cosmos DB has a choice of APIs to interact with your data. These APIs include SQL, MongoDB, Cassandra, Gremlin, and Azure Table Storage and are likely to be joined by more APIs in the future.

## The key benefits of Cosmos DB

### Global distribution
Cosmos DB enables you to seamlessly add or remove regions to ensure that data is close to users and improve availability. There is no need to administer replication when adding a region as data is automatically replicated using a multi-master model and applications can even be used while a region is added.

### Always on
Azure provides high levels of availability and Cosmos DB has an SLA of 99.99% when deployed to a single region. By deploying to more than one region, you can benefit from an SLA of 99.999%. Multiple regions allow your data to be available if there is a regional outage and, even if an Azure region could never be recovered, there would be no data loss in a multi-region deployment. Cosmos DB is the only service of this type to offer this level of SLA.

### Elastic scalability
The amount of data of almost every system is not static. Traditional on-premises systems needed to be provisioned with capacity for growth for the foreseeable future, which required significant over-capacity in the short term. With Cosmos DB, you pay for what you use and don't need to over provision. By paying a monthly fee for throughput generated and the quantity of GB stored, you are only paying for what you use. If more data or throughput is required, it is instantly available and is unlimited with a partitioned collection.

### Guaranteed low latency
Cosmos DB guarantees less than 10-ms latency for indexed reads and for writes globally.

### Consistency models
Consistency planning is essential for any database with multiple users and, even more so, for a globally distributed solution. As consistency increases, availability and throughput decreases, while latency increases. To simplify consistency, Cosmos DB has five levels which, when listed from most consistent to least consistent, are Strong, Bounded Staleness, Session, Consistent Prefix, and Eventual. The SLAs for your Cosmos DB database depend upon the consistency model that you choose.

### Schema and index management
With Cosmos DB, there is no schema or index management. Cosmos DB automatically indexes all data, although you can override the automatic indexing and the Cosmos DB engine is schema-agnostic.
