Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It is a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.

:::image type="content" source="../media/firewall-standard.png" alt-text="Diagram of Azure firewall configuration.":::

## Azure Firewall features

Azure Firewall includes the following features:

- **Built-in high availability** \- High availability is built in, so no extra load balancers are required and there's nothing you need to configure.
- **Unrestricted cloud scalability** \- Azure Firewall can scale out as much as you need to accommodate changing network traffic flows, so you do not need to budget for your peak traffic.
- **Application FQDN filtering rules** \- You can limit outbound HTTP/S traffic or Azure SQL traffic to a specified list of fully qualified domain names (FQDN) including wild cards. This feature does not require TLS termination.
- **Network traffic filtering rules** \- You can centrally create allow or deny network filtering rules by source and destination IP address, port, and protocol. Azure Firewall is fully stateful, so it can distinguish legitimate packets for different types of connections. Rules are enforced and logged across multiple subscriptions and virtual networks.
- **FQDN tags** \- These tags make it easy for you to allow well-known Azure service network traffic through your firewall. For example, say you want to allow Windows Update network traffic through your firewall. You create an application rule and include the Windows Update tag. Now network traffic from Windows Update can flow through your firewall.
- **Service tags** \- A service tag represents a group of IP address prefixes to help minimize complexity for security rule creation. You cannot create your own service tag, nor specify which IP addresses are included within a tag. Microsoft manages the address prefixes encompassed by the service tag, and automatically updates the service tag as addresses change.
- **Threat intelligence** - Threat intelligence-based filtering (IDPS) can be enabled for your firewall to alert and deny traffic from/to known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed.
- **TLS inspection** - The firewall can decrypt outbound traffic, processes the data, then encrypt the data and sends it to the destination.
- **Outbound SNAT support** \- All outbound virtual network traffic IP addresses are translated to the Azure Firewall public IP (Source Network Address Translation (SNAT)). You can identify and allow traffic originating from your virtual network to remote Internet destinations.
- **Inbound DNAT support** \- Inbound Internet network traffic to your firewall public IP address is translated (Destination Network Address Translation) and filtered to the private IP addresses on your virtual networks.
- **Multiple public IP addresses** \- You can associate multiple public IP addresses (up to 250) with your firewall, to enable specific DNAT and SNAT scenarios.
- **Azure Monitor logging** \- All events are integrated with Azure Monitor, allowing you to archive logs to a storage account, stream events to your Event Hubs, or send them to Azure Monitor logs.
- **Forced tunneling** \- You can configure Azure Firewall to route all Internet-bound traffic to a designated next hop instead of going directly to the Internet. For example, you may have an on-premises edge firewall or other network virtual appliance (NVA) to process network traffic before it is passed to the Internet.
- **Web categories** \- Web categories let administrators allow or deny user access to web site categories such as gambling websites, social media websites, and others. Web categories are included in Azure Firewall Standard, but it is more fine-tuned in Azure Firewall Premium Preview. As opposed to the Web categories capability in the Standard SKU that matches the category based on an FQDN, the Premium SKU matches the category according to the entire URL for both HTTP and HTTPS traffic.
- **Certifications** \- Azure Firewall is Payment Card Industry (PCI), Service Organization Controls (SOC), International Organization for Standardization (ISO), and ICSA Labs compliant.

## Rule processing in Azure Firewall

In the Azure Firewall, you can configure NAT rules, network rules, and applications rules, and this can be done either by using classic rules or Firewall Policy. An Azure Firewall denies all traffic by default, until rules are manually configured to allow traffic.

### Rule processing with classic rules

With classic rules, rule collections are processed according to the rule type in priority order, lower numbers to higher numbers from 100 to 65,000. A rule collection name can have only letters, numbers, underscores, periods, or hyphens. It must also begin with either a letter or a number, and it must end with a letter, a number, or an underscore. The maximum name length is 80 characters. It is best practice to initially space your rule collection priority numbers in increments of 100 (i.e., 100, 200, 300, and so on) so that you give yourself space to add more rule collections when needed.

### Rule processing with Firewall Policy

With Firewall Policy, rules are organized inside Rule Collections which are contained in Rule Collection Groups. Rule Collections can be of the following types:

 -  DNAT (Destination Network Address Translation)
 -  Network
 -  Application

