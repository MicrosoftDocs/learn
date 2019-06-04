2. **Troubleshoot networking using Network Watcher monitoring and diagnostic tools**

In this module, you will look at Azure Network Watcher monitoring and diagnostic tools. It is important to note that Network Watcher is a regional service. Network Watcher is an Azure service that brings together a combo of tools in a central place to diagnose the health of and monitor Azure networking. In your Azure environments, it can also help analyse usage and act as a central logging control for Azure network resources. Network diagnostic and visualization tools available with Network Watcher help you understand, diagnose, and gain insights into your network in Azure. The primary focus for this module will be on monitoring and diagnostic tools such as connection monitor, IP flow verify, next hop, packet capture, connection troubleshoot and effective security rules. We will also look at some use case scenarios for the tools towards the end of the module. 


1. Monitoring tools- Azure Network Watcher gives you a centralised hub for identifying network glitches, CPU spikes, connectivity problems, memory leaks and other issues before they impact your business. There are different tools available to use and each tool has a unique purpose...

   - Topology - This displays your virtual network (VNet), its resources, interconnections and their relationships with each other. This is great as it helps to visualize your infrastructure which can massively aid in troubleshooting connectivity and performance issues. To view topology in your Azure network
     1. Navigate to All Services > Networking > Network Watcher, select it.
     1. Select Topology. Generating a topology requires a network watcher in the same region that the virtual network that you want to generate the topology for exists in. 
     1. Select a subscription, the resource group of a virtual network you want to view the topology for, and then select the virtual network. 
     
     In the following picture, a topology is shown for a virtual network named *MyVNet*.
     ![In the following picture, a topology is shown for a virtual network named *MyVNet*, in the resource group named *MyResourceGroup*](../media/network-watcher-topology.png)

    - Connection Monitor - This tool provides a way to track connection reachability between Azure resources. This tool helps to identify latency between resources and catch changes that will impact connectivity, such as changes to the network configuration or network security group (NSG) rule changes. It can probe the device on regular intervals looking for failures or changes. If there is an issue, it tells you why it occurred and how to fix it. Connection monitor often serves to monitor network communication between two infrastructure-as-a-service (IaaS) virtual machines (VMs), but it can also monitor an IP address or fully qualified domain name (FQDN).
    - Network Performance Monitor - This tool gives you the ability to track and alert on latency/packet drops over time. It enables you to have a centralized view of your network monitoring requirements. To monitor your hybrid connections using the Network Performance Monitor (NPM), ensure that the workspace associated with NPM is in a supported region. NPM can monitor connectivity between networks and applications in any part of the world, from a workspace that is hosted in one of the following regions:
       - West Europe
       - West Central US
       - East US
       - East Japan
       - South East Asia
       - South East Australia
       - South UK
       - US Government Virginia

      NPM allows you to  monitor endpoint to endpoint connectivity
        - Between branches and data centre
        - Between VNets
        - For your on-premises and cloud
        - For express route  circuits

  2. Diagnostic tools - There are multiple elements to Azure diagnostics, including diagnostic logs and diagnostic tools. Below are some of the tools used to diagnose connectivity and performance issues.
     - IP flow verifies - This tool uses 5-Tuple packet parameter-based verification mechanism to detect whether packets inbound or outbound are allowed or denied from a VM. Within the tool, you specify a local and remote port, TCP/UDP, the local IP and remote IP, as well as the VM and the VM's NIC. IP flow verify will also tell you if an NSG rule is denying traffic.
     - Next hop – This tool determines the next hop for packets routed in the Azure network topology. Next hop can help identify routing problems. When you run the tool, it returns the next hop in the route. With this tool, you specify a VM to run it from and a destination IP. It will specify the next hop type, such as the internet, VNet, VNet peering, or Microsoft Edge. This helps discover traffic that is not routing to the correct place.
     - Effective security rules – This tool enables you to view network security groups associated with the chosen interface. You can view inbound and outbound rules. This tool comes in very handy as your infrastructure grows and you have to view more than one rule or route.
     - Effective route - The effective routes for each network interface attached to a virtual machine are a combination of route tables that have manually created, Azure's default routes and any routes propagated from on-premises networks via BGP. Understanding the effective routes for a network interface is helpful when troubleshooting routing problems. You can view the effective routes for any network interface that is attached to a running virtual machine. When outbound traffic is sent from a subnet, Azure selects a route based on the destination IP address. It uses the longest prefix match algorithm. For example, a route table has two routes: 
     
        -	One route specifies the 10.0.0.0/24 address prefix
       -	The other route specifies the 10.0.0.0/16 address prefix.
   
       Azure routes traffic destined for 10.0.0.5, to the next hop type specified in the route with the 10.0.0.0/24 address prefix, because 10.0.0.0/24 is a longer prefix than 10.0.0.0/16, even though 10.0.0.5 is within both address prefixes.  Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table. You can override some of Azure's system routes with custom routes. 
         -	System routes - Azure automatically creates system routes and assigns the routes to each subnet in a virtual network. You can't create system routes nor can you remove system routes. But you can override some system routes with custom routes.
        - Custom routes - You create custom routes by exchanging border gateway protocol (BGP) routes between your on-premises network gateway and an Azure network. You can also create custom routes by creating user-defined routes.
           - User-defined - You can create user-defined routes in Azure to override Azure's default system routes, or to add additional routes to a subnet's route table. In Azure, you create a route table, then associate the route table virtual network subnets.

     - Packet capture – This tool allows you to capture incoming and outgoing network traffic packets of a virtual machine. You can also automate remote packet capture with triggers to pro-actively capture traffic.  The default limit is 100 Packet capture sessions per region and the maximum limit is 10,000. These limits are for the number of sessions only, not saved captures. You can save packets captured in Azure storage or locally on your pc.
     - Connection troubleshoot – This tool provides the capability to detect connectivity issues on a TCP or ICMP connection from a VM to a VM, URI, FQDN, or IP address. This tool helps identify if connectivity issues are a platform or a user configuration issue. It gives insight into the fault type, such as a guest firewall on a VM, NSG rule, DNS, or a user-defined route (UDR).
     - VPN troubleshoot – This tool provides the ability to troubleshoot the virtual network gateway connections. This tool will run diagnostics on a VNet gateway connection and return health diagnosis. The capability can be called through the portal, PowerShell, Azure CLI, or REST API. When called, Network Watcher diagnoses the health of the gateway, or connection, and returns the appropriate results. The request is a long-running transaction. The results are returned once the diagnosis is completed. The following table below shows a few examples of different fault types that are available.

       | Fault Type | Reason | log|
       | ------- | ------------------------------------------------------------ | -------------------------------------------------------- |
       | NoFault | When no error is detected  | Yes
       | GatewayNotFound | Cannot find gateway or gateway is not provisioned | No
       | PlannedMaintenance | Gateway instance is under maintenance  | No
       | UserDrivenUpdate | This fault occurs when a user update is in progress. The update could be a resize operation.| No
       | VipUnResponsive | This fault occurs when the primary instance of the gateway can't be reached due to a health probe failure.| No
       | PlatformInActive | There is an issue with the platform.| No

