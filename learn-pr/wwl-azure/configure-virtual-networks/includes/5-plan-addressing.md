You can assign IP addresses to Azure resources to communicate with other Azure resources, your on-premises network, and the internet. There are two types of Azure IP addresses: _private_ and _public_.

**Private IP addresses** enable communication within an Azure virtual network and your on-premises network. You create a private IP address for your resource when you use a VPN gateway or Azure ExpressRoute circuit to extend your network to Azure.

**Public IP addresses** allow your resource to communicate with the internet. You can create a public IP address to connect with Azure public-facing services.

The following illustration shows a virtual machine resource that has a private IP address and a public IP address.

:::image type="content" source="../media/ip-addressing-54476e47.png" alt-text="Illustration of a resource with a private IP address and a public IP address." border="false":::

### Things to know about IP addresses

Let's take a closer look at the characteristics of IP addresses.

- IP addresses are never managed from within a virtual machine.

- IP addresses can be statically assigned or dynamically assigned.

- You can separate dynamically and statically assigned IP resources into different subnets.

- Static IP addresses don't change and are best for certain situations, such as:

   - DNS name resolution, where a change in the IP address requires updating host records.
   - IP address-based security models that require apps or services to have a static IP address.
   - TLS/SSL certificates linked to an IP address.
   - Firewall rules that allow or deny traffic by using IP address ranges.
   - Role-based virtual machines such as Domain Controllers and DNS servers.