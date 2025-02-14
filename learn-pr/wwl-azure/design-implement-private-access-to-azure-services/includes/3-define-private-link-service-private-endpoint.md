


## What is Azure Private Link?

Azure Private Link enables you to access Azure PaaS Services and Azure hosted customer-owned/partner services over a Private Endpoint in your virtual network.

Before you learn about Azure Private Link and its features and benefits, let's examine the problem that Private Link is designed to solve.

Contoso has an Azure virtual network, and you want to connect to a PaaS resource such as an Azure SQL database. When you create such resources, you normally specify a public endpoint as the connectivity method.

Having a public endpoint means that the resource is assigned a public IP address. So, even though both your virtual network and the Azure SQL database are located within the Azure cloud, the connection between them takes place over the internet.

The concern here's that your Azure SQL database is exposed to the internet through its public IP address. This exposure creates multiple security risks. These security risks are present when any Azure resource is accessed via a public IP address from:

 -  A peered Azure virtual network.
 -  An on-premises network that connects to Azure using ExpressRoute and Microsoft peering.
 -  A customer's Azure virtual network that connects to an Azure service offered by your company.

:::image type="content" source="../media/private-link-71e02d03.png" alt-text="Diagram showing private endpoint and private link zone.":::


Private Link is designed to eliminate these security risks by removing the public part of the connection.

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. There are three key points to consider with this new architecture:

 -  The Azure resource becomes, in a sense, a part of your virtual network.
 -  The connection to the resource now uses the Microsoft Azure backbone network instead of the public internet.
 -  You can configure the Azure resource to no longer expose its public IP address, which eliminates that potential security risk.

## What is Azure Private Endpoint?

Private Endpoint is the key technology behind Private Link. Private Endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. In other words, Private Endpoint is the network interface that replaces the resource's public endpoint.

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. Private Endpoint uses the private IP address for services into the VNet.

### How is Azure Private Endpoint different from a service endpoint?

Private Endpoints grant network access to specific resources behind a given service providing granular segmentation. Traffic can reach the service resource from on premises without using public endpoints.

A service endpoint remains a publicly routable IP address. A private endpoint is a private IP in the address space of the virtual network where the private endpoint is configured.

> [!NOTE]
> Microsoft recommends use of Azure Private Link for secure and private access to services hosted on Azure platform. 


## What is Azure Private Link Service?

Private Link gives you private access from your Azure virtual network to PaaS services and Microsoft Partner services in Azure. But, what if your company has its own Azure services? Is it possible to offer those customers a private connection to your company's services?

Yes, by using Azure Private Link Service. This service lets you offer Private Link connections to your custom Azure services. Consumers of your custom services can then access those services privately—that is, without using the internet—from their own Azure virtual networks.

Azure Private Link service is the reference to your own service that is powered by Azure Private Link. Your service that is running behind Azure standard load balancer can be enabled for Private Link access so that consumers to your service can access it privately from their own VNets. Your customers can create a private endpoint inside their VNet and map it to this service. A Private Link service receives connections from multiple private endpoints. A private endpoint connects to one Private Link service.

:::image type="content" source="../media/consumer-provider-endpoint.png" alt-text="Diagram of the private link service workflow." lightbox="../media/consumer-provider-endpoint.png":::

## Private Endpoint properties

Before creating a Private Endpoint, you should consider the Private Endpoint properties and collect data about specific needs to be addressed. 

 -  A unique name with a resource group.
 -  A subnet to deploy and allocate private IP addresses from a virtual network.
 -  The Private Link resource to connect using resource ID or alias, from the list of available types. A unique network identifier is generated for all traffic sent to this resource.
 -  The subresource to connect. Each Private Link resource type has different options to select based on preference.
 -  An automatic or manual connection approval method. Based on Azure role-based access control (RBAC) permissions, your Private Endpoint can be approved automatically. For the manual method, the owner of the resource approves the connection.
 -  Only Private Endpoints in an approved state can be used to send traffic.

Also consider:

 -  Clients initiate network connections. Connections can only be established in a single direction.
 -  Private Endpoint has a read-only network interface for the lifecycle of the resource. The interface is assigned dynamically private IP addresses from the subnet that maps to the Private Link resource. The value of the private IP address remains unchanged for the entire lifecycle of the Private Endpoint.
 -  The Private Endpoint must be deployed in the same region and subscription as the virtual network.
 -  The Private Link resource can be deployed in a different region than the virtual network and Private Endpoint.
 -  Multiple Private Endpoints can be created using the same Private Link resource. 
 -  Multiple Private Endpoints can be created on the same or different subnets within the same virtual network.