3. Now you are going to look at some use case scenarios for troubleshooting using Azure Network Watcher monitoring and diagnostics. The scenarios will be in the format below.
      - A. What the problem is (Title)
      - B. How to troubleshoot that issue using Network Watcher tools  (Paragraph)
      - C. An example solution (Paragraph)

- **One of your colleagues has deployed a virtual machine in Azure and is having network connectivity issues**
   - To troubleshoot this, we will use the tool IP Flow verify.  IP flow verify will let you specify a local and remote port, protocol (TCP/UDP), the local IP and remote IP and check the connection status. It also lets you specify the direction of the connection (inbound/outbound). This tool runs a logical test on the rules in place on your network. Your colleagues are trying to RDP onto one of the virtual machines in Azure. But he is unable to connect. We will use IP flow verify to specify our VMs (local IP *x.x.x.x" and port for RDP protocol *3389*) and then we specify the remote VM (IP address and Port *3389*). Specify the protocol in use *TCP* and then hit **Check**. The result shows that access denied due to NSG rule **DefaultInboundDenyAll**. 
  - Now we know that access denied due to NSG rule **DefaultInboundDenyAll**.  The solution will be to change the NSG rule to resolve the issue.

- **VPN connection not working**
  - To troubleshoot a VPN connection, you will need to use Azure VPN troubleshoot. This tool will run diagnostics on a VNet gateway connection and return health diagnosis.  You can run this tool from Azure portal, PowerShell & Azure CLI. This tool will check the health of the gateway and gateway connection itself. When you run the VPN troubleshoot, it checks the gateway for common issues and returns the health diagnosis. You can also view the log file available to get more information on the health diagnosis. The diagnostics will show is the VPN connection working or not. If the VPN connection is not working. VPN troubleshoot will suggest how to resolve the issue. Our VPN connection may not be working due to **Key mismatch between the gateway** or due to the **remote gateway being improperly configured**.
  - The diagnostics will show you the reason why VPN connection not working. To resolve the problem, it could we reconfigure the remote gateway or make sure the keys match on both ends. Pre-shared keys are case sensitive and it's easy to make a mistake. This is one of the common issues.

- **No servers listening on designated destination ports**
   - To troubleshoot this issue, we will use connection troubleshoot. This tool will let you specify the local and the remote VM. Furthermore, in the probe setting, you can choose a specific port. So, this is an ideal tool for this issue. We will specify the server destination port in the settings that is not listening then hit check.
   - The results show that the remote server is **Unreachable** as **Traffic blocked due to virtual machine firewall configuration**. On the remote server (destination VM) disable the firewall and then test the connection again. It turns out the server is reachable. The resolve the issue we will need to tweak the firewall settings.

- **Diagnose network routing problems from a VM**
  - Azure automatically creates routes to default destinations. You may create custom routes that override the default routes. Sometimes, custom routes can cause communication to fail. To troubleshoot this issue, you will use the next hop capability of Network Watcher to determine which route Azure is using to route traffic. In the Azure portal, select Next hop, under Network Watcher. Select your subscription, enter the following values
     -  Resource group
     - Virtual machine
     - Network interface
     - Source IP address
     - Destination IP address

    For the destination IP, test outbound communication from the VM to one of the IP addresses for *www.microsoft.com* (131.107.0.89). After a few seconds, the result informs you that the next hop type is the Internet and that the Route table ID is System Route. This result lets you know that there is a valid system route to the destination. Now change the Destination IP address to VMs IP that you are having the connectivity issue with and select Next hop again. The result returned informs you that None is the Next hop type and that the Route table ID is also System Route. This result lets you know that, while there is a valid system route to the destination, there is no next hop to route the traffic to the destination. We need to view the details of the route. To analyze routing further, review the effective routes for the network interface. 
       - In the search box at the top of the portal, enter the name of a virtual machine you want to view effective routes for.
       - Select **Networking** under SETTINGS.
       - Select the name of a network interface.
       - Select Effective routes under **SUPPORT + TROUBLESHOOTING**.
       - Review the list of effective routes to determine if the correct route exists for VMs IP that you are having the connectivity issue with. 
 
      When you ran the next hop test using *www.microsoft.com* (131.107.0.89), the route with the address prefix 0.0.0.0/0 was used to route traffic to the address since no other route includes the address. By default, all addresses not specified within the address prefix of another route are routed to the internet. When you ran the test using VMs IP (192.168.10.100) however, the result informed you that there was no next hop type. There is a default route to the 192.168.0.0/12 prefix, which includes the 192.168.0.100 address, the NEXT HOP TYPE is None. Azure creates a default route to 192.168.0.0/12 but doesn't specify a next hop type until there is a reason to. If, for example, you added the 192.168.0.0/12 address range to the address space of the virtual network.  Azure changes the NEXT HOP TYPE to Virtual network for the route. A check would then show Virtual network as the NEXT HOP TYPE.

 **Knowledge check**

A. To capture traffic on VM, Azure Network Watcher requires the ...
    
   -  Network watcher Agent VM Extension
     - Azure Traffic Manager
     - Azure Load Balance
     - Azure Storage Account  

B. To resolve latency issues on the network, which Azure Network Watcher features can you use?

   - IP flow verify
   - Next hop
   - VPN Gateway Troubleshooting
   - Connection troubleshoot

