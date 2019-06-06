Network Watcher includes several tools that you can use to monitor your virtual networks and VMs.

In your engineering company, you want to enable your staff to choose the right Network Watcher tool for each troubleshooting task. To complete this task, they need to understand the all the options available and the kinds of problems each tool can solve.

In this module, you will look at Azure Network Watcher monitoring and diagnostic tools such as connection monitor, IP flow verify, next hop, packet capture, connection troubleshoot and effective security rules. We will also look at some use case scenarios for the tools towards the end of the module. 

## Networking Watcher monitoring tools

Network Watcher is an Azure service that brings together a combination of tools in a central place to diagnose the health of Azure networking. In your Azure environments, it can also help analyze usage and act as a central logging center for Azure network resources. Network diagnostic and visualization tools available with Network Watcher help you understand, diagnose, and gain insights into your network in Azure.

Azure Network Watcher gives you a centralized hub for identifying network glitches, CPU spikes, connectivity problems, memory leaks, and other issues before they impact your business. There are different tools available to use and each tool has a unique purpose:

### Topology

The topology tool displays your virtual network (VNet), its resources, its interconnections, and their relationships with each other. You can use the tool to visualize your infrastructure. A good understanding of this infrastructure is the first step in any troubleshooting task.

To view the topology in your Azure network:

1. In the Azure portal, navigate to **All Services > Networking > Network Watcher**.
1. Select **Topology**. To generate the topology, requires a Network Watcher in the same region as the virtual network.
1. Select a subscription, the resource group of a virtual network, and then select the virtual network itself. In the following screenshot, a topology is shown for a virtual network named *MyVNet*:

    ![Virtual network topology as shown in Network Watcher](../media/network-watcher-topology.png)

### Connection Monitor

The connection monitor tool provides a way to check that connections work between Azure resources. This tool helps to identify latency between resources and catch changes that will impact connectivity, such as changes to the network configuration or Network Security Group (NSG) rule changes. It can probe VMs at regular intervals to look for failures or changes. If there is an issue, it tells you why it occurred and how to fix it. Connection monitor often serves to monitor network communication between two infrastructure-as-a-service (IaaS) VMs, but it can also monitor an IP address or fully qualified domain name (FQDN).

### Network Performance Monitor

The Network Performance Monitor (NPM) tool gives you the ability to track and alert on latency and packet drops over time. It enables you to have a centralized view of your network. 

To monitor your hybrid connections using NPM, ensure that the associated workspace is in a supported region. NPM can monitor connectivity between networks and applications in any part of the world, from a workspace that is hosted in one of the following regions:

- West Europe
- West Central US
- East US
- East Japan
- South East Asia
- South East Australia
- South UK
- US Government Virginia

NPM allows you to  monitor endpoint to endpoint connectivity:

- Between branches and data centers.
- Between VNets.
- For your on-premises and cloud connections.
- For express route circuits.

## Network Watcher diagnostic tools

The Network Monitor tools that you can use to diagnose connectivity and performance issues include:

### IP flow verify

This tool uses a 5-tuple packet parameter-based verification mechanism to detect whether packets inbound or outbound are allowed or denied from a VM. Within the tool, you specify a local and remote port, TCP/UDP, the local IP, the remote IP, the VM, and the VM's network card. IP flow verify will also tell you if an NSG rule is denying traffic.

### Next hop

This tool determines the next hop for packets routed in the Azure network topology. Next hop can help identify routing problems. When you run the tool, it returns the next hop in the route. With this tool, you specify a VM to run it from and a destination IP address. The tool specifies the next hop type, such as the internet, VNet, VNet peering, or Microsoft Edge. This information helps discover traffic that is not routing to the correct place.

### Effective security rules

This tool enables you to view the network security groups that are associated with the chosen interface. You can view inbound and outbound rules. This tool comes in handy as your infrastructure grows and you have to view more than one rule or route.

### Effective route

The effective routes for each network interface attached to a VM are a combination of route tables that have been manually created, Azure's default routes, and any routes propagated from on-premises networks through Border Gateway Protocol (BGP). Understanding the effective routes for a network interface is helpful when troubleshooting routing problems. You can view the effective routes for any network interface that is attached to a running VM. When outbound traffic is sent from a subnet, Azure selects a route based on the destination IP address. It uses the longest prefix match algorithm. For example, suppose a route table has two routes: 
     
- One route specifies the 10.0.0.0/24 address prefix
- The other route specifies the 10.0.0.0/16 address prefix.
   
Azure routes traffic destined for 10.0.0.5, to the next hop type specified in the route with the 10.0.0.0/24 address prefix, because 10.0.0.0/24 is a longer prefix than 10.0.0.0/16. Azure picks this route even though 10.0.0.5 is within both address prefixes. 

