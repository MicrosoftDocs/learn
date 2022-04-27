## How Azure Private DNS Resolver Works

Suppose you run all your workloads natively on Azure and register your Virtual Machine DNS records, and Private Endpoint DNS records on Azure Private DNS Zones. You’ll want to connect from on-prem or VPN and for that you need to be able to resolve the names hosted in Azure Private DNS Zones. 

You would provision Azure DNS Private Resolver on an Azure Virtual Network, provision an inbound endpoint, which will have a private IP address from your Virtual Network address space and conditionally forward your queries from on-prem to this IP address. This will enable you to resolve DNS names with a native cloud service.

There are some capabilities you should be aware:

* Conditional forwarding to on-prem DNS or external DNS servers via outbound endpoints of Azure DNS Private Resolver

This is a managed service that allows hybrid name resolution, used to do conditional forwarding from Azure to on-prem and other target DNS servers

* Resolve Azure Private DNS Zone records with inbound endpoints

Conditionally forward from on-prem to the inbound endpoint and resolve names on Azure, enabling you to perform name resolution of workloads registered on Azure Private DNS Zones from on-prem.

* Inbound Endpoints

DNS private resolver’s inbound endpoint that receives the name resolution request from Azure & on-premises network and resolve names.

The Azure DNS private resolver’s inbound endpoint has a private IP that is part of a subnet where the endpoint has been created. The IP address of the DNS private resolver inbound endpoint is then set as a DNS server on the on-premises VMs. Now, these VMs can send the DNS traffic to the private resolver’s Inbound endpoint IP address. When a name resolution request (from on-premises) is received by the inbound endpoint, DNS private resolver can resolve the name from Azure Private DNS zones linked to the VNET where resolver is deployed or from public internet DNS namespace.

* Outbound Endpoints

DNS resolver’s outbound endpoint conditionally forwards the request to on-premises or other target DNS servers.

When the Azure VM wanted to perform name resolution for specific domain/fqdn that exist in on-premises or on other cloud providers or in an external DNS server, the Azure DNS private resolver’s conditionally forwards the request through DNS resolver’s outbound endpoint. The outbound endpoint applies “Forwarding Rulesets” to forward the traffic to the specific target DNS servers.

* Forwarding Ruleset

Ruleset can be understood as a group of forwarding rules.

Forwarding Ruleset is one or more Forwarding Rules which can be applied to outbound endpoints and can be linked to VNETs. The VNETs that are linked to the Forwarding Ruleset use the Forwarding Rules to send matching traffic to the target DNS servers.

* Forwarding rules

Contains matching domain with target DNS server IP addresses.

The Forwarding Rules includes one or more target DNS servers that are used for conditional forwarding. The forwarding rules contain domain name, the target DNS server IP, and the port (53) to forward the name resolution traffic.

## How those features work together

In a hybrid environment, name resolution from on-premises is sent to Azure DNS private resolver’s Inbound Endpoint IP address then resolves the name from Azure Private DNS zones linked to the VNET where resolver is deployed or from public internet DNS namespace.

When there's a name resolution from Azure to on-premises, other clouds or to an external DNS, the Azure DNS private resolver’s Outbound Endpoint conditionally forwards that request to target DNS server.

The Outbound Endpoint uses DNS Forwarding Ruleset that comprises one or more DNS Forwarding Rules.