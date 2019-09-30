To integrate a set of Virtual Machines (VMs) in Azure with resources in your on-premises network, you must understand how you can connect those resources and how to configure IP addresses.

Suppose, in your manufacturing company, you want to migrate a business-critical database to Azure. Client applications on desktop computers, laptops, and mobile devices need constant access to the database as if it remained in the on-premises network. You want to move the database server without affecting users.

In this unit, you will look at a typical on-premises network design and compare it to a typical Azure network design. You will also learn about requirements for IP addressing when integrating an Azure network with on-premises networks.

## On-premises IP addressing

A typical on-premises network design includes these components:

- Modem/Router
- Firewall
- Switch
- DMZ zone
- Internal zone

![Typical on-premises network design](../media/2-on-premises-network.png)

The diagram shows a simplified version of a typical on-premises network. On the routers facing the Internet Service Provider (ISP), you have public IP addresses that are used by your outbound Internet traffic as their source. Furthermore, these are the addresses used for inbound traffic across the Internet.

 The DMZ and internal zone have private IP addresses. In the DMZ and internal zone, the IP addresses are not used to route packets across the public Internet. As such, the administrator has full control over the IP address assignment, name resolution, security settings, and security rules. There are three ranges of non-routable IP addresses specifically designed for internal networks that will not be sent over Internet routers. These are the following:

- 10.0.0.0 to 10.255.255.255
- 172.16.0.0 to 172.31.255.255
- 192.168.0.1 to 192.168.255.255

 The administrator can add or remove on-premises subnets to accommodate network devices and services. The number of subnets you can have in your on-premises network depends on the CIDR for the IP address block.


## Azure IP addressing

In an Azure network, you essentially have an internal network in the cloud. The traffic between non-public Azure services is not typically sent across the public Internet and so public IP addresses are not used. The ranges of private IP addresses are the same as for on-premises IP addressing. As in on-premises networks, the administrator has full control over the IP address assignment, name resolution, security settings, and security rules. The administrator can add or remove subnets depending on the CIDR for the IP address block. 

In Azure, you would typically implement a Network Security Group as well as a firewall. You use subnets to isolate frontend services (web servers and DNS) and backend services (database and storage). The Network Security Group separates the traffic coming in from the Internet from internal traffic and can filter both internal and external traffic at the network layer. A firewall has more extensive network layer and application layer filtering capabilities. By deploying both Network Security groups and a firewall, you have greater "defense in depth". 

In a typical Azure network design, we usually have these components:

- Virtual network
- Subnets (frontend/backend)
- Network Security Groups
- Firewall
- Load balancer (internal/external)

![Typical Azure network design](../media/2-azure-network.png)

In Azure, the network design has similar features and functions to an on-premises network, but the structure of the network is different. The Azure network does not follow the typical on-premises hierarchical network. The Azure network provides the ability to scale up and scale down infrastructure based on the demand. The provisioning in the Azure network happens in a matter of seconds. There are no hardware devices such as routers or switches. The entire infrastructure is virtual and you slice it into chunks that suit your requirements.

![Comparison of on-premises with Azure network design](../media/2-on-premises-vs-azure.png)


## Integrate Azure with on-premises networks

Before you start integrating Azure with on-premises networks, it is important to identify the current private IP address scheme used in the on-premises network because there can be no overlap for interconnected networks. You cannot use 192.168.0.0/16 on your on-premises network and use 192.168.10.0/24 on your Azure virtual network. However, you can have the same class range for multiple networks. So, you can use the 10.10.0.0/16 address space for the on-premises network and the 10.20.0.0/16 address space for your Azure network. It is vital to check for overlaps when you are planning an IP address scheme. If there is an overlap of IP addresses, you cannot integrate your networks together.

## Basic properties of Azure virtual networks

A virtual network is your network in the cloud. You can divide your virtual network into multiple subnets. Each subnet has a portion of the IP address space assigned to your virtual network. You can add, remove, expand, or shrink a subnet if there are no VMs or services deployed within it. By default, all subnets within an Azure virtual network can communicate with each other, however, you can use a Network Security Group to deny communication between subnets. The smallest subnet that is supported uses a /29-bit subnet mask. The largest supported subnet uses an /8-bit subnet mask.


## VPN Gateway requirements

Virtual network-to-virtual network and point-to-site VPNs require dynamic routing VPN gateways. Before you can deploy a VPN Gateway, you will need the following Azure and on-premises resources:

- **Virtual network.** Deploy an Azure virtual network with enough address space for the additional subnet that you will need for the VPN Gateway. The address space for this virtual network must not overlap with the on-premises network that you will be connecting. Remember that you can only deploy a single VPN Gateway within a virtual network.
- **GatewaySubnet.** Deploy a subnet called `GatewaySubnet` for the VPN Gateway. Use at least a **/27** address mask to give you enough IP addresses in the subnet for future growth. You can't use this subnet for any other services.
- **Public IP Address.** Create a basic dynamic public IP address. This address provides a public routable IP address as the target for your on-premises VPN device. Although this IP address is dynamic, it won't change unless you delete and recreate the VPN Gateway.
- **Local network gateway.** Create a local network gateway to define the on-premises network's configuration. This configuration defines where and what the VPN gateway will connect to. This configuration includes the on-premises VPN device's public IPv4 address and the on-premises routable networks. This information is used by the VPN Gateway to route packets through the IPSec tunnel that are destined for on-premises networks.
- **Virtual Network Gateway.** Create the virtual network gateway to route traffic between the virtual network and the on-premises data center or other virtual network. The virtual network Gateway can be either a VPN or an ExpressRoute gateway but this module deals only with the VPN virtual network Gateway type.
- **Connection.** Create a Connection resource to create a logical connection between the VPN gateway and the local network gateway. Make the connection to the on-premises VPN device's IPv4 address, as defined by the local network gateway. Make the connection from the virtual network gateway and its associated public IP address.


## Required on-premises resources

To connect to your data center to a VPN Gateway, you will need the following on-premises resources:

- A VPN device that supports policy-based or route-based VPN gateways.
- A public-facing, Internet routable IPv4 address.


