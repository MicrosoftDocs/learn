Private DNS zones are typically hosted centrally in the same Azure subscription where the hub VNet is deployed. This central hosting practice is driven by cross-premises DNS name resolution and other needs for central DNS resolution such as Active Directory. In most cases, only networking/identity admins have permissions to manage DNS records in these zones.

Application teams do have permissions to create Azure resource in their own subscription. They do not have any permissions in the central networking connectivity subscription, which includes managing DNS records in the private DNS zones. This access limitation means they do not have the possibility to create the DNS records required when deploying Azure PaaS services with Private Endpoints.

The following diagram shows a typical high-level architecture for enterprise environments with central DNS resolution and where name resolution for Private Link resources is done via Azure Private DNS:

> [!div class="mx-imgBorder"]
> ![Diagram of high-level workflow of enterprise environments with central DNS resolution and where name resolution for Private Link resources is done via Azure Private DNS.](../media/private-link-example-central-dns.png)

From the previous diagram, it is important to highlight that:

- On-premises DNS servers have conditional forwarders configured for each Private Endpoint public DNS zone forwarder pointing to the DNS forwarders (10.100.2.4 and 10.100.2.5) hosted in the hub VNet.

- The DNS servers 10.100.2.4 and 10.100.2.5 hosted in the hub VNet use the Azure-provided DNS resolver (168.63.129.16) as a forwarder.

- All Azure VNets have the DNS forwarders (10.100.2.4 and 10.100.2.5) configured as the primary and secondary DNS servers.

- There are two conditions that must be true to allow application teams the freedom to create any required Azure PaaS resources in their subscription:

- Central networking and/or central platform team must ensure that application teams can only deploy and access Azure PaaS services via Private Endpoints.

- Central networking and/or central platform teams must ensure that whenever Private Endpoints are created, the corresponding records are automatically created in the centralized private DNS zone that matches the service created.

- DNS record needs to follow the lifecycle of the Private Endpoint and automatically remove the DNS record when the Private Endpoint is deleted.

The following sections describe how application teams can enable these conditions by using Azure Policy. We will use Azure Storage as the Azure service that application teams need to deploy in our example below, but the same principle can be applied to most Azure services that support Private Link.

## Azure Private Endpoint DNS configuration

It's important to correctly configure your DNS settings to resolve the Private Endpoint IP address to the fully qualified domain name (FQDN) of the connection string.

Existing Microsoft Azure services might already have a DNS configuration for a public endpoint. This configuration must be overridden to connect using your private endpoint.

The network interface associated with the Private Endpoint contains the information to configure your DNS. The network interface information includes FQDN and private IP addresses for your Private Link resource.

You can use the following options to configure your DNS settings for Private Endpoints:

- **Use the host file** (only recommended for testing). You can use the host file on a virtual machine to override the DNS.

- **Use a private DNS zone**. You can use private DNS zones to override the DNS resolution for a Private Endpoint. A private DNS zone can be linked to your virtual network to resolve specific domains.

- **Use your DNS forwarder** (optional). You can use your DNS forwarder to override the DNS resolution for a Private Link resource. Create a DNS forwarding rule to use a private DNS zone on your DNS server hosted in a virtual network.

> [!Important]
>
> Is not recommended to override a zone that's actively in use to resolve public endpoints. Connections to resources won't be able to resolve correctly without DNS forwarding to the public DNS. To avoid issues, create a different domain name or follow the suggested name for each service below.

## Significance of IP address 168.63.129.16 

IP address 168.63.129.16 is a virtual public IP address that is used to facilitate a communication channel to Azure platform resources. Customers can define any address space for their private virtual network in Azure. The Azure platform resources must be presented as a unique public IP address. This virtual public IP address facilitates the following things:

- Enables the VM Agent to communicate with the Azure platform to signal that it is in a "Ready" state

- Enables communication with the DNS virtual server to provide filtered name resolution to the resources (such as VM) that do not have a custom DNS server. This filtering makes sure that customers can resolve only the hostnames of their resources

- Enables health probes from Azure load balancer to determine the health state of VMs

- Enables the VM to obtain a dynamic IP address from the DHCP service in Azure

- Enables Guest Agent heartbeat messages for the PaaS role

In a non-virtual network scenario (Classic), a private IP address is used instead of 168.63.129.16. This private IP address is dynamically discovered through DHCP. Firewall rules specific to 168.63.129.16 need to be adjusted as appropriate.

## Azure services DNS zone configuration

Azure creates a canonical name DNS record (CNAME) on the public DNS. The CNAME record redirects the resolution to the private domain name. You can override the resolution with the private IP address of your Private Endpoints.

Your applications don't need to change the connection URL. When resolving to a public DNS service, the DNS server will resolve to your Private Endpoints. The process doesn't affect your existing applications.

