

Private DNS zones are typically hosted in the same Azure subscription where the hub VNet is deployed. This central hosting practice is recommended for cross-premises DNS name resolution. In most cases, only networking and identity administrators have permissions to manage DNS records in these zones.

## Azure Private Endpoint DNS configuration

This diagram shows a typical high-level architecture for enterprise environments with central Domain Name Service (DNS) resolution. The name resolution for Private Link resources is done through Azure Private DNS.

:::image type="content" source="../media/private-link-example-central-dns-73e26cad.png" alt-text="Diagram of high-level workflow of enterprise environments with central DNS resolution.":::

In the previous diagram, it's important to highlight:

 -  On-premises DNS servers have conditional forwarders configured for each Private Endpoint. 
 -  The DNS servers in the hub VNet use the Azure-provided DNS resolver as a forwarder.
 -  All Azure VNets have the DNS forwarders configured as the primary and secondary DNS servers.
 -  DNS records follow the lifecycle of the Private Endpoint.

## Significance of IP address 168.63.129.16

IP address 168.63.129.16 is a virtual public IP address that facilitates a communication channel to Azure platform resources. 

- Enables the VM Agent to communicate with the Azure platform to signal that it is in a "Ready" state.
- Enables communication with the DNS virtual server to provide filtered name resolution. This filtering ensures customers can resolve only the hostnames of their resources.
- Enables health probes from Azure load balancer to determine the health state of virtual machines. 
- Enables virtual machines to obtain a dynamic IP address from the DHCP service in Azure.
- Enables heartbeat messages for the PaaS role.

## DNS configuration scenarios

The FQDN of the services resolves automatically to a public IP address. To resolve to the private IP address of the Private Endpoint, change your DNS configuration.

DNS is a critical component to make the application work correctly by successfully resolving the Private Endpoint IP address.

Based on your preferences, these scenarios are available with DNS resolution integrated.

 -  [Virtual network workloads without custom DNS server](/azure/private-link/private-endpoint-dns#virtual-network-workloads-without-custom-dns-server).
 -  [On-premises workloads using a DNS forwarder](/azure/private-link/private-endpoint-dns#on-premises-workloads-using-a-dns-forwarder).
 -  [Virtual network and on-premises workloads using a DNS forwarder](/azure/private-link/private-endpoint-dns#virtual-network-and-on-premises-workloads-using-a-dns-forwarder).
 -  [Private DNS zone group](/azure/private-link/private-endpoint-dns#private-dns-zone-group).


### On-premises workloads using a DNS forwarder

For on-premises workloads to resolve the FQDN of a Private Endpoint, use a DNS forwarder to resolve the Azure service public DNS zone in Azure. A DNS forwarder is a virtual machine running on the virtual network linked to the Private DNS Zone. The query must be originated from the virtual network to Azure DNS. A few options for DNS proxies are: Windows running DNS services, Linux running DNS services, Azure Firewall.

This diagram illustrates the DNS resolution sequence from an on-premises network. The configuration uses a DNS forwarder deployed in Azure. The resolution is made by a private DNS zone linked to a virtual network.

:::image type="content" source="../media/on-premises-using-azure-dns-ccdbeaf1.png" alt-text="Diagram illustrating the DNS resolution sequence from an on-premises network using a DNS forwarder deployed in Azure.":::

To configure this scenario, you need:

 -  On-premises network.
 -  Virtual network connected to on-premises.
 -  DNS forwarder deployed in Azure.
 -  Private DNS zones privatelink.database.windows.net with type A record.
 -  Private Endpoint information (FQDN record name and private IP address).




### Virtual network and on-premises workloads using Azure DNS Private Resolver

When you use DNS Private Resolver, you don't need a DNS forwarder VM, and Azure DNS is able to resolve on-premises domain names.

This diagram uses DNS Private Resolver in a hub-spoke network topology. As a best practice, the Azure landing zone design pattern recommends using this type of topology. A hybrid network connection is established by using Azure ExpressRoute and Azure Firewall. This setup provides a secure hybrid network. DNS Private Resolver is deployed in the hub network.

:::image type="content" source="../media/private-resolver.png" alt-text="Diagram illustrating on-premises workloads using Azure DNS Private Resolver.":::

- Review the [DNS Private Resolver solution components](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#dns-private-resolver-solution-components)
- Review the [traffic flow for an on-premises DNS query](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-an-on-premises-dns-query)
- Review the [traffic flow for a VM DNS query](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-a-vm-dns-query)
- Review the [traffic flow for a VM DNS query via DNS Private Resolver](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-a-vm-dns-query-via-dns-private-resolver)
- Review the [traffic flow for a VM DNS query via an on-premises DNS server](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-a-vm-dns-query-via-an-on-premises-dns-server)