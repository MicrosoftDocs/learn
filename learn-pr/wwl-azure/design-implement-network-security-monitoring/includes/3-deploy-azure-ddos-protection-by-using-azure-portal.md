## Distributed Denial of Service (DDoS)

A denial of service attack (DoS) is an attack that has the goal of preventing access to services or systems. If the attack originates from one location, it is called a DoS. If the attack originates from multiple networks and systems, it is called distributed denial of service (DDoS).

Distributed Denial of Service (DDoS) attacks are some of the largest availability and security concerns facing customers that are moving their applications to the cloud. A DDoS attack tries to drain an API's or application's resources, making that application unavailable to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.

## DDoS implementation

Azure DDoS protection, combined with application design best practices, provide defense against DDoS attacks. Azure DDoS protection provides the following service tiers:

 -  **Basic**: Automatically enabled as part of the Azure platform. Always-on traffic monitoring, and real-time mitigation of common network-level attacks, provide the same defenses utilized by Microsoft's online services. The entire scale of Azure's global network can be used to distribute and mitigate attack traffic across regions. Protection is provided for IPv4 and IPv6 Azure public IP addresses.
 -  **Standard**: Provides additional mitigation capabilities over the Basic service tier that are tuned specifically to Azure Virtual Network resources. DDoS Protection Standard is simple to enable, and requires no application changes. Protection policies are tuned through dedicated traffic monitoring and machine learning algorithms. Policies are applied to public IP addresses associated to resources deployed in virtual networks, such as Azure Load Balancer, Azure Application Gateway, and Azure Service Fabric instances, but this protection does not apply to App Service Environments. Real-time telemetry is available through Azure Monitor views during an attack, and for history. Rich attack mitigation analytics are available via diagnostic settings. Application layer protection can be added through the Azure Application Gateway Web Application Firewall or by installing a 3rd party firewall from Azure Marketplace. Protection is provided for IPv4 and IPv6 Azure public IP addresses.

DDoS Protection Standard protects resources in a virtual network including public IP addresses associated with virtual machines, load balancers, and application gateways. When coupled with the Application Gateway web application firewall, or a third-party web application firewall deployed in a virtual network with a public IP, DDoS Protection Standard can provide full layer 3 to layer 7 mitigation capability.

Every property in Azure is protected by Azure's infrastructure DDoS (Basic) Protection at no additional cost. While DDoS Protection Standard is a paid service, design for services that are deployed in a virtual network.

## Types of DDoS attacks

DDoS Protection Standard can mitigate the following types of attacks:

**Volumetric attacks** \- These attacks flood the network layer with a substantial amount of seemingly legitimate traffic. They include UDP floods, amplification floods, and other spoofed-packet floods. DDoS Protection Standard mitigates these potential multi-gigabyte attacks by absorbing and scrubbing them, with Azure's global network scale, automatically.

**Protocol attacks** \- These attacks render a target inaccessible, by exploiting a weakness in the layer 3 and layer 4 protocol stack. They include SYN flood attacks, reflection attacks, and other protocol attacks. DDoS Protection Standard mitigates these attacks, differentiating between malicious and legitimate traffic, by interacting with the client, and blocking malicious traffic.

**Resource (application) layer attacks** \- These attacks target web application packets, to disrupt the transmission of data between hosts. They include HTTP protocol violations, SQL injection, cross-site scripting, and other layer 7 attacks. Use a Web Application Firewall, such as the Azure Application Gateway web application firewall, as well as DDoS Protection Standard to provide defense against these attacks. There are also third-party web application firewall offerings available in the Azure Marketplace.

## Azure DDoS protection features

Some of Azure DDoS protection features include:

 -  **Native platform integration:** Natively integrated into Azure and configured through portal.
 -  **Turnkey protection:** Simplified configuration protecting all resources immediately.
 -  **Always-on traffic monitoring:** Your application traffic patterns are monitored 24 hours a day, 7 days a week, looking for indicators of DDoS attacks.
 -  **Adaptive tuning:** Profiling and adjusting to your service's traffic.
 -  **Attack analytics:** Get detailed reports in five-minute increments during an attack, and a complete summary after the attack ends.
 -  **Attack metrics and alerts:** Summarized metrics from each attack are accessible through Azure Monitor. Alerts can be configured at the start and stop of an attack, and over the attack's duration, using built-in attack metrics.
 -  **Multi-layered protection:** When deployed with a web application firewall (WAF), DDoS Protection Standard protects both at the network layer (Layer 3 and 4, offered by Azure DDoS Protection Standard) and at the application layer (Layer 7, offered by a WAF).

Let us have a look in a bit more detail at some of those key features.

## Always-on traffic monitoring