The route table consists of: 

-	**System routes**. Azure automatically creates system routes and assigns the routes to each subnet in a virtual network. You can't create or remove system routes but you can override some system routes with custom routes.
- **Custom routes**. You create custom routes by exchanging border gateway protocol (BGP) routes between your on-premises network gateway and an Azure network.
- **User-defined routes**. You can create user-defined routes in Azure to override Azure's default system routes, or to add additional routes to a subnet's route table. In Azure, you create a route table, then associate the route table virtual network subnets.

### Packet capture

This tool allows you to capture incoming and outgoing network traffic packets for a VM. You can also automate remote packet capture with triggers to actively capture traffic. 

The packet capture tool requires the Network Watcher Agent VM Extension to be present on the monitored VM. This extension is automatically installed when you start a packet capture session in the Azure portal.

The default usage limit for packet capture is 100 packet capture sessions per region and the maximum limit is 10,000. These limits are for the number of sessions only, not saved captures. You can save packets captured in Azure storage or locally on your PC.

### Connection troubleshoot

This tool provides the capability to detect connectivity issues on a TCP or ICMP connection from a VM to a VM, URI, FQDN, or IP address. This tool helps identify if connectivity issues are a platform or a user configuration issue. It gives insight into the fault type, such as a guest firewall on a VM, NSG rule, DNS, or a user-defined route (UDR). Connection troubleshoot also displays the latency associated with each hop in a route.

### VPN troubleshoot

This tool provides the ability to troubleshoot the virtual network gateway connections. This tool will run diagnostics on a VNet gateway connection and return a health diagnosis. The capability can be called through the portal, PowerShell, Azure CLI, or REST API. When called, Network Watcher diagnoses the health of the gateway or connection, and returns the appropriate results. The request is a long-running transaction. The results are returned once the diagnosis is completed. The table below shows a few examples of different fault types that are available.

| Fault Type | Reason | Log |
| --- | --- | --- |
| NoFault | When no error is detected  | Yes |
| GatewayNotFound | Cannot find gateway or gateway is not provisioned | No |
| PlannedMaintenance | Gateway instance is under maintenance  | No |
| UserDrivenUpdate | This fault occurs when a user update is in progress. The update could be a resize operation.| No |
| VipUnResponsive | This fault occurs when the primary instance of the gateway can't be reached due to a health probe failure.| No |
| PlatformInActive | There is an issue with the platform.| No |
| | |

## Azure Network Watcher use case scenarios

Let's examine some scenarios that you can investigate and troubleshoot by using Azure Network Watcher monitoring and diagnostics. 

### Single VM network connectivity issues

Your colleagues have deployed a VM in Azure and are having network connectivity issues. Your colleagues are trying to use Remote Desktop Protocol (RDP) to connect to the virtual machines but they are unable to connect.

To troubleshoot this issue, use the tool **IP Flow Verify**. This tool lets you specify a local and remote port, protocol (TCP/UDP), the local IP, and remote IP to check the connection status. It also lets you specify the direction of the connection (inbound or outbound). IP Flow Verify runs a logical test on the rules in place on your network.  

In this case, use IP Flow Verify to specify the VMs IP address and the RDP port 3389. Then specify the remote VMs IP address and port. Choose the protocol *TCP* and then click **Check**. 

Suppose that the result shows that access denied due to NSG rule **DefaultInboundDenyAll**. The solution is to change the NSG rule.

### VPN connection not working

Your colleagues have deployed VMs in two VNets and cannot connect between them.

To troubleshoot a VPN connection, use Azure VPN troubleshoot. This tool will run diagnostics on a VNet gateway connection and return a health diagnosis. You can run this tool from the Azure portal, PowerShell, or the Azure CLI. 

When you run the tool, it checks the gateway for common issues and returns the health diagnosis. You can also view the log file available to get more information. The diagnosis will show whether the VPN connection is working or not working. If the VPN connection is not working, VPN troubleshoot will suggest ways to resolve the issue. 

Suppose that the diagnosis shows a key mismatch. To resolve the problem, reconfigure the remote gateway to make sure the keys match on both ends. Pre-shared keys are case-sensitive and it's easy to make a mistake.

###  No servers are listening on designated destination ports

Your colleagues have deployed VMs in a single VNets and cannot connect between them.

To troubleshoot this issue, use connection troubleshoot. In this tool, you specify the local and the remote VM. Furthermore, in the probe setting, you can choose a specific port. 

Suppose the results show that the remote server is **Unreachable** and the message: **Traffic blocked due to virtual machine firewall configuration**. On the remote server, disable the firewall and then test the connection again. Suppose the server is now reachable. This result indicates that firewall rules on the remote server are the problem and must be corrected to permit the connection.