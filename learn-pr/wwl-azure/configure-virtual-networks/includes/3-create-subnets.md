Subnets provide a way for you to implement logical divisions within your virtual network. Your network can be segmented into subnets to help improve security, increase performance, and make it easier to manage. 

### Things to know about subnets

There are certain conditions for the IP addresses in a virtual network when you apply segmentation with subnets.

- Each subnet contains a range of IP addresses that fall within the virtual network address space.

- The address range for a subnet must be unique within the address space for the virtual network.

- The range for one subnet can't overlap with other subnet IP address ranges in the same virtual network.

- The IP address space for a subnet must be specified by using CIDR notation.

- You can segment a virtual network into one or more subnets in the Azure portal. Characteristics about the IP addresses for the subnets are listed.

   :::image type="content" source="../media/azure-subnets-a5c893d5.png" alt-text="Screenshot that shows multiple subnets for a virtual network in the Azure portal.":::

#### Reserved addresses

For each subnet, Azure reserves five IP addresses. The first four addresses and the last address are reserved.

Let's examine the reserved addresses in an IP address range of `192.168.1.0/24`.

| Reserved address | Reason |
| --- | --- |
| `192.168.1.0` | This value identifies the virtual network address. |
| `192.168.1.1` | Azure configures this address as the default gateway. |
| `192.168.1.2` _and_ `192.168.1.3` | Azure maps these Azure DNS IP addresses to the virtual network space. |
| `192.168.1.255` | This value supplies the virtual network broadcast address. |

### Things to consider when using subnets

When you plan for adding subnet segments within your virtual network, there are several factors to consider. Review the following scenarios.

- **Consider service requirements**. Each service directly deployed into a virtual network has specific requirements for routing and the types of traffic that must be allowed into and out of associated subnets. A service might require or create their own subnet. There must be enough unallocated space to meet the service requirements. Suppose you connect a virtual network to an on-premises network by using Azure VPN Gateway. The virtual network must have a dedicated subnet for the gateway.

- **Consider network virtual appliances**. Azure routes network traffic between all subnets in a virtual network, by default. You can override Azure's default routing to prevent Azure routing between subnets. You can also override the default to route traffic between subnets through a network virtual appliance. If you require traffic between resources in the same virtual network to flow through a network virtual appliance, deploy the resources to different subnets.

- **Consider service endpoints**. You can limit access to Azure resources like an Azure storage account or Azure SQL database to specific subnets with a virtual network service endpoint. You can also deny access to the resources from the internet. You might create multiple subnets, and then enable a service endpoint for some subnets, but not others.

- **Consider network security groups**. You can associate zero or one network security group to each subnet in a virtual network. You can associate the same or a different network security group to each subnet. Each network security group contains rules that allow or deny traffic to and from sources and destinations.

- **Consider private links**. Azure Private Link provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services. Private Link simplifies the network architecture and secures the connection between endpoints in Azure. The service eliminates data exposure to the public internet.