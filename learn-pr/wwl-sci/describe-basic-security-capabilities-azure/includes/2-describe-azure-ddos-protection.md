
Any company, large or small, can be the target of a serious network attack. The nature of these attacks might be to make a statement, or because the attacker wanted a challenge.

## Distributed Denial of Service attacks

The aim of a Distributed Denial of Service (DDoS) attack is to overwhelm the resources on your applications and servers, making them unresponsive or slow for genuine users. A DDoS attack usually targets any public-facing endpoint that's reachable through the internet.

The three most frequent types of DDoS attack are:

- **Volumetric attacks**: These are volume-based attacks that flood the network layer with seemingly legitimate traffic, overwhelming the available bandwidth. Legitimate traffic can't get through.
- **Protocol attacks**: Protocol attacks render a target inaccessible by exhausting server resources with false protocol requests that exploit weaknesses in layer 3 (network) and layer 4 (transport) protocols.
- **Resource (application) layer attacks**: These attacks target web application packets, to disrupt the transmission of data between hosts.

### What is Azure DDoS Protection?

Azure DDoS Protection is designed to help protect your applications and servers by analyzing network traffic and discarding anything that looks like a DDoS attack.

:::image type="content" source="../media/2-network-flow.png" alt-text="Diagram showing network flow into Azure from both customers and attackers, and how Azure DDoS Protection filters out DDoS attacks." lightbox="../media/2-network-flow.png":::

Azure DDoS Protection protects at layer 3 (network layer) and layer 4 (transport layer). Key benefits include:

- **Always-on traffic monitoring**: Your application traffic patterns are monitored 24 hours a day, 7 days a week, looking for indicators of DDoS attacks. Azure DDoS Protection instantly and automatically mitigates the attack, once it's detected. As part of the mitigation, traffic sent to the protected resource is redirected by the DDoS protection service and several checks are performed. Azure DDoS Protection drops attack traffic and forwards the remaining traffic to its intended destination. Within a few minutes of attack detection, you're notified using Azure Monitor metrics.
- **Adaptive real time tuning**: Intelligent traffic profiling learns your application's traffic over time, and selects and updates the profile that is the most suitable for your service. The profile adjusts as traffic changes over time.
- **DDoS Protection analytics, metrics, and alerting**: Azure DDoS Protection exposes rich telemetry through Azure Monitor. You can configure alerts for any of the Azure Monitor metrics that DDoS Protection uses. You can integrate logging with Azure Event Hubs, Azure Monitor logs, and Azure Storage for advanced analysis.

Azure DDoS Protection supports two tier types, DDoS IP Protection and DDoS Network Protection. The tier is configured in the Azure portal when you configure Azure DDoS Protection.

- **DDoS Network Protection**: Combined with application design best practices, DDoS Network Protection provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network. Protection is simple to enable on any new or existing virtual network, and it requires no application or resource changes. 
- **DDoS IP Protection**: DDoS IP Protection is a pay-per-protected IP model. It contains the same core engineering features as DDoS Network Protection, but doesn't include the value-added services—such as DDoS rapid response support, cost protection, and discounts on WAF—that are part of DDoS Network Protection.

A common question is: why consider adding DDoS Protection if services running on Azure are already protected by default infrastructure-level DDoS protection? The default infrastructure protection has a higher threshold than most applications can handle, and it doesn't provide telemetry or alerting. Traffic volume that the platform perceives as harmless can be devastating to the application receiving it. By onboarding to Azure DDoS Protection, your application gets dedicated monitoring to detect attacks and application-specific thresholds. A service is protected with a profile tuned to its expected traffic volume, providing a tighter defense against DDoS attacks.

Azure DDoS Protection protects at layers 3 and 4. For web applications, protection at layer 7 (the application layer) requires adding a Web Application Firewall (WAF) offering. Combining Azure DDoS Protection with a WAF provides multi-layered protection against both network-level and application-level attacks—consistent with a defense-in-depth security strategy.

## DDoS Protection analytics and visibility

One of the key advantages of Azure DDoS Protection over default infrastructure protection is the rich telemetry it provides before, during, and after an attack:

- **Attack analytics**: During an active attack, you receive detailed reports in five-minute increments. After the attack ends, you receive a complete summary report. You can stream mitigation flow logs to Microsoft Sentinel or another security information and event management (SIEM) system for near real-time monitoring.
- **Attack metrics**: Azure Monitor makes summarized metrics from each attack accessible, so you can track patterns and trends over time.
- **Attack alerting**: Configure alerts at the start and stop of an attack, and throughout its duration, using built-in attack metrics. Alerts integrate with operational tools like Azure Monitor logs, Azure Storage, email, and the Azure portal.

This telemetry capability is a key differentiator from the default infrastructure-level DDoS protection, which provides no visibility into ongoing or historical attacks. For organizations that need to understand their threat landscape, demonstrate compliance, or investigate incidents, this visibility is essential.

## DDoS rapid response

Organizations using DDoS Network Protection have access to the DDoS rapid response (DRR) team during an active attack. DRR experts assist with attack investigation while an attack is underway and provide post-attack analysis. This expert support complements the automated protection already in place, providing a human element for complex or prolonged attacks.

## Best practices for DDoS protection

A multi-layered approach to DDoS protection is most effective:

- **Combine DDoS Protection with WAF**: Use Azure DDoS Protection for network-layer (layers 3 and 4) protection and a WAF for application-layer (layer 7) protection. Neither service alone covers all attack vectors.
- **Design for resilience**: Build applications with redundancy so that if one component is temporarily impacted, the overall application can continue serving users.
- **Enable telemetry and alerting**: Configure Azure Monitor alerts for DDoS metrics so that your security team is notified immediately when an attack is detected.
- **Plan for incidents**: Have an incident response plan in place before an attack occurs, so your team knows how to respond quickly and coordinate effectively.
