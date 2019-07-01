Azure provides a number of services to enable an organization to secure and protect its cloud infrastructure.

Your company has planned the migration of on-premises resources to Azure using a hub and spoke architectural topology. The company has multiple locations that will be integrated into a central on-premises data center and share services – such as Active Directory domain services – through a central hub in Azure. The networking has been designed to use ExpressRoute to extend the on-premises networks. The organization now needs to understand how to secure the new network, and what other Azure services are available.

In this unit, you'll explore secure networking in the Azure platform, see an overview of Azure Firewall, and how to secure virtual networks using network security groups.

## Secure network design on Azure

![Image showing Azure network infrastructure](../media/6-secure-network.png)

The image above shows the Azure network infrastructure, and the methods that enable you to connect securely between on-premises, Azure hosted resources, and the public internet.

There are several features to consider as part of securing a network design:

- **Azure VNets**: provide a base layer of security by logically isolating your environments in Azure to prevent unauthorized or unwanted access.
- **Azure DNS**: a hosting service for your domain names. Azure DNS is a secure service that manages and resolves domain names in your virtual network.
- **Azure Application Gateway**: a dedicated virtual appliance that provides an application delivery controller as a service, including a Web Application Firewall (WAF).
- **Azure Traffic Manager**: a service to control the distribution of user traffic in Azure.
- **Azure Load Balancer**: provides high availability and network performance to your Azure applications.
- <!--CE:Is there something missing here? Should this bullet have a kicker, as all the others do?-->Deploy a perimeter network – known as a DMZ – to segment assets between your Azure VNet and the internet.

## Introduction to security on Azure

Azure has a wide range of security tools to help create secure solutions:

- Network access controls to make sure that your Azure services are accessible to only users and devices you want.
- Network security groups as a packet filtering firewall to control VNet traffic.
- Route control, and forced tunneling, to define custom routes through your infrastructure, and ensure services can't connect to an internet device.
- Enabling a virtual network security appliance through the Azure marketplace.
- Using ExpressRoute for a dedicated WAN link to extend on-premises networks to Azure.
- Azure Security Center to prevent, detect, and respond to threats against your Azure services.
- Azure firewall as a network security service.

There's a wide variety of security solutions for your organization in Azure, many of which complement each other providing additional layers of security. It's important to align your security approach with Microsoft's recommended best practice. You then implement any features needed to meet your organization's internal security requirements.

## Base components of Azure security for hub-spoke topologies

The goal with network security is to ensure resources are protected from unauthorized access, or attack, by controlling your network traffic. In the hub and spoke model, there are several components you need to implement to follow best practice:

**Azure ExpressRoute**

ExpressRoute creates a dedicated private WAN link between on-premises resources and an Azure gateway subnet in the Hub VNet. You add a network security appliance between the on-premises network and the ExpressRoute provider edge routers to restrict the flow of unauthorized traffic from the VNet.  

**Network security group (NSG)**

Each subnet within the topology has an NSG configured. The NSGs implement security rules to allow or deny network traffic to and from each resource in the topology.

**DMZ**

A DMZ has been configured in its own subnet in the hub VNet for routing external traffic. The DMZ is designed to host network virtual appliances to provide security functionality, such as firewalls and packet inspection. The outbound traffic from the DMZ VNet is force-tunneled to the internet through the on-premises network, so it's monitored and audited.

**Network Virtual Appliance (NVA)**

The NVA provides a secure network boundary by checking all inbound and outbound network traffic. Then the NVA passes only the traffic that meets network security rules, essentially acting as a firewall.

Some of the components mentioned above can be replaced with Azure Firewall to control access to Azure network resources.

## Introduction to Azure Firewall

Azure Firewall is a network security service managed by Microsoft. It protects Azure Virtual Networks and their resources by letting you manage and enforce connectivity policies centrally. Azure Firewall uses a static public IP address for VNet resources, allowing outside firewalls to identify your VNet traffic.

Azure Firewall is a fully stateful network firewall that tracks the operating state, and characteristics of network connections traversing it. Azure Firewall enables central control of all network communications through policy enforcement. These policies can be enforced across virtual networks, regions, and Azure subscriptions. In a hub and spoke topology, the Azure Firewall is typically provisioned in the hub for complete control of traffic through the network.

![Image showing Azure firewall features](../media/6-azure-firewall.png)

Azure Firewall comes with the following features:

- **Built-in high availability** – no additional configuration or add-on services are required.
- **Unrestricted cloud scalability** – you can scale up to adapt to changing traffic demands.
- **Application fully qualified domain names (FQDN) filtering rules** – you can restrict outgoing http/s traffic to a specific list of FQDN with support for wildcards.
- **Network traffic filtering rules** – you can centrally filter network traffic by source IP, destination IP, port, and protocol.
- **FQDN tags** – making it simple to allow known Azure services traffic through the firewall.
- **Threat intelligence** – to enable intelligence based filtering for alerting and denial of traffic to/from malicious IP addresses.
- **Outbound SNAT support** – to convert outbound traffic IP addresses to the Azure Firewall public IP (Source Network Address Translation).
- **Azure Monitor logging** – integrated with Azure Monitor to allow you to archive, stream, or monitor logs in real time.

