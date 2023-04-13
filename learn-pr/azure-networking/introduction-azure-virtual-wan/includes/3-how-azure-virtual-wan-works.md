In order to evaluate whether Contoso should migrate to Azure Virtual WAN, you need to understand how Azure Virtual WAN works.

In this unit, you’ll learn how remote offices use Virtual WAN to connect to Azure. You’ll explore connectivity options and hub types.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWEhw0]

## Service components of Azure Virtual WAN

The following services and components of Azure Virtual WAN provide multiple connectivity options into Azure and permit customers to use the Azure high-speed connected backbone.

- **The virtual hub**: All traffic flows through these fully meshed hubs. An address space and routing tables are provided at creation.
- **Hub-to-Hub connections**: Enable cross-region connectivity between all on-premises and Azure network endpoints.
- **Virtual hub router**: Supports custom route tables for virtual networks. Acts as default route table for branches (P2S, S2S, ER). Associates connections to route tables and propagates routes from connections to route tables.
- **Connection between sites**: Supports:
  - Any-to-any branch to Azure
  - Branch to branch
  - Users to branch
  - Virtual network to virtual network transit
  - VPN to ExpressRoute transit connectivity.
- **Secure virtual hub**: Added security with the integration of Azure Firewall Manager to:
  - Create policy and apply across multiple firewalls
  - Work across regions/subscription/deployments
  - Secure internet traffic (virtual network to internet and branch to internet)
  - Secure private traffic (virtual network to and from a branch)
- **Secure with Security-as-a-Service (SECaaS) partners**: Supported partners that currently have integration into Azure Firewall Manager's API to set up security policies are:
  - zScaler
  - iBoss
  - Check Point  

## Virtual WAN options

Azure Virtual WAN supports two WAN types, Basic and Standard. A Basic WAN creates only Basic hubs, and a Standard WAN creates only Standard hubs. The available configurations for each WAN type are included in the following table.

| **Virtual WAN type** | **Hub type** | **Available configurations**                                 |
| :------------------- | :----------- | :----------------------------------------------------------- |
| Basic                | Basic        | Site-to-site VPN only                                        |
| Standard             | Standard     | Full-mesh connectivity, ExpressRoute, User VPN (P2S), VPN (site-to-site), Inter-hub, Virtual Network-to-Virtual Network transiting through the virtual hub |

>[!NOTE]
> You can upgrade a  Basic Virtual WAN to a Standard Virtual WAN. You can't downgrade a Standard Virtual WAN to a Basic Virtual WAN.

Azure Virtual WAN is integrated into Azure Monitor Insights, which provides a display of health and metrics for all deployed network resources.
