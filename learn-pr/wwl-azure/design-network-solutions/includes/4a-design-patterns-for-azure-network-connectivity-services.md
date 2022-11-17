Now we'll examine three common networking patterns for organizing workloads in Azure:

- Single virtual network
- Multiple virtual networks with peering
- Multiple virtual networks in a hub-spoke topology

Each pattern provides a different type of isolation and connectivity. 

### Segmentation and Azure Firewall

For all patterns, the recommended Azure cloud native segmentation control is Azure Firewall. Azure Firewall works across both Azure Virtual Network and subscriptions to govern traffic flows by using layer 3 to layer 7 controls. You can define your communication rules and apply them consistently, such as network X can't talk with network Y and network Z can't access the internet. With Azure Firewall Manager, you can centrally manage policies across multiple Azure firewalls and enable DevOps teams to further customize local policies.

As you review these options, consider which pattern can meet the needs of the Tailwind Traders organization. 

## Pattern 1: Single virtual network

In the first pattern, all components of your workload (or in some cases your entire IT footprint) are placed in a single virtual network. This option is possible if you're operating solely in a single region because a virtual network can't span multiple regions.

The entities you would most likely use to create segments in the virtual network are network security groups (NSGs). You could also use application security groups (ASGs) to simplify administration.

Here's how you might implement a single virtual network pattern:

- One subnet (`Subnet 1`) can contain your database workloads.
- Another subnet (`Subnet 2`) can contain your web workloads.
- To govern subnet traffic, you can implement NSGs to specify that `Subnet 1` can talk only with `Subnet 2`, and `Subnet 2` can talk to the internet.
- You can enforce segmentation by using an NVA from Azure Marketplace or Azure Firewall.
- You can modify the pattern to support many workloads. You might carve out subnets that won't allow one workload to communicate to the backend of another workload.

## Pattern 2: Multiple virtual networks with peering

The second pattern extends the single virtual network pattern to support multiple virtual networks with potential peering connections. This option lets you group applications into separate virtual networks, or implement a presence in multiple Azure regions.

This pattern provides built-in segmentation through virtual networks because you must explicitly peer one virtual network to another for them to communicate. (Keep in mind that [Azure Virtual Network peering](/azure/virtual-network/virtual-network-peering-overview) connectivity isn't transitive.) You can add more segmentation within a virtual network in a manner similar to pattern 1 by using NSGs in the virtual networks.

## Pattern 3: Multiple virtual networks in hub-spoke topology

The third pattern is a more advanced virtual network organization, where you choose a virtual network in a given region as the hub for all the other virtual networks in that region.

The connectivity between the hub virtual network and its spoke virtual networks is achieved by using Virtual Network peering. All traffic passes through the hub virtual network, and it can act as a gateway to other hubs in different regions. You set up your security posture at the hubs, so they get to segment and govern the traffic between the virtual networks in a scalable way.

One benefit of this pattern is that as your network topology grows, the security posture overhead doesn't grow (except when you expand to new regions).

## Compare patterns

The following table compares capabilities of the three networking patterns. Review the details, and think about which patterns are applicable to the network topology for Tailwind Traders.

| Compare | Single virtual network | Multiple networks with peering | Multiple networks in hub-spoke topology |
| --- | --- | --- | --- |
| **Connectivity/Routing** (how segments communicate) | System routing provides default connectivity to any workload in any subnet. | System routing provides default connectivity to any workload in any subnet. | No default connectivity between spoke virtual networks. A layer 3 router (such as Azure Firewall) in the hub virtual network is required to enable connectivity. |
| **Network-level traffic filtering** | Traffic is allowed by default. NSG can be used for filtering. | Traffic is allowed by default. NSG can be used for filtering. | Traffic between spoke virtual networks is denied by default. Azure Firewall configuration can enable selected traffic, such as `windowsupdate.com`. |
| **Centralized logging** | NSG logs for the virtual network. | Aggregate NSG logs across all virtual networks. | Azure Firewall logs to Azure Monitor all accepted/denied traffic sent via a hub. |
| **Unintended open public endpoints** | DevOps can accidentally open a public endpoint via incorrect NSG rules. | DevOps can accidentally open a public endpoint via incorrect NSG rules. | An accidentally opened public endpoint in a spoke virtual network won't enable access. The return packet is dropped via stateful firewall (asymmetric routing). |
| **Application level protection** | NSG provides network layer support only. | NSG provides network layer support only. | Azure Firewall supports FQDN filtering for HTTP/S and MSSQL for outbound traffic and across virtual networks. |