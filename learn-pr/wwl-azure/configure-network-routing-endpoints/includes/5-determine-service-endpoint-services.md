
It's easy to add a service endpoint to the virtual network. In the Azure portal, you select the Azure service for which to create the endpoint. In this unit, we examine several services, including Azure Cosmos DB, Event Hubs, Key Vault, and SQL Database.

:::image type="content" source="../media/add-service-endpoints-5df9ecfc.png" alt-text="Screenshot of the Service endpoints page in the Azure portal.":::

> [!NOTE]
> Adding service endpoints can take up to 15 minutes to complete. Each service endpoint integration has its own Azure documentation page.

| Service | Availability | Description |
| --- | --- | --- |
| **Azure Storage** | Generally available in all Azure regions | This endpoint gives traffic an optimal route to the Azure Storage service. Each Storage account supports up to 100 virtual network rules. |
| **Azure SQL Database and Azure SQL Data Warehouse** | Generally available in all Azure regions | A firewall security feature controls whether your database accepts communication from particular subnets in virtual networks. This feature applies to the database server for your single databases and elastic pool in SQL Database or your databases in SQL Data Warehouse. |
| **Azure Database for PostgreSQL and Azure Database for MySQL** | Generally available in Azure regions where database service is available | Virtual network service endpoints and rules extend the private address space of a virtual network to your Azure Database for PostgreSQL server and Azure Database for MySQL server. |
| **Azure Cosmos DB** | Generally available in all Azure regions | You can configure the Azure Cosmos DB account to allow access only from a specific subnet of virtual network. Enable service endpoints to access Azure Cosmos DB on the subnet within a virtual network. Traffic from the subnet is sent to Azure Cosmos DB with the identity of the subnet and virtual network. After the Azure Cosmos DB service endpoint is enabled, you can limit access to the subnet by adding it to your Azure Cosmos DB account. |
| **Azure Key Vault** | Generally available in all Azure regions | The virtual network service endpoints for Key Vault allow you to restrict access to a specified virtual network. The endpoints also allow you to restrict access to a list of IPv4 (internet protocol version 4) address ranges. Any user connecting to your key vault from outside those sources is denied access. |
| **Azure Service Bus and Azure Event Hubs** | Generally available in all Azure regions | The integration of Service Bus with virtual network service endpoints enables secure access to messaging capabilities from workloads like virtual machines that are bound to virtual networks. The network traffic path is secured on both ends. |