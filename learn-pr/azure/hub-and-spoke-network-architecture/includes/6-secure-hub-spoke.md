Azure provides a number of services to enable an organization to secure and protect its cloud infrastructure.

The organization needs to understand how to secure it's new network, and what other Azure services are available.

In this unit, you'll explore secure networking in the Azure platform, see an overview of Azure Firewall, and how to secure virtual networks using network security groups.

## Secure network design on Azure

![Image showing Azure network infrastructure](../media/6-secure-network.png)

The image above shows the Azure network infrastructure, and the methods that enable you to connect securely between on-premises, Azure hosted resources, and the public internet.

There are several features to consider as part of securing a network design:

- **Azure Virtual Network**: provide a base layer of security by logically isolating your environments in Azure to prevent unauthorized or unwanted access.
- **Azure DNS**: a hosting service for your domain names. Azure DNS is a secure service that manages and resolves domain names in your virtual network.
- **Azure Application Gateway**: a dedicated virtual appliance that provides an application delivery controller as a service, including a Web Application Firewall (WAF).
- **Azure Traffic Manager**: a service to control the distribution of user traffic in Azure.
- **Azure Load Balancer**: provides high availability and network performance to your Azure applications.
- **Deploy a perimeter network**: also known as a DMZ – to segment assets between your Azure Virtual Network and the internet.

## Introduction to security on Azure

Azure has a wide range of security tools to help create secure solutions:

- Network access controls to make sure that your Azure services are accessible to only users and devices you want.
- Network security groups as a packet filtering firewall to control Virtual Network traffic.
- Route control, and forced tunneling, to define custom routes through your infrastructure, and ensure services can't connect to an internet device.
- Enabling a virtual network security appliance through the Azure marketplace.
- Using ExpressRoute for a dedicated WAN link to securely extend your on-premises networks to Azure.
- Azure Security Center to prevent, detect, and respond to threats against your Azure services.
- Azure firewall as a network security service.

There's a wide variety of security solutions for your organization, many of which complement each other providing additional layers of security. It's important to align your security approach with Microsoft's recommended best practice. You then implement any features needed to meet your organization's internal security requirements.

## Base components of Azure security for hub-spoke topologies

The goal with network security is to ensure resources are protected from unauthorized access, or attack, by controlling your network traffic. In the hub and spoke model, there are several components you need to implement to follow best practice:

**Network security group (NSG)**

Each subnet within the topology has an NSG configured. The NSGs implement security rules to allow or deny network traffic to and from each resource in the topology.

**DMZ**

A DMZ has been configured in its own subnet in the hub Virtual Network for routing external traffic. The DMZ is designed to host network virtual appliances to provide security functionality, such as firewalls and packet inspection. The outbound traffic from the DMZ Virtual Network is force-tunneled to the internet through the on-premises network, so it's monitored and audited.

**Network Virtual Appliance (NVA)**

The NVA provides a secure network boundary by checking all inbound and outbound network traffic. Then the NVA passes only the traffic that meets network security rules, essentially acting as a firewall.

Some of the components mentioned above can be replaced with Azure Firewall to control access to Azure network resources.

**Azure ExpressRoute**

ExpressRoute creates a dedicated private WAN link between on-premises resources and an Azure gateway subnet in the Hub virtual network. You add a network security appliance between the on-premises network and the ExpressRoute provider edge routers to restrict the flow of unauthorized traffic from the virtual network.  

## Introduction to Azure Firewall

Azure Firewall is a network security service managed by Microsoft. It protects Azure Virtual Networks and their resources by letting you manage and enforce connectivity policies centrally. Azure Firewall uses a static public IP address for Virtual Network resources, allowing outside firewalls to identify your Virtual Network traffic.

Azure Firewall is a fully stateful network firewall that tracks the operating state, and characteristics of network connections traversing it. Azure Firewall enables central control of all network communications through policy enforcement. These policies can be enforced across virtual networks, regions, and Azure subscriptions. In a hub and spoke topology, the Azure Firewall is typically provisioned in the hub for complete control of traffic through the network.

![Image showing Azure firewall features](../media/6-azure-firewall.png)

The monitoring of Azure Firewall consists of reviewing the firewall and activity logs. Because Azure Firewall is integrated with Azure Monitor Logs, you can view the full logs there. Some logs are also available to view in the Azure portal.

![Image showing Azure Monitor Logs](../media/6-firewall-monitor.png)

The logs can be stored in an Azure Storage Account, streamed to an Azure Event Hub, or sent to Azure Monitor Logs.

## Network security with Azure Network Security Groups

Network security groups enforce and control network traffic rules. Access is controlled by permitting or denying communication between workloads in a virtual network. NSGs are rules-based. Rules are evaluated by priority using source, source port, destination, destination port, and protocol, to either allow or deny traffic.

### Defining security rules

Security rules in an NSG provide the mechanism that defines the control of traffic flow. An NSG has a set of rules by default. These rules can't be deleted, but you can override them with your own custom rules. The default rules are:

- Traffic originating from, and ending in, a Virtual Network is allowed.
- Outbound traffic to the internet is allowed, but inbound traffic is blocked.
- Azure Load Balancer is allowed to probe the health of VMs, or role instances.

## Additional security considerations

The ability to control how traffic is routed through your resources is an important security measure to take. Azure helps you improve the security of your overall infrastructure by offering other services:

- **Application Security Groups (ASGs)**: provides central policy and security management for your applications. Use ASGs to define detailed network security policies by using a moniker. You can then use a zero-trust approach, where only specified flows are permitted.
- **Virtual Network Security Appliances**: enables security at a higher level in your networking design. NSGs and UDRs typically work at the transport layer. The security appliances for Azure are available in the Azure Marketplace.
- **Azure Network Watcher**: enables insights into your network logging and diagnostics. Network Watcher allows you to understand the health and performance of your Azure networks.
- **Virtual Network Service Endpoints**: extends your virtual network private address space to make it available to Azure services. The endpoints allow you to restrict access to Azure resources.
- **DDOS protection**: two levels are available – basic, and standard. DDOS protection allows you to mitigate volumetric, protocol, and resource layer attacks.