You can define multiple Rule Collection types within a single Rule Collection Group, and you can define zero or more Rules in a Rule Collection, but the rules within a Rule Collection must be of the same type (i.e., DNAT, Network, or Application).

With Firewall Policy, rules are processed based on Rule Collection Group Priority and Rule Collection priority. Priority is any number between 100 (highest priority) and 65,000 (lowest priority). Highest priority Rule Collection Groups are processed first, and inside a Rule Collection Group, Rule Collections with the highest priority (i.e., the lowest number) are processed first.

In the case of a Firewall Policy being inherited from a parent policy, Rule Collection Groups in the parent policy always takes precedence regardless of the priority of the child policy.

Application rules are always processed after network rules, which are themselves always processed after DNAT rules regardless of Rule Collection Group or Rule Collection priority and policy inheritance.

### Outbound connectivity using network rules and application rules

If you configure both network rules and application rules, then network rules are applied in priority order before application rules. Additionally, all rules are terminating, therefore, if a match is found in a network rule, no other rules are processed thereafter.

If there is no network rule match, and if the protocol is either HTTP, HTTPS, or MSSQL, then the packet is then evaluated by the application rules in priority order. For HTTP, Azure Firewall looks for an application rule match according to the Host Header, whereas for HTTPS, Azure Firewall looks for an application rule match according to Server Name Indication (SNI) only.

### Inbound connectivity using DNAT rules and network rules

Inbound Internet connectivity can be enabled by configuring DNAT. As mentioned previously, DNAT rules are applied in priority before network rules. If a match is found, an implicit corresponding network rule to allow the translated traffic is added. For security reasons, the recommended approach is to add a specific Internet source to allow DNAT access to the network and avoid using wildcards.

Application rules aren't applied for inbound connections. So, if you want to filter inbound HTTP/S traffic, you should use Web Application Firewall (WAF).

For enhanced security, if you modify a rule to deny access to traffic that had previously been allowed, any relevant existing sessions are dropped.

## Deploying and configuring Azure Firewall

Be aware of the following when deploying Azure Firewall:

 -  It can centrally create, enforce, and log application and network connectivity policies across subscriptions and virtual networks.
 -  It uses a static, public IP address for your virtual network resources. This allows outside firewalls to identify traffic originating from your virtual network.
 -  It is fully integrated with Azure Monitor for logging and analytics.
 -  When creating firewall rules, it is best to use the FQDN tags.

The key stages of deploying and configuring Azure Firewall are as follows:

 -  Create a resource group
 -  Create a virtual network and subnets
 -  Create a workload VM in a subnet
 -  Deploy the firewall and policy to the virtual network
 -  Create a default outbound route
 -  Configure an application rule
 -  Configure a network rule
 -  Configure a Destination NAT (DNAT) rule
 -  Test the firewall

### Deploying Azure Firewall with Availability Zones

One of the major features of Azure Firewall is Availability Zones.

When deploying Azure Firewall, you can configure it to span multiple Availability Zones for increased availability. When you configure Azure Firewall in this way your availability increases to 99.99% uptime. The 99.99% uptime SLA is offered when two or more Availability Zones are selected.

You can also associate Azure Firewall to a specific zone just for proximity reasons, using the service standard 99.95% SLA.

For more information, see the [Azure Firewall Service Level Agreement (SLA)](https://azure.microsoft.com/support/legal/sla/azure-firewall/v1_0/).

There is no additional cost for a firewall deployed in an Availability Zone. However, there are added costs for inbound and outbound data transfers associated with Availability Zones.

For more information, see [Bandwidth pricing details](https://azure.microsoft.com/pricing/details/bandwidth/).

Azure Firewall Availability Zones are only available in regions that support Availability Zones.

Availability Zones can only be configured during firewall deployment. You cannot configure an existing firewall to include Availability Zones.

### Methods for deploying an Azure Firewall with Availability Zones

You can use several methods for deploying your Azure Firewall using Availability Zones.

- Azure portal
- Azure PowerShell - see [Deploy an Azure Firewall with Availability Zones using Azure PowerShell](/azure/firewall/deploy-availability-zone-powershell)
- Azure Resource Manager template - see [Quickstart: Deploy Azure Firewall with Availability Zones - Azure Resource Manager template](/azure/firewall/deploy-template)