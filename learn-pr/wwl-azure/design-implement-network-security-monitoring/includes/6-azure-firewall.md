
Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.

:::image type="content" source="../media/firewall-standard.png" alt-text="Diagram of Azure firewall configuration.":::

## Azure Firewall features

Azure Firewall includes these features. 

- **Built-in high availability**. High availability is built in, so no extra load balancers are required and there's nothing you need to configure.

- **Unrestricted cloud scalability**. Azure Firewall can scale out as much as you need to accommodate changing network traffic flows, so you don't need to budget for your peak traffic.

- **Application FQDN filtering rules**. You can limit outbound HTTP/S traffic or Azure SQL traffic to a specified list of fully qualified domain names (FQDN) including wild cards. This feature doesn't require TLS termination.

- **Network traffic filtering rules**. You can centrally create allow or deny network filtering rules by source and destination IP address, port, and protocol. Azure Firewall is fully stateful, so it can distinguish legitimate packets for different types of connections. Rules are enforced and logged across multiple subscriptions and virtual networks.

- **FQDN tags**. These tags make it easy for you to allow well-known Azure service network traffic through your firewall. For example, say you want to allow Windows Update network traffic through your firewall. You create an application rule and include the Windows Update tag. Now network traffic from Windows Update can flow through your firewall.

- **Service tags**. A service tag represents a group of IP address prefixes to help minimize complexity for security rule creation. You can't create your own service tag, nor specify which IP addresses are included within a tag. Microsoft manages the address prefixes encompassed by the service tag, and automatically updates the service tag as addresses change.

- **Threat intelligence**. Threat intelligence-based filtering (IDPS) can be enabled for your firewall to alert and deny traffic from/to known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed.

- **TLS inspection**. The firewall can decrypt outbound traffic, processes the data, then encrypt the data and sends it to the destination.

- **Outbound SNAT support**. All outbound virtual network traffic IP addresses are translated to the Azure Firewall public IP (Source Network Address Translation (SNAT)). You can identify and allow traffic originating from your virtual network to remote Internet destinations.

- **Inbound DNAT support**. Inbound Internet network traffic to your firewall public IP address is translated (Destination Network Address Translation) and filtered to the private IP addresses on your virtual networks.

- **Multiple public IP addresses**. You can associate multiple public IP addresses (up to 250) with your firewall, to enable specific DNAT and SNAT scenarios.

- **Azure Monitor logging**. All events are integrated with Azure Monitor, allowing you to archive logs to a storage account, stream events to your Event Hubs, or send them to Azure Monitor logs.

- **Forced tunneling**. You can configure Azure Firewall to route all Internet-bound traffic to a designated next hop instead of going directly to the Internet. For example, you have an on-premises edge firewall or other network virtual appliance (NVA) to process Internet network traffic.

- **Web categories**. Web categories let administrators allow or deny user access to web site categories such as gambling websites, social media websites, and others. Web categories are included in Azure Firewall Standard, but it's more fine-tuned in Azure Firewall Premium Preview. As opposed to the Web categories capability in the Standard SKU that matches the category based on an FQDN, the Premium SKU matches the category according to the entire URL for both HTTP and HTTPS traffic.

- **Certifications**. Azure Firewall is Payment Card Industry (PCI), Service Organization Controls (SOC), International Organization for Standardization (ISO), and ICSA Labs compliant.

## Rule processing in Azure Firewall

In the Azure Firewall, you can configure NAT rules, network rules, and applications rules. An Azure Firewall denies all traffic by default, until rules are manually configured to allow traffic.

### Rule processing with classic rules

With classic rules, rule collections are processed according to the rule type in priority order, lower numbers to higher numbers from 100 to 65,000. A rule collection name can have only letters, numbers, underscores, periods, or hyphens. It must also begin with either a letter or a number, and it must end with a letter, a number, or an underscore. The maximum name length is 80 characters. It's best practice to initially space your rule collection priority numbers in increments of 100. Increments give  space to add more rule collections when needed.

### Rule processing with Firewall Policy

With Firewall Policy, rules are organized inside Rule Collections which are contained in Rule Collection Groups. Rule Collections can be of the following types:

 -  DNAT (Destination Network Address Translation)
 -  Network
 -  Application

You can define multiple Rule Collection types within a single Rule Collection Group. You can define zero or more Rules in a Rule Collection, but the rules within a Rule Collection must be of the same type.

With Firewall Policy, rules are processed based on Rule Collection Group Priority and Rule Collection priority. Priority is any number between 100 (highest priority) and 65,000 (lowest priority). Highest priority Rule Collection Groups are processed first, and inside a Rule Collection Group, Rule Collections with the highest priority are processed first.

Application rules are always processed after network rules, which are themselves always processed after DNAT rules regardless of Rule Collection Group or Rule Collection priority and policy inheritance.

## Deploying and configuring Azure Firewall

Consider these factors when deploying Azure Firewall.

 -  The firewall can centrally create, enforce, and log application and network connectivity policies across subscriptions and virtual networks.
 -  The firewall uses a static, public IP address for your virtual network resources. 
 -  The firewall is fully integrated with Azure Monitor for logging and analytics.

The key steps to deploying and configuring Azure Firewall are: 

1. Create a resource group.
2. Create a virtual network and subnets.
3. Create a workload VM in a subnet.
4. Deploy the firewall and policy to the virtual network.
5. Create a default outbound route.
6. Configure an application rule.
7. Configure a network rule.
8. Configure a Destination NAT (DNAT) rule.
9. Test the firewall.