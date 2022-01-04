**Why do some cases require forced tunneling?** \- A virtual private network (VPN) consists of remote peers sending private data securely to one another over an unsecured network, such as the Internet. This is called Internet tunneling. **Site-to-site (S2S) VPNs** use tunnels to encapsulate data packets within normal IP packets for forwarding over IP-based networks, using encryption to ensure privacy and authentication to ensure integrity of data.

Forced tunneling lets you redirect, or force, all internet-bound traffic back to your on-premises location via a site-to-site VPN tunnel for inspection and auditing. This is a critical security requirement for most enterprise IT policies. Without forced tunneling, internet-bound traffic from your VMs in Azure always traverses from the Azure network infrastructure directly to the internet—without the option to allow you to inspect or audit the traffic. Unauthorized internet access potentially leads to information disclosure or other types of security breaches.

As stated earlier, Azure currently works with two deployment models: The Resource Manager deployment model and the classic deployment model. The two models aren’t completely compatible with each other. The following exercise goes through configuring tunneling for virtual networks that were created via the Resource Manager deployment model.

The following figure depicts how forced tunneling works.

:::image type="content" source="../media/az500-virtual-private-network-tunnel-3d087ecc.png" alt-text="Network traffic between on-premises and Azure uses forced tunneling.":::


In the preceding figure, the front-end subnet doesn’t use forced tunneling. The workloads in the front-end subnet can continue to accept and respond to customer requests that come directly from the internet. The mid-tier and back-end subnets use forced tunneling. Any outbound connections from these two subnets to the internet are forced back to an on-premises site via one of the S2S VPN tunnels.

This allows you to restrict and inspect internet access from your VMs or cloud services in Azure while continuing to enable your multi-tier service architecture. If no internet-facing workloads exist in your VMs, you can also apply forced tunneling to the entire virtual network.

**You configure forced tunneling in Azure via virtual network User Defined Routes (UDR)**. Redirecting traffic to an on-premises site is expressed as a default route to the Azure VPN gateway. This example uses UDRs to create a routing table to first add a default route and then associate the routing table with your virtual network subnets to enable forced tunneling on those subnets.
