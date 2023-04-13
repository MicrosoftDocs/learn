Azure Network Watcher is designed to monitor and diagnose network health issues related to Azure Virtual Networks. Network Watcher provides tools that you can use to monitor, diagnose, and measure resources in your Azure virtual network. You can use tools included with Network Watcher to monitor virtual machines, virtual networks, application gateways, and load balancers. Network Watcher primarily supports IaaS resources, with limited support for platform as a service monitoring.

Network Watcher tools are separated into four broad categories:

- Out-of-box monitoring tools
- Tools for performing diagnostic checks
- Tools for performing monitoring tasks
- Tools for measuring connectivity and latency

## Network Watcher monitoring tools

Network Watchers provides four types of monitoring tools:

- Out-of-box monitoring
  - Network insights
  - Topology
- Diagnostic tools
  - IP flow verify
  - Next hop
  - Packet capture
  - VPN troubleshoot
  - Effective security rules
- Connectivity monitoring
  - Connection Monitor
  - Network Performance Monitor
- Traffic monitoring
  - NSG flow logs
  - Traffic analytics

### Network Watcher Topology tool

The Topology tool generates graphical displays of your Azure virtual network, its resources, its interconnections, and their relationships with each other. This tool can help you at the beginning of the troubleshooting process by allowing you to visualize all elements involved in the problem that you're troubleshooting, something that might not be apparent by looking at the contents of resource groups in the Azure portal.

:::image type="content" source="../images/network-watcher-topology.png" alt-text="Diagram that depicts the Network Watcher topology." border="false":::

### Connection Monitor tool

The Connection Monitor tool provides allows you to verify that connections work between Azure resources. For example, you could use connection monitor to verify that two IaaS VMs that host the components of a multi-tier application can communicate with each other. You can also use it to verify connectivity in hybrid scenarios.

:::image type="content" source="../images/connection-monitor-portal.png" alt-text="Screenshot that shows an example of connection monitors in the Azure portal." lightbox="../images/connection-monitor-portal.png":::

### Network Performance Monitor tool

The Network Performance Monitor tool allows you to track latency and packet loss. You can configure alerts to trigger when latency and packet loss exceed particular thresholds.

## Network Watcher diagnostic tools

Network Watcher provides six tools that you can use to diagnose why problems have occurred on Azure and hybrid networks. These tools are as follows:

- **IP flow verify**: You can use this tool to determine whether packets are allowed or denied to a specific IaaS virtual machine. This tool will provide information about which network security group (NSG) is causing the packet to be dropped.
- **Next hop**: You can use this tool to determine the route a packet takes from a source IP address to a destination IP address. Next hop is useful in determining if routing tables for Azure virtual networks are incorrectly configured.
- **Effective security rules**: You can use Effective security rules to determine which specific rule in a set of NSG rules applied in multiple locations is blocking or allowing specific network traffic.
- **Packet capture**: You can use Packet capture to record all network traffic sent to and from an IaaS VM.
- **Connection troubleshoot**: You can use Connection troubleshoot to check TCP connectivity between a source and destination VM.
- **VPN troubleshoot**. You can use this tool to troubleshoot problems with virtual network gateway connections.

## Network Watcher metrics

Azure limits the number of network resources that you can create within a subscription and region. If you reach this limit, you'll be unable to create more resources. For example, if you have 20 static public IP addresses in a region and you try to configure a twenty-first public IP address, you'll be blocked from doing so. You can use the Metrics section of Network Watcher to view what the current limits set on your region and subscription and your current utilization.

:::image type="content" source="../images/metrics-portal.png" alt-text="Screenshot that shows an example of connection limits and usage in the Metrics tool.":::

## Traffic monitoring

Network Watcher includes two logs you can use to troubleshoot Azure networking issues:

- **NSG flow logs**: You can use NSG flow logs to log the source and destination IP address, port, and protocol, and whether traffic was allowed or denied by an NSG.
- **Traffic analysis**: You can use Traffic analysis to monitor your cloud environment and get visibility into user and application networking activity across Azure.  
