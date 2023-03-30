Azure Private Link provides access to Azure services privately over the Microsoft Azure backbone network instead of publicly over the internet.

Suppose you work at Contoso, Ltd., a financial services company in Seattle with major offices located throughout the world. Your company has an Azure virtual network that connects to several, Azure platform as a service (PaaS) services. Your company also connects to these Azure PaaS services via several peered virtual networks and an on-premises network that uses Azure ExpressRoute. Contoso also offers company-created Azure services that Contoso customers connect to from their own Azure virtual networks.

However, the Contoso IT staff is concerned that these connections require the public internet, which they consider a security risk. It would like these connections to not use a public IP address.

You're a network engineer at Contoso. You’re responsible for finding a way to enable employees and customers to privately access services on the Azure platform. In particular, you want to evaluate Azure Private Link as a method for bypassing the internet and offering private connections.

In this module, you learn the fundamentals of Azure Private Link. You learn what it is, how it works, and when you should use it. By the end of this module, you're able to evaluate whether Azure Private Link is a suitable solution for offering Contoso employees and customers private access to Azure services.

## Learning objectives

In this module, you'll:

- Explain how Azure Private Link, Azure Private Endpoint, and Azure Private Link Service work together to create private connections to Azure resources.
- Evaluate whether Azure Private Link is appropriate for giving your employees, vendors, and customers private access to your Azure services.
- Identify and describe use cases for Azure Private Link.

## Prerequisites

To get the best learning experience from this module, you should have:

- Beginner-level knowledge of Azure, including regions, Azure virtual networks, Azure Virtual Network peering, Azure Active Directory, and ExpressRoute.
- Beginner-level knowledge of networking, including IP addresses, fully qualified domain names (FQDNs), network interfaces, and virtual private networks.
- Beginner-level knowledge of cloud computing, including tenants, virtual networks, virtual machines, and PaaS.
