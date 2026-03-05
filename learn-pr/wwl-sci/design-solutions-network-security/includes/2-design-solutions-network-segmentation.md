Network segmentation divides your network into smaller, isolated segments so you can control traffic flow, limit blast radius, and prevent unauthorized lateral movement. As a security architect, you design segmentation strategies that align with your organization's risk profile, compliance requirements, and the Zero Trust principle of assume breach. This unit builds on the evaluation criteria from MCSB v2 control NS-1 (Establish network segmentation boundaries) and focuses on how to design effective segmentation using Azure services.

## Design an enterprise segmentation strategy

Before selecting Azure services, define your segmentation strategy around business context. The Azure Well-Architected Framework describes a segment as a logical section of your solution that you secure as one unit. Your strategy should answer three questions:

- **What trust boundaries exist?** Identify where workloads with different risk levels, compliance requirements, or organizational ownership need isolation from each other.
- **How do you contain a breach?** Design segments so that if an attacker compromises one area, they can't move laterally to other areas. Containment limits the blast radius.
- **Where do you enforce traffic controls?** Define perimeter points where you inspect and filter traffic entering or leaving each segment.

Common segmentation boundaries include separating production from nonproduction environments, isolating internet-facing workloads from internal systems, and separating workloads that process regulated data (such as payment card or health data) from general workloads.

## Design segmentation layers in Azure

Azure provides multiple constructs that create layers of isolation. Design your segmentation by combining these layers based on the level of separation each workload requires.

### Subscriptions and management groups

Subscriptions provide the broadest isolation boundary. Resources in different subscriptions have no default connectivity and require explicit configuration to communicate. Use subscriptions to separate major organizational units, environments (production, development, testing), or regulatory boundaries. Management groups allow you to apply Azure Policy and role-based access control (RBAC) consistently across multiple subscriptions.

### Virtual networks and subnets

[Azure Virtual Networks](/azure/virtual-network/virtual-networks-overview) provide network-level containment within a subscription. No traffic flows between virtual networks by default—you must explicitly enable communication through peering, VPN, or routing. This default isolation is a security advantage.

Within each virtual network, subnets create internal boundaries. Use [network security groups (NSGs)](/azure/virtual-network/network-security-groups-overview) on subnets to filter traffic by port, protocol, and source or destination IP address. Design NSG rules following deny-by-default principles—allow only the traffic each workload requires and deny everything else.

[Application security groups (ASGs)](/azure/virtual-network/application-security-groups) simplify NSG rules by grouping virtual machines by application role. Instead of managing rules based on individual IP addresses, you reference ASGs in your NSG rules. This approach reduces rule complexity and the risk of misconfiguration as your environment scales.

### Azure Network Security Perimeter for PaaS isolation

For PaaS services, [Azure Network Security Perimeter](/azure/private-link/network-security-perimeter-concepts) creates a logical boundary around multiple PaaS resources. Resources within the perimeter communicate freely with each other, while traffic from outside the perimeter is denied by default. This approach complements private endpoints by adding perimeter-level data exfiltration controls without requiring individual access rules for each service. Supported services include Azure Storage, Azure SQL Database, Azure Key Vault, Azure Event Hubs, and Azure Cosmos DB.

## Design network topology patterns

Your topology determines how segments connect and how traffic flows between them. Choose a pattern based on the number of workloads, regions, and the level of centralized control you need.

### Single virtual network with subnet segmentation

All workload components reside in one virtual network, with subnets defining segment boundaries. NSGs and ASGs control traffic between subnets. This pattern suits single-region deployments with a small number of workloads.

![Diagram showing a segmentation pattern with a single virtual network.](../media/single-azure-region.png)

This design is straightforward but provides limited centralized control. If an NSG rule is misconfigured, a public endpoint could be accidentally exposed.

### Multiple virtual networks with peering

