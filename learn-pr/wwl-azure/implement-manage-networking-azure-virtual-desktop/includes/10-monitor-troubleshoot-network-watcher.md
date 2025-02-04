Azure Network Watcher provides a suite of tools to monitor, diagnose, view metrics, and enable or disable logs for Azure IaaS (Infrastructure-as-a-Service) resources. Network Watcher enables you to monitor and repair the network health of IaaS products like virtual machines (VMs), virtual networks (VNets), application gateways, load balancers, etc. Network Watcher isn't designed or intended for PaaS monitoring or Web analytics.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=42144182-b8b1-4425-b28e-8e27fac6c9e8]

Network Watcher consists of three major sets of tools and capabilities:

 -  Monitoring
 -  Network diagnostic tools
 -  Traffic

:::image type="content" source="../media/network-watcher-capabilities-a25629a3.png" alt-text="Diagram showing Azure Network Watcher's capabilities.":::


> [!NOTE]
> When you create or update a virtual network in your subscription, Network Watcher is automatically enabled in your virtual network's region. There's no impact on your resources or associated charge for automatically enabling Network Watcher. You must manually enable Network Watcher if you previously chose to opt out of Network Watcher automatic enablement.

## Monitoring

Network Watcher offers two monitoring tools that help you view and monitor resources:

 -  Topology
 -  Connection monitor

### Topology

Topology provides a visualization of the entire network for understanding network configuration. It provides an interactive interface to view resources and their relationships in Azure spanning across multiple subscriptions, resource groups, and locations.

### Connection monitor

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

### IP flow verify

IP flow verify allows you to detect traffic filtering issues at a virtual machine level. It checks if a packet is allowed or denied to or from an IP address (IPv4 or IPv6 address). It also tells you which security rule allowed or denied the traffic. For more information, see [IP flow verify overview](/azure/network-watcher/ip-flow-verify-overview).

### NSG diagnostics

NSG diagnostics allows you to detect traffic filtering issues at a virtual machine, virtual machine scale set, or application gateway level. It checks if a packet is allowed or denied to or from an IP address, IP prefix, or a service tag. It tells you which security rule allowed or denied the traffic. It also allows you to add a new security rule with a higher priority to allow or deny the traffic. 

### Next hop

Next hop allows you to detect routing issues. It checks if traffic is routed correctly to the intended destination. It provides you with information about the Next hop type, IP address, and Route table ID for a specific destination IP address. For more information, see [Next hop overview](/azure/network-watcher/network-watcher-next-hop-overview).

### Effective security rules

Effective security rules allows you to view the effective security rules applied to a network interface. It shows you all security rules applied to the network interface, the subnet the network interface is in, and the aggregate of both. For more information, see [Effective security rules overview](/azure/network-watcher/effective-security-rules-overview).

### Connection troubleshoot

Connection troubleshoot enables you to test a connection between a virtual machine, a virtual machine scale set, an application gateway, or a Bastion host and a virtual machine, an FQDN, a URI, or an IPv4 address. The test returns similar information returned when using the [connection monitor](/azure/network-watcher/network-watcher-overview#connection-monitor) capability, but tests the connection at a point in time instead of monitoring it over time, as connection monitor does. For more information, see [Connection troubleshoot overview](/azure/network-watcher/connection-troubleshoot-overview).

### Packet capture

Packet capture allows you to remotely create packet capture sessions to track traffic to and from a virtual machine (VM) or a virtual machine scale set. For more information, see [packet capture](/azure/network-watcher/packet-capture-overview).

### VPN troubleshoot

VPN troubleshoot enables you to troubleshoot virtual network gateways and their connections. For more information, see [VPN troubleshoot overview](/azure/network-watcher/vpn-troubleshoot-overview).

## Traffic

Network Watcher offers two traffic tools that help you log and visualize network traffic:

 -  Flow logs
 -  Traffic analytics

### Flow logs

Flow logs allows you to log information about your Azure IP traffic and stores the data in Azure storage. You can log IP traffic flowing through a network security group or Azure virtual network. For more information, see:

 -  [Network security group flow logs](/azure/network-watcher/nsg-flow-logs-overview) and [Manage network security group flow logs](/azure/network-watcher/nsg-flow-logs-portal).
 -  [Virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) and [Manage virtual network flow logs](/azure/network-watcher/vnet-flow-logs-portal).

### Traffic analytics

Traffic analytics provides rich visualizations of flow logs data. For more information about traffic analytics, see [traffic analytics](/azure/network-watcher/traffic-analytics) and [Manage traffic analytics using Azure Policy](/azure/network-watcher/traffic-analytics-policy-portal).

:::image type="content" source="../media/traffic-analytics-global-f866e9a5.png" alt-text="Screenshot showing Traffic analytics feature of Network Watcher.":::
