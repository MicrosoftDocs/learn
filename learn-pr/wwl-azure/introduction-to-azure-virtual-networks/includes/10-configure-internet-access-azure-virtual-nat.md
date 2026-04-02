
Globally, IPv4 address ranges are in short supply, and can be an expensive way to grant access to Internet resources. [Azure Network Address Translation (NAT)](/azure/nat-gateway/nat-overview) lets internal resources on a private network to share routable IPv4 addresses. Rather than purchasing an IPv4 address for each resource that requires internet access, you can use a NAT service to map outgoing requests from internal resources to an external IP address.

### NAT gateway SKUs

Azure NAT gateway is available in two SKUs.

| Feature	 |Standard	 |StandardV2 |
| --- | --- | --- |
| Availability zone	 | Zonal (single zone) |	Zone-redundant (all zones) |
| IPv6 support |	No |	Yes |
| Maximum throughput |	50 Gbps |	100 Gbps |
| Flow logs	 | No |	Yes |

### NAT gateway usage scenario

The following diagram shows outbound traffic flow from Subnet 1 through the NAT gateway to be mapped to a Public IP address or a Public IP prefix.

:::image type="content" source="../media/nat-flow-map-e4870a4e.png" alt-text="Diagram with NAT service providing internet connectivity for internal resources.":::

After NAT is configured, all UDP and TCP outbound flows from any virtual machine instance will use NAT for internet connectivity. No further configuration is necessary, and you don’t need to create any user-defined routes. NAT takes precedence over other outbound scenarios and replaces the default Internet destination of a subnet.

NAT scales automatically to support dynamic workloads. NAT can support up to 16 public IP addresses. By using port network address translation (PNAT or PAT), NAT provides up to 64,000 concurrent flows for UDP and TCP. 

### Considerations for NAT gateway

- Standard NAT gateway supports IPv4 only.
- StandardV2 NAT gateway supports both IPv4 and IPv6 public IP addresses and prefixes.
- NAT can't span multiple virtual networks.
