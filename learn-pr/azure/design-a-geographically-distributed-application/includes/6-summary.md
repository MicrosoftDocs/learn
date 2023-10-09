The shipping company needed to take their existing highly available architecture and make it resilient to disasters that might bring down the whole East US Azure region.

We've seen how to make the networking elements of the application highly available and multi-regional. Azure DNS and Azure CDN are multi-regional by default. By replacing Application Gateway with Azure Traffic Manager or Azure Front Door, we can detect regional failures and automatically fail over to a standby region.

Many application services, such as web apps, web APIs, and Azure Functions that implement the core functionality of your application, can be deployed to multiple regions.

Finally, you saw how to make the data architecture highly available and multi-regional by using replication in Azure SQL Database or Azure Cosmos DB.

## Learn more

- [Improve scalability in an Azure web application](/azure/architecture/reference-architectures/app-service-web-app/scalable-web-app)
- [Run a web application in multiple Azure regions for high availability](/azure/architecture/reference-architectures/app-service-web-app/multi-region)
- [Business continuity and disaster recovery (BCDR): Azure Paired Regions](/azure/best-practices-availability-paired-regions)
- [Use auto failover groups to enable transparent and coordinated failover of multiple databases](/azure/sql-database/sql-database-auto-failover-group#preventing-the-loss-of-critical-data)
- [Global data distribution with Azure Cosmos DB - overview](/azure/cosmos-db/distribute-data-globally)
- [High availability with Azure Cosmos DB](/azure/cosmos-db/high-availability)