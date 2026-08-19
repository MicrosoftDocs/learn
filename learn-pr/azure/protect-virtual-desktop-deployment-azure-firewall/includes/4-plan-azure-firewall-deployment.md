Before you can deploy Azure Firewall, you need to plan your network topology, identify the firewall rules you'll need, and understand the deployment steps.

## Recommended network topology

Recall that Azure Firewall is best deployed by using a hub-and-spoke network topology with the following characteristics:

- A virtual network that acts as the central connectivity point. This network is the hub virtual network.
- One or more virtual networks that are peered to the hub. These peers are the spoke virtual networks and are used to provision workload servers.

You can deploy the firewall instance in a subnet of the hub virtual network, then use user-defined routes to send selected outbound traffic through the firewall. You'll use this configuration when you deploy Azure Firewall to protect the host pool for Azure Virtual Desktop. Azure Virtual Desktop gateway and broker traffic should use a direct route to avoid disconnections during Azure Firewall scale-in.

## Azure Firewall rules

By default, Azure Firewall denies traffic that reaches it. You configure rules that define which traffic the firewall allows. Only traffic that passes all applicable rule checks is allowed through.

The following table describes the three types of rules you can create for an Azure firewall. To allow the appropriate network traffic for Azure Virtual Desktop, you'll use application and network rules.

|Rule type  |Description  |
|---------|---------|
|Network address translation (NAT)     |Translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number. For example, you can publish an internal HTTPS service by translating the firewall's public IP address and TCP port 443 to a private workload address. Azure Virtual Desktop doesn't require inbound ports. |
|Application     |Filter traffic based on a fully qualified domain name (FQDN) or FQDN tag. An FQDN tag represents a group of FQDNs associated with well-known Microsoft services, like Azure Virtual Desktop. For example, you'll use an application rule to allow outbound traffic for the Azure Virtual Desktop VMs by using the FQDN tag *WindowsVirtualDesktop*.         |
|Network     |Filter traffic based on one or more of the following network parameters: IP address, FQDN, service tag, port, and protocol. For example, use an FQDN network rule to allow Windows activation traffic to `azkms.core.windows.net` on TCP port 1688. FQDN network rules require DNS proxy. |

Azure Firewall applies rules in priority order. Rules based on threat intelligence are always given the highest priority and are processed first. After that, rules are applied by type: NAT rules, then network rules, then application rules. Within each type, rules are processed according to the priority values you assign when you create the rule, from lowest value to highest value.

## Deployment options

Recall that Azure Firewall offers many features designed to make it easier to create and manage rules. The following table summarizes these features. To allow network traffic for Azure Virtual Desktop, you'll use FQDN tags, but you could also use these other options in your environment.

|Feature  |Description  |
|---------|---------|
|FQDN     |A fully qualified domain name (FQDN) identifies a host by its complete domain name. Adding an FQDN to a rule allows access to that destination. Application rules support wildcards, such as `*.contoso.com`. Network rules don't support FQDN wildcards. |
|FQDN tag     |A group of well-known Microsoft FQDNs. Adding an FQDN tag to an application rule allows outbound access to the tag's FQDNs. For example, there are FQDN tags for Windows Update, Azure Virtual Desktop, Windows diagnostics, and Azure Backup. Microsoft manages FQDN tags, and you can't modify or create them.       |
|Service tag     |A group of IP address prefixes related to a specific Azure service. Adding a service tag to a network rule allows access to the service represented by the tag. There are service tags for dozens of Azure services, including Azure Backup, Azure Cosmos DB, and Azure Logic Apps. Microsoft manages service tags, and you can't modify or create them.        |
|IP groups     |A group of IP addresses, such as 10.2.0.0/16 or 10.1.0.0-10.1.0.31. You can use an IP group as the source address in a NAT or application rule, or as the source or destination address in a network rule.        |
|Custom DNS     |A DNS server that resolves domain names to IP addresses. If session hosts use a custom upstream resolver, configure it in the Firewall Policy. If traffic from the firewall to that resolver is filtered, allow TCP and UDP port 53. |
|DNS proxy     |Azure Firewall can act as a DNS proxy between session hosts and an upstream DNS server. FQDN network rules require DNS proxy. Configure the workload virtual network to use the firewall private IP address as its DNS server so clients and the firewall receive consistent DNS responses. |

## Select controls for each traffic requirement

Use the traffic requirement to choose a route or rule type. The following table summarizes the controls that you'll configure in the exercises:

| Traffic requirement | Control | Traffic path |
| --- | --- | --- |
| Gateway, broker, and relayed RDP traffic | `WindowsVirtualDesktop` service-tag route | Direct to the service |
| Required HTTPS and certificate endpoints | Application rules | Through Azure Firewall |
| Windows activation | FQDN network rule with DNS proxy | Through Azure Firewall |
| Other outbound traffic | Default deny | Blocked |

## Deployment steps for Azure Firewall

In the previous exercise, you created a host pool and virtual network with a subnet. You deployed a session host VM into that subnet and registered it with the host pool. In the next exercises, you'll complete the following steps to deploy Azure Firewall to protect the host pool.

1. Set up the network:

    - Create a hub virtual network that includes a subnet for the firewall deployment.
    - Peer the hub and spoke networks. In the next exercise, you'll peer the hub virtual network with the virtual network used by the host pool of Azure Virtual Desktop.

1. Deploy Azure Firewall:

    - Deploy Azure Firewall with a Firewall Policy to a subnet in the hub virtual network.
    - Enable DNS proxy and configure the host-pool virtual network to use the firewall private IP address as its DNS server.
    - Create a default route that sends traffic without a more specific route to the firewall's private IP address.
    - Create a `WindowsVirtualDesktop` service-tag route with **Internet** as the next hop so gateway and broker traffic bypasses the firewall.

1. Create Azure Firewall rules:

    - Configure the firewall with rules to filter outbound session-host traffic.
