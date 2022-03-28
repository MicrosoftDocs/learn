A virtual network can be segmented into one or more subnets. Subnets provide logical divisions within your network. Subnets can help improve security, increase performance, and make it easier to manage the network.

Each subnet contains a range of IP addresses that fall within the virtual network address space. The range must be unique within the address space for the virtual network. The range can't overlap with other subnet address ranges within the virtual network. The address space must be specified by using Classless Inter-Domain Routing (CIDR) notation.

:::image type="content" source="../media/azure-subnets-a5c893d5.png" alt-text="The Create virtual network page of the Azure portal is shown. The Address space, 10.1.0.0 16, is highlighted. Connected to the address space are two subnets.":::


## Considerations

 -  **Service requirements**. Each service directly deployed into virtual network has specific requirements for routing and the types of traffic that must be allowed into and out of subnets. A service may require, or create, their own subnet, so there must be enough unallocated space for them to do so. For example, if you connect a virtual network to an on-premises network using an Azure VPN Gateway, the virtual network must have a dedicated subnet for the gateway.
 -  **Virtual appliances**. Azure routes network traffic between all subnets in a virtual network, by default. You can override Azure's default routing to prevent Azure routing between subnets, or to route traffic between subnets through a network virtual appliance. So, if you require that traffic between resources in the same virtual network flow through a network virtual appliance (NVA), deploy the resources to different subnets.
 -  **Service endpoints**. You can limit access to Azure resources such as an Azure storage account or Azure SQL database, to specific subnets with a virtual network service endpoint. Further, you can deny access to the resources from the internet. You may create multiple subnets, and enable a service endpoint for some subnets, but not others.
 -  **Network security groups**. You can associate zero or one network security group to each subnet in a virtual network. You can associate the same, or a different, network security group to each subnet. Each network security group contains rules, which allow or deny traffic to and from sources and destinations.
 -  **Private Links**. Azure Private Link provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services. It simplifies the network architecture and secures the connection between endpoints in Azure by eliminating data exposure to the public internet.

> [!NOTE]
> There are restrictions on using IP addresses. Azure reserves five IP addresses within each subnet.

 -  x.x.x.0: Network address
 -  x.x.x.1: Reserved by Azure for the default gateway
 -  x.x.x.2, x.x.x.3: Reserved by Azure to map the Azure DNS IPs to the VNet space
 -  x.x.x.255: Network broadcast address
