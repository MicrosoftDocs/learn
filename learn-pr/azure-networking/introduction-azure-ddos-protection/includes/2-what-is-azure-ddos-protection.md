
<!-- A short video like the following example to explain what a DDoS attack is and the various types of DDoS attacks.
[DDoS Attack Explained](https://www.youtube.com/watch?v=ilhGh9CEIwM) -->

Microsoft offers DDoS Basic protection to all Azure customers for free. Microsoft also offers additional services in their DDoS Standard protection.

You’re investigating the benefits for Contoso to upgrade to Azure Standard Denial of Service protection for your services running in Azure.

The motivation for investigating upgrading, is the consensus of DDoS security experts, the frequency of the DDoS attacks continues to grow every year. It's not only the frequency of the attacks that's increasing, but also the sophistication of the attacks that's growing as well.

The attack traffic does not have to be terabits per second to take an application down. All it needs is to be a specific targeted attack that will impact the availability of any application running in Azure which is receiving traffic from the public Internet.

### What is a DDoS attack?

In a DDoS attack, a perpetrator intentionally floods the system, like a server, website, or other network resource, with fake traffic. By overwhelming the service’s capabilities, the activity triggers a denial of services to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.

The following image shows a typical DDoS attack from a botnet.

:::image type="content" source="../media/2-ddos-attack.png" alt-text="typical DDoS attack from a botnet.":::

Some common DDoS attacks are:

- **Volumetric attacks** - These attacks use multiple infected systems to flood the network layer with a substantial amount of seemingly legitimate traffic. The multiple compromised systems are typically part of criminal botnet. The types of volumetric DDoS attackers are:

  - **UDP floods** - The attacker sends User Datagram Protocol (UDP) packets, typically large ones, to single destination or to random ports. The attacking systems can easily spoof their IP address since UDP is connectionless.

  - **Amplification floods** – A Domain Name System (DNS) server is overwhelmed with seemingly legitimate requests for service. The attacker’s goal is to saturate the DNS service by exhausting bandwidth capacity.

  - **Other spoofed packet floods** – Sending massive amounts of bogus traffic to a resource.

- **Protocol attacks** – These attacks target Layer 3 or Layer 4 of the OSI layer. They exploit a weakness in Transmission Control Protocol (TCP). An example of a protocol-based DDoS attack is the TCP Syn Flood, that exploits part of the three-way handshake. The attacker sends a succession of TCP SYN requests, ignoring the SYN+ACK reply. This attack is directed towards a target with the goal of overwhelming the target and make it unresponsive.

- **Resource (application) layer attacks** - Resource attacks target the “top” layer in the OSI model to disrupt the transmission of data between hosts. These layer 7 attacks include exploiting the http protocol, SQL injection, cross-site scripting (XSS), and other application attacks.

### Azure DDoS protection offerings

DDoS protection can be compared to a secure and functioning backup system. A backups value to your organization is not obvious until it’s needed. DDoS protection, like backups, provide risk mitigation against potential threats.

### DDoS (Basic) Protection

Azure provides continuous protection against DDoS attacks. Every IPv4 and IPv6 Public IP Address deployed service in Azure is protected by Azure's DDoS (Basic) Protection at no additional cost. This DDoS protection service helps to protect all Azure services, including PaaS services like Azure DNS. DDoS Protection Basic requires no user configuration or application changes. Azure DDoS protection does not store customer data.

DDoS Protection Basic provides

- Active traffic monitoring and always on detection - Your application traffic patterns are monitored 24 by 7 looking for indicators of DDoS attacks.

- Automatic attack mitigation – Once the attack is detected, the attack is mitigated.

- DDoS Basic service level agreement (SLA) is based on the Azure Region with best effort support.

### DDoS Protection Standard

Azure DDoS Protection Standard, provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network.

The features are:

1. Intelligent traffic profiling as described in unit 3.

1. Native integration into the Azure portal for setup and deploying. This level of integration enables DDoS Standard to identify your Azure resources and their configuration.

1. When DDoS Standard is enabled for a virtual network, all resources on that network are automatically protected. No additional administrative procedure is needed.

1. Your network resources are under constant traffic monitoring for indications of a DDoS attack. Once detected, DDoS Standard will intervene and automatically mitigate the attack.

1. Layers 3, and 4 protection at the network layer secured by DDoS Standard Protect. Combined the above with application layer 7 protection with Azure Web Application Firewall (WAF). WAF is included with Azure Gateway. Since the Azure Gateway, and WAF, are Internet facing, their network interfaces will be protected by DDoS Standard. This is an example of multi-layed or defense-in-depth protection.

1. Given the world-wide scale of Azure, DDoS Standard Protection's machine learning data sets have access to information on the latest DDoS attacks. This ML framework can currently recognize, and mitigate, over 60 different attack types.

1. Detailed attack analytic reports during the attack in five minute intervals.

1. After action report for a complete summary of the event when the attack ends.

1. Support for integration of mitigation logs with Azure Security Center, Azure Sentinel, or an offline security information and event management (SIEM) system for near real-time monitoring during an attack.

1. Azure Monitor collects monitoring telemetry from DDoS Standard for access to a summarized attack metrics.

1. Service level agreement (SLA) based on your company’s requirements. Microsoft guarantees Azure’s DDoS service will not go down. DDoS Standard will always ensure that the availability of the application is protected during the DDoS attack.

Two other DDoS Standard Protection features that need to be outlined. They are DDoS Rapid Response, and Cost guarantee.

### Cost guarantee

At the beginning of DDoS attack, what often happens is that the attack will trigger the automatic scale out of the service running in Azure. It could be the increase in network bandwidth, the scaling up of the virtual machine count, or both.

Customers that are onboarded to DDoS protection standard, will receive service credit for application scale-out, and network bandwidth, cost incurred during a documented DDoS attack.

This refund is provided by Microsoft directly.

### DDoS Rapid Response support

Microsoft has created a DDoS Protection Rapid Response (DRR) team. This team can be engaged to help during a DDoS attack, and also perform a post-attack analysis. The DDR team can be notified using the Azure portal by opening a support request. The team should be called on if:

- Your company is planning a virtual event that is expected to significantly increase your network traffic.
- An attack that is severely degrading the performance of a protected critical business system.
- Your security team determines that protected resources are under attack, but DDoS Standard Protection service is not mitigating the attack effectively.

This DDR service follows the Azure Rapid Response support model.
