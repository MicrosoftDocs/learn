You've created your storage account in Azure and configured the replication settings to enable RA-GRS.  Now you're ready to start designing the EasyHealthCare application to make use of the RA-GRS storage account so that the application is highly available for doctors and consultants in the field.  This will ensure they can always access data and upload records 24/7 even if there is an outage in their Primary region.

In this unit you'll look at how to design and configure an application capable of handling disaster recovery and fail over. You will learn about considerations that must be taken when designing applications for high availability.

## How an account fail-over works

When a storage account is configured as GRS or RA-GRS, the normal flow of communication is the client writes data to the primary endpoint or region, and the data is then automatically replicated across to the secondary region.

The below diagram shows this process

![Replication workflow](../media/4-primary-secondary-replication.png).

In the event the primary region hosting your geo-redundant storage becomes unavailable due to unforseen circumstances, you can fail-over to the secondary region.
When fail-over occurs, the secondary region becomes the new primary region and all data is then accessible from your new primary.
All DNS records which relate to your storage account, whether it's Blob storage, Azure Files, Tables all have their DNS endpoints updated to point to the new primary region which does not require any application coding change

The below diagram shows what happens when the primary region fails

![Replication fail-over](../media/4-primary-account-failover.png).

## Implications of account fail-over

If you initiate a storage account fail-over, the DNS records are updated so that the secondary region becomes the new primary region.
There is potential that you could lose data if you were to fail-over the storage account as the data from the current primary region may not have replicated across to the secondary region at the time of invoking fail-over.  
To determine if there is likely to be data loss when you initiate fail over, you can check the **Last Sync Time** property.  The command to find this value was used in the previous exercise to review the storage account replication status.

## How to design an application for high availability

There are a number of factors you need to consider when designing your application to be resilient and highly available.  Some of the areas you must consider include:

- **Resiliency** - This is the ability for the application to recover from a failure and continue to function to avoid downtime and data loss

- **High availability** -  This is the capability of the application to continue to function in a healthy state in the event there is a hardware fault, server fault or network issues impacting one or more components of the application.

- **Disaster recovery** - This is the ability to recover the application in the event there is a major incident impacting the services hosting the application such as a datacenter outage, complete regional outage.  Disaster recovery includes manually failing over an application using ASR (Azure Site Recovery) which enables you to fail-over servers between Azure regions or Azure backups to restore a database or application from backup.

## Azure Features to utilize

There are several features available within Azure which can be utilized to make an application redundant at various levels from a server failure, hardware fault or an entire region outage

![Azure features](../media/4-azure-features.png).

- **Availability sets** - If your application is hosted on virtual machines, you should deploy two or more virtual machines in an Azure availability set.  This will protect your application against hardware faults, servers issues, server maintenance, network faults.  With Availability sets, servers are split across different fault and update domains to provide resiliency against all issues listed above

- **Availability Zones** - An Availability zone is a separate facility within an Azure region.  A facility is commonly known as a datacenter.  There are usually 2 to 3 AZ's within one region.  Deploying your application across AZ's will protect your application from a datacenter failure by ensuring the servers are still accessible in the other AZ's.  Each AZ has access to its own set of hardware, power and networks.

- **Azure Site Recovery** - With ASR (Azure Site Recovery) you can replicate virtual machines to another Azure region for disaster recovery and business continuity.  Virtual machines will replicate across from primary to secondary regions based on a replication policy you set, and in the event of a Azure region failure, you can invoke DR by bringing the virtual machines online in the secondary region.  Once the primary region is back online, you can easily failback the virtual machines.

- **Azure Health Dashboard** - Track the health of your applications and Azure Services.  The application must be designed to cope with network blips, so setup alerting for monitoring possible outages.

- **Azure Backup** - Ensure that you have a backup of your data and virtual machines to recover from a complete service failure

## Best practices for cloud based applications

Below are some general guidelines to follow when developing an application to be hosted in the Cloud.  The purpose of these guidelines is to show you how to develop an application that will continue to run even if its in a limited capacity.

### **Retry transient failure**

Transient failures can be caused by a number of conditions from a disconnected database, temporary loss of network, latency issues causing slow response from service.  
Applications must be able to detect the faults and determine whether it is simply a blip in the service or a more severe outage.  The application must have the capability to retry a service if it believes the fault is likely to be transient before listing it as failed.

### **Load balance across virtual machines**

