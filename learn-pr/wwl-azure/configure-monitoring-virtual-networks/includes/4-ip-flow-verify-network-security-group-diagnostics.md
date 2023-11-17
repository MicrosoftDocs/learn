
Both IP flow verify and NSG diagnostics allow you to diagnose how networking configuration might be restricting network traffic.

## IP flow verify

IP flow verify checks if a packet is allowed or denied to or from a virtual machine. The information consists of direction, protocol, local IP, remote IP, local port, and a remote port. If the packet is denied by a security group, the name of the rule that denied the packet is returned. While any source or destination IP can be chosen, IP flow verify helps administrators quickly diagnose connectivity issues from or to the internet and from or to the on-premises environment.

IP flow verify looks at the rules for all Network Security Groups (NSGs) applied to the network interface, such as a subnet or virtual machine NIC. Traffic flow is then verified based on the configured settings to or from that network interface. IP flow verify is useful in confirming if a rule in a Network Security Group is blocking ingress or egress traffic to or from a virtual machine. Now along with the NSG rules evaluation, the Azure Virtual Network Manager rules will also be evaluated.

Azure Virtual Network Manager (AVNM) is a management service that enables users to group, configure, deploy, and manage Virtual Networks globally across subscriptions. AVNM security configuration allows users to define a collection of rules that can be applied to one or more network groups at the global level. These security rules have a higher priority than network security group (NSG) rules. An important difference to note here is that admin rules are a resource delivered by AVNM in a central location controlled by governance and security teams, which bubble down to each VNet. NSGs are a resource controlled by the VNet owners, which apply at each subnet or NIC level.

An instance of Network Watcher needs to be created in all regions where you plan to run IP flow verify. Network Watcher is a regional service and can only be run against resources in the same region. The instance used does not affect the results of IP flow verify, as any route associated with the NIC or subnet is still returned.

## NSG diagnostics

The NSG (Network Security Group) diagnostics is an Azure Network Watcher tool that helps you understand which network traffic is allowed or denied in your Azure virtual network along with detailed information for debugging. NSG diagnostics can help you verify that your network security group rules are set up properly. NSG diagnostics shares some functionality with IP flow verify.

The NSG diagnostics tool can simulate a given flow based on the source and destination you provide. It returns whether the flow is allowed or denied with detailed information about the security rule allowing or denying the flow.

To run diagnostics against an NSG, perform the following steps:

1. In the search box at the top of the portal, search for and select **Network Watcher**.
1. Under **Network diagnostic tools**, select **NSG diagnostics**.
1. On the **NSG diagnostics** page, enter or select the following values:
    - Target resource
        - Target resource type.	Select the resource you are diagnosing the connection to.
        - Virtual machine. Select the VM you want to run the diagnostics from.
    - Traffic details
        - Protocol. Select TCP, UDP and/or ICMP.
        - Direction. Select Inbound or Outbound.
        - Source type.	Select IPv4 address/CIDR or Service Tag.
        - Ipv4 address/CIDR. Acceptable values are: single IP address, multiple IP addresses, single IP prefix, and multiple IP prefixes.
        - Destination IP address. Acceptable values are: single IP address, multiple IP addresses, single IP prefix, multiple IP prefixes.
        - Destination port. Enter * to include all ports.
4. Select **Run NSG diagnostics** to run the test. Once NSG diagnostics completes checking all security rules, it displays the result. This result will indicate which rules an NSG has, and which rule is denying traffic.