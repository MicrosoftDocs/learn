As a System Administrator at Contoso, you are responsible for evaluating all possible mitigations to secure the company’s network traffic. In addition to NSGs and Adaptive Network Hardening, you're considering implementing Microsoft Azure Firewall.

## What is Azure Firewall?

Azure Firewall is a cloud-based network security service. You can use Azure Firewall to help to protect your Azure Virtual Network resources. By using Azure Firewall, you can centrally create and manage network connectivity profiles across your organization.

![A graphic that displays an Azure Firewall solution. A number of spoke VNets are connected to a Central VNet containing the firewall. This VNet is in turn connected to both an on-premises network and the internet. Traffic is filtered according to different rules between these different environments.](../media/m19-firewall-threat.png)


Azure Firewall uses a static public IP address for your virtual network resources. Consequently, external firewalls can identify traffic that originates from your organization's virtual network. Azure Firewall is also fully integrated with Azure Monitor, enabling support for both logging and analytics.

## Key features of Azure Firewall

Azure Firewall is a stateful firewall as a service, and offers the features described in the following table.

|Feature|Description|
|-|-|
|Built-in high availability|Because Azure Firewall is highly available by default, there's no need for you to configure load balancers.|
|Availability zones|You can configure Azure Firewall to span multiple [Regions that support Availability Zones in Azure](https://aka.ms/availability-zones-az-region?azure-portal=true) to provide increased availability. This provides for increased uptime to 99.99 percent. **Note**: You can only configure availability zones when you first deploy Azure Firewall.|
|Unrestricted cloud scalability|Azure Firewall scales up as needed to accommodate your organization's changing network traffic volumes.|
|Application FQDN filtering rules|By using filtering rules based on fully qualified domain names (FQDNs), you can limit outbound HTTP, HTTPS, and Azure SQL traffic to designated FQDNs. **Note**: wildcard names are supported.|
|Network traffic filtering rules|You can create deny/allow network filtering rules centrally by using both source and destination IP address, protocol, and port. Because Azure Firewall is fully stateful, it can distinguish legitimate packets for different types of connections. Rules are enforced and logged across multiple virtual networks, and where appropriate, multiple subscriptions.|
|FQDN tags|FQDN tags help to simplify the creation of rules that allow well-known Azure service network traffic through your firewall. For example, you can create an application rule to allow network traffic from Windows Update by including the *Windows Update* tag in the rule. You can find more information about this at [FQDN tags overview](https://aka.ms/fqdn-tags?azure-portal=true).|
|Service tags|You can use [Azure Firewall service tags](https://aka.ms/service-tags?azure-portal=true) to represent a group of IP address prefixes. This can help to reduce complexity when you create security rules. **Note**: You can't create your own service tags, nor can you define which IP address prefixes are included within a tag. Microsoft manages the both the address prefixes and the service tags.|
|Threat intelligence|To help alert you to (and to deny traffic from and to) known malicious IP addresses and domains, you can enable threat intelligence–based filtering for your firewall. For more information, refer to [Azure Firewall threat intelligence-based filtering](https://aka.ms/threat-intel?azure-portal=true). **Note**: Microsoft provides details about potentially malicious IP addresses and domains through the Microsoft Threat Intelligence feed.|
|Outbound SNAT support|Azure Firewall translates all outbound virtual network traffic IP addresses to the Azure Firewall public IP. This *translation* is known as Source Network Address Translation (SNAT). You can identify and allow traffic that originates from your organization's virtual network to remote internet destinations. If your organization uses a public IP address range for private networks, Azure Firewall performs SNAT on the traffic to one of the firewall private IP addresses in *AzureFirewallSubnet*. You can also configure Azure Firewall to not perform SNAT on your public IP address range. For more information, refer to [Azure Firewall SNAT private IP address ranges](https://aka.ms/snat-private-range?azure-portal=true). **Note**: Azure Firewall doesn't perform SNAT when the destination IP is a private IP range defined in [IANA Request for comment 1918](https://aka.ms/rfc1918?azure-portal=true).|
|Inbound DNAT support|Azure Firewall uses Destination Network Address Translation (DNAT) to translate any inbound internet network traffic arriving at your firewall public IP address. Azure Firewall filters network traffic to the private IP addresses on your organization's virtual networks.|
|Multiple public IP addresses|You can associate up to 250 public IP addresses with your Azure Firewall.|
|Azure Monitor logging|All Azure Firewall events integrate with Azure Monitor, enabling you to archive logs to a storage account, stream events to your event hub, or send them to Azure Monitor logs. For more information, refer to [Tutorial: Monitor Azure Firewall logs and metrics](https://aka.ms/tutorial-diagnostics?azure-portal=true).|
|Forced tunneling|You can configure Azure Firewall to route all outbound internet traffic to a designated next hop, such as an on-premises edge firewall or other network virtual appliance (NVA). For more information, refer to [Azure Firewall forced tunneling](https://aka.ms/forced-tunneling?azure-portal=true).|
|Certifications|Azure Firewall is Payment Card Industry (PCI), Service Organization Controls (SOC), International Organization for Standardization (ISO), and ICSA Labs compliant.|

> [!NOTE] 
> Visit [Azure Firewall FAQ](https://aka.ms/firewall-faq?azure-portal=true) to learn more about Azure Firewall.

## Typical deployment model

You can deploy Azure Firewall on any virtual network. Most Azure subscribers deploy Azure Firewall in a hub-and-spoke model. The central virtual network – the hub – hosts the firewall. Additional virtual networks – the spokes – can be set to peer with the hub firewall virtual network.

> [!TIP] 
> The hub-and-spoke model enables administrators to centrally exert control on multiple spoke virtual networks, even across multiple subscriptions.

> [!NOTE] 
> For best performance, you should deploy one firewall in each region.

## Controlling outbound network access

Managing and controlling outbound network access is a critical part of an organization's network security plan. Reasons to manage outbound traffic might including wanting to:

- Limit access to websites.
- Limit the outbound IP addresses and ports that your users can access.

You can use Azure Firewall to control outbound network access from an Azure subnet. With Azure Firewall, you can configure:

- Application rules that define FQDNs that your users can access from a subnet.
- Network rules that define source IP address, protocol, destination port, and destination IP address.

> [!NOTE] 
> The rules you configure apply to network traffic when you route your network traffic to the firewall as the subnet default gateway.

## Controlling inbound network access

You can use network address translation (NAT) rules to manage inbound network access with Azure Firewall. Specifically, you can configure Azure Firewall DNAT to translate and filter inbound internet traffic to your subnets.

When you configure DNAT, the NAT rule collection action is set to **DNAT**. Each rule in the NAT rule collection can then be used to translate your firewall public IP and port to a private IP and port.

DNAT rules implicitly add a corresponding network rule to allow any translated traffic. You can override this behavior by explicitly adding a network rule collection with deny rules that match the translated traffic.

> [!NOTE] 
> If you have a trial Azure tenant and you want to test Azure Firewall, review the following lab exercise: [Create an Azure Firewall test environment](https://aka.ms/sample-create-firewall-test?azure-portal=true).

> [!CAUTION] 
> There are a number of known issues with Azure Firewall. To read more about them, refer to [What is Azure Firewall, Known issues](https://aka.ms/known-issues?azure-portal=true).

## What is Azure Web Application Firewall?

Web applications are constantly targeted by malicious attacks that seek to exploit common network vulnerabilities. For example, SQL injection and cross-site scripting are among the most common attacks.

You can use the Azure Web Application Firewall to provide centralized protection of your web applications from common exploits and vulnerabilities.

![A typical Azure Web Application Firewall deployment. A Microsoft Global Network is comprised of Azure regions, and a Public Network includes an on-premises server and other cloud services. Separating these elements from the Azure resources is a web application firewall.](../media/m19-web-application-firewall-overview.png)

A centralized web application firewall helps simplify security management. It also provides better assurance of protection against threats and intrusions.

A web application firewall solution can react to a security threat faster by centrally patching a known vulnerability instead of securing each individual web application.

You can deploy an Azure Web Application Firewall with:

- [Azure Application Gateway](https://aka.ms/ag-overview?azure-portal=true)
- [Azure Front Door](https://aka.ms/afds-overview?azure-portal=true)
- [Azure Content Delivery Network](https://aka.ms/cdn-overview?azure-portal=true) service from Microsoft