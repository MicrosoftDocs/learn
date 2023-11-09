Azure **Virtual Network** is the fundamental building block for your private network in Azure. A virtual network enables many types of **Azure resources**, such as **Azure Virtual Machines (VM)**, to securely communicate with each other, the internet, and on-premises networks. A virtual network is similar to a traditional network that you'd operate in your own data center. An Azure Virtual Network brings with it extra benefits of Azure's infrastructure such as scale, availability, and isolation.

**Example: Azure virtual network**

:::image type="content" source="../media/virtual-network-qs-resources-292872a9.png" alt-text="Diagram showing an example of an Azure virtual network topology.":::


## Why use an Azure Virtual network?

Azure virtual network enables Azure resources to securely communicate with each other, the internet, and on-premises networks.

Key scenarios that you can accomplish with a virtual network include:<br>

 -  Communication of Azure resources with the internet
 -  Communication between Azure resources
 -  Communication with on-premises resources
 -  Filtering network traffic
 -  Routing network traffic
 -  Integration with Azure services.

Based on the principle of “never trust, always verify,” Zero Trust helps secure corporate resources by eliminating unknown and unmanaged devices and limiting lateral movement. Implementing a true Zero Trust model requires that all components—user identity, device, network, and applications—be validated and proven trustworthy. Zero Trust verifies identity and device health prior to granting access to corporate resources. When access is granted, applying the principle of least privilege limits user access to only those resources that are explicitly authorized for each user, thus reducing the risk of lateral movement within the environment. In an ideal Zero Trust environment, the following four elements are necessary:

 -  Strong identity authentication everywhere (user verification via authentication)
 -  Devices are enrolled in device management, and their health is validated
 -  Least-privilege user rights (access is limited to only what is needed)
 -  The health of services is verified (future goal)

## Communicate with the internet<br>

All resources in a virtual network can communicate outbound to the internet, by default. You can communicate inbound to a resource by assigning a public IP address or a public load balancer. You can also use public IP, Network Address Translation (NAT) gateway, or public load balancer to manage your outbound connections.

> [!NOTE]
> When using only an internal Standard Load Balancer, outbound connectivity is not available until you define how you want outbound connections to work with an instance-level public IP or a public load balancer.<br>

## Communicate between Azure resources<br>

Azure resources communicate securely with each other in one of the following ways:

 -  **Through a virtual network**: You can deploy VMs, and other types of Azure resources to a virtual network. Examples of resources include Azure App Service Environments, the Azure Kubernetes Service (AKS), and Azure Virtual Machine Scale Sets.<br>
 -  **Through a virtual network service endpoint**: Extend your virtual network private address space and the identity of your virtual network to Azure service resources. Examples of resources include Azure Storage accounts and Azure Structured Query Language (SQL) Database, over a direct connection. Service endpoints allow you to secure your critical Azure service resources to only a virtual network.<br>
 -  **Through virtual network peering**: You can connect virtual networks to each other, enabling resources in either virtual network to communicate with each other, using virtual network peering. The virtual networks you connect can be in the same, or different, Azure regions.<br>

## Communicate with on-premises resources<br>

You can connect your on-premises computers and networks to a virtual network using any of the following options:

 -  **Point-to-site virtual private network (VPN)**: Established between a virtual network and a single computer in your network. Each computer that wants to establish connectivity with a virtual network must configure its connection. This connection type is great if you're just getting started with Azure, or for developers, because it requires little or no changes to your existing network. The communication between your computer and a virtual network is sent through an encrypted tunnel over the internet.<br>
 -  **Site-to-site VPN**: Established between your on-premises VPN device and an Azure VPN Gateway that is deployed in a virtual network. This connection type enables any on-premises resource that you authorize to access a virtual network. The communication between your on-premises VPN device and an Azure VPN gateway is sent through an encrypted tunnel over the internet.<br>
 -  **Azure ExpressRoute**: Established between your network and Azure, through an ExpressRoute partner. This connection is private. Traffic doesn't go over the internet.<br>

## Filter network traffic<br>

You can filter network traffic between subnets using either or both of the following options:

 -  **Network security groups**: Network security groups and application security groups can contain **multiple inbound and outbound security rules**. These rules enable you to **filter traffic to and from resources by source and destination IP address**, **port**, and **protocol**.<br>
 -  **Network virtual appliances**: A network virtual appliance is a VM that performs a network function, such as a **firewall**, **Wide-Area Network (WAN) optimization**, or **other network function**.<br>

## Route network traffic<br>

Azure routes traffic between subnets, connected virtual networks, on-premises networks, and the Internet, by default. You can implement either or both of the following options to override the default routes Azure creates:

 -  **Route tables**: You can create custom route tables with routes that control where traffic is routed to for each subnet.<br>
 -  **Border gateway protocol (BGP) routes**: If you connect your virtual network to your on-premises network using an Azure VPN Gateway or ExpressRoute connection, you can propagate your on-premises Border Gateway Protocol (BGP) routes to your virtual networks.<br>

## Virtual network integration for Azure services<br>

Integrating Azure services to an Azure virtual network enables private access to the service from virtual machines or compute resources in the virtual network. You can integrate Azure services in your virtual network with the following options:

 -  Deploying dedicated instances of the service into a virtual network. The services can then be privately accessed within the virtual network and from on-premises networks.<br>
 -  Using Private Link to access privately a specific instance of the service from your virtual network and from on-premises networks.<br>
 -  You can also access the service using public endpoints by extending a virtual network to the service, through service endpoints. Service endpoints allow service resources to be secured to the virtual network.<br>

## Azure Virtual Network limits<br>

There are certain limits around the number of Azure resources you can deploy. Most Azure networking limits are at the maximum values. However, you can increase certain networking limits as specified on the virtual network limits page.

## Virtual networks and availability zones<br>

Virtual networks and subnets span all availability zones in a region. You don't need to divide them by availability zones to accommodate zonal resources. For example, if you configure a zonal VM, you don't have to take into consideration the virtual network when selecting the availability zone for the VM. The same is true for other zonal resources.
