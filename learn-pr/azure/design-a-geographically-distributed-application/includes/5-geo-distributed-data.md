The final component to make the shipping application architecture highly available and fault-tolerant across regions is its data architecture.

Not unlike Azure Storage, the Azure data services you'll use for this architecture natively provide for the concept of access in more than one region. There's no need to physically duplicate the resource in another region, as you did for most of the services in the application architecture unit. Instead, you need to 'flip a switch', and use the Azure portal, PowerShell, or the Azure CLI to make them multi-regional.

Azure SQL and Cosmos DB support deployment to more than one region. Depending on the tier you select, they support different kinds of readable and writable permutations to one or more secondaries. It's easy to make an application highly available with an unlimited budget. However, there are likely to be real-world financial constraints. It's more important to identify the choke points and vulnerabilities of the application you're working on, and the way it's most likely to be used, and then allocate resources.

## Azure SQL Database

With Azure SQL, you enable **Active Geo-Replication** to create a readable secondary replica in a different region. Up to four readable secondary replicas can be configured. If the primary fails or a regional failure affects the primary, you temporarily use the readable secondaries for read-only queries. Or you can implement a failover to a secondary database. You could also use **failover groups** to do a failover that's automatically based on policies you define. Such failovers result in the secondaries becoming primary, and the DNS records are automatically updated to reflect this new state.

<!-- TODO: DIAGRAM based on the first graphic here https://docs.microsoft.com/en-us/azure/sql-database/sql-database-active-geo-replication. It would be great if primary and secondary region can be labeled as the two Europe regions to reflect the tutorial.-->

As with the Azure Storage considerations you saw in the previous unit, there's a possibility of data loss after an Azure SQL failover. Consequently, recent transactions can be lost. If you use a queue to mitigate this loss, transactions are stored in the queue and not removed until successfully written to Azure SQL. But what if the queue has also been affected by the regional outage? 

One aspect of developing a robust and fault-tolerant architecture is to accept that there might be data loss. You'll need to set a recovery time objective (RTO) or the maximum acceptable time until the app needs to become available again. When you've set such an RTO and defined a strategy for achieving it, you should assess the point that you ideally want to return to after you restore the app. 

For example, is an hour's worth of transactions an acceptable amount of data loss if there's a catastrophic failure of a region because of an earthquake or similar? If so, then returning Azure SQL DB back to the state it was in an hour before that event is the goal – this target is called the recovery point objective (RPO). This RPO and the overall estimated recovery time (ERT) might change, depending on the tier of Azure SQL Database you use.

## Cosmos DB

Cosmos DB has been designed from the ground up as a fully cloud-native database. Consequently, it supports multiple writes across regions, in addition to the designation of one region as the writable region and the others as read-only replicas. With a regional outage, you can fail over by turning another region into the writable region. Providing you use multiple write regions, high availability is guaranteed across regions. Regional failures are automatic and instantaneous, and don't require any changes in code.