You can limit network traffic to resources in a virtual network using a network security group (NSG). A network security group contains a list of security rules that allow or deny inbound or outbound network traffic. An NSG can be associated to a subnet or a network interface. A network security group can be associated multiple times.

## Subnets

You can assign NSGs to subnets and create protected screened subnets (also called a DMZ). These NSGs can restrict traffic flow to all the machines that reside within that subnet. Each subnet can have zero, or one, associated network security groups.

## Network interfaces

You can assign NSGs to a NIC so that all the traffic that flows through that NIC is controlled by NSG rules. Each network interface that exists in a subnet can have zero, or one, associated network security groups.

## Associations

When you create an NSG the Overview blade provides information about the NSG such as, associated subnets, associated network interfaces, and security rules.

:::image type="content" source="../media/network-security-groups-1ebf7bed.png" alt-text="Screen shot of the virtual machine Overview blade in the Azure portal. The Security rules and Associated with information is highlighted.":::