Private networks already using the private DNS zone for a given type, can only connect to public resources if they don't have any Private Endpoint connections, otherwise a corresponding DNS configuration is required on the private DNS zone in order to complete the DNS resolution sequence.

For Azure services, use the recommended zone names as described in the following table:

| **Private Link resource type / Subresource**                 | **Private DNS zone name**                          | **Public DNS zone forwarders**                  |
|:-:|:-:|:-:|
| Azure  Automation / (Microsoft.Automation/automationAccounts) / Webhook,  DSCAndHybridWorker | privatelink.azure-automation.net                   | azure-automation.net                            |
| Azure  SQL Database (Microsoft.Sql/servers) / sqlServer      | privatelink.database.windows.net                   | database.windows.net                            |
| Azure  Synapse Analytics (Microsoft.Sql/servers) / sqlServer | privatelink.database.windows.net                   | database.windows.net                            |
| Azure  Synapse Analytics (Microsoft.Synapse/workspaces) / Sql | privatelink.sql.azuresynapse.net                   | sql.azuresynapse.net                            |
| Storage  account (Microsoft.Storage/storageAccounts) / Blob (blob, blob_secondary) | privatelink.blob.core.windows.net                  | blob.core.windows.net                           |
| Storage  account (Microsoft.Storage/storageAccounts) / Table (table, table_secondary) | privatelink.table.core.windows.net                 | table.core.windows.net                          |
| Storage  account (Microsoft.Storage/storageAccounts) / Queue (queue, queue_secondary) | privatelink.queue.core.windows.net                 | queue.core.windows.net                          |
| Storage  account (Microsoft.Storage/storageAccounts) / File (file, file_secondary) | privatelink.file.core.windows.net                  | file.core.windows.net                           |
| Storage  account (Microsoft.Storage/storageAccounts) / Web (web, web_secondary) | privatelink.web.core.windows.net                   | web.core.windows.net                            |
| Azure  Data Lake File System Gen2 (Microsoft.Storage/storageAccounts) / Data Lake  File System Gen2 (dfs, dfs_secondary) | privatelink.dfs.core.windows.net                   | dfs.core.windows.net                            |
| Azure  Cosmos DB (Microsoft.AzureCosmosDB/databaseAccounts) / SQL | privatelink.documents.azure.com                    | documents.azure.com                             |
| Azure  Cosmos DB (Microsoft.AzureCosmosDB/databaseAccounts) / MongoDB | privatelink.mongo.cosmos.azure.com                 | mongo.cosmos.azure.com                          |
| Azure  Cosmos DB (Microsoft.AzureCosmosDB/databaseAccounts) / Cassandra | privatelink.cassandra.cosmos.azure.com             | cassandra.cosmos.azure.com                      |
| Azure  Cosmos DB (Microsoft.AzureCosmosDB/databaseAccounts) / Gremlin | privatelink.gremlin.cosmos.azure.com               | gremlin.cosmos.azure.com                        |
| Azure  Cosmos DB (Microsoft.AzureCosmosDB/databaseAccounts) / Table | privatelink.table.cosmos.azure.com                 | table.cosmos.azure.com                          |
| Azure  Database for PostgreSQL - Single server (Microsoft.DBforPostgreSQL/servers) /  postgresqlServer | privatelink.postgres.database.azure.com            | postgres.database.azure.com                     |
| Azure  Database for MySQL (Microsoft.DBforMySQL/servers) / mysqlServer | privatelink.mysql.database.azure.com               | mysql.database.azure.com                        |
| Azure  Database for MariaDB (Microsoft.DBforMariaDB/servers) / mariadbServer | privatelink.mariadb.database.azure.com             | mariadb.database.azure.com                      |
| Azure  Key Vault (Microsoft.KeyVault/vaults) / vault         | privatelink.vaultcore.azure.net                    | vault.azure.net                                 |
| vaultcore.azure.net                                          |                                                    |                                                 |
| Azure  Kubernetes Service - Kubernetes API (Microsoft.ContainerService/managedClusters)  / management | privatelink.{region}.azmk8s.io                     | {region}.azmk8s.io                              |
| Azure  Search (Microsoft.Search/searchServices) / searchService | privatelink.search.windows.net                     | search.windows.net                              |
| Azure  Container Registry (Microsoft.ContainerRegistry/registries) / registry | privatelink.azurecr.io                             | azurecr.io                                      |
| Azure  App Configuration (Microsoft.AppConfiguration/configurationStores) /  configurationStores | privatelink.azconfig.io                            | azconfig.io                                     |
| Azure  Backup (Microsoft.RecoveryServices/vaults) / vault    | privatelink.{region}.backup.windowsazure.com       | {region}.backup.windowsazure.com                |
| Azure  Site Recovery (Microsoft.RecoveryServices/vaults) / vault | {region}.privatelink.siterecovery.windowsazure.com | {region}.hypervrecoverymanager.windowsazure.com |
| Azure  Event Hubs (Microsoft.EventHub/namespaces) / namespace | privatelink.servicebus.windows.net                 | servicebus.windows.net                          |
| Azure  Service Bus (Microsoft.ServiceBus/namespaces) / namespace | privatelink.servicebus.windows.net                 | servicebus.windows.net                          |
| Azure  IoT Hub (Microsoft.Devices/IotHubs) / iotHub          | privatelink.azure-devices.net                      | azure-devices.net                               |
| privatelink.servicebus.windows.net1                          | servicebus.windows.net                             |                                                 |
| Azure  Relay (Microsoft.Relay/namespaces) / namespace        | privatelink.servicebus.windows.net                 | servicebus.windows.net                          |
| Azure  Event Grid (Microsoft.EventGrid/topics) / topic       | privatelink.eventgrid.azure.net                    | eventgrid.azure.net                             |
| Azure  Event Grid (Microsoft.EventGrid/domains) / domain     | privatelink.eventgrid.azure.net                    | eventgrid.azure.net                             |
| Azure  Web Apps (Microsoft.Web/sites) / sites                | privatelink.azurewebsites.net                      | azurewebsites.net                               |
| Azure  Machine Learning (Microsoft.MachineLearningServices/workspaces) /  amlworkspace | privatelink.api.azureml.ms                         | api.azureml.ms                                  |
| privatelink.notebooks.azure.net                              | notebooks.azure.net                                |                                                 |
|                                                              | instances.azureml.ms                               |                                                 |
|                                                              | aznbcontent.net                                    |                                                 |
| SignalR  (Microsoft.SignalRService/SignalR) / signalR        | privatelink.service.signalr.net                    | service.signalr.net                             |
| Azure  Monitor (Microsoft.Insights/privateLinkScopes) / azuremonitor | privatelink.monitor.azure.com                      | monitor.azure.com                               |
| privatelink.oms.opinsights.azure.com                         | oms.opinsights.azure.com                           |                                                 |
| privatelink.ods.opinsights.azure.com                         | ods.opinsights.azure.com                           |                                                 |
| privatelink.agentsvc.azure-automation.net                    | agentsvc.azure-automation.net                      |                                                 |
| Cognitive  Services (Microsoft.CognitiveServices/accounts) / account | privatelink.cognitiveservices.azure.com            | cognitiveservices.azure.com                     |
| Azure  File Sync (Microsoft.StorageSync/storageSyncServices) / afs | privatelink.afs.azure.net                          | afs.azure.net                                   |
| Azure  Data Factory (Microsoft.DataFactory/factories) / dataFactory | privatelink.datafactory.azure.net                  | datafactory.azure.net                           |
| Azure  Data Factory (Microsoft.DataFactory/factories) / portal | privatelink.adf.azure.com                          | adf.azure.com                                   |
| Azure  Cache for Redis (Microsoft.Cache/Redis) / redisCache  | privatelink.redis.cache.windows.net                | redis.cache.windows.net                         |




