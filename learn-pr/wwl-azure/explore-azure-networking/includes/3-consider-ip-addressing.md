When you connect Azure Virtual Machines, Azure load balancers, and application gateways to a virtual network, the Azure platform will ensure that each of them has a unique private IP address. A private IP is allocated to a network adapter of a virtual machine, an internal Azure load balancer, or an application gateway from the IP address range of the subnet to which they're connected. This address is used for communication within the same virtual network, across multiple, connected virtual networks, or with on-premises networks via a virtual private network (VPN) tunnel or a private connection known as ExpressRoute.

In addition, the majority of Azure resources support (directly or indirectly) the use of public IP addresses. Public IP addresses allow Azure resources to become accessible directly from the internet. For example, to provide inbound connectivity from the internet to an Azure Virtual Machine, you can assign a public IP address to the network adapter of that Azure Virtual Machine. Alternatively, you can assign a public IP address to a load balancer, such as an external Azure load balancer or an application gateway, in front of that virtual machine.

Public IP addresses are available in two stock keeping units (SKUs), Basic and Standard:

## Characteristics of basic SKU public IP addresses

- They support both dynamic and static allocation methods.
- You can assign them to network interfaces of Azure Virtual Machines, internet-facing Basic SKU Azure load balancers, application gateways, and VPN gateways.
- You can assign them to a specific zone within an Azure region, but they don't support zone-level redundancy.
- They facilitate assignment of IPv6 public IP addresses to internet-facing Basic SKU Azure load balancers.

## Characteristics of standard SKU public IP addresses

- They support only the static allocation method.
- You can assign them to network interfaces of Azure Virtual Machines or internet-facing Standard SKU Azure load balancers.
- You can assign them to a specific zone or configure them as zone redundant. You can assign both types of IP addresses to the same Standard SKU Azure load balancer.
- They support only IPv4 addresses.
