Your initial research of the SDN Distributed Firewall capabilities in Azure Stack HCI raised your level of confidence in being able to use them to help improve the security of your network infrastructure. To validate your findings, you decided to implement it in your proof-of-concept environment.

The basic procedure for implementing a Datacenter Firewall policy consists of the following sequence of steps:

1. Create an Access Control List (ACL) object.
1. Within the ACL, define one or more inbound and outbound rules that allow or deny East/West and North/South network traffic based on any of the following criteria, which describe the properties of the traffic to which the rule should apply:

    - Protocol representing the layer 4 protocol and set to **TCP**, **UDP**, or **ALL**. **ALL** includes  Internet Control Message Protocol (ICMP) in addition to TCP and UDP.
    - Source Address Prefix representing the IP address prefix of the origin of an incoming or outgoing network packet. An asterisk (`*`) is a wild card denoting all IP addresses.
    - Source Port Range representing one or more port numbers from which an incoming or outgoing network packet originates. An asterisk (`*`) is a wild card denoting all port numbers.
    - Destination Address Prefix representing the IP address prefix of the destination of an incoming or outgoing network packet. An asterisk (`*`) is a wild card denoting all IP addresses.
    - Destination Port Range representing one or more port numbers that an incoming or outgoing network packet targets. An asterisk (`*`) is a wild card denoting all port numbers.

1. For each rule, you additionally need to specify the following settings:

    - **Action**, representing the outcome or the rule in case a match is found and set to either **Allow** or **Deny**.
    - **Priority**, representing the precedence of the rule in relation to other rules within the same ACL. Each rule within the same ACL must have a unique priority and can be set to any value between 100 and 65000. A lower numerical value designates a higher precedence.

1. Optionally, enable logging for individual firewall rules.
1. For the rules defined in an ACL object to take effect, you need to apply them to a target scope, which can be any of the following objects:

    - A virtual network subnet
    - A logical network subnet
    - A network interface of a VM connected to a virtual or logical network subnet

> [!NOTE]
> You can perform each of these steps by using PowerShell, Windows Admin Center, or VMM.

> [!NOTE]
> Applying ACLs to virtual or logical network subnets simplifies administration, but sometimes you might want to make the constraints more granular. If so, you have the option to assign an ACL to an individual VM network interface. In case of multiple ACLs between the source and destination of network traffic, the resulting constraints depend on its direction. For inbound traffic, the subnet ACL applies before the one assigned to the network interface ACL, whereas for outbound traffic, that sequence is reversed.

## Evaluate Datacenter Firewall functionality

To evaluate Datacenter Firewall functionality, consider creating an ACL containing a rule that allows all inbound network traffic:

- **AllowAllInbound**. Allows all ingress traffic targeting the scope to which the ACL will be applied.

> [!NOTE]
> Without any custom ACL rules applied, the default behavior of a network interface is to allow all outbound traffic but block all inbound traffic.

The following table illustrates the settings to create the rule that allows all inbound traffic.

   |Source address prefix|Destination address prefix|Protocol|Source port|Destination port|Type|Action|Priority|
   |--|--|--|--|--|--|--|--|
   |\*|\*|ALL|\*|\*|Inbound|Allow|1000|

:::image type="content" source="../media/3-azure-stack-hci-windows-admin-center-new-acl-rule-allow-all.png" alt-text="Windows Admin Center access control list entry pane with an allow-all rule being created.":::

With the custom allow rule in place, you can identify the types of traffic you want to block. For example, you might want to restrict connectivity via Windows Remote Management (WinRM) across subnets. This type of restriction limits the potential impact of an exploit that employs a lateral movement technique following a compromise of a single VM. Let's assume that you intend to permit WinRM connectivity within the same subnet. In the following table, the new rule is based on the assumption that the subnet from which the connections would originate has the IP address range of **192.168.0.0/24**.

   |Source address prefix|Destination address prefix|Protocol|Source port|Destination port|Type|Action|Priority|
   |--|--|--|--|--|--|--|--|
   |192.168.0.0/24|\*|TCP|\*|5985,5986|Inbound|Block|500|
   |\*|\*|ALL|\*|\*|Inbound|Allow|1000|

:::image type="content" source="../media/3-azure-stack-hci-windows-admin-center-new-acl-rule-deny-winrm.png" alt-text="Windows Admin Center access control list entry pane with a deny-winrm rule being created.":::

At this point, you’re ready to assign the ACL to the target virtual network subnet, which, in our example, has the IP address prefix of **192.168.100.0/24**.

:::image type="content" source="../media/3-azure-stack-hci-windows-admin-center-assign-acl-subnet.png" alt-text="Windows Admin Center virtual networks pane with virtual subnet access control list assignment being created.":::

After you complete your evaluation, consider removing the ACL assignments from the target scope. This reverts to the default filtering behavior.
