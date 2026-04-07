

## Scenario

Your organization has an Azure virtual network, and you want to connect to a PaaS resource such as an Azure SQL database. When you create such resources, you normally specify a public endpoint as the connectivity method.

Having a public endpoint means that the resource is assigned a public IP address. So, even though both your virtual network and the Azure SQL database are located within the Azure cloud, the connection between them takes place over the internet.

The concern here's that your Azure SQL database is exposed to the internet through its public IP address. This exposure creates multiple security risks. These security risks are present when any Azure resource is accessed via a public IP address from:

 -  A peered Azure virtual network.
 -  An on-premises network that connects to Azure using ExpressRoute and Microsoft peering.
 -  A customer's Azure virtual network that connects to an Azure service offered by your company.

## Overview of Azure Private Endpoint and Azure Private Link

This video summarizes Private Endpoints and Private Links. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=512163b5-e468-4e20-ab1c-d82d4420951e]

## What is Azure Private Link?

[Azure Private Link](/azure/private-link/private-link-overview) enables you to access Azure PaaS Services and Azure hosted customer-owned/partner services over a Private Endpoint in your virtual network. Private Link is designed to eliminate security risks by removing the public part of the connection.

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. There are three key points to consider with this new architecture.

 -  The Azure resource becomes, in a sense, a part of your virtual network.
 -  The connection to the resource now uses the Microsoft Azure backbone network instead of the public internet.
 -  You can configure the Azure resource to no longer expose its public IP address, which eliminates that potential security risk.

## What is Azure Private Endpoint?

[Azure private endpoint](/azure/private-link/private-endpoint-overview) is the key technology behind private link. Private endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. In other words, private endpoint is the network interface that replaces the resource's public endpoint.

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. Private Endpoint uses the private IP address for services into the virtual network.

:::image type="content" source="../media/private-link-71e02d03.png" alt-text="Diagram showing private endpoint and private link zone.":::

[Network policies](/azure/private-link/disable-private-endpoint-network-policy/) are disabled by default for private endpoint subnets. You can selectively enable support for:

- **Network Security Groups (NSG)**: Control inbound traffic to the private endpoint from specific sources.

- **User Defined Routes (UDR)**: Override the default /32 route to redirect traffic through an NVA or firewall.

- **Application Security Groups (ASG)**: Group private endpoints for policy application.


## How is Azure Private Endpoint different from a service endpoint?



Azure Private Endpoint lets you connect to an Azure service using a private IP address from your own virtual network. This process ensures all traffic on Microsoft's network and means you don't need the public internet to access the service.

In contrast, Service Endpoints secure access to an Azure service’s public endpoint by allowing traffic from specific VNets or subnets, but the service itself still uses a public IP.

Private Endpoints offer full isolation and higher security, while Service Endpoints are easier to set up but provide less isolation.


> [!NOTE]
> When public internet access is required for PaaS services, [Network Security Perimeter](/azure/private-link/network-security-perimeter-concepts) provides a logical security boundary with controlled inbound and outbound access rules. Network Security Perimeter is generally available in all Azure public regions and complements Private Link.
