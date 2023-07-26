This unit looks at connectivity to Azure, to the internet, and to platform as a service (PaaS) services. It covers design considerations and prescriptive recommendations for the enterprise.

## Connectivity to Azure

Azure ExpressRoute is private, dedicated connectivity to Azure, and is the preferred approach for the enterprise over virtual private network (VPN). You can configure VPN as a backup route if ExpressRoute(s) fail. Because VPNs use the internet, latency can be inconsistent.

Select ExpressRoute Direct or a provider by matching your requirements for peering locations. Connect to the Microsoft network with as little latency as possible. If you need more than 10 Gbps or multiple circuits that total more than 10 Gbps, consider ExpressRoute Direct. ExpressRoute Direct is a layer 2 connection from your hardware to Microsoft's inside a peering location, and it goes up to 100 Gbps.

Ensure that you use the right SKU for the ExpressRoute or VPN gateways based on bandwidth and performance requirements. Otherwise, you're either paying too much or not getting full throughput.

Be sure to deploy zone-redundant gateways where possible. When throughput from on-premises to Azure must be greater than 10 Gbps or you need to minimize latency, enable FastPath to bypass the ExpressRoute gateway from the data path.

Proactively monitor ExpressRoute circuits by using Network Performance Monitor. Use multiple ExpressRoute peering locations for resiliency. To avoid noisy-neighbor risks, don't use the same ExpressRoute circuit to connect multiple environments that require isolation or dedicated bandwidth.

## Connectivity with the public internet

Azure-native network security services such as Azure Firewall, Azure Web Application Firewall (WAF) on Azure Application Gateway, and Azure Front Door are fully managed services. Managed services ensure you don't incur the operational and management costs associated with infrastructure deployments, which can become complex at scale. However, the enterprise-scale architecture is fully compatible with third-party network virtual appliances if:

- Your organization prefers to use network virtual appliances.
- Native services don't satisfy your organization's specific requirements.

When you're using Azure Firewall, use Azure Firewall Manager with Azure Virtual WAN to deploy and manage Azure Firewall across Virtual WAN hubs or in hub virtual networks. Firewall Manager is now in general availability (GA) for both Virtual WAN and regular virtual networks. Firewall Manager allows for Azure Firewall to be managed at scale. Create a global Azure Firewall policy to govern security posture across the global network environment, and assign it to all Azure Firewall instances.

:::image type="content" source="../media/5-firewall-overview.png" alt-text="Diagram that shows a basic Azure Firewall implementation." lightbox="../media/5-firewall-overview-large.png":::

When you're using Azure Front Door and Azure Application Gateway to help protect HTTP/S apps, use WAF policies in Azure Front Door. Also, lock down Azure Application Gateway to receive traffic only from Azure Front Door. Use Azure DDoS Network Protection to help protect all public endpoints hosted within your virtual networks. DDoS Protection provides SLA-backed distributed denial of service (DDoS) protection and log data.

Also, use Azure Firewall or a network virtual appliance from a partner to control the IP addresses that virtual machines use to access the internet. Don't replicate on-premises perimeter network concepts and architectures into Azure. Similar security capabilities are available in Azure, but the implementation and architecture must be adapted to the cloud. This strategy is a common architecture mistake that lowers performance and resiliency.

## Connectivity to PaaS services

Azure Private Link provides dedicated access by using private IP addresses to Azure PaaS instances or custom services behind Azure Load Balancer Standard. Virtual network injection provides dedicated private deployments for supported services. With virtual network injection, management-plane traffic flows through public IP addresses. Private Link is the preferred solution to help secure PaaS services.

:::image type="content" source="../media/5-private-link.png" alt-text="Diagram of how Private Link connects on-premises to private endpoints over a virtual network." lightbox="../media/5-private-link-large.png":::