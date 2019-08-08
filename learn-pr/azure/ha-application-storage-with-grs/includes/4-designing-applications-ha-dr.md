You've created your storage account in Azure and configured the replication settings to enable RA-GRS. You're now ready to start the health care application's design to make use of the RA-GRS storage account. This approach helps to ensure that the application is highly available for doctors and consultants in the field even if there's an outage in their Primary region.

In this unit, you'll look at how to design and configure an application that can handle disaster recovery and failover. You'll also explore the considerations applicable when designing applications for high availability.

## How an account failover works

When you configure a storage account GRS or RA-GRS, the client writes data to the primary endpoint or region. The data is then automatically replicated across to the secondary region. The diagram below shows this process.

![Replication workflow](../media/4-primary-secondary-replication.png)

If the primary region hosting your geo-redundant storage becomes unavailable, you can fail over to the secondary region.

When failover occurs, the secondary region becomes the new primary region, and all data is then accessible from your new primary. All DNS records, which relate to your storage account, have their DNS endpoints updated to point to the new primary region. This redirection doesn't require any changes to your application code.

The following diagram shows what happens when the primary region fails.

![Replication fail-over](../media/4-primary-account-failover.png)

> [!IMPORTANT]
> Failover is automatic and controlled by Microsoft. A manual failover of an Azure storage account is not possible in a majority of the Azure regions. However, a new feature has been made available in WestUS2 and CentralUS regions, where you can manually failover the storage account using the following command:
>
> ```azurecli
> az storage account failover --name "storgeaccountname"`.
> ```

## Implications of storage account failover

When storage account failover occurs, there's potential that you could lose data; data from the current primary region might not have replicated across to the secondary region at the time of the failover. To determine if there's likely to be data loss, you can check the **Last Sync Time** property. The command to find this value was used in the previous exercise to review the storage account replication status.

## How to design a resilient application

There are several factors you need to consider when designing your application to be resilient and highly available. Some of the areas you must consider are:

- **Resiliency** - This is the ability for the application to recover from a failure and continue to function, to avoid downtime and data loss

- **High availability** - This is the capability of the application to continue to function in a healthy state in the event there is a hardware fault, server fault, or network issues impacting one or more components of the application.

- **Disaster recovery** - This is the ability to recover the application if there's a major incident impacting the services hosting the application such as a datacenter outage, or complete regional outage. Disaster recovery includes manually failing over an application using Azure Site Recovery. Azure Site Recovery enables you to fail over servers between Azure regions or Azure backups. You can then restore a database or application from backup.

- **Eventual consistency** - RA-GRS works by replicating data from the primary endpoint to the secondary endpoint. The data, which is replicated between the regions, is not available at the secondary location immediately. Eventual consistency means that all the transactions on the primary region will eventually appear in the secondary region. The data isn't lost, but there may be some lag.

 The table below shows the effects of eventual consistency in the health care system. When a doctor uploads a new record to primary region, or when a consultant updates an existing record, the latest records are immediately available in the primary storage location. The updates are eventually propagated to the secondary regions, but there may be a delay before this occurs. An application reading data from a secondary location may see out-of-date data for a short while.

 | Time | Transaction | Replication | Last Sync Time | Result |
 | ------| -------- | --------------- | --------------- | ------ |
 | T0 | Doctor adds patient record| - | - | Transaction added but not replicated |
 | T1 | - | Record replicated | T1 | Last Sync Time field updated |
 | T2 | Consultant updates patient record | -|T1 | Record updated on primary but not replicated |
 | T3 | Read records from secondary region | | | When you read data from the secondary, you get stale data as this hasn't yet been replicated from the primary |
 | T4 | - | Records replicate | - | Data at secondary now updated. Last Sync Time updated |

## Best practices for cloud-based applications with RA-GRS

There are a number of general guidelines to consider when developing an application for the cloud.

### Retry transient failures

Transient failures can be caused by a number of conditions from a disconnected database, temporary loss of network or latency issues that cause slow response times from services. Applications must detect the faults and determine whether it's merely a blip in the service or a more severe outage. The application must have the capability to retry a service if it believes the fault is likely to be transient, before listing it as failed.

### Handle failed writes

RA-GRS replicates writes across locations. If the primary location fails, read operations can be directed towards the secondary location. However, this secondary location is read-only. If a long-lasting outage (more than a few seconds) occurs at the primary location, your application must be able to run in read-only mode. You can achieve this in several ways:

- Temporarily return an error from all write operations until write capability is restored.
- Buffer write operations, perhaps by using a queue, and enact them later when the write location becomes available.
- Write updates to a different storage account in another location. Merge these changes into the storage account at the primary location when it becomes available.
- Trigger the application to disable all write operations, and inform the user that the application is running in read-only mode. You can also use this mechanism if you need to upgrade the application and ensure that no-one is using the primary location while the upgrade is taking place.

An application using the Azure Storage client library can set the **LocationMode** of a read request to one of the following values:

- PrimaryOnly. The read fails if the primary location is unavailable. This failure is the default behavior.
- PrimaryThenSecondary. Try the primary location first, and then try the secondary location if the primary location is unavailable. Fail if the secondary location is also unavailable.
- SecondaryOnly. Only try the secondary location, and fail if it is not available.
- SecondaryThenPrimary. Try the secondary location first, and then the primary.

### Handle eventual consistency

Be prepared to handle stale data if it is read from a secondary region. As described above, it takes time to replicate data between regions, and an outage can occur between writing to the primary location and the data is replicated to each secondary location.

### Use the Circuit Breaker pattern

In distributed environments, communication between remote resources can fail because of slow network connections, resources timeouts, resources being offline, or a transmission problem corrupting data in transit. A majority of the time, these issues are transient and resolve themselves. If the application retries the same operation, it often succeeds.

In some situations, when the outage is severe, it makes sense for the application to stop retrying the operation and instead initiate failover to a secondary site.
To prevent an application to keep retrying operations that have failed, you can implement the Circuit Breaker pattern.

The Circuit Breaker pattern forces the application to fail over to the secondary site allowing the application to resume its normal service. At the same time, the circuit breaker continues to check if the resources on the primary site are back online, and when they do come online, it allows the application to reconnect to the primary site. The circuit breaker acts as a proxy; it monitors the service, and if there's a failure in the service, it prevents the application from retrying that endpoint and forces it to go to an alternative endpoint.

The difference between the Circuit Breaker pattern and the Retry pattern is that the Retry pattern allows an application to keep retrying a connection to a resource, which may be offline. The Circuit Breaker pattern prevents this behavior and failover the application to the secondary connection.

The purpose of implementing a Circuit Breaker pattern is to provide stability to your application while the system recovers from a failure.

Use the Circuit Breaker pattern to prevent an application from trying connections to resources, which have failed, and instead redirecting the connection to working resources to minimize disruption. Don't use the Circuit Breaker pattern for accessing local or in-memory data structures, as circuit breakers would add overhead to the system.

When you implement the Circuit Breaker pattern, set the **LocationMode** of read requests appropriately. Most of the time, you should set this mode to **PrimaryThenSecondary**. If the read from the primary location times out, then the secondary location is used. However, this process can slow an application down if performed repeatedly. Once the circuit breaker has detected that the primary location is unavailable, it should switch the mode to **SecondaryOnly**. This switch ensures that read operations don't wait for a timeout from the primary location before trying the secondary. When the circuit breaker estimates that the primary location has been repaired, it can revert back to the **PrimaryThenSecondary** mode.

For more information, see [Circuit Breaker pattern](https://docs.microsoft.com/azure/architecture/patterns/circuit-breaker)
