
Any company, large or small, can be the target of a serious network attack. The nature of these attacks might be to make a statement, or because the attacker wanted a challenge.

## Distributed Denial of Service attacks

The aim of a Distributed Denial of Service (DDoS) attack is to overwhelm the resources on your applications and servers, making them unresponsive or slow for genuine users. A DDoS attack will usually target any public-facing device that can be accessed through the internet.

The three most frequent types of DDoS attack are:

- **Volumetric attacks**: These are volume-based attacks that flood the network layer with seemingly legitimate traffic, overwhelming the available bandwidth. Legitimate traffic can't get through.
- **Protocol attacks**: Protocol attacks render a target inaccessible by exhausting server resources with false protocol requests that exploit weaknesses in layer 3 (network) and layer 4 (transport) protocols.
- **Resource (application) layer attacks**: These attacks target web application packets, to disrupt the transmission of data between hosts.

### What is Azure DDoS Protection?

The Azure DDoS Protection service is designed to help protect your applications and servers by analyzing network traffic and discarding anything that looks like a DDoS attack.

:::image type="content" source="../media/2-network-flow.png" alt-text="Diagram showing network flow into Azure from both customers and attackers, and how  Azure DDoS Protection filters out DDoS attacks.":::

Azure DDoS Protection service protects at layer 3 (network layer) and layer 4 (transport layer).  Key benefits provided include:

- **Always-on traffic monitoring**: Your application traffic patterns are monitored 24 hours a day, 7 days a week, looking for indicators of DDoS attacks. Azure DDoS Protection instantly and automatically mitigates the attack, once it's detected.  As part of the mitigation, traffic sent to the protected resource is redirected by the DDoS protection service and several checks are performed. Azure DDoS Protection drops attack traffic and forwards the remaining traffic to its intended destination. Within a few minutes of attack detection, you're notified using Azure Monitor metrics.
- **Adaptive real time tuning**: Intelligent traffic profiling learns your application's traffic over time, and selects and updates the profile that is the most suitable for your service. The profile adjusts as traffic changes over time.
- **DDoS Protection telemetry, monitoring, and alerting**: Azure DDoS Protection exposes rich telemetry via Azure Monitor. You can configure alerts for any of the Azure Monitor metrics that DDoS Protection uses. You can integrate logging with Azure Event Hubs, Azure Monitor logs, and Azure Storage for advanced analysis via the Azure Monitor Diagnostics interface.

Azure DDoS Protection supports two tier types, DDoS IP Protection and DDoS Network Protection. The tier is configured in the Azure portal when you configure Azure DDoS Protection.

- **DDoS Network Protection**: The DDoS Network Protection service (available as a SKU), combined with application design best practices, provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network. Protection is simple to enable on any new or existing virtual network, and it requires no application or resource changes. 
- **DDoS IP Protection**: DDoS IP Protection is a pay-per-protected IP model. DDoS IP Protection contains the same core engineering features as DDoS Network Protection, but differs in that it doesn't include the value-added services such as DDoS rapid response support, cost protection, and discounts on Web Application Firewall (WAF) that are part of DDoS Network Protection.  For a complete listing of the features and corresponding tiers, see [About Azure DDoS Protection tier Comparison](/azure/ddos-protection/ddos-protection-sku-comparison)

A common question that is often raised is why consider adding DDos Protection services if services running on Azure are inherently protected by the default infrastructure-level DDoS protection? The reason is because the protection that safeguards the infrastructure has a much higher threshold than most applications have the capacity to handle, and doesn't provide telemetry or alerting.  So while traffic volume may be perceived as harmless by the platform, it can be devastating to the application that receives it. By onboarding to the Azure DDoS Protection Service, the application gets dedicated monitoring to detect attacks and application specific thresholds. A service will be protected with a profile that is tuned to its expected traffic volume, providing a much tighter defense against DDoS attacks.

As mentioned, earlier, Azure DDos Protection protects at layer 3 and layer 4. For web applications protection at layer 7 (the application layer), you need to add protection at the application layer using a Web Application Firewall (WAF) offering, described in a subsequent unit of this module.
