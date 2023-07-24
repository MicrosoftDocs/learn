
Azure Private Link provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services. It simplifies the network architecture and secures the connection between endpoints in Azure by eliminating data exposure to the public internet.

### Things to know about Azure Private Link 

Let's examine the characteristics of Azure Private Link and network routing configurations.

- Azure Private Link keeps all traffic on the Microsoft global network. There's no public internet access.

- Private Link is global and there are no regional restrictions. You can connect privately to services running in other Azure regions. 

- Services delivered on Azure can be brought into your private virtual network by mapping your network to a private endpoint.

- Private Link can privately deliver your own services in your customer's virtual networks.

- All traffic to the service can be routed through the private endpoint. No gateways, NAT devices, Azure ExpressRoute or VPN connections, or public IP addresses are required. 

The following Illustration demonstrates a network routing configuration with Azure Private Link. The service connects to a network security group (NSG) private endpoint by using Azure SQL Database. This configuration prevents a direct connection.

:::image type="content" source="../media/private-links-602b4a62.png" alt-text="Diagram that shows a network routing configuration with Azure Private Link as described in the text." border="false":::

### Things to consider when using Azure Private Link 

There are many benefits to working with Azure Private Link. Review the following points and consider how you can implement the service for your scenarios.

- **Consider private connectivity to services on Azure**. Connect privately to services running in other Azure regions. Traffic remains on the Microsoft network with no public internet access.  

- **Consider integration with on-premises and peered networks**. Access private endpoints over private peering or VPN tunnels from on-premises or peered virtual networks. Microsoft hosts the traffic, so you don't need to set up public peering or use the internet to migrate your workloads to the cloud.

- **Consider protection against data exfiltration for Azure resources**. Map private endpoints to Azure PaaS resources. When there's a security incident within your network, only the mapped resources are accessible. This implementation eliminates the threat of data exfiltration.

- **Consider services delivered directly to customer virtual networks**. Privately consume Azure PaaS, Microsoft partner, and your own services in your virtual networks on Azure. Private Link works across Azure Active Directory (Azure AD) tenants to help unify your experience across services. Send, approve, or reject requests directly without permissions or role-based access controls.