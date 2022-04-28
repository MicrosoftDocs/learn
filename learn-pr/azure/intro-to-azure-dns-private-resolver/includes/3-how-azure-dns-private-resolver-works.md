## How Azure Private DNS Resolver Works

Assume if you are running workloads in Azure PaaS services with private endpoint, or IaaS workload with Azure provided DNS, these workloads use Azure private DNS zone for name resolution within Azure. In a hybrid environment, when an on-premises network is required to connect these workloads through FQDN/domain name, it requires a name resolution that resolves names hosted in Azure private DNS zone.

The Azure DNS private resolver that is deployed in virtual network acts as a resolver to handle the name resolution queries from on-premises to Azure and vice versa.

You should be aware of its capabilities and the list of components that are part of Azure DNS private resolver:

* Conditional forwarding to on-premises DNS or external DNS servers via outbound endpoints of Azure DNS Private Resolver

This is a managed service that allows hybrid name resolution, used to do conditional forwarding from Azure to on-premises and other target DNS servers.

* Resolve Azure Private DNS Zone records with inbound endpoints

Name resolution queries for Azure workloads from on-premises network are conditionally forwarded to Azure DNS private resolver inbound endpoint, it enables you to perform name resolution of workloads registered on Azure Private DNS Zones from on-premises.

* Inbound Endpoints

Azure DNS private resolver inbound endpoint that receives the name resolution request from Azure & on-premises network and resolve names.

The Azure DNS private resolver inbound endpoint has a private IP that is part of a subnet where the endpoint has been created. The IP address of the DNS private resolver inbound endpoint is then set as a DNS server on the on-premises network. Now, the VMs from on-premises can send the name resolution traffic to the Azure DNS private resolver Inbound endpoint IP address. When a name resolution request (from on-premises) is received by the inbound endpoint, Azure DNS private resolver can resolve the name from Azure Private DNS zones linked to the VNET where resolver is deployed or from public internet DNS namespace.

* Outbound Endpoints

Azure DNS private resolver outbound endpoint conditionally forwards the request to on-premises or other target DNS servers.

When the Azure VM wanted to perform name resolution for specific domain/fqdn that exist in on-premises or on other cloud providers or in an external DNS server, the Azure DNS private resolver conditionally forwards the request through DNS resolver outbound endpoint. The outbound endpoint applies “Forwarding Rulesets” to forward the traffic to the specific target DNS servers.

* Forwarding Ruleset

Ruleset can be understood as a group of forwarding rules.

Forwarding Ruleset is one or more Forwarding Rules which can be applied to outbound endpoints and can be linked to virtual networks. The virtual networks that are linked to the Forwarding Ruleset use the Forwarding Rules to send matching traffic to the target DNS servers.

* Forwarding rules

Contains matching domain with target DNS server IP addresses.

The Forwarding Rules includes one or more target DNS servers that are used for conditional forwarding. The forwarding rules contain domain name, the target DNS server IP, and the port (53) to forward the name resolution traffic.

## How those features work together

In a hybrid environment, name resolution from on-premises is sent to Azure DNS private resolver Inbound Endpoint IP address, it then resolves the name from Azure Private DNS zones linked to the Virtual network where resolver is deployed or from public internet DNS namespace if no matching record found.

When there's a name resolution from Azure to on-premises, other clouds or to an external DNS, the Azure DNS private resolver Outbound Endpoint conditionally forwards that request to target DNS server.

The Outbound Endpoint uses DNS Forwarding Ruleset that comprises one or more DNS Forwarding Rules.