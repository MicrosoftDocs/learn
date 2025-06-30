

## Scenario

Your organization migrates an existing app with database servers to Azure virtual machines. Now, to reduce your costs and administrative requirements, you're considering using some Azure platform as a service (PaaS) services. Specifically, storage services to hold large file assets, such as engineering diagrams. These engineering diagrams have proprietary information, and must remain secure from unauthorized access. These files must only be accessible from specific systems. 

Here are some other scenarios that have similar requirements.

- Connecting services to peered or multiple virtual networks.
- Securing Azure resources to services deployed directly into virtual networks. 
- Filtering outbound traffic from a virtual network to Azure services.
- Managing disk traffic from an Azure virtual machine. 

## What is a Virtual Network Service Endpoint?

By default, Azure services are all designed for direct internet access. All Azure resources have public IP addresses, including PaaS services such as Azure SQL Database and Azure Storage. Because these services are exposed to the internet, anyone can potentially access your Azure services.

[Virtual Network (VNet) Service Endpoint](/azure/virtual-network/virtual-network-service-endpoints-overview) provides secure and direct connectivity to Azure services over the Azure backbone network. Endpoints allow you to secure your critical Azure service resources to only your virtual networks. Service endpoints enable private IP addresses in the virtual network to reach the endpoint of an Azure service.

:::image type="content" source="../media/service-endpoint-e15a99ae.png" alt-text="Diagram showing web server, database server, and Service Endpoint within a VNet.":::

Service Endpoints can connect certain services directly to your private address space in Azure. Azure Service Endpoints are available for many services, such as:

- Azure Storage
- Azure SQL Database
- Azure Cosmos DB
- Azure Key Vault
- Azure Service Bus
- Azure Data Lake

## Service Endpoint optimization and security features

This video highlights the optimization and security features of endpoints. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=b8e95c42-e7a2-4d29-a0bf-b5baf82c6ead]


## Service Endpoint policies

[Virtual Network Service Endpoint policies](/azure/virtual-network/virtual-network-service-endpoint-policies-overview) Service endpoint policies enable you to filter virtual network traffic to specific Azure resources, over service endpoints. For example, endpoint policies could provide granular access control for virtual network traffic to Azure Storage when connecting over a Service Endpoint.

:::image type="content" source="../media/vnet-service-endpoint-policies-overview.png" alt-text="Diagram showing an endpoint policy restriction on a storage account.":::


> [!NOTE]
> Microsoft recommends use of Azure Private Link and private endpoints for secure and private access to services hosted on the Azure platform. This information in covered in the next units. 

> [!TIP]
> Learn more about Service Endpoints in the [Secure and isolate access to Azure resources by using network security groups and service endpoints](/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/) module. This module includes an exercise to create a Service Endpoint and use network rules to restrict access to Azure Storage.