## Deploying Azure Firewall

You configure application rules defining the FQDNs that can be accessed within a subnet, and rules to allow source addresses, protocols, destination ports, and destination addresses. In this configuration, you also need to ensure traffic is routed through the firewall as the default gateway. Azure Firewall requires direct internet connectivity to work correctly. The firewall doesn't support forced tunneling to your on-premises network by default. If forced tunneling is a requirement, you request it through Microsoft support – but it's only enabled on a case-by-case basis.

> [!NOTE]
> Traffic for directly peered VNets is routed by Azure Firewall regardless of whether a User Defined Route (UDR) exists to route to the default gateway. For subnet-to-subnet direct traffic routing, you create a UDR targeting both subnets' network prefix explicitly.

Here's the process for deploying Azure Firewall into your hub and spoke model:

1. Create a UDR on the hub gateway subnet, also pointing to the Azure Firewall IP address as the next hop type.
1. Create a UDR on the spoke subnet – pointed to the Azure Firewall IP address as the default gateway – and disable the Border Gateway Protocol (BGP) route propagation.
1. Ensure the hub and spoke VNets are set to AllowGatewayTransit from hub to spoke, and to UseRemoteGateways from VNet to spoke.
1. Deploy Azure Firewall into the hub VNet.
1. Configure the network rules – for example, allow RDP on port 3389.
1. Configure the routes from the hub to the spokes.
1. Configure the spoke subnet through the firewall IP address.
1. Configure any application routes – for example, an FQDN allowing outbound access to www.microsoft.com.

## Monitoring Azure Firewall

![Image showing Azure Monitor Logs](../media/6-firewall-monitor.png)

The monitoring of Azure Firewall consists of reviewing the firewall and activity logs. Because Azure Firewall is integrated with Azure Monitor Logs, you can view the full logs there. Some logs are also available to view in the Azure portal. You use default activity logs and two types of diagnostic logs:

- **Application Rule Log**: stores details of every new connection matching one of the configured application rules.
- **Network Rule Log**: stores details of every new connection matching one of the configured network rules.

The logs can be stored in an Azure Storage Account, streamed to an Azure Event Hub, or sent to Azure Monitor Logs.

## Network security with Azure Network Security Groups

You filter network traffic to and from Azure resources in an Azure virtual network using network security groups. A network security group contains security rules that allow, or deny, inbound network traffic to – or outbound network traffic from – Azure resources.

## Overview of Azure Network Security Groups

Network security groups enforce and control network traffic rules. Access is controlled by permitting or denying communication between workloads in a VNet. VNets and NSGs are in layers of the Azure security stack that includes UDRs and NVAs to create an effective security boundary for your deployments.
NSGs are rules-based. Rules are evaluated by priority using source, source port, destination, destination port, and protocol, to either allow or deny traffic.

## Defining security rules

Security rules in an NSG provide the mechanism that defines the control of traffic flow. An NSG has a set of rules by default. These rules can't be deleted, but you can override them with your own custom rules. The default rules are:

- Traffic originating from, and ending in, a VNet is allowed.
- Outbound traffic to the internet is allowed, but inbound traffic is blocked.
- Azure Load Balancer is allowed to probe the health of VMs, or role instances.

Service tags, which refer to a group of IP address prefixes, to reduce complexity, can be used in NSGs. The IP address prefixes are managed by Microsoft. For example, there's a **VirtualNetwork** tag that includes the Azure virtual network address space, all connected on-premises address spaces, peered VNets – or VNets connected to a gateway – and the address prefixes configured on UDRs.

## Traffic flow with network security groups

The rules defined in NSGs are applied to the traffic flow by a priority as follows:

**Inbound traffic**:
1. If the NSG in a subnet has a matching rule to deny traffic, the network packet is dropped.
1. If the VM\NIC has a matching rule to deny traffic, the network packet is dropped at the VM, regardless of a subnet NSG rule allowing traffic.

**Outbound traffic**:
1. If the VM\NIC has a matching rule to deny traffic, the network packet is dropped.
1. If the NSG in a subnet has a matching rule to deny traffic, the network packet is dropped, regardless of a VM\NIC NSG rule allowing traffic.

## Additional security considerations

The ability to control how traffic is routed through your resources is an important security measure to take. Azure helps you improve the security of your overall infrastructure by offering other services:

- **Application Security Groups (ASGs)**: provides central policy and security management for your applications. Use ASGs to define detailed network security policies based on workloads, applications, or environments, by using a moniker. You can then use a zero-trust approach, where only specified flows are permitted.
- **Virtual Network Security Appliances**: enables security at a higher level in your networking design. NSGs and UDRs typically work at the transport layer. The security appliances for Azure are available in the Azure Marketplace.
- **Azure Network Watcher**: enables insights into your network logging and diagnostics. Network Watcher allows you to understand the health and performance of your Azure networks.
- **Virtual Network Service Endpoints**: extends your virtual network private address space to make it available to Azure services. The endpoints allow you to restrict access to business critical Azure resources to only your virtual networks, removing internet access entirely.
- **DDOS protection**: two levels are available – basic, and standard. DDOS protection allows you to mitigate volumetric, protocol, and resource layer attacks.
