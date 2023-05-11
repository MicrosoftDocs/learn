

Although you still can perform typical end-user configuration in Control Panel through Windows Defender Firewall, you can perform advanced configuration in the Windows Defender Firewall with the Advanced Security snap-in. You can access this snap-in through Control Panel from the Windows Defender Firewall page by selecting **Advanced settings** in the navigation pane. The snap-in provides an interface for configuring Windows Defender Firewall locally, on remote computers, and by using Group Policy.

Windows Defender Firewall with Advanced Security is an example of a network-aware app. You can create a profile for each network location type, and each profile can contain different firewall policies. For example, you can allow incoming traffic for a specific desktop management tool when a computer is on a domain network, but block traffic when the computer connects to public or private networks.

Network awareness enables you to provide flexibility on an internal network without sacrificing security when users travel. A public network profile must have stricter firewall policies to protect against unauthorized access. A private network profile might have less restrictive firewall policies to allow file and print sharing or peer-to-peer discovery.

### Windows Defender Firewall with Advanced Security properties

You can configure basic firewall properties for domain, private, and public network profiles by using the Windows Defender Firewall with Advanced Security Properties dialog box. A firewall profile is a way of grouping settings, including firewall rules and connection security rules. Use the IPsec Settings tab on the Windows Defender Firewall with Advanced Security Properties dialog box to configure the default values for IPsec configuration options.

To access the global profile settings in Windows Defender Firewall with Advanced Security Properties, perform one of the following procedures:

 -  In the navigation pane, right-click **Windows Defender Firewall with Advanced Security**, and then select **Properties**.
 -  In the navigation pane, select **Windows Defender Firewall with Advanced Security**, and then in the Overview section, select **Windows Defender Firewall Properties**.
 -  In the navigation pane, select **Windows Defender Firewall with Advanced Security**, and then in the Actions pane, select **Properties**.

The options that you can configure for each of the three network profiles are:

 -  **Firewall state**. Turn on or off for each profile.
 -  **Inbound connections**. Configure to block connections that do not match any active firewall rules, block all connections regardless of inbound rule specifications, or allow inbound connections that do not match an active firewall rule.
 -  **Outbound connections**. Configure to allow connections that do not match any active firewall rules or block outbound connections that do not match an active firewall rule.
 -  **Protected network connections**. Configure which network adapters Windows Defender Firewall will protect.
 -  **Settings**. Configure display notifications, unicast responses, local firewall rules, and local connection security rules.
 -  **Logging**. Configure the following logging options:
    
     -  **Name**. Use a different name for each network profile’s log file.
     -  **Size limit (KB)**. The default size is 4,096. Adjust this if necessary when troubleshooting.
     -  **No logging occurs until you set one or both of following two options to Yes**:
        
         -  Log dropped packets
         -  Log successful connections

### Windows Defender Firewall with Advanced Security rules

Rules are a collection of criteria that define what traffic you will allow, block, or secure with a firewall. You can configure the following types of rules:

 -  Inbound
 -  Outbound
 -  Connection security rules :::image type="content" source="../media/windows-defender-advanced-firewall-console-53912b2b.png" alt-text="Screenshot of the Windows Defender Firewall with Advanced Security screen":::
    

#### Inbound rules

Inbound rules explicitly allow or block traffic that matches the rule’s criteria. For example, you can configure a rule to allow traffic for Remote Desktop from the local network segment through the firewall, but block traffic if the source is a different network segment.

When you first install the Windows operating system, Windows Defender Firewall blocks all unsolicited inbound traffic. To allow a certain type of unsolicited inbound traffic, you must create an inbound rule that describes that traffic. For example, if you want to run a web server, you must create a rule that allows unsolicited inbound network traffic on TCP port 80 for HTTP traffic and TCP port 443 for HTTPS traffic. You can configure the default action that Windows Defender Firewall with Advanced Security takes, which is whether to allow or block connections when an inbound rule does not apply.

