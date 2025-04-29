
A denial of service attack (DoS) is an attack that has the goal of preventing access to services or systems. A DoS attack originates from one location. A distributed denial of service (DDoS) attack originates from multiple networks and systems.

DDoS attacks are one of the security concerns facing customers that are moving their applications to the cloud. A DDoS attack tries to drain an APIs or application's resources, making that application unavailable to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.

[Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) protects resources in a virtual network. Protection includes virtual machine public IP addresses, load balancers, and application gateways. When coupled with the Application Gateway WAF, DDoS Protection can provide full layer 3 to layer 7 mitigation capabilities.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=0fa9ca9f-6746-4fbd-85fa-f1f5aa406db5]

## Types of DDoS attacks

DDoS Protection can mitigate the following types of attacks.

- **Volumetric attacks**. These attacks flood the network layer with a substantial amount of seemingly legitimate traffic. They include UDP floods, amplification floods, and other spoofed-packet floods. 

- **Protocol attacks**. These attacks render a target inaccessible, by exploiting a weakness in the layer 3 and layer 4 protocol stack. Attacks include SYN flood attacks, reflection attacks, and other protocol attacks. 

- **Resource (application) layer attacks**. These attacks target web application packets, to disrupt the transmission of data between hosts. Attacks include HTTP protocol violations, SQL injection, cross-site scripting, and other layer 7 attacks. 

## DDoS implementation tiers

Azure DDoS Protection offers two tiers: DDoS IP Protection and DDoS Network Protection. Both tiers provide active traffic monitoring, always-on detection, and automatic attack mitigation. The tiers include application-based mitigation policies, metrics and alerts, mitigation reports, and integration with Firewall Manager.
Each tier is designed to cater to different needs and scenarios.

- **DDoS IP Protection**. This tier is suitable for protecting individual public IP addresses. It's ideal for scenarios where you have fewer than 15 public IP resources to protect. 

- **DDoS Network Protection**. This tier offers a few more benefits such as rapid response support and cost protection. Opt for this tier when you have a larger deployment with more than 15 public IP addresses. 

## Azure DDoS protection features

Some of Azure DDoS protection features include:

- **Native platform integration**. Natively integrated into Azure and configured through portal.

- **Turnkey protection**. Simplified configuration protecting all resources immediately.

- **Always-on traffic monitoring**. Your application traffic patterns are monitored 24 hours a day, 7 days a week, looking for indicators of DDoS attacks.

- **Adaptive tuning**. Profiling and adjusting to your service's traffic.

- **Attack analytics**. Get detailed reports in five-minute increments during an attack, and a complete summary after the attack ends.

- **Attack metrics and alerts**. Summarized metrics from each attack are accessible through Azure Monitor. Alerts can be configured at the start and stop of an attack, and over the attack's duration, using built-in attack metrics.

- **Multi-layered protection**. When deployed with a WAF, DDoS Protection protects both at the network layer and the application layer.



> [!TIP]
> Learn more about DDoS with the [Introduction to Azure DDoS Protection](/training/modules/introduction-azure-ddos-protection/) module.