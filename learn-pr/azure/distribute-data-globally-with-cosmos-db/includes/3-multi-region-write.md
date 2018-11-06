Assuring a great user experience in an e-commerce scenario such as yours requires high availability and low latency.

By enabling multi-master support on the Azure Cosmos DB account you created, there are multiple benefits to both of these performance aspects, and all of the benefits are guaranteed by the financially backed service level agreements (SLAs) provided by Azure Cosmos DB.

## What is multi-master support?

Multi-master support is an option that can be enabled on new Azure Cosmos DB accounts. Once the account is replicated in multiple regions, each region is a master region that equally participates in a write-anywhere model, also known as an active-active pattern.

Azure Cosmos DB regions operating as master regions in a multi-master configuration automatically work to converge data written to all replicas and ensure global consistency and data integrity.

With Azure Cosmos DB multi-master support, you can perform writes on any container in a write-enabled region world-wide. Written data is propagated to all other regions immediately.  

## What are the benefits of multi-master support?

The benefits of multi-master support are:

* Single-digit write latency – Multi-master accounts have an improved write latency of <10 ms for 99% of writes, up from <15 ms for non-multi-master accounts.
* 99.999% read-write availability - The write availability multi-master accounts increases to 99.999%, up from the 99.99% for non-multi-master accounts.
* Unlimited write scalability and throughput – With multi-master accounts, you can write to every region, providing unlimited write scalability and throughput to support billions of devices.
* Built-in conflict resolution – Multi-master accounts have three methods for resolving conflicts to ensure global data integrity and consistency.

## Conflict resolution

With the addition of multi-master support comes the possibility of encountering conflicts for writes to different regions. Conflicts are rare in Azure Cosmos DB and can only occur when an item is simultaneously changed in multiple regions, before propagation between the regions has happened. Given the speed with which replication happens globally, you should not experience conflicts often, if at all. However, Azure Cosmos DB does provide conflict resolution modes that allow users to decide how to handle scenarios where the same record is updated simultaneously by different writers in two or more regions.  

There are three conflict resolution modes offered by Azure Cosmos DB.

* **Last-Writer-Wins (LWW)**, in which conflicts are resolved based on the value of a user-defined integer property in the document. By default _ts is used to determine the last written document. Last-Writer-Wins is the default conflict handling mechanism.
* **Custom - User-defined function**, in which you can fully control conflict resolution by registering a User-defined function to the collection. A User-defined function is a special type of stored procedure with a specific signature. If the User-defined function fails or does not exist, Azure Cosmos DB will add all conflicts into the read-only conflicts feed they can be processed asynchronously.  
* **Custom - Async**, in which Azure Cosmos DB excludes all conflicts from being committed and registers them in the read-only conflicts feed for deferred resolution by the user’s application. The application can perform conflict resolution asynchronously and use any logic or refer to any external source, application, or service to resolve the conflict.

## Summary

In this unit, you learned about multi-master accounts, which enable you to write data to multiple regions for improved availability and performance.