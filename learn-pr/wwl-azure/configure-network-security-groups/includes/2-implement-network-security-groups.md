You can limit network traffic to resources in your virtual network by using a [network security group](/azure/virtual-network/network-security-groups-overview). You can assign a network security group to a subnet or a network interface, and define security rules in the group to control network traffic.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=82ae3221-5622-47d5-b21d-4110c546d85d]

### Things to know about network security groups

Let's look at the characteristics of network security groups.

- A network security group contains a list of security rules that allow or deny inbound or outbound network traffic.

- A network security group can be associated to a subnet or a network interface.

- A network security group can be associated multiple times.

- You create a network security group and define security rules in the Azure portal. 

- The Overview page for a virtual machine provides information about the associated network security groups. You can see details such as the assigned subnets, assigned network interfaces, and the defined security rules.

:::image type="content" source="../media/network-security-groups-1ebf7bed.png" alt-text="Screenshot of the network security group overview page." border="false":::

#### Network security groups and subnets

You can assign network security groups to a subnet and create a protected screened subnet (also referred to as a demilitarized zone or _DMZ_). A DMZ acts as a buffer between resources within your virtual network and the internet.

- Use the network security group to restrict traffic flow to all machines that reside within the subnet.

- Each subnet can have a maximum of one associated network security group.

#### Network security groups and network interfaces

You can assign network security groups to a network interface card (NIC).

- Define network security group rules to control all traffic that flows through a network interface.

- Each network interface that exists in a subnet can have zero, or one, associated network security groups.
