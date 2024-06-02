Here you learn the basics of both Azure Firewall and Azure Firewall Manager. This overview should help you decide whether Azure Firewall and Azure Firewall Manager are a good fit with Contoso's network security strategy.

## Overview of Azure Firewall

Azure Firewall is a cloud-based security service that protects your Azure virtual network resources from incoming and outgoing threats. In the next few sections, you learn the fundamentals and key features of Azure Firewall.

### What is a firewall?

A *firewall* is a network security feature that sits between a trusted network and an untrusted network, such as the internet. The firewall's job is to analyze all incoming and outgoing network traffic. Based on that analysis, the firewall either allows the traffic to pass, or it denies the traffic. Ideally, the firewall allows all legitimate traffic while denying malicious traffic such as malware and intrusion attempts.

By default, most firewalls deny all incoming and outgoing traffic. When a firewall analyzes network traffic, it checks for certain conditions to be met before it allows the traffic to pass through. Those conditions could be a specified IP address, FQDN, network port, network protocol, or any combination.

Together, these conditions define a firewall *rule*. A firewall might have only a single rule, but most firewalls are configured with many rules. Only network traffic that meets the conditions of the firewall's rules is allowed to pass through.

Some firewalls are hardware-based and reside inside devices that are built to act as firewalls. Other firewalls are software programs that run on general-purpose computing devices.

### What is Azure Firewall?

Azure Firewall is a cloud-based firewall service. In most configurations, Azure Firewall is provisioned inside a hub virtual network. Traffic to and from the spoke virtual networks and the on-premises network traverses the firewall with the hub network.

All traffic to and from the internet is denied by default. Traffic is only allowed if it passes various tests, such as the configured firewall rules.

:::image type="content" source="../media/2-firewall-standard.png" alt-text="Network diagram of a hub virtual network, several spoke virtual networks, and an on-premises network. It shows all traffic to and from the internet passing through an Azure Firewall instance in the hub network." border="false":::

> [!NOTE]
> Azure Firewall works not only for traffic to and from the internet, but also internally. Internal traffic filtering includes spoke-to-spoke traffic and hybrid cloud traffic between your on-premises network and your Azure virtual network.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWCoAv]

#### Key features of Azure Firewall Standard

The following table lists key features of Azure Firewall Standard.

|Feature  |Description  |
|---------|---------|
|Source network address translation (SNAT)     |All outbound traffic is sent to the private IP address of the Azure Firewall instance. The IP address of each source virtual machine is translated to the static public IP address of the Azure Firewall instance. To all external destinations, your network traffic appears to come from a single public IP address.         |
|Destination network address translation (DNAT)     |All inbound traffic from external sources is sent to the public IP address of the Azure Firewall instance. Allowed traffic is translated to the private IP address of the destination resource on your virtual network.         |
|Application rules     |Rules that limit outbound traffic to a list of FQDNs. For example, you can allow outbound traffic to access the FQDN of a specified SQL database instance.         |
|Network rules     |Rules for incoming and outgoing traffic based on network parameters. These parameters include the destination or source IP address; the network port; and the network protocol.         |
|Threat intelligence     |Filters incoming and outgoing traffic based on the Microsoft threat intelligence rules, which define known malicious IP addresses and domain names. You can configure Azure Firewall with one of two threat intelligence modes: alert you when traffic fails a threat intelligence rule or alert you and deny the traffic.         |
|Stateful     |Examines network packets in context, not just individually. If one or more packets arrive unexpectedly given current traffic, Azure Firewall treats the packets as malicious and denies them.         |
|Forced tunneling     |Enables Azure Firewall to route all outbound traffic to a specified network resource rather than directly to the internet. The network resource might be an on-premises hardware firewall or a network virtual appliance that processes traffic before allowing it to pass through to the internet.         |
|Tag support     |Azure Firewall supports service tags and FQDN tags for easier rule configuration. A *service tag* is a text entity that represents an Azure service. For example, **AzureCosmosDB** is the service tag for the Azure Cosmos DB service. An *FQDN tag* is a text entity that represents a group of domain names associated with popular Microsoft services. For example, **WindowsVirtualDesktop** is the FQDN tag for Azure Virtual Desktop traffic.   |
|DNS proxy|With DNS proxy enabled, Azure Firewall can process and forward DNS queries from a Virtual Network(s) to your desired DNS server.|
|Custom DNS|Allows you to configure Azure Firewall to use your own DNS server, while ensuring the firewall outbound dependencies are still resolved with Azure DNS.|
|Web categories|The Web categories feature lets administrators allow or deny user access to web site categories such as gambling websites, social media websites, and others.|
|Monitoring     |Azure Firewall logs all incoming and outgoing network traffic, and you can analyze the resulting logs using Azure Monitor, Power BI, Excel, and other tools.         |

