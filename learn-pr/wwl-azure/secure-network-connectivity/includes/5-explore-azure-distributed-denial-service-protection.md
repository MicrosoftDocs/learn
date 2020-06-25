![DDoS icon.](../media/icon-distributed-denial-service.png)

[Distributed Denial of Service (DDoS)](https://azure.microsoft.com/services/ddos-protection?azure-portal=true) attacks attempt to overwhelm and exhaust an application’s resources, making the application slow or unresponsive to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet. Thus, any resource exposed to the internet, such as a website, is potentially at risk from a DDoS attack.

When you combine Azure DDoS Protection with application design best practices, you help provide defense against DDoS attacks. DDoS Protection leverages the scale and elasticity of Microsoft’s global network to bring DDoS mitigation capacity to every Azure region. The Azure DDoS Protection service protects your Azure applications by scrubbing traffic at the Azure network edge before it can impact your service's availability.

This diagram shows network traffic flowing into Azure from both customers and an attacker. Azure DDoS protection identifies the attacker's attempt to overwhelm the network and blocks further traffic from reaching Azure services. Legitimate traffic from customers still flows into Azure without any interruption of service.

![An illustration showing Azure DDoS protection installed between virtual network and external user requests. The Azure DDoS protection blocks malicious traffic attack but forwards the legitimate traffic to the intended destination.](../media/distributed-denial-service.png)

**Azure Distributed Denial of Service (DDoS) protection service tiers**

Azure DDoS Protection provides the following service tiers:

+ **Basic**. The Basic service tier is automatically enabled as part of the Azure platform. Always-on traffic monitoring and real-time mitigation of common network-level attacks provide the same defenses that Microsoft’s online services use. Azure’s global network is used to distribute and mitigate attack traffic across regions.
+ **Standard**. The Standard service tier provides additional mitigation capabilities that are tuned specifically to Microsoft Azure Virtual Network resources. DDoS Protection Standard is simple to enable and requires no application changes. Protection policies are tuned through dedicated traffic monitoring and machine learning algorithms. Policies are applied to public IP addresses which are associated with resources deployed in virtual networks, such as Azure Load Balancer and Application Gateway.


**Distributed Denial of Service (DDoS) standard protection**

DDoS standard protection can mitigate the following types of attacks:

+ **Volumetric attacks**. The attack's goal is to flood the network layer with a substantial amount of seemingly legitimate traffic.
+ **Protocol attacks**. These attacks render a target inaccessible, by exploiting a weakness in the layer 3 and layer 4 protocol stack.
+ **Resource (application) layer attacks**. These attacks target web application packets to disrupt the transmission of data between hosts.