When deploying an application in the cloud, load balance the traffic to the application by placing the virtual machines behind a load balancer and distribute the traffic to the virtual machines. In the event there is a fault with one of the servers, the load balancer will detect this and take the server out of service.

You can also scale out the virtual machines to more than one virtual machine, so if demand increases to your application, the application will automatically scale out, thus not impacting the performance of your application.

Use Azure Traffic Manager to distribute traffic across endpoints, be it in one region or across regions.  You can distribute traffic to your application running in the primary region and when and if there is a failure with the servers in the primary region, Azure Traffic Manager will detect this and redirect the traffic to the secondary region.

### **Replicate data**

Replicate data across to secondary regions, so that the data can still be accessed if there is an outage.  Make use of geo-redundant storage accounts across regions, or if you are deploying applications which utilize databases like SQL or Cosmos DB, make use of the replication features and replicate the data across to a secondary region or setup replicas of the services which can be placed in different regions and then promoted to primary role if the need arises.

You can also make use of ASR - Azure Site Recovery to replicate virtual machines between regions. Site recovery replicates the data to a target region and when an outage occurs you can fail over to the secondary location.

### **Use circuit breakers**
In distributed environments, communication between remote resources can fail due to slow network connections, resources timeouts, resources being offline or becoming corrupt. Majority of the time these issues will resolve themselves, and when deploying and application in the cloud, the application needs to deal with these outages.
In some situations when the outage is severe, it makes sense for the application to stop retrying connections and instead initiate failover to its DR site.
To prevent an application to keep retrying operations which have failed, you can implement the Circuit Breaker pattern.  The circuit breaker pattern will force the application to failover to the DR or secondary site allowing the application to resume its normal service.  At the same time, the circuit breaker will continue to check if the resources on the primary site are back online, and when they do come online, it will allow the application to reconnect to the primary site.
The difference between the Circuit Breaker pattern and the Retry pattern, is that the  Retry pattern will allow an application to keep retrying a connection to a resource which may be offline, whereas the circuit breaker pattern will prevent this behaviour and simply fail the application across to the secondary connection.

The circuit breaker pattern prevents an application from retrying a certain operation if there is a failure and forcing it to continue running by utilize an alternative route.  The circuit breaker acts like a proxy, it monitors a service and if there is a failure in the service, it prevents the application from retrying that endpoint and forces it to go to an alternative endpoint.   

For example, if EasyHealthCare applications primary region fails, the application will automatically fail over and utilize the storage accounts at the secondary location.  The circuit breaker will force the application to behave in this manner and when the primary is back online, it will re-route the application back to the primary region.

The purpose of implementing a Circuit Breaker pattern is to provide stability to your application while the system recovers from a failure.

Use this pattern:

- To prevent an application from trying connections to resources which have failed, and instead redirecting the connection to working resources to minimize disruption.

This pattern isn't recommended:

- For applications which run in-memory data structures, as circuit breakers would add overhead to the systems.

## Fiddler
The Fiddler tool is a third party tool which is used to help you debug applications, in particular web applications.  It captures network traffic between computers, and based on the result, uses its event-based scripting subsystem to halt connections.  For example, Fiddler can be used to monitor the storage account for EasyHealthCare, when it detects that consultants are no longer able to download blobs from storage, it will initiate failover to the secondary storage account.  When it detects that the primary connection is available again, it will re-direct the connections to the primary account.



## Eventual Consistency

RA-GRS (Read Access-Geo Redundant Storage) works by replicating data from the primary endpoint to the secondary endpoint.  The data which is replicated between the regions is not available at the secondary location immediately.  Eventual consistency means that all the transactions on the primary region will eventually appear at the secondary region. Below table shows an example when a doctor uploads a new record to primary region or when a consultant updates an existing record.

| Time  | Transaction | Replication     | Last Sync Time  | Result |
| ------| --------    | --------------- | --------------- | ------ |
| T0    | Doctor adds patient record| - | - | Transaction added but not replicated |
| T1    | -       | Record replicated | T1       | Last Sync Time field updated  |
| T2    | Consultant updates patient record | -|T1 | Record updated on primary but not replicated |
| T3    | Read records from secondary region | | | When you read data from secondary you get stale data as this has not been replicated yet from primary |
| T4    |    -        | Records replicates |    -           | Data at secondary now updated. Last Sync Time updated |
