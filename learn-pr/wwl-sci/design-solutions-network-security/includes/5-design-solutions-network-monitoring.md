Effective network monitoring gives you continuous visibility into the traffic flowing through your cloud environment. For a security architect, designing a monitoring solution means capturing the right data, analyzing it for threats and anomalies, and integrating findings into your security operations workflow. This unit explores how to combine Azure monitoring tools to build a comprehensive network monitoring strategy.

## Capture traffic data with virtual network flow logs

Virtual network flow logs are a Network Watcher traffic capability and the foundation of network traffic monitoring in Azure. They record metadata about every IP flow entering and leaving a virtual network, including source and destination addresses, ports, protocol, traffic direction, and whether the flow was allowed or denied. Flow logs operate at Layer 4 and are collected at one-minute intervals without affecting your resources or network performance.

Virtual network flow logs offer several advantages over the older network security group (NSG) flow logs:

- **Broader scope.** You enable logging at the virtual-network level, which captures all traffic through supported workloads in that virtual network. With NSG flow logs, you need to configure logging at both the subnet and network-interface level to get complete coverage.
- **Additional signals.** Virtual network flow logs identify whether Azure Virtual Network Manager security admin rules allowed or denied traffic, not only NSG rules. They also report the encryption status of flows when you use virtual network encryption.
- **Simplified management.** A single flow log per virtual network replaces the need for multiple NSG flow logs, reducing configuration complexity and the risk of gaps.

> [!IMPORTANT]
> NSG flow logs will be retired on September 30, 2027. After June 30, 2025, you can no longer create new NSG flow logs. Migrate existing NSG flow logs to virtual flow logs and design all new deployments around virtual network flow logs.

Flow log data is stored in Azure Storage and can be exported to a security information and event management (SIEM) solution, intrusion detection system (IDS), or visualization tool for further analysis.

### Design considerations for flow logs

When you design your flow log strategy, consider the following factors:

- **Storage account placement.** The storage account must be in the same region and subscription (or same Microsoft Entra tenant) as the virtual network. Only standard-tier storage accounts are supported.
- **Coverage gaps.** Some Azure services don't support virtual network flow logs, including Azure Container Instances, Azure Container Apps, Azure Functions, Logic Apps, and Azure App Service. For traffic to and from these services, plan alternative monitoring approaches.
- **Private endpoint traffic.** Traffic can't be recorded at the private endpoint itself. Capture this traffic at the source VM using the destination IP address of the private endpoint.
- **Cost management.** Virtual network flow logs are charged per gigabyte collected, with a free tier of 5 GB per month per subscription. Enable flow logs selectively on virtual networks that carry sensitive or high-risk traffic to control costs.

## Analyze traffic patterns with Traffic Analytics

Raw flow logs produce large volumes of data that are difficult to interpret on their own. Traffic Analytics, another Network Watcher traffic capability, processes flow log data to produce actionable insights about your network traffic.

Traffic Analytics aggregates raw flows, reduces the data volume by combining flows with common attributes, and enriches each record with geographic, security, and topology information. It stores the processed data in a Log Analytics workspace, where you can query it with Kusto Query Language (KQL) or view it through a built-in dashboard.

Traffic Analytics answers key monitoring questions:

- **Who is communicating?** Identify the most active hosts, application protocols, and host pairs in your network.
- **What traffic is blocked?** View denied flows by rule, source, and destination to validate that your security controls are working as intended.
- **Where are open internet ports?** Detect ports exposed to the internet across your environment.
- **Are there anomalies?** Spot sudden spikes in traffic volume, unexpected communication between segments, or connections to known malicious IP addresses.

To use Traffic Analytics, you need virtual network flow logs (or NSG flow logs for existing deployments), a Network Watcher instance, and a Log Analytics workspace. Configure the processing interval at one minute or 10 minutes depending on how quickly you need insights relative to cost.

## Monitor connectivity with Connection Monitor

