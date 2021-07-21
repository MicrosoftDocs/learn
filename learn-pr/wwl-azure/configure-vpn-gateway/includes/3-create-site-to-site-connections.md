Here are the high-level steps to create a VNet-to-VNet connection. The on-premises part is only needed when you are configuring Site-to-Site. We will review in detail each step.

:::image type="content" source="../media/gateway-steps-aebd935e.png" alt-text="Flowchart with seven steps.":::


**Create VNets and subnets**. By now you should be familiar with creating virtual networks and subnets. Remember for this VNet to connect to an on-premises location. Contact your on-premises network administrator to reserve an IP address range for this virtual network.

**Specify the DNS server (optional)**. DNS is not required to create a Site-to-Site connection. However, if you need name resolution for resources that are deployed to your virtual network, you should specify a DNS server in the virtual network configuration.

> [!NOTE]
> Take time to carefully plan your network configuration. If a duplicate IP address range exists on both sides of the VPN connection, traffic will not route the way you may expect it to.
