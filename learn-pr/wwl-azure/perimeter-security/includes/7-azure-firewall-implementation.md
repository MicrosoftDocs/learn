Controlling outbound network access is an important part of an overall network security plan. For example, you may want to limit access to web sites. Or, you may want to limit the outbound IP addresses and ports that can be accessed.

One way you can control outbound network access from an Azure subnet is with Azure Firewall. With Azure Firewall, you can configure:

 -  Application rules that define fully qualified domain names (FQDNs) that can be accessed from a subnet.
 -  Network rules that define source address, protocol, destination port, and destination address.

Network traffic is subjected to the configured firewall rules when you route your network traffic to the firewall as the subnet default gateway.

:::image type="content" source="../media/az500-firewall-2-171c2383.png" alt-text="In this diagram, an azure firewall is in the middle. Bi-directional arrows show communication with two spoke VNets and an on-premises office building. Traffic is flowing between the internet and the firewall, but some traffic is denied.":::


### Fully Qualified Domain Name (FQDN) tag

An FQDN tag represents a group of fully qualified domain names (FQDNs) associated with well known Microsoft services. You can use an FQDN tag in application rules to allow the required outbound network traffic through your firewall.

For example, to manually allow **Windows Update** network traffic through your firewall, you need to create multiple application rules per the Microsoft documentation. Using FQDN tags, you can create an application rule, include the Windows Updates tag, and now network traffic to Microsoft Windows Update endpoints can flow through your firewall.

### Infrastructure qualified domain names

Azure Firewall includes a built-in rule collection for infrastructure FQDNs that are allowed by default. These FQDNs are specific for the platform and can't be used for other purposes.

The following services are included in the built-in rule collection:

 -  Compute access to storage Platform Image Repository (PIR)
 -  Managed disks status storage access
 -  Azure Diagnostics and Logging (MDS)

### Logs and metrics

You can monitor Azure Firewall using firewall logs. You can also use activity logs to audit operations on Azure Firewall resources.

You can access some of these logs through the portal. Logs can be sent to Azure Monitor logs, Storage, and Event Hubs and analyzed in Azure Monitor logs or by different tools such as Excel and Power BI.

Metrics are lightweight and can support near real-time scenarios making them useful for alerting and fast issue detection.

### Threat intelligence-based filtering

Threat intelligence-based filtering can be enabled for your firewall to alert and deny traffic from/to known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed. Intelligent Security Graph powers Microsoft threat intelligence and is used by multiple services including Microsoft Defender for Cloud. If you've enabled threat intelligence-based filtering, the associated rules are processed before any of the NAT rules, network rules, or application rules.

You can choose to just log an alert when a rule is triggered, or you can choose alert and deny mode. By default, threat intelligence-based filtering is enabled in alert mode.

### Rule processing logic

You can configure NAT rules, network rules, and applications rules on Azure Firewall. Rule collections are processed according to the rule type in priority order, lower numbers to higher numbers from 100 to 65,000. A rule collection name can have only letters, numbers, underscores, periods, or hyphens. It must begin with a letter or number, and end with a letter, number or underscore. The maximum name length is 80 characters.

It's best to initially space your rule collection priority numbers in 100 increments (100, 200, 300, and so on) so you have room to add more rule collections if needed.

### Service tags

A service tag represents a group of IP address prefixes to help minimize complexity for security rule creation. You cannot create your own service tag, nor specify which IP addresses are included within a tag. Microsoft manages the address prefixes encompassed by the service tag, and automatically updates the service tag as addresses change.

Azure Firewall service tags can be used in the network rules destination field. You can use them in place of specific IP addresses.

### Remote work support

**VDI**

Work from home policies requires many IT organizations to address fundamental changes in capacity, network, security, and governance. Employees aren't protected by the layered security policies associated with on-premises services while working from home. Virtual Desktop Infrastructure (VDI) deployments on Azure can help organizations rapidly respond to this changing environment. However, you need a way to protect inbound/outbound Internet access to and from these VDI deployments. You can use Azure Firewall DNAT rules along with its threat intelligence-based filtering capabilities to protect your VDI deployments.

**Virtual Desktop support**

Windows Virtual Desktop is a comprehensive desktop and app virtualization service running in Azure. It’s the only virtual desktop infrastructure (VDI) that delivers simplified management, multi-session Windows 10, optimizations for Microsoft 365 ProPlus, and support for Remote Desktop Services (RDS) environments. You can deploy and scale your Windows desktops and apps on Azure in minutes and get built-in security and compliance features. Windows Virtual Desktop doesn't require you to open any inbound access to your virtual network. However, you must allow a set of outbound network connections for the Windows Virtual Desktop virtual machines that run in your virtual network.