### What is Azure Firewall Premium?

Azure Firewall Premium provides advanced threat protection that meets the needs of highly sensitive and regulated environments, such as the payment and healthcare industries.

:::image type="content" source="../media/2-firewall-premium.png" alt-text="Firewall Premium architecture":::

#### Key features of Azure Firewall Premium

The following table lists key features of Azure Firewall Premium.

|Feature  |Description  |
|---------|---------|
|TLS Inspection|Decrypts outbound traffic, processes the data, then encrypts the data and sends it to the destination.|
|IDPS|A network intrusion detection and prevention system (IDPS) allows you to monitor network activities for malicious activity, log information about this activity, report it, and optionally attempt to block it.|
|URL filtering|Extends Azure Firewall’s FQDN filtering capability to consider an entire URL. For example, `www.contoso.com/a/c` instead of `www.contoso.com`.
|Web categories|Administrators can allow or deny user access to website categories such as gambling websites, social media websites, and others. Web categories can be more fine-tuned in Azure Firewall Premium.|

### What is Azure Firewall Basic?

Azure Firewall Basic is intended for small and medium size (SMB) customers to secure their Azure cloud 
environments. It provides the essential protection SMB customers need at an affordable price point.

:::image type="content" source="../media/2-firewall-basic-diagram.png" alt-text="Diagram showing Firewall Basic.":::

Azure Firewall Basic is similar to Firewall Standard, but has the following main limitations:

- Supports Threat Intel *alert mode* only.
- Fixed scale unit to run the service on two virtual machine backend instances.
- Recommended for environments with an estimated throughput of 250 Mbps.

## Overview of Azure Firewall Manager

Azure Firewall Manager provides a central point of configuration and management of multiple Azure Firewall instances. Azure Firewall Manager enables you to create one or more firewall policies and rapidly apply them to multiple firewalls.

### What is a firewall policy?

The configuration of a single Azure Firewall can be complicated. For example, the firewall might be configured with multiple rule collections. A *collection* is a combination of any or all of the following items:

- One or more network address translation (NAT) rules
- One or more network rules
- One or more application rules

When you include other firewall settings such as custom DNS and threat intelligence rules, configuring just a single firewall can be a burden. Adding to that burden are two common network security scenarios:

- Your network architectures require multiple firewalls.
- You want each firewall to implement both a base level of security rules that apply to everyone, plus special rules for designated groups such as developers, database users, and the marketing department.

To simplify the complexity of managing these and similar firewall scenarios, you can implement firewall policies. A *firewall policy* is an Azure resource that contains one or more collections of NAT, network, and application rules. It also contains custom DNS settings, threat intelligence settings, and more.

The key point is that Azure offers a resource called Firewall Policy. A firewall policy that you create is an instance of that resource. As a separate resource, you can rapidly apply the policy to multiple firewalls using Azure Firewall Manager. You can create one policy to be the base policy, then have more specialized policies inherit the base policy's rules.

### Key features of Azure Firewall Manager

The following table lists key features of Azure Firewall Manager.

|Feature  |Description  |
|---------|---------|
|Centralized management     |Manage all firewall configurations across your entire network.         |
|Manage multiple firewalls     |Deploy, configure, and monitor any number of firewalls from a single interface.         |
|Supports multiple network architectures     |Protects both standard Azure virtual networks and Azure Virtual WAN Hubs.         |
|Automated traffic routing     |Network traffic is automatically routed to the firewall (when used with Azure Virtual WAN Hub only).         |
|Hierarchical policies     |Enables you to create so-called parent and child firewall policies. A *parent* policy contains the rules and settings you want to apply globally. A *child* policy inherits all the rules and settings of its parent.         |
|Support for third-party security providers     |Enables you to integrate third-party security as a service (SECaaS) solutions to protect your network's internet connection.         |
|DDoS protection plan|You can associate your virtual networks with a DDoS protection plan within Azure Firewall Manager.|
|Manage Web Application Firewall policies|You can centrally create and associate Web Application Firewall (WAF) policies for your application delivery platforms, including Azure Front Door and Azure Application Gateway.|

> [!NOTE]
> By enabling you to integrate third-party SECaaS solutions, your network security strategy might be to use Azure Firewall to monitor local network traffic while using the third-party SECaaS provider to monitor internet traffic.

### Architecture options

Azure Firewall Manager provides security management for the following two network architectures:

- Hub virtual network. A standard Azure virtual network where one or more firewall policies are applied.
- Secured virtual hub. An Azure Virtual WAN Hub where one or more firewall policies are applied.
