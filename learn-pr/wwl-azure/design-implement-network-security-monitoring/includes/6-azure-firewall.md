

[Azure Firewall](/azure/firewall/overview) is a managed, cloud-based network security service that protects your Azure virtual network resources. Azure firewall has built-in high availability and unrestricted cloud scalability. Azure Firewall works not only for traffic to and from the internet, but also internally. Internal traffic filtering includes spoke-to-spoke traffic and hybrid cloud traffic between your on-premises network and your Azure virtual network.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=84af3f87-d43d-42bd-b794-7bcb658abf81]

## When to use Azure Firewall 

Azure Firewall has three [SKUs](/azure/firewall/choose-firewall-sku): Azure Firewall Basic, Azure Firewall Standard, and Azure Firewall Premium. All versions can help you in these scenarios. 

- You want to protect your network against infiltration.
- You want to protect your network against user error.
- Your business includes e-commerce or credit card payments.
- You want to configure spoke-to-spoke connectivity.
- You want to monitor incoming and outgoing traffic.

## What are Azure Firewall rules?

 An Azure Firewall denies all traffic by default, until rules are manually configured to allow traffic. Rules are organized inside Rule Collections which are contained in Rule Collection Groups. In the Azure Firewall, you can configure NAT rules, network rules, and applications rules.

| Rule type	| Description |
| --- | --- |
| NAT| Translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number. For example, to enable a remote desktop connection to a virtual machine, you might use a NAT rule to translate your firewall's public IP address and port 3389 to the private IP address of the virtual machine.
| Application| Filter traffic based on an FQDN. For example, you might use an application rule to allow outbound traffic to access an Azure SQL Database instance using the FQDN server10.database.windows.net. |
| Network | Filter traffic based on one or more of the following three network parameters: IP address, port, and protocol. For example, you might use a network rule to allow outbound traffic to access a particular DNS server at a specified IP address using port 53. |

Azure Firewall applies rules in priority order. Rules based on threat intelligence are always given the highest priority and are processed first. After that, rules are applied by type: NAT rules, then network rules, then application rules. Within each type, rules are processed according to the priority values you assign when you create the rule, from lowest value to highest value.


> [!TIP]
> Learn more about Azure Firewall in the [Introduction to Azure Firewall](/training/modules/introduction-azure-firewall/) module.