<!- Estimated unit duration 10 minutes -->

<!--video  short conceptual video of Azure Virtual WAN
Use a video like this one, Azure Virtual WAN, and stop at 4:25 minutes. It’s an overview of the Azure Network and how remote offices could be connected to Azure. It also illustrates how the architecture can become unwieldy as connections grow. Azure Virtual WAN Hubs addresses the issue. -->

The following services and components of Azure Virtual WAN are designed to provide multiple connectivity options into Azure and permit customers to use Azure high-speed connected backbone.

### The service components that encompass the Azure Virtual WAN service follow

- **The Virtual Hub** - All traffic flows through these fully meshed hubs. An address space and routing tables are provided at creation.
- **Hub-to-Hub connections** - Enable cross-region connectivity between all on-premises and Azure network endpoints.
- **Virtual Hub Router** - Support for custom route tables for VNets, default route table for branches (P2S, S2S, ER). They also associate connections to route tables, and propagate routes from connections to route tables.
- **Connection between sites** - Support for any-to-any, branch to Azure, branch to branch, users to branch, VNet to VNet transit, and VPN to Express Route transit connectivity.
- **Secure virtual hub** - Added security with the integration of Azure Firewall Manager to:
  - Create policy and apply across multiple firewalls
  - Works across regions/subscription/deployments
  - Secure Internet traffic (VNet to Internet and Branch to Internet)
  - Secure Private traffic (VNet to and from a Branch)
- **Secure with Security-as-a-Service (SECaaS) partners** - Supported Partners that currently have integration into Azure Firewall Manager's API to setup security policies are:
  - zScaler,
  - iBoss,
  - CheckPoint  

## Virtual WAN options

Azure Virtual WAN supports two WAN types, Basic and Standard. A Basic WAN creates only Basic hubs, and Standard WAN creates only Standard hubs. The difference between Basic and Standard is detailed below.

| **Virtual WAN type** | **Hub type** | **Available configurations**                                 |
| :------------------- | :----------- | :----------------------------------------------------------- |
| Basic                | Basic        | Site-to-site VPN only                                        |
| Standard             | Standard     | Full mesh connectivity, ExpressRoute, User VPN (P2S), VPN (site-to-site), Inter-hub and VNet-to-VNet transiting through the virtual hub |

>[!NOTE]
> An Basic Virtual WAN can be upgraded to a Standard Virtual WAN. A Standard Virtual WAN cannot be downgraded to a Basic Virtual WAN

Comparison of VPN Network Gateways and Virtual WAN Hubs

| Connection model | VPN Gateway | Virtual WAN Hub |
|:------------- |:-------------------- |:-------------------- |
| Site-to-site VPN max connections | 30 | 1,000 |
| Site-to-site VPN connection speed | 10 Gbps| 20 Gbps |
| Point-to-Site VPN max connections | 10,000 | 10,000 |
| Point-to-Site VPN connection speed | 10 Gbps | 20 Gbps |
| Express Route max connections | 0 | 4 |
| Express Route connection speed | N/A | 20 Gbps |


As shown above the Virtual WAN offers significant improvements in connectivity, speed, and configuration over the VPN gateways.

In addition to the above, Azure Virtual WAN is integrated into Azure Monitor Insights which provides a view of health and metrics for all deployed network resources.
