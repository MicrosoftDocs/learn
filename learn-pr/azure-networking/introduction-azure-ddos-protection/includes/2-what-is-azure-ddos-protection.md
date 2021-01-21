Microsoft offers DDoS Basic protection to all Azure customers for free. Microsoft also offers additional services in their DDoS Standard protection.
<!-- Link to concept video here - A short video like the following example to explain what a DDoS attack is and the various types of DDoS attacks.
[DDoS Attack Explained](https://www.youtube.com/watch?v=ilhGh9CEIwM) -->

## Azure DDoS Basic or Standard Protection

You’re investigating the benefits for Contoso to upgrade to Azure DDoS Protection Standard for your services running in Azure. The motivation for evaluating this upgrade option, in the consensus of DDoS security experts, is the growing frequency and sophistication of DDoS attacks.

The attack traffic doesn't have to be in the range of terabits per second to take an application down. Any specific targeted attack can impact the availability of an application running in Azure, which is receiving traffic from the public internet.

### What is a DDoS attack?

In a DDoS attack, a perpetrator intentionally floods the system, like a server, website, or other network resource, with fake traffic. The computers are connected in a coordinated command-and-control network, called a *botnet*. A malicious third party controls the botnet to launch the DDoS attack. By overwhelming the service’s capabilities, the activity triggers a denial of services to legitimate users. DDoS attacks can be targeted at any endpoint that's publicly reachable through the internet.

The following image depicts a typical DDoS attack from a botnet.

:::image type="content" source="../media/2-ddos-attack.png" alt-text="Typical DDoS attack from a botnet that's controlling computers and sending a flood of service requests over the internet to the targeted website. This flood of malicious traffic is exhausting the resources of the website to the point where legitimate users cannot use the service.":::

Some common DDoS attacks are:

- Volumetric attacks. These attacks use multiple infected systems to flood the network layer with a substantial amount of seemingly legitimate traffic. The multiple compromised systems are typically part of a criminal botnet. The types of volumetric DDoS attacks are:

  - UDP floods. The attacker sends UDP packets, typically large ones, to a single destination or to random ports. The attacking systems can easily spoof their IP address, because UDP is connectionless.
  - Amplification floods. A DNS server is overwhelmed with seemingly legitimate requests for service. The attacker’s goal is to saturate the DNS service by exhausting bandwidth capacity.
  - Other spoofed packet floods. Sending massive amounts of bogus traffic to a resource.

- Protocol attacks. These attacks target Layer 3 or Layer 4 of the OSI model. They exploit a weakness in TCP. An example of a protocol-based DDoS attack is the TCP SYN flood, which exploits part of the three-way handshake. The attacker sends a succession of TCP SYN requests, ignoring the SYN+ACK reply. This attack is directed towards a target with the goal of overwhelming the target and making it unresponsive.
- Resource (application) layer attacks. Resource attacks target the “top” layer in the OSI model to disrupt the transmission of data between hosts. These layer-7 attacks include exploiting the HTTP protocol, SQL injection attacks, cross-site scripting, and other application attacks.

### Azure DDoS protection offerings

DDoS protection is similar to a secure and functioning backup system. A backup’s value to your organization isn't obvious until it’s needed. DDoS protection, like a backup, provides risk mitigation against potential threats.

### DDoS  Protection Basic

Azure provides continuous protection against DDoS attacks. DDoS protection does not store customer data. At no additional cost, Azure DDoS Protection Basic protects every Azure service that uses public IPv4 and IPv6 addresses. This DDoS protection service helps to protect all Azure services, including platform as a service (PaaS) services such as Azure DNS. DDoS Protection Basic requires no user configuration or application changes.

DDoS Protection Basic provides:

- Active traffic monitoring and always-on detection. DDoS Protection Basic monitors your application traffic patterns all day, every day, searching for indicators of DDoS attacks.
- Automatic attack mitigation. Once the attack is detected, it’s mitigated.
- The DDoS Protection Basic service level agreement (SLA), which is based on the Azure region with best-effort support.

### DDoS Protection Standard

DDoS Protection Standard provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network.

The following list describes the features and benefits of DDoS Protection Standard:

- It provides intelligent traffic profiling, which you’ll learn about in the next unit.
- It provides native integration into the Azure portal for setup and deployment. This level of integration enables DDoS Standard to identify your Azure resources and their configurations.
- When DDoS Standard is enabled for a virtual network, all resources on that network are automatically protected. No additional administrative procedure is needed.
- Your network resources are under constant traffic monitoring for indications of a DDoS attack. Once detected, DDoS Standard will intervene and automatically mitigate the attack.
- It helps secure layers 3 and 4 at the network layer and provide application (layer 7) protection with Azure Web Application Firewall, which is included with Azure Gateway. Because the Azure Gateway and Web Application Firewall are internet-facing, DDoS Protection Standard protects their network interfaces. This is an example of multilayered or defense-in-depth protection.
- It provides detailed attack analytic reports during the attack in five-minute intervals and an after-action report for a complete summary of the event, when the attack ends.
- It includes support for the integration of mitigation logs with Azure Security Center, Azure Sentinel, or an offline security information and event management (SIEM) system for near real-time monitoring during an attack.
- Microsoft provides an SLA guarantee that the application availability/performance will not be impacted during a DDoS attack as well as cost protection in the form of Azure credits back for any scale of resources during an attack.
- Azure Monitor collects monitoring telemetry from DDoS Protection Standard for access to summarized attack metrics.

Cost guarantee and DDoS rapid response support are two of the other important DDoS Standard Protection features.

### Cost guarantee

At the beginning of a DDoS attack, the attack often triggers the automatic scale-out of the service running in Azure. This could be caused by the increase in network bandwidth, the scaling-up of the virtual machine count, or both.

> [!NOTE]
> Customers that are onboarded to DDoS Protection Standard receive service credit for application scale-out and network bandwidth cost that they incur during a documented DDoS attack. Microsoft directly provides this credit.

### DDoS rapid response support

Microsoft has created a DDoS Protection rapid response team. You can contact this team for help during a DDoS attack and request a post-attack analysis. The DDoS Protection rapid response team follows the Azure Rapid Response support model.

You can notify the team by opening a support request on the Azure portal. Contact the team if:

- Your company is planning a virtual event that's expected to significantly increase your network traffic.
- There's an attack that's severely degrading the performance of a protected critical business system.
- Your security team determines that protected resources are under attack, but DDoS Protection Standard isn’t mitigating the attack effectively.
