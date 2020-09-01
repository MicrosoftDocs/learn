Any large company can be the target of a large-scale network attack. Tailwind Traders is no exception. Attackers might flood your network to make a statement or simply for the challenge. As they move to the cloud, Tailwind Traders wants to understand how Azure can help them prevent Distributed Denial of Service (DDoS) and other attacks.

In this part, you learn how Azure DDoS Protection helps protect your Azure resources from DDoS attacks. First, let's define what a DDoS attack is.

## What are DDoS attacks?

A [Distributed Denial of Service](https://azure.microsoft.com/services/ddos-protection?azure-portal=true) (DDoS) attack attempts to overwhelm and exhaust an application's resources, making the application slow or unresponsive to legitimate users. DDoS attacks can target any resource that's publicly reachable through the internet, including websites.

## What is Azure DDoS Protection?

[Azure DDoS Protection](https://azure.microsoft.com/services/ddos-protection/?azure-portal=true) helps protect your Azure resources from DDoS attacks.

When you combine DDoS Protection with recommended application design practices, you help provide a defense against DDoS attacks. DDoS Protection leverages the scale and elasticity of Microsoft's global network to bring DDoS mitigation capacity to every Azure region. The DDoS Protection service protects your Azure applications by analyzing and discarding DDoS traffic at the Azure network edge, before it can impact your service's availability.

This diagram shows network traffic flowing into Azure from both customers and an attacker:

:::image type="content" source="../media/distributed-denial-service.png" alt-text="An illustration showing Azure DDoS Protection installed between virtual network and external user requests. The Azure DDoS Protection blocks malicious traffic attack but forwards the legitimate traffic to the intended destination." border="false":::

Azure DDoS Protection identifies the attacker's attempt to overwhelm the network and blocks further traffic from them, ensuring that traffic never reaches Azure resources. Legitimate traffic from customers still flows into Azure without any interruption of service.

## What service tiers are available to DDoS Protection?

DDoS Protection provides these service tiers:

+ **Basic**

    The Basic service tier is automatically enabled for free as part of your Azure subscription. 

    Always-on traffic monitoring and real-time mitigation of common network-level attacks provide the same defenses that Microsoft's online services use.

    Azure's global network is used to distribute and mitigate attack traffic across Azure regions.
+ **Standard**

    The Standard service tier provides additional mitigation capabilities that are tuned specifically to Azure Virtual Network (VNet) resources. DDoS Protection Standard is relatively easy to enable and requires no changes to your applications.

    Protection policies are tuned through dedicated traffic monitoring and machine learning algorithms. Policies are applied to public IP addresses, which are associated with resources deployed in virtual networks such as Azure Load Balancer and Application Gateway.

## What kinds of attacks can DDoS Protection help prevent?

The Standard service tier can help prevent:

+ **Volumetric attacks**

    The goal of this attack is to flood the network layer with a substantial amount of seemingly legitimate traffic.
+ **Protocol attacks**

    These attacks render a target inaccessible by exploiting a weakness in the layer 3 and layer 4 protocol stack.
+ **Resource (application) layer attacks**

    These attacks target web application packets to disrupt the transmission of data between hosts.
