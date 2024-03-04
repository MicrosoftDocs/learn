Distributed denial of service (DDoS) attacks are some of the largest availability and security concerns facing customers that are moving their applications to the cloud. A DDoS attack attempts to exhaust an application's resources, making the application unavailable to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.

Azure DDoS Protection, combined with application design best practices, provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network. Protection is simple to enable on any new or existing virtual network, and it requires no application or resource changes.

:::image type="content" source="../media/distributed-denial-of-service-ccf87522.png" alt-text="Diagram showing an example of Azure distributed denial of service protection architecture.":::


## Azure DDoS Protection: Tiers

**DDoS Network Protection**

Azure DDoS Network Protection, combined with application design best practices, provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network.

**DDoS IP Protection**<br>

DDoS IP Protection is a pay-per-protected IP model. DDoS IP Protection contains the same core engineering features as DDoS Network Protection, but will differ in the following value-added services: DDoS rapid response support, cost protection, and discounts on WAF.

## Azure DDoS Protection: Key Features

 -  Always-on traffic monitoring: Your application traffic patterns are monitored 24 hours a day, 7 days a week, looking for indicators of DDoS attacks. Azure DDoS Protection instantly and automatically mitigates the attack, once it's detected.
 -  Adaptive real time tuning: Intelligent traffic profiling learns your application's traffic over time, and selects and updates the profile that is the most suitable for your service. The profile adjusts as traffic changes over time.<br>
 -  DDoS Protection analytics, metrics, and alerting: Azure DDoS Protection applies three auto-tuned mitigation policies (TCP SYN, TCP, and UDP) for each public IP of the protected resource, in the virtual network that has DDoS enabled. The policy thresholds are auto-configured via machine learning-based network traffic profiling. DDoS mitigation occurs for an IP address under attack only when the policy threshold is exceeded.<br>
     -  Attack analytics: Get detailed reports in five-minute increments during an attack, and a complete summary after the attack ends. Stream mitigation flow logs to Microsoft Sentinel or an offline security information and event management (SIEM) system for near real-time monitoring during an attack. See View and configure DDoS diagnostic logging to learn more.<br>
     -  Attack metrics: Summarized metrics from each attack are accessible through Azure Monitor. See View and configure DDoS protection telemetry to learn more.<br>
     -  Attack alerting: Alerts can be configured at the start and stop of an attack, and over the attack's duration, using built-in attack metrics. Alerts integrate into your operational software like Microsoft Azure Monitor logs, Splunk, Azure Storage, Email, and the Azure portal. See View and configure DDoS protection alerts to learn more.<br>
 -  Azure DDoS Rapid Response: During an active attack, Azure DDoS Protection customers have access to the DDoS Rapid Response (DRR) team, who can help with attack investigation during an attack and post-attack analysis. For more information, see Azure DDoS Rapid Response.<br>
 -  Native platform integration: Natively integrated into Azure. Includes configuration through the Azure portal. Azure DDoS Protection understands your resources and resource configuration.<br>
 -  Turnkey protection: Simplified configuration immediately protects all resources on a virtual network as soon as DDoS Network Protection is enabled. No intervention or user definition is required. Similarly, simplified configuration immediately protects a public IP resource when DDoS IP Protection is enabled for it.<br>
 -  Multi-Layered protection: When deployed with a web application firewall (WAF), Azure DDoS Protection protects both at the network layer (Layer 3 and 4, offered by Azure DDoS Protection) and at the application layer (Layer 7, offered by a WAF). WAF offerings include Azure Application Gateway WAF SKU and third-party web application firewall offerings available in the Azure Marketplace.<br>
 -  Extensive mitigation scale: All L3/L4 attack vectors can be mitigated, with global capacity, to protect against the largest known DDoS attacks.<br>
 -  Cost guarantee: Receive data-transfer and application scale-out service credit for resource costs incurred as a result of documented DDoS attacks.<br>

## Azure DDoS Protection: Architecture

Azure DDoS Protection is designed for services that are deployed in a virtual network. For other services, the default infrastructure-level DDoS protection applies, which defends against common network-layer attacks. To learn more about supported architectures, see DDoS Protection reference architectures.

## Pricing

