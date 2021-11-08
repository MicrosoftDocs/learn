You can assign IP addresses to Azure resources to communicate with other Azure resources, your on-premises network, and the Internet. There are two types of Azure IP addresses: public and private IP addresses.

:::image type="content" source="../media/ip-addressing-54476e47.png" alt-text="An Azure resource is shown. The resource is using a private IP address to connect to VNets, on-premises networks, VPN gateways, and ExpressRoute. The resource is using a public IP address to connect to the internet, and public-facing services.":::


 -  **Private IP addresses**: Used for communication within an Azure virtual network (VNet), and your on-premises network, when you use a VPN gateway or ExpressRoute circuit to extend your network to Azure.
 -  **Public IP addresses**: Used for communication with the Internet, including Azure public-facing services.

> [!NOTE]
> IP Addresses are never managed from within a virtual machine.

## Static vs dynamic addressing

IP addresses can also be statically assigned or dynamically assigned. Static IP addresses do not change and are best for certain situations such as:

 -  DNS name resolution, where a change in the IP address would require updating host records.
 -  IP address-based security models that require apps or services to have a static IP address.
 -  TLS/SSL certificates linked to an IP address.
 -  Firewall rules that allow or deny traffic using IP address ranges.
 -  Role-based VMs such as Domain Controllers and DNS servers.

> [!NOTE]
> You may decide to separate dynamically and statically assigned IP resources into different subnets.