Workloads are deployed across separate virtual networks that connect through [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Because peering isn't transitive, each virtual network pair requires explicit configuration. This pattern provides stronger isolation between workloads and supports multiregion deployments.

![Diagram showing a segmentation pattern with multiple virtual networks.](../media/multiple-virtual-networks.png)

Use this pattern when workloads have different owners or compliance requirements that warrant virtual network-level separation. You can still apply NSGs within each virtual network for granular subnet-level filtering.

### Hub-and-spoke topology

A central hub virtual network hosts shared security services, and spoke virtual networks contain workloads. Spokes connect to the hub through peering, and all inter-spoke and internet-bound traffic routes through the hub. This pattern provides the strongest centralized control and scales well as you add workloads.

![Diagram showing a segmentation pattern with a hub and spoke topology.](../media/hub-and-spoke.png)

Deploy [Azure Firewall](/azure/firewall/overview) in the hub to enforce centralized network and application rules across all spokes. Define [user-defined routes (UDRs)](/azure/virtual-network/virtual-networks-udr-overview) on spoke subnets to direct traffic through the firewall. Key design benefits include:

- **Deny by default between spokes.** Inter-spoke traffic is blocked unless explicitly allowed through firewall rules.
- **Centralized logging.** Azure Firewall logs all accepted and denied traffic to Azure Monitor, providing a single view of traffic across the network.
- **Asymmetric routing protection.** Even if someone accidentally creates a public endpoint in a spoke, the return packet is dropped by the stateful firewall, preventing unintended access.

For organizations that need global transit connectivity and integrated security across multiple regions, [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) provides a managed hub-and-spoke architecture with built-in routing, VPN, ExpressRoute, and Azure Firewall integration.

## Enforce segmentation at scale with Azure Virtual Network Manager

As your network grows, manually managing NSG rules and peering across dozens of virtual networks becomes error-prone. [Azure Virtual Network Manager](/azure/virtual-network-manager/overview) centralizes network management and enables you to enforce segmentation policies at scale.

### Security Admin Rules

Security Admin Rules are a key capability of Azure Virtual Network Manager for segmentation design. These rules are evaluated **before** NSG rules, so they act as organizational guardrails that individual teams can't override. Design your Security Admin Rules to:

- **Block high-risk ports globally.** Deny inbound traffic on ports like RDP (3389), SSH (22), and SMB (445) from the internet across all managed virtual networks. Teams that need exceptions can use Azure Bastion or just-in-time VM access.
- **Enforce network segmentation.** Block traffic between virtual networks or subnets that shouldn't communicate, regardless of individual NSG configurations.
- **Allow platform services.** Use *Always Allow* rules to ensure traffic from hub infrastructure services (such as Azure Firewall or Azure Bastion) can always reach spoke virtual networks, preventing NSG misconfigurations from breaking critical services.

Security Admin Rules support three actions: *Allow* (evaluated first, then NSG rules apply), *Deny* (traffic is dropped, NSG rules don't apply), and *Always Allow* (traffic is permitted, NSG rules are bypassed). This hierarchy lets your central security team set guardrails while application teams manage workload-specific NSG rules within those boundaries.

### Network groups and connectivity configurations

Group virtual networks into [network groups](/azure/virtual-network-manager/concept-network-groups) based on environment, region, or workload type. Use dynamic membership with Azure Policy to automatically add new virtual networks to the appropriate group. Then apply connectivity configurations to define whether virtual networks in a group use mesh or hub-and-spoke connectivity, and deploy security admin configurations to enforce segmentation rules across the group.

## Control east-west traffic with Azure Firewall

Segmentation boundaries are only effective when you inspect and filter the traffic crossing them. Deploy Azure Firewall as the central east-west and north-south inspection point in your hub virtual network. Design your firewall rules using the principle of least privilege:

- **Network rules** filter by IP address, port, and protocol for layer 3 and layer 4 traffic between segments.
- **Application rules** filter by fully qualified domain name (FQDN) for HTTP/HTTPS and Azure SQL traffic, controlling which external destinations workloads can reach.
- **Threat intelligence** blocks traffic to and from known malicious IP addresses and domains.

Use [Azure Firewall Manager](/azure/firewall-manager/overview) to manage policies across multiple firewalls and regions through a parent-child policy hierarchy—a base policy sets organization-wide rules, and child policies add environment-specific overrides.

## Design microsegmentation within workloads

Beyond virtual network and subnet boundaries, design microsegmentation within individual workloads to limit lateral movement even inside a segment. Key approaches include:

- **NSG rules between application tiers.** For a three-tier application, allow only the web tier to communicate with the application tier, and only the application tier to communicate with the database tier. Deny all other inter-tier traffic.
- **Private endpoints.** Use [Azure Private Link](/azure/private-link/private-link-overview) to access PaaS services through private endpoints within the virtual network, eliminating public internet exposure and mapping each endpoint to a specific resource instance to prevent data exfiltration to other accounts.
- **Azure Bastion.** Replace direct RDP/SSH access with [Azure Bastion](/azure/bastion/bastion-overview), which provides secure remote access over TLS through the Azure portal without exposing management ports.
- **Virtual network encryption.** Enable [virtual network encryption](/azure/virtual-network/virtual-network-encryption-overview) to encrypt traffic between virtual machines and virtual machine scale sets within the same virtual network and across peered virtual networks. This protects data in transit at the network layer, even from users with access to the underlying infrastructure. Virtual network encryption requires the Accelerated Networking capability on supported VM SKUs.
