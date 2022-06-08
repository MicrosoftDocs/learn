## Troubleshoot Azure Firewall application rules

Azure Firewall helps you to control outbound network access from an Azure subnet. With Azure Firewall, you can configure:

- Application rules that define fully qualified domain names (FQDNs) that can be accessed from a subnet.

- Network rules that define source address, protocol, destination port, and destination address.

A [hub-and-spoke model](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli) is recommended for production deployments, where the firewall is in its own VNet. The workload servers are in peered VNets in the same region, with one or more subnets.

- **AzureFirewallSubnet** ‒ the firewall is in this subnet.

- **Workload-SN** ‒ the workload server is in this subnet. This subnet's network traffic goes through the firewall.

The following [Tutorial - Deploy & configure Azure Firewall using the Azure portal | Microsoft Docs](/azure/firewall/tutorial-firewall-deploy-portal) can help you learn how to:

- Set up a test network environment.

- Deploy a firewall.

- Create a default route.

- Configure an application rule to allow access to www.google.com.

- Configure a network rule to allow access to external DNS servers.

- Configure a NAT rule to allow a remote desktop to the test server.

- Test the firewall.

### Monitor Azure Firewall logs and metrics

Firewall logs allow you to monitor Azure Firewall. You can also consider using activity logs to audit Azure Firewall resources. To view performance counters in the portal, use metrics.

Logs can be sent to Azure Monitor logs, Storage, and Event Hubs. They can be analyzed in Azure Monitor logs or by using Excel and Power BI.

### View and analyze the activity log

You can view and analyze activity log data by using any of the following methods:

- **Azure tools**: Through Azure PowerShell, the Azure CLI, the Azure REST API, or the Azure portal, you can retrieve information from the activity log.

- **Power BI**: By using the [Azure Activity Logs content pack for Power BI](/power-bi/connect-data/service-connect-to-services), you can analyze your data with preconfigured dashboards that you can use as is, or customize.

- **Microsoft Sentinel**: By connecting Azure Firewall logs to Microsoft Sentinel, you can view log data in workbooks, use it to create custom alerts, and incorporate it to improve your investigation.

Watch this video to learn more about the monitoring abilities of Azure Firewall:

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RWI4nn?postJsllMsg=true]

### View and analyze the network and application rule logs

Azure Firewall Workbook within the Azure portal is a platform where you can use Azure Firewall data analysis in an interactive way. For example, to create visual reports, combine multiple firewalls deployed across Azure, and so on.

For access and performance logs, you can connect to your storage account and retrieve the JSON log entries. After you download the JSON files, you can convert them to CSV and view them in Excel, Power BI, or any other data visualization tool.

To learn more, see [Monitor logs using Azure Firewall Workbook](/azure/firewall/firewall-workbook).

## Troubleshoot Azure Firewall network rules

Azure Firewall denies all traffic by default. You need to manually configure the rules to allow traffic. You can configure NAT rules, network rules, and applications rules on Azure Firewall using either classic rules or Firewall Policy.

### Rule processing using classic rules

Rule collections are processed according to the priority order of a rule type, lower numbers to higher numbers, from 100 to 65,000. A rule collection name can have only letters, numbers, underscores, periods, or hyphens. It must begin with a letter or number, and end with a letter, number, or underscore. The maximum name length is 80 characters.

To have room to add more rule collections if required, it's recommended to initially space your rule collection priority numbers in increments of 100 (100, 200, 300, and so on).

### Rule processing using Firewall Policy

Rules are organized inside Rule Collections and Rule Collection Groups when using Firewall Policy. Rule Collection Groups contain zero or more Rule Collections. Rule Collections are of NAT, Network, or Applications types. You can define multiple Rule Collection types within a single Rule Group. You can specify zero or more Rules in a Rule Collection. Rules in a Rule Collection must be of the same type (NAT, Network, or Application).

Rules are processed based on Rule Collection Group and Rule Collection priority. They can be any number between 100 (highest priority) to 65,000 (lowest priority).

If a Firewall Policy is inherited from a parent policy, Rule Collection Groups in the parent policy always take precedence regardless of the priority of a child policy.

Here is an example of a Firewall Policy:

| Name| Type| Priority| Rules| Inherited from|
| :--- | :--- | :--- | :--- | :--- |
| BaseRCG1| Rule Collection Group| 200| 8| Parent policy|
| DNATRC1| DNAT Rule Collection| 600| 7| Parent policy|
| DNATRC3| DNAT Rule Collection| 600| 7| Parent policy|
| NetworkRc1| Network Rule Collection| 800| 1| Parent policy|
| BaseRCG2| Rule Collection Group| 300| 3| Parent policy|
| AppRCG2| Application Rule Collection| 1200| 2| Parent policy|
| NetworkRC2| Network Rule Collection| 1300| 1| Parent policy|
| ChildRCG1| Rule Collection Group| 300| 5| -|
| ChAppRC1| Application Rule Collection| 700| 3| -|
| ChNetRC1| Network Rule Collection| 900| 2| -|
| ChildRCG2| Rule Collection Group| 650| 9| -|
| ChNetRC2| Network Rule Collection| 1100| 2| -|
| ChAppRC2| Application Rule Collection| 2000| 7| -|
| ChDNATRC3| DNAT Rule Collection| 3000| 2| -|

