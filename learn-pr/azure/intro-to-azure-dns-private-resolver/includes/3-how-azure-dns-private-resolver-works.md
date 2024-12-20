If you run workloads in Azure platform as a service with private endpoint, or infrastructure as a service workloads with Azure-provided DNS, these workloads use Azure Private DNS zones for name resolution within Azure. In hybrid environments, when an on-premises network is required to connect these workloads through FQDN/domain name, it requires that you're able to resolve names hosted in Azure Private DNS zones.

An Azure DNS Private Resolver deployed in a virtual network handles name resolution queries from on-premises to Azure and vice versa.

You should be aware of its capabilities, and the list of components that are part of Azure DNS Private Resolver.

### Conditional forwarding to on-premises DNS or external DNS servers via outbound endpoints of Azure DNS Private Resolver

Create DNS forwarding rules to conditionally forward DNS queries, similar to how on-premises DNS forwarding works. This is a managed service that enables hybrid name resolution, used for conditional forwarding from Azure to on-premises and other target DNS servers.

### Resolve Azure Private DNS zone records with inbound endpoints

Name resolution queries for Azure workloads from on-premises networks can be conditionally forwarded to Azure DNS Private Resolver inbound endpoints. Inbound endpoints let you perform name resolution of workloads registered in Azure Private DNS zones from on-premises.

### Inbound endpoints

Azure DNS Private Resolver inbound endpoints can resolve name resolution requests from Azure and on-premises networks.

The Azure DNS Private Resolver inbound endpoint has a private IP address that's part of a subnet in the virtual network where the endpoint is created. The IP address of the DNS private resolver inbound endpoint can be configured as a DNS server on the on-premises network so that VMs from on-premises can resolve Azure private zones. When a name resolution request (from on-premises) is received by the inbound endpoint, Azure DNS Private Resolver can resolve the name from Azure Private DNS zones linked to the VNet where resolver is deployed or from the public internet DNS namespace.

### Outbound endpoints

Azure DNS Private Resolver outbound endpoints conditionally forward DNS queries to on-premises or other target DNS servers.

If an Azure VM needs to perform name resolution for specific domains or FQDNs that exist in on-premises or on other cloud providers or in an external DNS server, the private resolver conditionally forwards the request through its outbound endpoint. The outbound endpoint uses *forwarding rulesets* to forward the traffic to specific target DNS servers.

### Forwarding ruleset

A forwarding ruleset is a group of forwarding rules.

Forwarding rulesets are one or more forwarding rules that are applied to outbound endpoints and can be linked to virtual networks. The virtual networks that are linked to the forwarding ruleset use the configured forwarding rules to send matching DNS queries to the specified target DNS servers.

### Forwarding rules

A forwarding rule consists of a specified domain and one or more target DNS server IP addresses.

Forwarding rules are used for conditional forwarding DNS queries for a domain to the target DNS servers. In addition to the domain name and target DNS server IP addresses, you can also specify the port (ex: 53) to forward name resolution traffic.

## How those features work together

In a hybrid environment, name resolution from on-premises is sent to an Azure DNS Private Resolver inbound endpoint IP address. The inbound endpoint resolves the name from Azure Private DNS zones linked to the Virtual network where resolver is deployed or from public internet DNS namespace, if no matching record is found.

When name resolution from Azure to on-premises, to other clouds, or to an external DNS is required, the Azure DNS Private Resolver outbound endpoint can conditionally forward these requests to target DNS servers by using a forwarding ruleset.

The DNS forwarding ruleset contains one or more DNS forwarding rules.