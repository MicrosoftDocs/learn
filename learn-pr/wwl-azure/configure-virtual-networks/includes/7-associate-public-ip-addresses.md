A [public IP address](/azure/virtual-network/ip-services/public-ip-addresses) resource can be associated with virtual machine network interfaces, internet-facing load balancers, VPN gateways, and application gateways. You can associate your resource with both dynamic and static public IP addresses.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=8124baac-6dbd-4bc3-97b1-3693b3b465c0]

### Things to consider when associating public IP addresses

The next table summarizes how you can associate public IP addresses for different types of resources.

| Resource | Public IP address association | Dynamic IP address | Static IP address |
| --- | --- | --- | --- |
| Virtual machine | NIC | Yes | Yes |
| Load balancer | Front-end configuration | Yes | Yes |
| VPN gateway | VPN gateway IP configuration | Yes | Yes __\*__ |
| Application gateway | Front-end configuration | Yes | Yes __\*__ |

__\*__ Static IP addresses are available on certain SKUs only.

#### Public IP address SKUs

When you create a public IP address, you select the Basic or Standard SKU. Your SKU choice affects the IP assignment method, security, available resources, and redundancy options.

The next table summarizes the differences between the SKU types for public IP addresses.

| Feature | Basic SKU | Standard SKU |
| --- | --- | --- |
| IP assignment | Static or Dynamic | Static |
| Security | Open by default | Secure by default, closed to inbound traffic |
| Resources | Network interfaces, VPN gateways, Application gateways, and internet-facing load balancers | Network interfaces or public standard load balancers |
| Redundancy | Not zone redundant | Zone redundant by default |

> [!IMPORTANT]
> On September 30, 2025, Basic SKU public IPs will be retired. For more information, see the [official announcement](https://azure.microsoft.com/updates?id=upgrade-to-standard-sku-public-ip-addresses-in-azure-by-30-september-2025-basic-sku-will-be-retired). 

