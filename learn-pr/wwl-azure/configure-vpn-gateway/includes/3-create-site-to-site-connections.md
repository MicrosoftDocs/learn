Here are the high-level steps to create a site-to-site virtual network connection. The on-premises part is only needed when you're configuring Site-to-Site. We'll review in detail each step.

:::image type="content" source="../media/gateway-steps-aebd935e.png" alt-text="Flowchart with seven steps. Each step is discussed in the content.":::


**Create VNets and subnets**. By now you should be familiar with creating virtual networks and subnets. Contact your on-premises network administrator to reserve an IP address range for this virtual network.

**Specify the DNS server (optional)**. DNS isn't required to create a site-to-site connection. However, if you need name resolution for resources that are deployed to your virtual network, you should specify a DNS server in the virtual network configuration.

> [!NOTE]
> Take time to carefully plan your network configuration. If a duplicate IP address range exists on both sides of the VPN connection, traffic will not route the way you may expect it to.
