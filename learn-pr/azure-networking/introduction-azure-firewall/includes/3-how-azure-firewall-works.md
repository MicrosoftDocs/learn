You're familiar with the basic features of both Azure Firewall and Azure Firewall Manager. Now let's see how these technologies work to provide security for your Azure resources. This information will help you evaluate whether Azure Firewall and Azure Firewall Manager are the right tools for Contoso's network security strategy.

## How Azure Firewall works

How Azure Firewall protects an Azure virtual network

Describe how Azure Firewall works and how Azure Firewall is deployed:

Where Azure Firewall resides in a virtual network

Basic operation

### Azure Firewall rule types

The following table describes the three types of rules you can create for an Azure firewall.

|Rule type  |Description  |
|---------|---------|
|NAT     |Enables you to translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number. For example, to enable a remote desktop connection to a virtual machine, you might use a NAT rule to translate your firewall's public IP address and port 3389 to the private IP address of the virtual machine.        |
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
