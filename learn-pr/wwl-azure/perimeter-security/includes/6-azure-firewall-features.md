**Azure Firewall** is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It’s a fully stateful firewall-as-a-service with built-in high availability and unrestricted cloud scalability. By default, Azure Firewall blocks traffic.

:::image type="content" source="../media/az500-firewall-5e845047.png" alt-text="In this diagram, an azure firewall is in the middle. Bi-directional arrows show communication with two spoke VNets and an on-premises office building. Traffic is flowing between the internet and the firewall, but some traffic is denied.":::


## The Azure firewall features include

 -  **Built-in high availability** \- Because high availability is built in, no additional load balancers are required and there’s nothing you need to configure.
 -  **Unrestricted cloud scalability** \- Azure Firewall can scale up as much as you need, to accommodate changing network traffic flows so you don't need to budget for your peak traffic.
 -  **Application Fully Qualified Domain Name (FQDN) filtering rules** \- You can limit outbound HTTP/S traffic to a specified list of FQDNs, including wild cards. This feature does not require SSL termination.
 -  **Network traffic filtering rules** \- You can centrally create allow or deny network filtering rules by source and destination IP address, port, and protocol. Azure Firewall is fully stateful, so it can distinguish legitimate packets for different types of connections. Rules are enforced and logged across multiple subscriptions and virtual networks.
 -  **Qualified domain tags** \- Fully Qualified Domain Names (FQDN) tags make it easier for you to allow well known Azure service network traffic through your firewall. For example, say you want to allow Windows Update network traffic through your firewall. You create an application rule and include the Windows Update tag. Now network traffic from Windows Update can flow through your firewall.
 -  **Outbound Source Network Address Translation (OSNAT) support** \- All outbound virtual network traffic IP addresses are translated to the Azure Firewall public IP. You can identify and allow traffic originating from your virtual network to remote internet destinations.
 -  **Inbound Destination Network Address Translation (DNAT) support** \- Inbound network traffic to your firewall public IP address is translated and filtered to the private IP addresses on your virtual networks.
 -  **Azure Monitor logging** \- All events are integrated with Azure Monitor, allowing you to archive logs to a storage account, stream events to your Event Hub, or send them to Azure Monitor logs.

Grouping the features above into logical groups reveals that Azure Firewall has three rule types: **NAT rules**, **network rules**, and **application rules**. The application order precedence for the rules are that network rules are applied first, then application rules. Rules are terminating, which means if a match is found in network rules, then application rules are not processed. If there’s no network rule match, and if the packet protocol is HTTP/HTTPS, the packet is then evaluated by the application rules. If no match continues to be found, then the packet is evaluated against the infrastructure rule collection. If there’s still no match, then the packet is denied by default.

## NAT rules

You can configure inbound connectivity by configuring Destination Network Address Translation (DNAT) as described in: Filter inbound traffic with Azure Firewall DNAT using the Azure portal. DNAT rules are applied first. If a match is found, an implicit corresponding network rule to allow the translated traffic is added. You can override this behavior by explicitly adding a network rule collection with deny rules that match the translated traffic. No application rules are applied for these connections.

## Firewall rules to secure Azure Storage

Azure Storage provides a layered security model, which enables you to secure your storage accounts to a specific set of supported networks. When network rules are configured, only applications requesting data from over the specified set of networks can access a storage account.

An application that accesses a storage account when network rules are in effect requires proper authorization on the request. Authorization is supported with Azure AD credentials for blobs and queues, a valid account access key, or a SAS token.

By default, storage accounts accept connections from clients on any network. To limit access to selected networks, you must first change the default action. Making changes to network rules can impact your applications' ability to connect to Azure Storage. Setting the default network rule to Deny blocks all access to the data unless specific network rules that grant access are also applied. Be sure to grant access to any allowed networks using network rules before you change the default rule to deny access.

## Grant access from a virtual network

You can configure storage accounts to allow access only from specific VNets.

You enable a service endpoint for Azure Storage within the VNet. This endpoint gives traffic an optimal route to the Azure Storage service. The identities of the virtual network and the subnet are also transmitted with each request. Administrators can then configure network rules for the storage account that allow requests to be received from specific subnets in the VNet. Clients granted access via these network rules must continue to meet the authorization requirements of the storage account to access the data.

Each storage account supports up to 100 virtual network rules, which could be combined with IP network rules.

Controlling outbound and inbound network access is an important part of an overall network security plan. Network traffic is subjected to the configured firewall rules when you route your network traffic to the firewall as the default gateway.
