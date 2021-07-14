Security rules in network security groups enable you to filter the type of network traffic that can flow in and out of virtual network subnets and network interfaces. Azure creates several default security rules within each network security group.

You can add more rules by specifying:

 -  Name
 -  Priority
 -  Port
 -  Protocol (Any, TCP, UDP)
 -  Source (Any, IP Addresses, Service tag)
 -  Destination (Any, IP Addresses, Virtual Network)
 -  Action (Allow or Deny).

Azure creates the default rules in each network security group that you create. You cannot remove the default rules, but you can override them by creating rules with higher priorities.

## Inbound rules

There are three default inbound security rules. The rules deny all inbound traffic except from the virtual network and Azure load balancers.

:::image type="content" source="../media/AZ104_Default_NSG_Rules1-b0bcf8fe.png" alt-text="Screenshot of the default inbound security rules.":::


## Outbound rules

There are three default outbound security rules. The rules only allow outbound traffic to the Internet and the virtual network.

:::image type="content" source="../media/AZ104_Default_NSG_Rules2-da8208ef.png" alt-text="Screenshot of the default outbound security rules.":::