## DNS configuration scenarios

The FQDN of the services resolves automatically to a public IP address. To resolve to the private IP address of the Private Endpoint, change your DNS configuration.

DNS is a critical component to make the application work correctly by successfully resolving the Private Endpoint IP address.

Based on your preferences, the following scenarios are available with DNS resolution integrated:

- Virtual network workloads without custom DNS server

- On-premises workloads using a DNS forwarder

- Virtual network and on-premises workloads using a DNS forwarder

Azure Firewall DNS proxy can be used as DNS forwarder for On-premises workloads and Virtual network workloads using a DNS forwarder.

### Virtual network workloads without custom DNS server

This configuration is appropriate for virtual network workloads without a custom DNS server. In this scenario, the client queries for the Private Endpoint IP address to the Azure-provided DNS service 168.63.129.16. Azure DNS will be responsible for DNS resolution of the private DNS zones.

This scenario uses the Azure SQL Database-recommended private DNS zone. For other services, you can adjust the model using the following reference: Azure services DNS zone configuration.

To configure properly, you need the following resources:

- Client virtual network

- Private DNS zone privatelink.database.windows.net with type A record

- Private Endpoint information (FQDN record name and private IP address)

The following screenshot illustrates the DNS resolution sequence from virtual network workloads using the private DNS zone:

> [!div class="mx-imgBorder"]
> ![Diagram illustrating the DNS resolution sequence from virtual network workloads using the private DNS zone.](../media/single-vnet-azure-dns.png)