For DDoS Network Protection, under a tenant, a single DDoS protection plan can be used across multiple subscriptions, so there's no need to create more than one DDoS protection plan. For DDoS IP Protection, there's no need to create a DDoS protection plan. Customers can enable DDoS IP protection on any public IP resource.

## Best Practices for DDoS Protection

Maximize the effectiveness of your DDoS protection strategy by following these best practices:

 -  Design your applications and infrastructure with redundancy and resilience in mind.<br>
 -  Implement a multi-layered security approach, including network, application, and data protection.
 -  Prepare an incident response plan to ensure a coordinated response to DDoS attacks.

## Azure DDoS Protection features

**Always-on traffic monitoring**

Azure DDoS Protection monitors actual traffic utilization and constantly compares it against the thresholds defined in the DDoS Policy. When the traffic threshold is exceeded, DDoS mitigation is initiated automatically. When traffic returns below the thresholds, the mitigation is stopped.

During mitigation, traffic sent to the protected resource is redirected by the DDoS protection service and several checks are performed, such as:<br>

 -  Ensure packets conform to internet specifications and are not malformed.<br>
 -  Interact with the client to determine if the traffic is potentially a spoofed packet (e.g: SYN Auth or SYN Cookie or by dropping a packet for the source to retransmit it).
 -  Rate-limit packets, if no other enforcement method can be performed.

Azure DDoS Protection drops attack traffic and forwards the remaining traffic to its intended destination. Within a few minutes of attack detection, you are notified using Azure Monitor metrics. By configuring logging on DDoS Protection telemetry, you can write the logs to available options for future analysis. Metric data in Azure Monitor for DDoS Protection is retained for 30 days.

## Adaptive real time tuning

The complexity of attacks (for example, multi-vector DDoS attacks) and the application-specific behaviors of tenants call for per-customer, tailored protection policies.

The service accomplishes this by using two insights:

 -  Automatic learning of per-customer (per-Public IP) traffic patterns for Layer 3 and 4.
 -  Minimizing false positives, considering that the scale of Azure allows it to absorb a significant amount of traffic.

## Azure DDoS Protection mitigation policies

In the Azure portal, select Monitor &gt; Metrics. In the Metrics pane, select the resource group, select a resource type of Public IP Address, and select your Azure public IP address. DDoS metrics are visible in the Available metrics pane.

DDoS Protection applies three auto-tuned mitigation policies (TCP SYN, TCP, and UDP) for each public IP of the protected resource, in the virtual network that has DDoS enabled. You can view the policy thresholds by selecting the metric Inbound packets to trigger DDoS mitigation.<br>

The policy thresholds are auto-configured via machine learning-based network traffic profiling. DDoS mitigation occurs for an IP address under attack only when the policy threshold is exceeded.<br>

## Metric for an IP address under DDoS attack

If the public IP address is under attack, the value for the metric Under DDoS attack or not changes to 1 as DDoS Protection performs mitigation on the attack traffic.

We recommend configuring an alert on this metric. You'll then be notified when there’s an active DDoS mitigation performed on your public IP address.<br>

## Web application firewall for resource attacks

Specific to resource attacks at the application layer, you should configure a web application firewall (WAF) to help secure web applications. A WAF inspects inbound web traffic to block SQL injections, cross-site scripting, DDoS, and other Layer 7 attacks. Azure provides WAF as a feature of Application Gateway for centralized protection of your web applications from common exploits and vulnerabilities. There are other WAF offerings available from Azure partners that might be more suitable for your needs via the Azure Marketplace.

Even web application firewalls are susceptible to volumetric and state exhaustion attacks. We strongly recommend enabling DDoS Protection on the WAF virtual network to help protect from volumetric and protocol attacks.<br>

## Protection Planning

Planning and preparation are crucial to understand how a system will perform during a DDoS attack. Designing an incident management response plan is part of this effort.

If you had DDoS Protection, make sure that it's enabled on the virtual network of internet-facing endpoints. Configuring DDoS alerts helps you constantly watch for any potential attacks on your infrastructure.<br>

Monitor your applications independently. Understand the normal behavior of an application. Prepare to act if the application is not behaving as expected during a DDoS attack.
