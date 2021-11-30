Understanding IP network communication is critical to ensuring that you can implement, troubleshoot, and maintain IP networks. Most computers in an on-premises environment lease a configuration from a DHCP Server. This means that common IP configuration problems, such as duplicate IP addresses, are eliminated. Having said that, when initially configuring your IP infrastructure, problems are more common.

## What are the stages of an IP troubleshooting methodology?

The first step in troubleshooting a network-related problem is identifying the scope of the problem. The causes of a problem that affects a single user most often differs from a problem that affects all users. Consider the following:

- If a problem affects only a single user, then the problem is likely related to the configuration of that one computer.

- If a problem affects all users, then the problem is likely either a server configuration issue or a network configuration issue.

- If a problem affects only a group of users, then you must determine the common denominator among that group of users' devices.

To troubleshoot network communication problems, you must understand the overall communication process. This requires that you understand the routing and firewall configuration on your network. There are many approaches to troubleshooting IP issues. One quite useful methodology is to take a logical approach, starting with common questions, such as:

- Can you duplicate the issue? This helps you determine if there really is an issue or if a simple mistake had been made.

- What is working? This helps you to determine the nature of the issue. For example, the server might be able to reach resources on the local network but not on a remote network.

- What does not work? This question helps further expand the answer to the previous question. For example, a server might not be able to connect to a remote resource but it might be able to resolve the address of the remote resources.

- How are the things that work and that do not work related? For example:

  - Being able to connect to local resources shows that IP is working.

  - Being able to resolve remote addresses shows that DNS is working.

  - If the DNS server is on a different network, it also tells you the default gateway is working.

- Does it work for other systems on the network? This helps you determine where the issue lies. For example, if a different server can't access the same remote resource, it's an indication that the issue lies with:

  - The infrastructure

  - The remote resource

- Has it worked in the past? This helps determine what should be examined. For example, if it is a remote resource that has never been accessed before, the issue could be as simple as the new resource not yet being ready.

- What has changed since it last worked? For example, with the unreachable remote resource, questions you might ask, include:

  - Were new networking components installed?

  - Did the IP address schema change?

Answering these questions can help you to determine which tools you will need to use to resolve the issue in a timely fashion. You can then go on to use tools to investigate more closely.

## What are the tools and techniques for troubleshooting IP configuration?

When you begin investigating IP configuration problems, you can use the following tools to help:

- Resource Monitor. Resource Monitor is a graphical tool that enables you to monitor system resource utilization. You can use Resource Monitor to view TCP and UDP ports that are in use. You also can verify which programs are using specific ports and the amount of data that they are transferring on those ports.

- Network Diagnostics. Windows Network Diagnostics can help you to diagnose and correct networking problems. In the event of a Windows Server networking problem, the Diagnose Connection Problems option helps you diagnose and repair the problem. Windows Network Diagnostics returns a possible description of the problem and a potential remedy. However, the solution might require manual intervention from the user.

- Event Viewer. Event logs are files that record significant events on a computer, such as when a process encounters an error. When these events occur, the Windows Server operating system records the event in an appropriate event log. You can use Event Viewer to read the event log. IP conflicts, which might prevent services from starting, are listed in the System event log.

 In addition to the preceding tools, you can also use the command-line tools described in the following table to troubleshoot IP connectivity and configuration issues.

| Tool| Description|
| :--- | :--- |
| IPConfig| IPConfig displays the current TCP/IP network configuration. Additionally, you can use IPConfig to refresh DHCP and DNS settings, as discussed earlier.|
| Ping| Ping helps verifies IP level connectivity to another TCP/IP computer. It sends Internet Control Message Protocol (ICMP) echo request messages and displays the receipt of corresponding echo reply messages. Ping is the primary TCP/IP command that you use to troubleshoot connectivity, but firewalls might block the ICMP messages.|
| Tracert| Identifies the path taken to a destination computer by sending a series of ICMP echo requests. Tracert then displays a list of router interfaces between a source and a destination. This tool also determines which router has failed and what the latency, or speed, is. These results might not be accurate if the router is busy because the ICMP packets are assigned a low priority by the router.|
| Pathping| Traces a route through the network in a manner similar to Tracert. However, Pathping provides more detailed statistics on the individual steps, or hops, through the network. Pathping can provide greater detail because it sends 100 packets for each router, which enables it to establish trends.|
| Route| Enables you to view and modify the local routing table. You can use this to verify the default gateway, which is listed as the route 0.0.0.0. In Windows Server, you can also use Windows PowerShell cmdlets to view and modify the routing table. The cmdlets for viewing and modifying the local routing table include `Get-NetRoute`, `New-NetRoute`, and `Remove-NetRoute`.|
| Telnet| You can use the Telnet Client feature to verify whether a server port is listening. For example, the command `telnet 10.10.0.10 25` attempts to open a connection with the destination server, 10.10.0.10, on port 25, Simple Mail Transfer Protocol (SMTP). If the port is active and listening, it returns a message to the Telnet client.|
| Netstat| Enables you to view network connections and statistics. For example, the `netstat –ab` command returns all listening ports and the executable that is listening.|

There is also an extensive list of useful Windows PowerShell cmdlets that you can use to help troubleshoot network connectivity and configuration issues. Some of the more common are described in the following list:

- `Get-NetIPv4Protocol`. Gets information about the IPv4 protocol configuration. Note that the Get-NetIPv6Protocol cmdlet retrieves information about the IPv6 protocol configuration.

- `Get-NetIPAddress`. Obtains a list of IP addresses that are configured for interfaces.

- `Get-NetRoute`. Obtains the list of routes in the local routing table.

- `Get-NetConnectionProfile`. Obtains the type of network (public, private, domain) to which a network adapter is connected.

- `Test-Connection`. Runs connectivity tests that are similar to those used by ping.

- `Test-NetConnection`. Displays the following:

  - Results of a DNS lookup

  - Listing of IP interfaces

  - Option to test a TCP connection

  - Internet Protocol security (IPsec) rules

  - Confirmation of connection establishment

The following screenshot displays the output from the `Test-NetConnection www.microsoft.com` command.

![This screenshot displays a command window and the output from the `Test-NetConnection www.microsoft.com` command.](../media/test-netconnection.png)