DDoS Protection Standard monitors actual traffic utilization and constantly compares it against the thresholds defined in the DDoS Policy. When the traffic threshold is exceeded, DDoS mitigation is initiated automatically. When traffic returns below the thresholds, the mitigation is stopped.

:::image type="content" source="../media/always-on-traffic-monitoring-d9296111.png" alt-text="Diagram illustrating always-on traffic monitoring with DDoS protection.":::


During mitigation, traffic sent to the protected resource is redirected by the DDoS protection service and several checks are performed, such as:

 -  Ensure packets conform to internet specifications and aren't malformed.
 -  Interact with the client to determine if the traffic is potentially a spoofed packet (e.g: SYN Auth or SYN Cookie or by dropping a packet for the source to retransmit it).
 -  Rate-limit packets if no other enforcement method can be performed.

DDoS protection drops attack traffic and forwards the remaining traffic to its intended destination. Within a few minutes of attack detection, you are notified using Azure Monitor metrics. By configuring logging on DDoS Protection Standard telemetry, you can write the logs to available options for future analysis. Metric data in Azure Monitor for DDoS Protection Standard is retained for 30 days.

## Adaptive real-time tuning

The Azure DDoS Protection service helps protect customers and prevent impacts to other customers. For example, if a service is provisioned for a typical volume of legitimate incoming traffic that is smaller than the trigger rate of the infrastructure-wide DDoS Protection policy, a DDoS attack on that customer’s resources might go unnoticed. More generally, the complexity of recent attacks (for example, multi-vector DDoS) and the application-specific behaviors of tenants call for per-customer, tailored protection policies.

:::image type="content" source="../media/adaptive-real-time-tuning-c2c94bd4.png" alt-text="Diagram illustrating adaptive real-time tuning in DDoS protection.":::


The service accomplishes this by using two insights:

 -  Automatic learning of per-customer (per- Public IP) traffic patterns for Layer 3 and 4.
 -  Minimizing false positives, considering that the scale of Azure allows it to absorb a significant amount of traffic.

## Attack metrics, alerts, and logs

DDoS Protection Standard exposes rich telemetry via the Azure Monitor tool. You can configure alerts for any of the Azure Monitor metrics that DDoS Protection uses. You can integrate logging with Splunk (Azure Event Hubs), Azure Monitor logs, and Azure Storage for advanced analysis via the Azure Monitor Diagnostics interface.

In the Azure portal, select **Monitor > Metrics**. In the **Metrics** pane, select the resource group, select a resource type of **Public IP Address**, and select your Azure public IP address. DDoS metrics are visible in the **Available metrics** pane.

DDoS Protection Standard applies three autotuned mitigation policies (SYN, TCP, and UDP) for each public IP of the protected resource, in the virtual network that has DDoS enabled. You can view the policy thresholds by selecting the **Inbound \[SYN/TCP/UDP\] packets to trigger DDoS mitigation** metrics as shown in the example screenshot below.

:::image type="content" source="../media/ddos-mitigation-policies-586c35e7.png" alt-text="Chart displaying mitigation policy metrics from DDoS Protection Standard":::


The policy thresholds are autoconfigured via machine learning-based network traffic profiling. DDoS mitigation occurs for an IP address under attack only when the policy threshold is exceeded.

If the public IP address is under attack, the value for the **Under DDoS attack or not** metric changes to **1** as DDoS Protection performs mitigation on the attack traffic.

It is recommended to configure an alert on this metric as you will then get notified if there is an active DDoS mitigation performed on your public IP address.

:::image type="content" source="../media/under-ddos-attack-metric-a946df9a.png" alt-text="Chart displaying metric for 'Under DDoS attack or not'":::


## Multi-layered protection

Specific to resource attacks at the application layer, you should configure a web application firewall (WAF) to help secure web applications. A WAF inspects inbound web traffic to block SQL injections, cross-site scripting, DDoS, and other Layer 7 attacks. Azure provides WAF as a feature of **Application Gateway** for centralized protection of your web applications from common exploits and vulnerabilities. There are other WAF offerings available from Azure partners that might be more suitable for your needs via the Azure Marketplace.

:::image type="content" source="../media/waf-application-gateway-a8c1eff1.png" alt-text="Diagram illustrating the Web Application Firewall Application Gateway":::


Even web application firewalls are susceptible to volumetric and state exhaustion attacks. Therefore, it is firmly recommended to enable DDoS Protection Standard on the WAF virtual network to help protect from volumetric and protocol attacks.

## Deploying a DDoS protection plan

The key stages of deploying as DDoS Protection plan are as follows:

 -  Create a resource group
 -  Create a DDoS Protection Plan
 -  Enable DDoS protection on a new or existing virtual network
 -  Configure DDoS telemetry
 -  Configure DDoS diagnostic logs
 -  Configure DDoS alerts
 -  Run a test DDoS attack and monitor the results