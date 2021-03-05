Any large company can be the target of a large-scale network attack. Tailwind Traders is no exception. Attackers might flood your network to make a statement or simply for the challenge. As Tailwind Traders moves to the cloud, it wants to understand how Azure can help prevent distributed denial of service (DDoS) and other attacks.

In this part, you learn how Azure DDoS Protection (Standard service tier) helps protect your Azure resources from DDoS attacks. First, let's define what a DDoS attack is.

## What are DDoS attacks?

A [distributed denial of service](https://azure.microsoft.com/services/ddos-protection?azure-portal=true) attack attempts to overwhelm and exhaust an application's resources, making the application slow or unresponsive to legitimate users. DDoS attacks can target any resource that's publicly reachable through the internet, including websites.

## What is Azure DDoS Protection?

[Azure DDoS Protection](https://azure.microsoft.com/services/ddos-protection/?azure-portal=true) (Standard) helps protect your Azure resources from DDoS attacks.

When you combine DDoS Protection with recommended application design practices, you help provide a defense against DDoS attacks. DDoS Protection uses the scale and elasticity of Microsoft's global network to bring DDoS mitigation capacity to every Azure region. The DDoS Protection service helps protect your Azure applications by analyzing and discarding DDoS traffic at the Azure network edge, before it can affect your service's availability.

This diagram shows network traffic flowing into Azure from both customers and an attacker:

:::image type="content" source="../media/4-distributed-denial-service.png" alt-text="An illustration showing Azure DDoS Protection installed between a virtual network and external user requests." border="false":::

DDoS Protection identifies the attacker's attempt to overwhelm the network and blocks further traffic from them, ensuring that traffic never reaches Azure resources. Legitimate traffic from customers still flows into Azure without any interruption of service.

DDoS Protection can also help you manage your cloud consumption. When you run on-premises, you have a fixed number of compute resources. But in the cloud, elastic computing means that you can automatically scale out your deployment to meet demand. A cleverly designed DDoS attack can cause you to increase your resource allocation, which incurs unneeded expense. DDoS Protection Standard helps ensure that the network load you process reflects customer usage. You can also receive credit for any costs accrued for scaled-out resources during a DDoS attack.

## What service tiers are available to DDoS Protection?

DDoS Protection provides these service tiers:

+ **Basic**

    The Basic service tier is automatically enabled for free as part of your Azure subscription.

    Always-on traffic monitoring and real-time mitigation of common network-level attacks provide the same defenses that Microsoft's online services use. The Basic service tier ensures that Azure infrastructure itself is not affected during a large-scale DDoS attack.

    The Azure global network is used to distribute and mitigate attack traffic across Azure regions.
+ **Standard**

    The Standard service tier provides additional mitigation capabilities that are tuned specifically to Azure Virtual Network resources. DDoS Protection Standard is relatively easy to enable and requires no changes to your applications.

    The Standard tier provides always-on traffic monitoring and real-time mitigation of common network-level attacks. It provides the same defenses that Microsoft's online services use.

    Protection policies are tuned through dedicated traffic monitoring and machine learning algorithms. Policies are applied to public IP addresses, which are associated with resources deployed in virtual networks such as Azure Load Balancer and Application Gateway.

    The Azure global network is used to distribute and mitigate attack traffic across Azure regions.

## What kinds of attacks can DDoS Protection help prevent?

The Standard service tier can help prevent:

+ **Volumetric attacks**

    The goal of this attack is to flood the network layer with a substantial amount of seemingly legitimate traffic.
+ **Protocol attacks**

    These attacks render a target inaccessible by exploiting a weakness in the layer 3 and layer 4 protocol stack.
+ **Resource-layer (application-layer) attacks (only with web application firewall)**

    These attacks target web application packets to disrupt the transmission of data between hosts. You need a web application firewall (WAF) to protect against L7 attacks. DDoS Protection Standard protects the WAF from volumetric and protocol attacks.
