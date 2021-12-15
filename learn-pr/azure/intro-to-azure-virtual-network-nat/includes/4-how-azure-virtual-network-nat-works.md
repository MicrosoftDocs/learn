Before you can use Azure Virtual Network NAT to start resolving the port exhaustion issues at your company, you need to understand how it works. This understanding will give you a better idea about the steps you need to take to properly deploy, configure, and use this service to resolve connectivity problems.

When you create an Azure Virtual Network NAT gateway service, you need to assign it a public IP address or public IP address prefix. The Azure Virtual Network NAT gateway resource can use a maximum of 16 public IP addresses. The Virtual Network NAT can use any combination of public IP addresses and public IP address prefixes, totaling to 16 addresses.

The Virtual Network NAT maximum prefix size is /28 (16 addresses). When you associate a Public IP Prefix to an Azure Virtual Network NAT service, it’ll automatically scale to the number of outbound IP addresses needed. Azure Virtual Network NAT supports TCP and UDP protocols only, and you can’t associate it with an IPv6 public IP address or IPv6 public IP prefix.

When you connect an Azure Virtual Network NAT service to a subnet or subnets in your virtual network, it automatically overrides how your traffic is routed to the internet. Even if you had Azure VMs with public IP addresses in that subnet, these addresses will no longer be used for outbound connectivity.

The following diagram is a scenario of a virtual network with two subnets. Azure VMs and other services in these subnets don’t have public IP addresses assigned. All outgoing and incoming traffic is routed through the Azure Virtual Network NAT service, which uses either a public IP or a public IP prefix for outbound connections.

:::image type="content" source="../media/4-virtual-network-scenario.svg" alt-text=" A virtual network with two subnets that has all traffic routed through Azure Virtual Network NAT, which uses either a public IP or public IP prefix for outbound connections." border="false":::

In the following diagram, an Azure VM in Subnet A has an instance-level public IP assigned, whereas VMs in Subnet B don’t have public IP addresses. When you deploy Azure Virtual Network NAT in this scenario, inbound traffic directed to VMs in Subnet A will still be directed to an instance-level IP, but all outbound traffic from both Subnet A and Subnet B will be routed through Azure Virtual Network NAT.

:::image type="content" source="../media/4-inbound-outbound.svg" alt-text="Diagram depicting inbound and outbound traffic flow for two subnets." border="false":::

The following screenshot has an Azure VM that uses 20.107.71.22 as its public IP address that it uses to make inbound RDP connection to the VM. However, its IP address for outbound connections has a different address of 40.68.136.21. This is the public IP address used by the Azure Virtual Network NAT service.

:::image type="content" source="../media/4-ip-address.png" alt-text="Screenshot that depicts the difference in an Azure VM's public IP address and its IP address for outbound connections.":::

You can use the Azure Virtual Network NAT service in scenarios where you have a network load balancer deployed for a virtual network. It’s important to understand that all outbound configuration from a load-balancing rule or outbound rules is superseded by a NAT gateway. Inbound-originated traffic isn't affected by Azure Virtual Network NAT.

If you’re using Azure availability zones, be aware that a virtual network can span more than one availability zone and the subnets in that network. Azure Virtual Network NAT service is currently a zonal service, which means that it can only be designated to single zones. However, it can still be used to work with resources outside of its zone.
