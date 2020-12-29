You're familiar with the basic features of both Azure Firewall and Azure Firewall Manager. Now let's see how these technologies work to provide security for your Azure resources. This information will help you evaluate whether Azure Firewall and Azure Firewall Manager are the right tools for Contoso's network security strategy.

## How Azure Firewall works

To help you evaluate Azure Firewall, you need to know the basic of how it operates and how it fits into an Azure virtual network

### How Azure Firewall protects an Azure virtual network

To understand how Azure Firewall protects your virtual network, there are two key characteristics to any Azure Firewall deployment:

* The firewall instance has a public IP address to which all inbound traffic is sent.

* The firewall instance has a private IP address to which all outbound traffic is sent.

### Where Azure Firewall resides in a virtual network

For Azure Firewall to do its job effectively, you must set it up as a barrier between a trusted network you want to protect, and an untrusted network that offers potential threats. In general, you deploy Azure Firewall as a barrier between your Azure virtual network and the Internet.

Azure Firewall is best deployed using a *hub and spoke* network topology with the following characteristics:

* A virtual network that acts as the central connectivity point. This is the *hub virtual network*.

* One or more virtual networks that are peered to the hub. These are the *spoke virtual networks* and are used to provision workload servers.

You deploy the firewall instance in a subnet of the hub virtual network and then configure all inbound and outbound traffic to go through the firewall.

From a practical viewpoint, you follow these general steps to set up an instance of Azure Firewall:

1. Create a hub virtual network that includes a subnet for the firewall deployment.
1. Create the spoke virtual networks and their subnets and servers.
1. Peer the hub and spoke networks.
1. Deploy the firewall to the hub's subnet.
1. For outbound traffic, create a default route that sends traffic from all subnets to the firewall's private IP address.
1. Configure the firewall with rules to filter inbound and outbound traffic.

### Azure Firewall rule types

The following table describes the three types of rules you can create for an Azure firewall.

|Rule type  |Description  |
|---------|---------|
|NAT     |Enables you to translate and filter inbound Internet traffic based on your firewall's public IP address and a specified port number. For example, to enable a remote desktop connection to a virtual machine, you might use a NAT rule to translate your firewall's public IP address and port 3389 to the private IP address of the virtual machine.        |
|Application     |Enables you to filter traffic based on an FQDN. For example, you might use an application rule to allow outbound traffic to access an Azure SQL Database instance using the FQDN *server10.database.windows.net*.         |
|Network     |Enables you to filter traffic based on one or more of the following three network parameters: IP address, port, and protocol. For example, you might use a network rule to allow outbound traffic to access a particular DNS server at a specified IP address using port 53.

> [!IMPORTANT]
> Azure Firewall applies rules in priority order. Rules based on threat intelligence are always given the highest priority and are processed first. After that, rules are applied by type: NAT rules, then network rules, then application rules. Within each type, rules are processed according to the priority values you assign when you create the rule, from lowest to highest.

### Azure Firewall deployment options

FQDNs

IP groups

FQDN tags and service tags

Threat intelligence

Forced tunneling

Custom DNS servers

Azure Firewall as a DNS proxy

## How Azure Firewall Manager works

### Architecture options

### Firewall policy

How to manage multiple firewalls using Firewall policy
