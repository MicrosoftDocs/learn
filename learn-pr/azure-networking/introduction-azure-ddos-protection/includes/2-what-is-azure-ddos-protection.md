Microsoft offers DDoS infrastructure Protection to all Azure customers for free. Microsoft also offers additional services in their DDoS protection.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWCjzm]

## Azure DDoS infrastructure Protection or Azure DDoS Protection

You’re investigating the benefits for Contoso to upgrade to Azure DDoS Protection for your services running in Azure. The motivation for evaluating this upgrade option, in the consensus of DDoS security experts, is the growing frequency and sophistication of DDoS attacks.

The attack traffic doesn't have to be in the range of terabits per second to take down an application. Any specific targeted attack can impact the availability of an application running in Azure, which is receiving traffic from the public internet.

### What is a DDoS attack?

In a DDoS attack, a perpetrator intentionally floods the system, like a server, website, or other network resource, with fake traffic. The computers are connected in a coordinated command-and-control network, called a *botnet*. A malicious third party controls the botnet to launch the DDoS attack. By overwhelming the service’s capabilities, the activity triggers a denial of services to legitimate users. DDoS attacks can be targeted at any endpoint that's publicly reachable through the internet.

The following image depicts a typical DDoS attack from a botnet.

:::image type="content" source="../media/2-ddos-attack.png" alt-text="DDoS attack from a botnet that's controlling computers and sending malicious traffic to a website, which exhausts its resources and makes it unavailable to legitimate users." border="false":::

Some common DDoS attacks are:

- Volumetric attacks. These attacks use multiple infected systems to flood the network layer with a substantial amount of seemingly legitimate traffic. The multiple compromised systems are typically part of a criminal botnet. The types of volumetric DDoS attacks are:

  - UDP floods. The attacker sends UDP packets, typically large ones, to a single destination or to random ports. The attacking systems can easily spoof their IP address, because UDP is connectionless.
  - Amplification floods. A DNS server is overwhelmed with seemingly legitimate requests for service. The attacker’s goal is to saturate the DNS service by exhausting bandwidth capacity.
  - Other spoofed packet floods. Sending massive amounts of bogus traffic to a resource.

- Protocol attacks. These attacks target Layer 3 or Layer 4 of the OSI model. They exploit a weakness in TCP. An example of a protocol-based DDoS attack is the TCP SYN flood, which exploits part of the three-way handshake. The attacker sends a succession of TCP SYN requests, ignoring the SYN+ACK reply. This attack is directed towards a target with the goal of overwhelming the target and making it unresponsive.
- Resource (application) layer attacks. Resource attacks target the “top” layer in the OSI model to disrupt the transmission of data between hosts. These layer-7 attacks include exploiting the HTTP protocol, SQL injection attacks, cross-site scripting, and other application attacks.

## Azure DDoS protection offerings

DDoS protection is similar to a secure and functioning backup system. A backup’s value to your organization isn't obvious until it’s needed. DDoS protection, like a backup, provides risk mitigation against potential threats.

### DDoS infrastructure protection

Azure provides continuous protection against DDoS attacks. DDoS protection doesn't store customer data. At no additional cost, Azure DDoS infrastructure protection protects every Azure service that uses public IPv4 and IPv6 addresses. This DDoS protection service helps to protect all Azure services, including platform as a service (PaaS) services such as Azure DNS. DDoS infrastructure protection requires no user configuration or application changes.

Azure DDoS infrastructure protection provides:

- Active traffic monitoring and always-on detection. DDoS infrastructure protection monitors your application traffic patterns all day, every day, searching for indicators of DDoS attacks.
- Automatic attack mitigation. Once the attack is detected, it’s mitigated.
- The DDoS infrastructure protection service level agreement (SLA), which is based on the Azure region with best-effort support.

### Azure DDoS Network Protection

DDoS Network Protection provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network.

The following list describes the features and benefits of DDoS Network Protection:

- Protection for 100 public IP resources.
- It provides intelligent traffic profiling, which you’ll learn about in the next unit.
- It provides native integration into the Azure portal for setup and deployment. This level of integration enables DDoS Network Protection to identify your Azure resources and their configurations.
- When DDoS Network Protection is enabled for a virtual network, all resources on that network are automatically protected. No additional administrative procedure is needed.
- Your network resources are under constant traffic monitoring for indications of a DDoS attack. Once detected, DDoS Network Protection will intervene and automatically mitigate the attack.
- It helps secure layers 3 and 4 at the network layer and provide application (layer 7) protection with Azure Web Application Firewall, which is included with Azure Gateway. Because the Azure Gateway and Web Application Firewall are internet-facing, DDoS Network Protection protects their network interfaces. This is an example of multilayered or defense-in-depth protection.
- It provides detailed attack analytic reports during the attack in five-minute intervals and an after-action report for a complete summary of the event, when the attack ends.
- It includes support for the integration of mitigation logs with Microsoft Defender for Cloud, Microsoft Sentinel, or an offline security information and event management (SIEM) system for near real-time monitoring during an attack.
- Azure Monitor collects monitoring telemetry from DDoS Network Protection for access to summarized attack metrics.

### Azure DDoS IP Protection

DDoS IP Protection is a pay-per-protected IP model. DDoS IP Protection contains the same core engineering features as DDoS Network Protection, but will differ in the following value-added services:

- DDoS rapid response support
- Cost protection
- Discounts on WAF.

## Value-added services

Cost guarantee and DDoS rapid response support are two important DDoS Network Protection features that are value-added for DDoS IP Protection.

### Cost guarantee

At the beginning of a DDoS attack, the attack often triggers the automatic scale-out of the service running in Azure. This could be caused by the increase in network bandwidth, the scaling-up of the virtual machine count, or both.

> [!NOTE]
> Customers that are on-boarded to DDoS Protection receive service credit for application scale-out and network bandwidth cost that they incur during a documented DDoS attack. Microsoft directly provides this credit.

### DDoS rapid response support

Microsoft has created a DDoS Protection rapid response team. You can contact this team for help during a DDoS attack and request a post-attack analysis. The DDoS Protection rapid response team follows the Azure Rapid Response support model.

You can notify the team by opening a support request on the Azure portal. Contact the team if:

- Your company is planning a virtual event that's expected to significantly increase your network traffic.
- There's an attack that's severely degrading the performance of a protected critical business system.
- Your security team determines that protected resources are under attack, but DDoS Protection isn’t mitigating the attack effectively.
