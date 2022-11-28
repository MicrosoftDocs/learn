Azure Distributed Denial of Service (DDoS) protection, combined with application design best practices, provide defense against DDoS attacks. Azure DDoS protection provides the following service tiers:

 -  **Infrastructure**: Automatically enabled as part of the Azure platform. Always-on traffic monitoring, and real-time mitigation of common network-level attacks, provide the same defenses utilized by Microsoft's online services. The entire scale of Azure's global network can be used to distribute and mitigate attack traffic across regions. Protection is provided for IPv4 and IPv6 Azure public IP addresses.
 -  **Network Protection**: Provides additional mitigation capabilities over the infrastructure service tier that are tuned specifically to Azure Virtual Network resources. Network Protection is simple to enable, and requires no application changes. Protection policies are tuned through dedicated traffic monitoring and machine learning algorithms. Policies are applied to public IP addresses associated to resources deployed in virtual networks, such as Azure Load Balancer, Azure Application Gateway, and Azure Service Fabric instances, but this protection does not apply to App Service Environments. Real-time telemetry is available through Azure Monitor views during an attack, and for history. Rich attack mitigation analytics are available via diagnostic settings. Application layer protection can be added through the Azure Application Gateway Web Application Firewall or by installing a 3rd party firewall from Azure Marketplace. Protection is provided for IPv4 and IPv6 Azure public IP addresses.
-  **IP Protection (Preview)**: DDoS IP Protection is a pay-per-protected IP model. DDoS IP Protection contains the same core engineering features as DDoS Network Protection, but will differ in the following value-added services: DDoS rapid response support, cost protection, and discounts on WAF.

## How Azure denial-of-service protection works

DDoS Protection monitors actual traffic utilization and constantly compares it against the thresholds defined in the DDoS policy. When the traffic threshold is exceeded, DDoS mitigation is automatically initiated. When traffic returns to a level below the threshold, the mitigation is removed.

:::image type="content" source="../media/az500-distributed-denial-of-service-f342556e.png" alt-text="Diagram that depicts customers using the Azure portal or a virtual network to get DDoS Protection, which uses public IP addresses for policy generation, which causes information about network utilization, detected anomalies, and initiated mitigations for each public IP address to be generated.":::


During mitigation, DDoS Protection redirects traffic sent to the protected resource and performs several checks, including:

 -  Helping ensure that packets conform to internet specifications and aren’t malformed.
 -  Interacting with the client to determine if the traffic might be a spoofed packet (for example, using `SYN Auth` or `SYN Cookie` or dropping a packet for the source to retransmit it).
 -  Using rate-limit packets if it can’t perform any other enforcement method.

DDoS Protection blocks attack traffic and forwards the remaining traffic to its intended destination. Within a few minutes of attack detection, you’ll be notified with Azure Monitor metrics. By configuring logging on DDoS Protection telemetry, you can write the logs to available options for future analysis. Azure Monitor retains metric data for DDoS Protection for 30 days.

## Types of denial-of-service attacks that Azure protection mitigates

DDoS Protection can mitigate the following types of attacks:

 -  **Volumetric attacks**: The attack's goal is to flood the network layer with a substantial amount of seemingly legitimate traffic. It includes UDP floods, amplification floods, and other spoofed-packet floods. DDoS Protection mitigates these potential multi-gigabyte attacks by absorbing and scrubbing them, with Azure's global network scale, automatically.
 -  **Protocol attacks**: These attacks render a target inaccessible, by exploiting a weakness in the layer 3 and layer 4 protocol stack. It includes, SYN flood attacks, reflection attacks, and other protocol attacks. DDoS Protection mitigates these attacks, differentiating between malicious and legitimate traffic, by interacting with the client, and blocking malicious traffic.
 -  **Resource (application) layer attacks**: These attacks target web application packets, to disrupt the transmission of data between hosts. The attacks include HTTP protocol violations, SQL injection, cross-site scripting, and other layer 7 attacks. Use a Web Application Firewall, such as the Azure Application Gateway web application firewall, as well as DDoS Protection to provide defense against these attacks. There are also third-party web application firewall offerings available in the Azure Marketplace.

> [!IMPORTANT]
> DDoS Protection protects resources in a virtual network including public IP addresses associated with virtual machines, load balancers, and application gateways. When coupled with the Application Gateway web application firewall, or a third-party web application firewall deployed in a virtual network with a public IP, DDoS Protection can provide full layer 3 to layer 7 mitigation capability.