You can extend this model to peered virtual networks associated to the same Private Endpoint. Add new virtual network links to the private DNS zone for all peered virtual networks.

A single private DNS zone is required for this configuration. Creating multiple zones with the same name for different virtual networks would need manual operations to merge the DNS records.

If you're using a Private Endpoint in a hub-and-spoke model from a different subscription, reuse the same private DNS zone on the hub.

In this scenario, there's a hub and spoke networking topology. The spoke networks share a Private Endpoint. The spoke virtual networks are linked to the same private DNS zone.

> [!div class="mx-imgBorder"]
> ![Diagram illustrating hub and spoke topology where the spoke networks share a Private Endpoint. The spoke virtual networks are linked to the same private DNS zone.](../media/hub-spoke-azure-dns.png)

This configuration can be extended for an on-premises network that already has a DNS solution in place. The on-premises DNS solution is configured to forward DNS traffic to Azure DNS via a conditional forwarder. The conditional forwarder references the DNS forwarder deployed in Azure.

This scenario uses the Azure SQL Database-recommended private DNS zone. For other services, you can adjust the model using the following reference: Azure services DNS zone configuration.

To configure properly, you need the following resources:

- On-premises network with a custom DNS solution in place 

- Virtual network connected to on-premises

- DNS forwarder deployed in Azure

- Private DNS zones privatelink.database.windows.net with type A record

- Private Endpoint information (FQDN record name and private IP address)

The following diagram illustrates the DNS resolution from an on-premises network. DNS resolution is conditionally forwarded to Azure. The resolution is made by a private DNS zone linked to a virtual network.

The conditional forwarding must be made to the recommended public DNS zone forwarder. For example: database.windows.net instead of privatelink.database.windows.net.

> [!div class="mx-imgBorder"]
> ![Diagram illustrating DNS resolution from an on-premises network. DNS resolution is conditionally forwarded to Azure. The resolution is made by a private DNS zone linked to a virtual network](../media/on-premises-forwarding-to-azure.png)

 

### On-premises workloads using a DNS forwarder

For on-premises workloads to resolve the FQDN of a Private Endpoint, use a DNS forwarder to resolve the Azure service public DNS zone in Azure. A DNS forwarder is a Virtual Machine running on the Virtual Network linked to the Private DNS Zone that can proxy DNS queries coming from other Virtual Networks or from on-premises. This is required as the query must be originated from the Virtual Network to Azure DNS. A few options for DNS proxies are: Windows running DNS services, Linux running DNS services, Azure Firewall.

The following scenario is for an on-premises network that has a DNS forwarder in Azure. This forwarder resolves DNS queries via a server-level forwarder to the Azure provided DNS 168.63.129.16.

This scenario uses the Azure SQL Database-recommended private DNS zone. For other services, you can adjust the model using the following reference: Azure services DNS zone configuration.

To configure properly, you need the following resources:

- On-premises network

- Virtual network connected to on-premises

- DNS forwarder deployed in Azure 

- Private DNS zones privatelink.database.windows.net with type A record

- Private Endpoint information (FQDN record name and private IP address)

The following diagram illustrates the DNS resolution sequence from an on-premises network. The configuration uses a DNS forwarder deployed in Azure. The resolution is made by a private DNS zone linked to a virtual network:

> [!div class="mx-imgBorder"]
> ![Diagram illustrating the DNS resolution sequence from an on-premises network using a DNS forwarder deployed in Azure.](../media/on-premises-using-azure-dns.png)

### Virtual network and on-premises workloads using a DNS forwarder

For workloads accessing a Private Endpoint from virtual and on-premises networks, use a DNS forwarder to resolve the Azure service public DNS zone deployed in Azure.

The following scenario is for an on-premises network with virtual networks in Azure. Both networks access the Private Endpoint located in a shared hub network.

This DNS forwarder is responsible for resolving all the DNS queries via a server-level forwarder to the Azure-provided DNS service 168.63.129.16.

**A single private DNS zone is required for this configuration. All client connections made from on-premises and peered virtual networks must also use the same private DNS zone**.

This scenario uses the Azure SQL Database-recommended private DNS zone. For other services, you can adjust the model using the following reference: Azure services DNS zone configuration.

To configure properly, you need the following resources:

- On-premises network

- Virtual network connected to on-premises

- Peered virtual network 

- DNS forwarder deployed in Azure

- Private DNS zones privatelink.database.windows.net with type A record

- Private Endpoint information (FQDN record name and private IP address)

The following diagram shows the DNS resolution for both networks, on-premises and virtual networks. The resolution is using a DNS forwarder. The resolution is made by a private DNS zone linked to a virtual network:

> [!div class="mx-imgBorder"]
> ![Diagram illustrating the DNS resolution for both on-premises and virtual networks.](../media/hybrid-scenario.png)