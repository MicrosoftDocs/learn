You're confident that the software defined networking (SDN) distributed firewall capabilities of Azure Stack HCI can help improve the security of your network infrastructure. In this unit, you evaluate the functionality and usefulness of Datacenter Firewall in Azure Stack HCI by implementing it in your proof-of-concept environment.

## Implement Datacenter Firewall

The basic procedure for implementing a Datacenter Firewall policy consists of the following steps. You can do these steps by using PowerShell, Windows Admin Center, or Microsoft System Center Virtual Machine Manager (VMM).

1. Create an Access Control List (ACL) object.
1. Within the ACL, define one or more inbound and outbound rules that allow or deny East-West and North-South network traffic based on any of the following criteria for the traffic the rule applies to.

   - **Protocol** representing the layer 4 protocol and set to **TCP**, **UDP**, or **ALL**. **ALL** includes  Internet Control Message Protocol (ICMP) in addition to TCP and UDP.
   - **Source Address Prefix** representing the IP address prefix of the origin of an incoming or outgoing network packet. An asterisk `*` is a wild card denoting all IP addresses.
   - **Source Port Range** representing one or more port numbers from which an incoming or outgoing network packet originates. An asterisk `*` is a wild card denoting all port numbers.
   - **Destination Address Prefix** representing the IP address prefix of the destination of an incoming or outgoing network packet. An asterisk `*` is a wild card denoting all IP addresses.
   - **Destination Port Range** representing one or more port numbers that an incoming or outgoing network packet targets. An asterisk `*` is a wild card denoting all port numbers.

1. For each rule, also specify the following settings:

   - **Action** representing the outcome or the rule in case a match is found and set to either **Allow** or **Deny**.
   - **Priority** representing the precedence of the rule in relation to other rules within the same ACL. Each rule within the same ACL must have a unique priority that can be set to any value between 100 and 65000. A lower numerical value designates a higher priority.

1. Optionally, enable logging for individual firewall rules.

1. Apply the rules defined in the ACL object to a target scope, which can be any of the following objects:

   - A virtual network subnet.
   - A logical network subnet.
   - A network interface of a virtual machine (VM) connected to a virtual or logical network subnet.

> [!NOTE]
> Applying ACLs to virtual or logical network subnets simplifies administration, but sometimes you might want to make the constraints more granular. If so, you can assign an ACL to an individual VM network interface. In case of multiple ACLs between the source and destination, the resulting constraints depend on the network traffic direction. For inbound traffic, the subnet ACL applies before the one assigned to the network interface ACL. For outbound traffic, that sequence is reversed.

## Evaluate Datacenter Firewall functionality

Without any custom ACL rules applied, the default behavior of a network interface is to allow all outbound traffic but block all inbound traffic. To evaluate Datacenter Firewall functionality, create an ACL containing a rule that allows all inbound network traffic.

- **AllowAllInbound**. Allows all ingress traffic that targets the scope the ACL applies to.

1. Apply the following settings to create the rule:

   |Source address prefix|Destination address prefix|Protocol|Source port|Destination port|Type|Action|Priority|
   |--|--|--|--|--|--|--|--|
   |\*|\*|ALL|\*|\*|Inbound|Allow|1000|

   The following screenshot shows the Windows Admin Center access control list entry pane with the **allow-all** rule being created.

   :::image type="content" source="../media/3-azure-stack-hci-windows-admin-center-new-acl-rule-allow-all.png" alt-text="Screenshot of the Windows Admin Center ACL entry pane with an allow-all rule being created." lightbox="../media/3-azure-stack-hci-windows-admin-center-new-acl-rule-allow-all.png":::

1. After you allow all inbound traffic, identify the types of traffic you want to block.

   For example, you might want to restrict connectivity via Windows Remote Management (WinRM) across subnets. This type of restriction limits the impact of an exploit that moves laterally after a compromise of a single VM. You still permit WinRM connectivity within the same subnet.

   Apply the following settings to create the new rule, based on the assumption that the originating subnet has the IP address range **192.168.0.0/24**.

   |Source address prefix|Destination address prefix|Protocol|Source port|Destination port|Type|Action|Priority|
   |--|--|--|--|--|--|--|--|
   |192.168.0.0/24|\*|TCP|\*|5985,5986|Inbound|Block|500|
   |\*|\*|ALL|\*|\*|Inbound|Allow|1000|

   The following screenshot shows the Windows Admin Center access control list entry pane with the **deny-winrm** rule being created.

   :::image type="content" source="../media/3-azure-stack-hci-windows-admin-center-new-acl-rule-deny-winrm.png" alt-text="Screenshot of the Windows Admin Center ACL entry pane with a deny-winrm rule being created." lightbox="../media/3-azure-stack-hci-windows-admin-center-new-acl-rule-deny-winrm.png:::

1. Now assign the ACL to the example target virtual network subnet, which has the IP address prefix of **192.168.100.0/24**.

   :::image type="content" source="../media/3-azure-stack-hci-windows-admin-center-assign-acl-subnet.png" alt-text="Screenshot of the Windows Admin Center virtual networks pane with the virtual subnet ACL assignment being created." lightbox="../media/3-azure-stack-hci-windows-admin-center-assign-acl-subnet.png":::

1. After you complete your evaluation, remove the ACL assignments from the target scope to revert to the default filtering behavior.