The rule processing will be in the following order: DNATRC1, DNATRC3, ChDNATRC3, NetworkRC1, NetworkRC2, ChNetRC1, ChNetRC2, AppRC2, ChAppRC1, ChAppRC2.

For more information about Firewall Policy rule sets, refer to [Azure Firewall Policy rule sets](/azure/firewall/policy-rule-sets).

> [!NOTE]
> Application rules are always processed after Network rules, which are processed after DNAT rules, regardless of Rule Collection Group or Rule Collection priority and policy inheritance.

If you enable threat intelligence-based filtering, those rules are highest priority and are always processed first. For more information, see [Azure Firewall threat intelligence-based filtering](/azure/firewall/threat-intel).

### IDPS

When IDPS is configured in Alert mode, it generates alerts on matching signatures for inbound and outbound flows. For an IDPS signature match, an alert is logged in firewall logs. However, there might still be another log entry generated for traffic that is denied/allowed by application/network rules. This is because the IDPS engine works in parallel to the rule processing engine.

## Troubleshoot Azure Firewall infrastructure rules

There is a built-in rule collection for infrastructure Fully Qualified Domain Names (FQDNs) by default in Azure Firewall. Specific FQDNs used for the platform can't be used for other purposes.

The built-in rule collection comprises of the following services:

- Compute access to storage Platform Image Repository (PIR).
- Managed disks status storage access.

- Azure Diagnostics and Logging (MDS).

### Overriding

With the override feature, you can create a deny all application rule collection that is processed last. This will override the built-in infrastructure rule collection and will always be processed before it. Anything not in the infrastructure rule collection is denied by default.

## Troubleshoot Azure Firewall network address translation (NAT) rules

Network rules allow or deny inbound, outbound, and east-west traffic based on the network layer (L3) and transport layer (L4). A network rule facilitates traffic filtering based on IP addresses, any ports, and any protocols.

When you configure DNAT, the NAT rule collection action is set to <!--CE: Is this correct or should this be in capitals?-->Dnat. Each rule in the NAT rule collection can then be used to translate your firewall public IP address and port to a private IP address and port.

The following [Tutorial: Filter inbound Internet traffic with Azure Firewall DNAT policy using the portal](/azure/firewall/tutorial-firewall-dnat-policy) can help you learn how to:

- Set up a test network environment.

- Deploy a firewall.

- Create a default route.

- Configure a DNAT rule.

- Test the firewall.

## Troubleshoot Azure Firewall distributed network address translation (DNAT) rules

Azure Firewall Destination Network Address Translation (DNAT) translates and filters inbound internet traffic to your subnets. It allows or denies inbound traffic through the firewall public IP address(es). A DNAT rule translates a public IP address into a private IP address.

It's recommended to add a specific internet source to allow DNAT access to the network and avoid using wildcards for security reasons.

## Troubleshoot network-level protection issues including firewalls

Adding security layers to the virtual machine (VM) networks protects inbound and outbound flows, to and from the users. You can use Firewall Policy to manage rule sets that the Azure Firewall uses to filter traffic.

### Outbound connectivity

### Network rules and applications rules

Network rules are applied in priority order before application rules. This means if a match is found in a network rule, no other rules are processed. IDPS may alert and/or block suspicious traffic.

In case there's no network rule match, and if the protocol is HTTP, HTTPS, or MSSQL, the packet is then evaluated by the application rules in priority order.

For HTTP, Azure Firewall looks for an application rule match according to the host header. For HTTPS, Azure Firewall looks for an application rule match according to SNI only.

In both HTTP and TLS-inspected HTTPS cases, the firewall uses the DNS resolved IP address from the Host header instead of the packet's destination IP address. If the firewall does not get the port number in the host header, it assumes it to be the standard port 80. In case of a port mismatch between the actual TCP port and the port in the host header, the traffic is dropped. DNS resolution is done by Azure DNS or by a custom DNS if configured on the firewall. 

### Inbound connectivity

### DNAT rules and network rules

Inbound internet connectivity is enabled by configuring Destination Network Address Translation (DNAT). NAT rules are applied in priority before network rules.

If a match is found, a corresponding network rule to allow the translated traffic is added.

To filter inbound HTTP/S traffic, you should use Web Application Firewall (WAF) as Application rules aren't applied for inbound connections.

To view the results of some of the rule combinations, refer to [Azure Firewall rule processing logic](/azure/firewall/rule-processing).

## Troubleshoot Azure Firewall Manager misconfiguration issues

Azure Firewall Manager is a security management service. You can use it to create secured virtual hubs to secure cloud network traffic destined for private IP addresses, Azure PaaS, and the internet.


| Secured virtual hub  |
|:---------:|
|:::image type="content" source="../media/4-azure-firewall-manager.png" alt-text="Diagram showing secured virtual hub using Azure Firewall Manager." border="false":::|

The following [Tutorial: Secure your virtual hub using Azure Firewall Manager](/azure/firewall-manager/secure-cloud-network) can help you learn how to:

- Create the spoke virtual network.

- Create a secured virtual hub.

- Connect the hub-and-spoke virtual networks.

- Route traffic to your hub.

- Deploy the servers.

- Create a firewall policy and secure your hub.

- Test the firewall.

