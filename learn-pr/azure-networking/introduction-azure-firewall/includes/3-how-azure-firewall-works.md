You're familiar with the basic features of both Azure Firewall and Azure Firewall Manager. Now let's examine how these technologies work to provide security for your Azure resources. This information will help you evaluate whether Azure Firewall is the right tool for Contoso's network security strategy.

## How Azure Firewall protects an Azure virtual network

To understand how Azure Firewall protects your virtual network, know that there are two key characteristics to any Azure Firewall deployment:

- The firewall instance has a public IP address to which all inbound traffic is sent.
- The firewall instance has a private IP address to which all outbound traffic is sent.

That is, all traffic—inbound and outbound—goes through the firewall. By default, the firewall denies access to everything. Your job is to configure the firewall with the conditions under which traffic is allowed through the firewall. Each condition is called a *rule* and each rule applies one or more checks on the data. Only traffic that passes every check in all the firewall's rules is allowed to pass through.

How Azure Firewall manages network traffic depends on where the traffic originates:

- For allowed inbound traffic, Azure Firewall uses DNAT to translate the firewall's public IP address to the private IP address of the appropriate destination resource in the virtual network.
- For allowed outbound traffic, Azure Firewall uses SNAT to translate the source IP address to the firewall's public IP address.

> [!NOTE]
> Azure Firewall uses SNAT only when the destination IP address is outside your virtual network. If the destination IP address is from your virtual network's private address space, Azure Firewall doesn't use SNAT on the traffic.

## Where Azure Firewall fits into a virtual network

For Azure Firewall to do its job effectively, you must set it up as a barrier between a trusted network you want to protect and an untrusted network that offers potential threats. Most commonly, you deploy Azure Firewall as a barrier between your Azure virtual network and the internet.

Azure Firewall is best deployed using a *hub and spoke* network topology with the following characteristics:

- A virtual network that acts as the central connectivity point. This network is the *hub virtual network*.
- One or more virtual networks that are peered to the hub. These peers are the *spoke virtual networks* and are used to provision workload servers.

You deploy the firewall instance in a subnet of the hub virtual network and then configure all inbound and outbound traffic to go through the firewall.

Use the following general steps to set up an instance of Azure Firewall:

1. Create a hub virtual network that includes a subnet for the firewall deployment.
1. Create the spoke virtual networks and their subnets and servers.
1. Peer the hub and spoke networks.
1. Deploy the firewall to the hub's subnet.
1. For outbound traffic, create a default route that sends traffic from all subnets to the firewall's private IP address.
1. Configure the firewall with rules to filter inbound and outbound traffic.

## Azure Firewall rule types

The following table describes the three types of rules you can create for an Azure firewall.

|Rule type  |Description  |
|---------|---------|
|NAT     |Translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number. For example, to enable a remote desktop connection to a virtual machine, you might use a NAT rule to translate your firewall's public IP address and port **3389** to the private IP address of the virtual machine.        |
|Application     |Filter traffic based on an FQDN. For example, you might use an application rule to allow outbound traffic to access an Azure SQL Database instance using the FQDN *server10.database.windows.net*.         |
|Network     |Filter traffic based on one or more of the following three network parameters: IP address, port, and protocol. For example, you might use a network rule to allow outbound traffic to access a particular DNS server at a specified IP address using port **53**.  |

:::image type="content" source="../media/3-firewall-operation.png" alt-text="Network diagram of an external computer requesting a remote desktop connection with a virtual machine and Azure Firewall translating its public IP address to the virtual machine's private IP address.":::

> [!IMPORTANT]
> Azure Firewall applies rules in priority order. Rules based on threat intelligence are always given the highest priority and are processed first. After that, rules are applied by type: NAT rules, then network rules, then application rules. Within each type, rules are processed according to the priority values you assign when you create the rule, from lowest value to highest value.

## Azure Firewall deployment options

Azure Firewall offers many features designed to make it easier to create and manage rules. The following table summarizes these features.

|Feature  |Description  |
|---------|---------|
|FQDN     |A domain name of a host, or one or more IP addresses. Adding an FQDN to an application rule allows access to that domain. When you use an FQDN in an application rule, you can use wild cards, such as *.google.com.        |
|FQDN tag     |A group of well-known Microsoft FQDNs. Adding an FQDN tag to an application rule allows outbound access to the tag's FQDNs. There are FQDN tags for Windows Update, Windows Virtual Desktop, Windows diagnostics, Azure Backup, and more. FQDN tags are managed by Microsoft and can't be modified or created.       |
|Service tag     |A group of IP address prefixes related to a specific Azure service. Adding a service tag to a network rule allows access to the service represented by the tag. There are service tags for dozens of Azure services, including Azure Backup, Azure Cosmos DB, Logic Apps, and more. Service tags are managed by Microsoft and can't be modified or created.        |
|IP groups     |A group of IP addresses, such as 10.2.0.0/16 or 10.1.0.0-10.1.0.31. You can use an IP group as the source address in a NAT or application rule, or as the source or destination address in a network rule.        |
|Custom DNS     |A custom DNS server that resolves domain names to IP addresses. If you use a custom DNS server rather than Azure DNS, you must also configure Azure Firewall as a DNS proxy.        |
|DNS proxy     |You can configure Azure Firewall to act as a DNS proxy, which means that all client DNS requests go through the firewall before going to the DNS server.        |
