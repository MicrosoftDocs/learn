Azure Network Watcher provides a suite of tools to monitor, diagnose, view metrics, and enable or disable logs for Azure IaaS (Infrastructure-as-a-Service) resources. Network Watcher enables you to monitor and repair the network health of IaaS products like virtual machines (VMs), virtual networks (VNets), application gateways, load balancers, etc. Network Watcher isn't designed or intended for PaaS monitoring or Web analytics.

Network Watcher consists of three major sets of tools and capabilities:

 -  Monitoring<br>
 -  Network diagnostic tools
 -  Traffic

:::image type="content" source="../media/azure-network-watcher-cf554286-4d5ee917.png" alt-text="Diagram showing an example of network watcher monitoring and diagnostic tools.":::


> [!NOTE]
> When you create or update a virtual network in your subscription, Network Watcher is automatically enabled in your virtual network's region. There's no impact on your resources or associated charge for automatically enabling Network Watcher.

## Monitoring

Network Watcher offers two monitoring tools that help you view and monitor resources:

 -  Topology
 -  Connection monitor

## Topology

Topology provides a visualization of the entire network for understanding network configuration. It provides an interactive interface to view resources and their relationships in Azure spanning across multiple subscriptions, resource groups, and locations.

## Connection monitor

Connection monitor provides end-to-end connection monitoring for Azure and hybrid endpoints. It helps you understand network performance between various endpoints in your network infrastructure.

## Network diagnostic tools

Network Watcher offers seven network diagnostic tools that help troubleshoot and diagnose network issues:

 -  IP flow verify
 -  NSG diagnostics
 -  Next hop
 -  Effective security rules
 -  Connection troubleshoot
 -  Packet capture
 -  VPN troubleshoot

## IP flow verify

IP flow verify allows you to detect traffic filtering issues at a virtual machine level. It checks if a packet is allowed or denied to or from an IP address (IPv4 or IPv6 address). It also tells you which security rule allowed or denied the traffic.

## Network Security Group (NSG) diagnostics

NSG diagnostics allows you to detect traffic filtering issues at a virtual machine, virtual machine scale set, or application gateway level. It checks if a packet is allowed or denied to or from an IP address, IP prefix, or a service tag. It tells you which security rule allowed or denied the traffic. It also allows you to add a new security rule with a higher priority to allow or deny the traffic.

## Next hop

Next hop allows you to detect routing issues. It checks if traffic is routed correctly to the intended destination. It provides you with information about the Next hop type, IP address, and Route table ID for a specific destination IP address.

## Effective security rules

Effective security rules allow you to view the effective security rules applied to a network interface. It shows you all security rules applied to the network interface, the subnet the network interface is in, and the aggregate of both.

## Connection troubleshoot

Connection troubleshoot enables you to test a connection between a virtual machine, a virtual machine scale set, an application gateway, or a Bastion host and a virtual machine, an FQDN, a URI, or an IPv4 address. The test returns similar information returned when using the connection monitor capability, but tests the connection at a point in time instead of monitoring it over time, as connection monitor does.

## Packet capture

Packet capture allows you to remotely create packet capture sessions to track traffic to and from a virtual machine (VM) or a virtual machine scale set.

## VPN troubleshoot

VPN troubleshoot enables you to troubleshoot virtual network gateways and their connections

## Traffic<br>

Network Watcher offers two traffic tools that help you log and visualize network traffic:

 -  Flow logs
 -  Traffic analytics

## Flow logs<br>

Flow logs allows you to log information about your Azure IP traffic and stores the data in Azure storage.

Network security groups flow logging is a feature of Azure Network Watcher that allows you to log information about IP traffic flowing through a network security group. Flow data is sent to Azure Storage from where you can access it and export it to any visualization tool, security information and event management (SIEM) solution, or intrusion detection system (IDS) of your choice.

## Traffic analytics

Traffic analytics provides rich visualizations of flow logs data.

:::image type="content" source="../media/traffic-analytics-dashboard-ff698520-64ae69dc.png" alt-text="Screenshot showing traffic analytics flow log data.":::


## Usage + quotas

The Usage + quotas capability of Network Watcher provides a summary of your deployed network resources within a subscription and region, including current usage and corresponding limits for each resource. For more information, see [Networking limits](/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=/azure/network-watcher/toc.json#azure-resource-manager-virtual-networking-limits) to learn about the limits for each Azure network resource per region per subscription. This information is helpful when planning future resource deployments as you can't create more resources if you reach their limits within the subscription or region.

:::image type="content" source="../media/network-watcher-usage-quotas-ad59c6e5.png" alt-text="Sceenshot showing an example of the Network Watcher usage and quotas page.":::


## Network Watcher limits

Network Watcher has the following limits:

Expand table

| **Resource**                                              | **Limit**                                                                  |
| --------------------------------------------------------- | -------------------------------------------------------------------------- |
| Network Watcher instances per region per subscription     | 1 (One instance in a region to enable access to the service in the region) |
| Connection monitors per region per subscription           | 100                                                                        |
| Maximum test groups per a connection monitor              | 20                                                                         |
| Maximum sources and destinations per a connection monitor | 100                                                                        |
| Maximum test configurations per a connection monitor      | 20                                                                         |
| Packet capture sessions per region per subscription       | 10,000 (Number of sessions only, not saved captures)                       |
| VPN troubleshoot operations per subscription              | 1 (Number of operations at one time)                                       |

## Pricing

For pricing details, see [Network Watcher pricing](https://azure.microsoft.com/pricing/details/network-watcher/).

## Service Level Agreement (SLA)

For SLA details, see [Service Level Agreements (SLA) for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

## Frequently asked questions (FAQ)

For answers to frequently asked questions about Network Watcher, see [Network Watcher (FAQ)](/azure/network-watcher/frequently-asked-questions).

## What's new?

To view the latest Network Watcher feature updates, see [Service updates](https://azure.microsoft.com/updates/?filters=%5B%22Network+Watcher%22%5D).

## Related content

 -  To get started using Network Watcher diagnostic tools, see [Quickstart: Diagnose a virtual machine network traffic filter problem](/azure/network-watcher/diagnose-vm-network-traffic-filtering-problem).
 -  To learn more about Network Watcher, see [Training module: Introduction to Azure Network Watcher](/training/modules/intro-to-azure-network-watcher).
