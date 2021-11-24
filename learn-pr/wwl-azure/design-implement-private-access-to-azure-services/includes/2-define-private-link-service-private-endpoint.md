## What is Azure Private Link?

Azure Private Link enables you to access Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a Private Endpoint in your virtual network.

Before you learn about Azure Private Link and its features and benefits, let's examine the problem that Private Link is designed to solve.

Contoso has an Azure virtual network, and you want to connect to a PaaS resource such as an Azure SQL database. When you create such resources, you normally specify a public endpoint as the connectivity method.

Having a public endpoint means that the resource is assigned a public IP address. So, even though both your virtual network and the Azure SQL database are located within the Azure cloud, the connection between them takes place over the internet.

The concern here is that your Azure SQL database is exposed to the internet via its public IP address. That exposure creates multiple security risks. The same security risks are present when an Azure resource is accessed via a public IP address from the following locations:

 -  A peered Azure virtual network
 -  An on-premises network that connects to Azure using ExpressRoute and Microsoft peering
 -  A customer's Azure virtual network that connects to an Azure service offered by your company

:::image type="content" source="../media/private-link-71e02d03.png" alt-text="image showing private endpoint and private link zone, customer v-net zone, and intersection with customer premises":::


Private Link is designed to eliminate these security risks by removing the public part of the connection.

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. There are three key points to consider with this new architecture:

 -  The Azure resource becomes, in a sense, a part of your virtual network.
 -  The connection to the resource now uses the Microsoft Azure backbone network instead of the public internet.
 -  You can configure the Azure resource to no longer expose its public IP address, which eliminates that potential security risk.

## What is Azure Private Endpoint?

Private Endpoint is the key technology behind Private Link. Private Endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. In other words, Private Endpoint is the network interface that replaces the resource's public endpoint.

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. Private Endpoint uses a private IP address from the VNet to bring the service into the VNet.

## What is Azure Private Link Service?

Private Link gives you private access from your Azure virtual network to PaaS services and Microsoft Partner services in Azure. However, what if your company has created its own Azure services that are consumed by your company's customers? Is it possible to offer those customers a private connection to your company's services?

Yes, by using Azure Private Link Service. This service lets you offer Private Link connections to your custom Azure services. Consumers of your custom services can then access those services privately—that is, without using the internet—from their own Azure virtual networks.

Azure Private Link service is the reference to your own service that is powered by Azure Private Link. Your service that is running behind Azure standard load balancer can be enabled for Private Link access so that consumers to your service can access it privately from their own VNets. Your customers can create a private endpoint inside their VNet and map it to this service. A Private Link service receives connections from multiple private endpoints. A private endpoint connects to one Private Link service.

:::image type="content" source="../media/consumer-provider-endpoint-2c5222b7.png" alt-text="Private link service workflow" lightbox="../media/consumer-provider-endpoint-2c5222b7.png":::

## Plan Private Endpoints

Before creating a Private Endpoint, you should consider the Private Endpoint properties and collect data about specific needs to be addressed. These include:

 -  A unique name with a resource group
 -  A subnet to deploy and allocate private IP addresses from a virtual network
 -  The Private Link resource to connect using resource ID or alias, from the list of available types. A unique network identifier will be generated for all traffic sent to this resource.
 -  The subresource to connect. Each Private Link resource type has different options to select based on preference.
 -  An automatic or manual connection approval method. Based on Azure role-based access control (Azure RBAC) permissions, your Private Endpoint can be approved automatically. If you try to connect to a Private Link resource without Azure RBAC, use the manual method to allow the owner of the resource to approve the connection.
 -  A specific request message for requested connections to be approved manually. This message can be used to identify a specific request.
 -  Connection status, A read-only property that specifies if the Private Endpoint is active. Only Private Endpoints in an approved state can be used to send traffic.

Also consider the following details:

 -  Private Endpoint enables connectivity between the consumers from the same VNet, regionally peered VNets, globally peered VNets and on premises using VPN or Express Route and services powered by Private Link.
 -  Network connections can only be initiated by clients connecting to the Private Endpoint, Service providers do not have any routing configuration to initiate connections into service consumers. Connections can only be established in a single direction.
 -  When creating a Private Endpoint, a read-only network interface is also created for the lifecycle of the resource. The interface is assigned dynamically private IP addresses from the subnet that maps to the Private Link resource. The value of the private IP address remains unchanged for the entire lifecycle of the Private Endpoint.
 -  The Private Endpoint must be deployed in the same region and subscription as the virtual network.
 -  The Private Link resource can be deployed in a different region than the virtual network and Private Endpoint.
 -  Multiple Private Endpoints can be created using the same Private Link resource. For a single network using a common DNS server configuration, the recommended practice is to use a single Private Endpoint for a given Private Link resource to avoid duplicate entries or conflicts in DNS resolution.
 -  Multiple Private Endpoints can be created on the same or different subnets within the same virtual network. There are limits to the number of Private Endpoints you can create in a subscription. For details, see Azure limits.
 -  The subscription from the Private Link resource must also be registered with Microsoft.