#### Outbound rules

Windows Defender Firewall allows all outbound traffic unless a rule blocks it. Outbound rules explicitly allow or deny traffic originating from a computer that matches a rule’s criteria. For example, you can configure a rule to explicitly block outbound traffic to a computer by IP address through the firewall, but allow the same traffic for other computers.

#### Inbound and outbound rule types

There are four different types of inbound and outbound rules:

 -  **Program rules**. These control connections for a program. Use this type of firewall rule to allow a connection based on the program that is trying to connect. These rules are useful when you are not sure of the port or other required settings, because you only specify the path to the program’s executable (.exe) file.
 -  **Port rules**. These control connections for a TCP or UDP port. Use this type of firewall rule to allow a connection based on the TCP or UDP port number over which the computer is trying to connect. You specify the protocol and the individual or multiple local ports to which the rule applies.
 -  **Predefined rules**. These control connections for a Windows-based experience. Use this type of firewall rule to allow a connection by selecting one of the programs or experiences from the list. Network-aware programs that you install typically add their own entries to this list, so that you can enable and disable them as a group.
 -  **Custom rules**. Configure these as necessary. Use this type of firewall rule to allow a connection based on criteria that other types of firewall rules do not cover.

Consider the scenario in which you want to create and manage tasks on a remote computer by using the Task Scheduler user interface. Before connecting to the remote computer, you must enable the Remote Scheduled Tasks Management firewall exception on the remote computer. You can do this by using the predefined rule type on an inbound rule.

Alternatively, you might want to block all web traffic on the default TCP web server port 80. In this scenario, you create an outbound port rule that blocks the specified port.

#### Connection security rules

Firewall rules and connection security rules are complementary, and both contribute to a defense-in-depth strategy to protect a computer. Connection security rules secure traffic as it crosses a network by using IPsec. Use connection security rules to require authentication or encryption of connections between two computers. Connection security rules specify how and when authentication occurs, but they do not allow connections. To allow a connection, create an inbound or outbound rule. After a connection security rule is in place, you can specify that inbound and outbound rules apply only to specific users or computers.

You can create the following connection security rule types:

 -  **Isolation rules**. These isolate computers by restricting connections based on authentication criteria, such as domain membership or health status. Isolation rules allow you to implement a server or domain isolation strategy.
 -  **Authentication exemption rules**. These designate connections that don’t require authentication. You can designate computers by specific IP address, an IP address range, a subnet, or a predefined group, such as a gateway. You typically use this type of rule to grant access to infrastructure computers, such as Active Directory domain controllers, certification authorities (CAs), or Dynamic Host Configuration Protocol (DHCP) servers.
 -  **Server-to-server rules**. These protect connections between specific computers. When you create this type of rule, you must specify the network endpoints between which you want to protect communications. You then designate requirements and the type of authentication that you want to use, such as the Kerberos version 5 protocol. A scenario in which you might use this rule is if you want to authenticate traffic between a database server and a business-layer computer.
 -  **Tunnel rules**. These secure communications that travel between two computers by using tunnel mode in IPsec instead of transport mode. Tunnel mode embeds the entire network packet into one that you route between two defined endpoints. For each endpoint, specify a single computer that receives and consumes the sent network traffic, or specify a gateway computer that connects to a private network onto which the received traffic is routed after extracting it from the tunnel.
 -  **Custom rules**. Configure these as necessary. Custom rules authenticate connections between two endpoints when you cannot set up authentication rules by using the other rule types.

### Monitoring

Windows Defender Firewall uses the monitoring interface to display information about current firewall rules, connection security rules, and security associations (SAs). The Monitoring page displays which profiles are active (domain, private, or public), and the settings for the active profiles.

The Windows Defender Firewall with Advanced Security events also is available in Event Viewer. For example, the ConnectionSecurity operational event log is a resource that you can use to view IPsec-related events. The operational log is always on, and it contains events for connection security rules.