Connection Monitor is a Network Watcher monitoring capability that tests whether traffic *can* flow between endpoints. While flow logs capture what traffic is flowing, Connection Monitor provides continuous, end-to-end connectivity monitoring between Azure VMs, virtual machine scale sets, on-premises hosts (through Azure Arc), and external endpoints such as URLs or IP addresses.

Connection Monitor measures packet loss, latency, and round-trip time using TCP, ICMP, and HTTP probes. It visualizes the end-to-end network path including hop-by-hop performance, helping you identify where connectivity degrades.

Design your Connection Monitor tests to cover critical paths in your architecture:

- **Multi-tier application connectivity,** such as web servers to database servers
- **Cross-region latency** between VMs in different Azure regions
- **Hybrid connectivity** from on-premises offices to Azure workloads
- **SaaS access** to endpoints like Microsoft 365 URLs

Connection Monitor integrates with Azure Monitor metrics and Log Analytics. Configure metric-based alerts on `ChecksFailedPercent` and `RoundTripTimeMs` to detect connectivity degradation before it affects users. The topology view helps you pinpoint whether issues originate from NSG rules, routing problems, or gateway failures.

## Inspect traffic at the firewall layer

When you route traffic through Azure Firewall, you gain an additional monitoring layer with structured firewall logs. These logs use resource-specific tables in Log Analytics, which can reduce logging costs by up to 80 percent compared to legacy Azure Diagnostics mode and provide faster query performance.

Structured logs include dedicated tables for:

| Log category | What it captures |
|---|---|
| **Network rule log** | Matches between traffic and network rules (allow or deny) |
| **Application rule log** | Matches between traffic and application rules, including URL filtering decisions |
| **Threat Intelligence log** | Connections flagged by Microsoft threat intelligence feeds |
| **IDPS signature log** | Packets matched by intrusion detection and prevention system (IDPS) signatures |
| **DNS proxy log** | DNS queries routed through the firewall's DNS proxy |
| **Top flow log** | Connections contributing the highest throughput (fat flows) |

The **Azure Firewall Workbook** provides a prebuilt visualization for analyzing this data across multiple firewalls in your environment. You can also use **Policy Analytics** to identify unused rules, overly broad rules, and rule optimization opportunities.

For security monitoring, the threat intelligence and IDPS logs are the most operationally relevant. They detect known malicious indicators (IP addresses, domains, URLs) and flag network-level attack patterns like port scanning or protocol exploits.

## Centralize with a SIEM

Individual monitoring tools produce valuable data, but their full power emerges when you aggregate and correlate logs across your entire environment. Microsoft Sentinel, as a cloud-native SIEM solution, provides this centralization layer.

Design your monitoring solution to send the following network data sources to Microsoft Sentinel:

- Virtual network flow logs (through Traffic Analytics and the Log Analytics workspace)
- Azure Firewall structured logs
- Azure DDoS Protection logs
- Azure Web Application Firewall (WAF) logs
- Defender for Cloud security alerts (including network-related recommendations)

Microsoft Sentinel applies analytics rules and machine-learning models to detect threats that span multiple data sources. For example, it can correlate an IDPS alert from Azure Firewall with anomalous flow patterns from Traffic Analytics and a Defender for Cloud recommendation about an exposed management port to create a single, high-confidence security incident.

## Design recommendations

- Enable virtual network flow logs on all virtual networks that carry production or sensitive workloads. Use Traffic Analytics with a one-minute processing interval for security-critical environments.
- Deploy Connection Monitor tests for every critical application path, including hybrid and cross-region connections. Set alerts at thresholds that give your team time to respond before users are affected.
- Configure Azure Firewall structured logs in resource-specific mode and enable IDPS and threat intelligence logging for all Azure Firewall instances.
- Route all network monitoring data to a centralized Log Analytics workspace connected to Microsoft Sentinel.
- Avoid building custom traffic-mirroring solutions for large deployments. Use the native monitoring capabilities described in this unit, and supplement with Azure Marketplace partner solutions only when specific capabilities are needed.
