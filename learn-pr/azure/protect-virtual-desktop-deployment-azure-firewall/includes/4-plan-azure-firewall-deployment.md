Before you can deploy Azure Firewall, you need to plan your network topology, identify the firewall rules you'll need, and understand the deployment steps. 

## Recommended network topology

Recall that Azure Firewall is best deployed by using a hub-and-spoke network topology with the following characteristics:

- A virtual network that acts as the central connectivity point. This network is the hub virtual network.
- One or more virtual networks that are peered to the hub. These peers are the spoke virtual networks and are used to provision workload servers.

You can deploy the firewall instance in a subnet of the hub virtual network, then configure all inbound and outbound traffic to go through the firewall. You'll use this configuration when you deploy Azure Firewall to protect the host pool for Azure Virtual Desktop.

## Azure Firewall rules

Recall that, by default, the firewall denies access to everything. Your job is to configure the firewall with the conditions under which traffic is allowed through the firewall. Each condition is called a rule. Each rule applies one or more checks on the data. Only traffic that passes every check in all the firewall's rules is allowed to pass through.

The following table describes the three types of rules you can create for an Azure firewall. To allow the appropriate network traffic for Azure Virtual Desktop, you'll use application and network rules.

|Rule type  |Description  |
|---------|---------|
|Network address translation (NAT)     |Translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number. For example, to enable a remote desktop connection to a virtual machine (VM), you might use a NAT rule to translate your firewall's public IP address and port 3389 to the private IP address of the VM.    |
|Application     |Filter traffic based on a fully qualified domain name (FQDN) or FQDN tag. An FQDN tag represents a group of FQDNs associated with well-known Microsoft services, like Azure Virtual Desktop. For example, you'll use an application rule to allow outbound traffic for the Azure Virtual Desktop VMs by using the FQDN tag *WindowsVirtualDesktop*.         |
|Network     |Filter traffic based on one or more of the following three network parameters: IP address, port, and protocol. For example, use a network rule to allow traffic from an on-premises Active Directory Domain Server private IP address to Azure for TCP and UDP port 53. If you're using Microsoft Entra Domain Server, you don't need to create a network rule. DNS queries are forwarded to Azure DNS at 168.63.129.16. |

Azure Firewall applies rules in priority order. Rules based on threat intelligence are always given the highest priority and are processed first. After that, rules are applied by type: NAT rules, then network rules, then application rules. Within each type, rules are processed according to the priority values you assign when you create the rule, from lowest value to highest value.

## Deployment options

Recall that Azure Firewall offers many features designed to make it easier to create and manage rules. The following table summarizes these features. To allow network traffic for Azure Virtual Desktop, you'll use FQDN tags, but you could also use these other options in your environment.

|Feature  |Description  |
|---------|---------|
|FQDN     |A domain name of a host, or one or more IP addresses. Adding an FQDN to an application rule allows access to that domain. When you use an FQDN in an application rule, you can use wildcards, such as **.google.com*.        |
|FQDN tag     |A group of well-known Microsoft FQDNs. Adding an FQDN tag to an application rule allows outbound access to the tag's FQDNs. For example, there are FQDN tags for Windows Update, Azure Virtual Desktop, Windows diagnostics, and Azure Backup. Microsoft manages FQDN tags, and you can't modify or create them.       |
|Service tag     |A group of IP address prefixes related to a specific Azure service. Adding a service tag to a network rule allows access to the service represented by the tag. There are service tags for dozens of Azure services, including Azure Backup, Azure Cosmos DB, and Azure Logic Apps. Microsoft manages service tags, and you can't modify or create them.        |
|IP groups     |A group of IP addresses, such as 10.2.0.0/16 or 10.1.0.0-10.1.0.31. You can use an IP group as the source address in a NAT or application rule, or as the source or destination address in a network rule.        |
|Custom DNS     |A custom DNS server that resolves domain names to IP addresses. If you use a custom DNS server rather than Azure DNS, you must also configure Azure Firewall as a DNS proxy.        |
|DNS proxy     |You can configure Azure Firewall to act as a DNS proxy, which means that all client DNS requests go through the firewall before going to the DNS server.        |

## Deployment steps for Azure Firewall

In the previous exercise, you created a host pool and virtual network with a subnet. You deployed a session host VM into that subnet and registered it with the host pool. In the next exercises, you'll complete the following steps to deploy Azure Firewall to protect the host pool.

1. Set up the network:

    - Create a hub virtual network that includes a subnet for the firewall deployment.
    - Peer the hub and spoke networks. In the next exercise, you'll peer the hub virtual network with the virtual network used by the host pool of Azure Virtual Desktop.  

1. Deploy Azure Firewall:

    - Deploy Azure Firewall to a subnet in the hub virtual network.
    - For outbound traffic, create a default route that sends traffic from all subnets to the firewall's private IP address.

1. Create Azure Firewall rules:

    - Configure the firewall with rules to filter inbound and outbound traffic.
