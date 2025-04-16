
## Scenario

Your organization has an Azure virtual network, and you want to connect to a PaaS resource such as an Azure SQL database. When you create such resources, you normally specify a public endpoint as the connectivity method.

Having a public endpoint means that the resource is assigned a public IP address. So, even though both your virtual network and the Azure SQL database are located within the Azure cloud, the connection between them takes place over the internet.

The concern here's that your Azure SQL database is exposed to the internet through its public IP address. This exposure creates multiple security risks. These security risks are present when any Azure resource is accessed via a public IP address from:

 -  A peered Azure virtual network.
 -  An on-premises network that connects to Azure using ExpressRoute and Microsoft peering.
 -  A customer's Azure virtual network that connects to an Azure service offered by your company.

## Overview of Azure Private Endpoint and Azure Private Link

This video summarizes Private Link and Private Link. 

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


## How is Azure Private Endpoint different from a service endpoint?

Private Endpoints grant network access to specific resources behind a given service providing granular segmentation. Traffic can reach the service resource from on premises without using public endpoints.

A service endpoint remains a publicly routable IP address. A private endpoint is a private IP in the address space of the virtual network where the private endpoint is configured.

> [!TIP]
> Learn more about Azure Private Link check out the [Introduction to Azure Private Link](/training/modules/introduction-azure-private-link/) module.