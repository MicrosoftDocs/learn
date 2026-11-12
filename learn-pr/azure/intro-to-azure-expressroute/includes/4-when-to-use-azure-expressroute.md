Azure ExpressRoute can meet Adatum's needs when the connection is sized and designed for its workloads:

- **More predictable performance**: Private connectivity can reduce the variability associated with typical internet paths. Measure latency and throughput with Adatum's video-processing and file-transfer workloads rather than assuming that every operation will be faster.
- **Capacity for large transfers**: Select circuit bandwidth and gateway capacity that support the workload, including when a redundant connection is unavailable. Endpoint performance and application behavior also affect the achievable transfer rate.
- **Resilient connectivity**: Use the appropriate peering-location, provider, and gateway redundancy. The applicable SLA depends on the configuration and doesn't guarantee uninterrupted access to every application.
- **Private transport**: ExpressRoute keeps the traffic it carries off the public internet. Continue to use encryption and access controls for sensitive imagery.

## Connect Adatum's Azure file shares

For Adatum's SMB Azure file shares, create a private endpoint for the storage account's `file` service in a VNet reachable through ExpressRoute private peering. In Azure public cloud, integrate the endpoint with a private DNS zone named `privatelink.file.core.windows.net` and ensure that the zone contains an A record for the storage account that points to the private endpoint's address.

> [!IMPORTANT]
> For private-endpoint connectivity through an ExpressRoute gateway, enable private endpoint network policies for route tables on the subnet containing the private endpoint. If you also enable NSG policy support, review the applicable rules to allow the required SMB traffic. This setting affects all private endpoints in that subnet.
>
> The private-endpoint subnet is separate from GatewaySubnet. Don't associate an NSG with GatewaySubnet. Enabling route-table policy support doesn't, by itself, require adding a user-defined route or routing traffic through a network virtual appliance.

Link this private DNS zone to the VNet containing the Azure DNS Private Resolver or DNS forwarder that handles on-premises queries. On the on-premises DNS servers, conditionally forward the file service's public namespace, `file.core.windows.net`, to the resolver's inbound endpoint or the Azure-hosted DNS forwarder. Forward the normal service namespace, not just the `privatelink` namespace. If you use an Azure-hosted DNS forwarder, configure it to forward these queries to Azure-provided DNS at `168.63.129.16`. Don't point on-premises DNS servers directly at this internal Azure address.

Clients continue to use the normal host name, `<storage-account-name>.file.core.windows.net`. From an on-premises client, confirm that this name resolves to the private endpoint's IP address before attempting to mount the share.

The conditional forwarder affects every query for file.core.windows.net that uses these DNS servers. Before rolling it out, test other storage-account names your users need. An account with a private endpoint elsewhere can return a nonexistent-domain response if its name points into your linked private DNS zone but that zone doesn't contain its record.

For private-only access, arrange the required private endpoint and private DNS records, with the resource owner's approval where needed. Where policy permits public-endpoint access, Azure Private DNS fallback can resolve otherwise missing Private Link names through public DNS. That fallback changes name resolution only. It doesn't create a private connection or guarantee that application traffic uses ExpressRoute. Keep Adatum's own file-share name resolving to its private endpoint.

For SMB access, allow TCP port 445 along the private path and retain appropriate SMB encryption, authentication, and authorization. ExpressRoute doesn't supply those controls for the file share.

Size Adatum's connection for its private-endpoint traffic, not just for the circuit bandwidth or general gateway performance figures. Through an ExpressRoute gateway, throughput and control-plane capacity for private-endpoint connectivity might be reduced by half compared with connectivity to other resources. Measure representative SMB transfers before choosing capacity. If you choose ErGwScale for a workload that includes Private Link traffic, use fixed scaling by setting the same minimum and maximum scale-unit values, rather than autoscaling.

Private-endpoint connectivity through the gateway is stateful. During normal operation, keep packets from each flow on the same Microsoft edge-router next hop rather than repeatedly switching that flow between next hops. Gateway maintenance and SKU upgrades can still cause brief interruptions. Plan for client reconnection and confirm how Adatum's applications recover or resume interrupted file transfers.

Check packet sizes as well as bandwidth when testing Adatum's file transfers. For traffic through an ExpressRoute gateway, Microsoft documents a maximum TCP/UDP packet size of 1,400 bytes, and the gateway doesn't support fragmented packets. Plan the path maximum transmission unit (MTU) and TCP maximum segment size (MSS) for the actual connection. IPsec adds packet overhead, so an encrypted design can need a smaller MSS. Don't assume that increasing a VM's MTU will improve transfers.

FastPath isn't an automatic workaround for the file-share path. FastPath connectivity to private endpoints requires an eligible ExpressRoute Direct configuration and enrollment. Private-endpoint traffic on provider-based circuits still traverses the gateway. Confirm feature eligibility before assuming that gateway limits can be bypassed.

Creating a private endpoint doesn't disable the service's public endpoint. For Adatum's SMB shares hosted in a storage account, disable public network access after confirming that the required clients can connect privately. Also review existing trusted-service and resource-instance exceptions, because these can remain effective after public access is disabled. If access must be exclusively through private endpoints, assess dependent services and remove exceptions that conflict with that policy.

When public-endpoint access is permitted, supported Azure Files SMB and FileREST traffic can alternatively use Microsoft peering. This isn't a private-endpoint connection, and the public endpoint doesn't become reachable through private peering just because an ExpressRoute circuit exists.

## Choose reach, capacity, and cost

An ExpressRoute peering location is the physical location where your connection enters Microsoft's network. It isn't the Azure region hosting Adatum's virtual machines or file shares. The circuit resource's Region setting identifies the Azure Network Resource Provider location, not the physical peering site.

Choose a provider and peering location that support connectivity to the workload regions required by your circuit SKU. For Local, confirm the specific Azure regions mapped to that peering location before ordering connectivity.

The following table compares the geographic reach of ExpressRoute circuit SKUs.

| Circuit SKU | Geographic reach |
| --- | --- |
| Local | The specific nearby Azure region or regions associated with the selected peering location |
| Standard | Azure regions in the same geopolitical region |
| Premium | Extended connectivity across geopolitical regions, subject to cloud boundaries |

Premium doesn't bridge Microsoft's separate national clouds. A circuit SKU also isn't the same thing as its bandwidth, gateway SKU, or resiliency architecture.

Premium also increases routing and connection capacity. For private peering, Local and Standard circuits accept up to 4,000 on-premises IPv4 route prefixes, while Premium increases this limit to 10,000. Premium also increases the number of virtual network connections allowed on a circuit, with the limit depending on circuit bandwidth.

Plan route counts as well as bandwidth. Exceeding an advertised-prefix limit can disconnect BGP sessions. The private-peering IPv4 limits aren't Microsoft-peering limits, IPv6 limits, gateway capacity limits, or limits on routes advertised from Azure to on-premises. Buying more bandwidth doesn't by itself increase all these limits.

Budget for provider connectivity, the ExpressRoute circuit or Direct ports, gateways where required, and applicable feature and Azure service charges. Metered plans charge for outbound data transfer. Unlimited plans include ExpressRoute data transfer, but additional Azure service and Global Reach charges can still apply. Circuit bandwidth is shared across its peerings and connected workloads.

ExpressRoute Local includes ExpressRoute data transfer in its port charge. It can be economical for Adatum's large video transfers if the required Azure regions are among the regions served by the selected Local peering location. Compare the available bandwidth options and total cost, not just geographic reach. Included ExpressRoute transfer doesn't remove provider, gateway, or applicable Azure service charges.

Provider-based circuits offer bandwidths of 50, 100, 200, or 500 Mbps and 1, 2, 5, or 10 Gbps, subject to provider and location availability. Provider-based Local circuits start at 1 Gbps. These circuit bandwidths aren't the same as the physical port speeds offered by ExpressRoute Direct.

Circuit bandwidth is full duplex on each redundant connection. For example, a 1-Gbps circuit provides up to 1 Gbps in each direction on each connection. Size the normal workload to fit within one connection's capacity when the other connection is unavailable. Don't treat the combined capacity of both connections as guaranteed sustained bandwidth.

Plan for growth and changes before ordering a circuit. Increasing bandwidth depends on available port capacity, and your provider must support the higher rate. Reducing circuit bandwidth requires a replacement circuit. You can change a circuit from Metered Data to Unlimited Data, but you can't change that circuit back to Metered Data. Allow for provider provisioning, possible interruption, and applicable charges when a replacement circuit is needed.

> [!IMPORTANT]
> For a provider-based circuit, Azure billing starts when the service key is issued, even if the provider hasn't finished provisioning connectivity. Coordinate circuit creation with the provider's readiness. When retiring a circuit, remove its associated connections and other dependent resources, have the provider deprovision it, and then delete the circuit in Azure. Provider deprovisioning alone doesn't stop the Azure circuit charge. ExpressRoute Direct port pairs have a separate billing lifecycle.

## When to use Azure VPN Gateway

Smaller sites with moderate bandwidth requirements can use an internet-based site-to-site VPN instead of dedicated ExpressRoute connectivity. Individual remote users can use point-to-site VPN connections from their computers to Azure.

Adatum can also retain an appropriately configured internet-based site-to-site VPN as a backup for private-peering access to its VNets. This requires a compatible route-based VPN gateway, the ExpressRoute gateway, suitable routing, and enough backup capacity. For matching prefixes, Azure normally prefers ExpressRoute, but a more-specific route takes precedence. Configure the on-premises routing accordingly and test failover.

Before retaining an existing site-to-site VPN alongside ExpressRoute, confirm that GatewaySubnet is /27 or larger and that the VPN gateway supports coexistence. Use a route-based VPN gateway other than the Basic SKU. If the existing gateway subnet is too small, plan the required gateway and subnet changes, including possible connectivity downtime, before adding ExpressRoute.

> [!IMPORTANT]
> This VPN backup applies to VNet connectivity through private peering, not to Microsoft peering services. Keep the backup tunnel's transport independent of ExpressRoute. An IPsec tunnel carried over ExpressRoute adds encryption but isn't an independent backup if the circuit fails. An internet-based VPN backup also uses the public internet, so it might not satisfy a requirement that data never traverse the internet, even when encrypted.
>
> Microsoft doesn't recommend site-to-site VPN as the ExpressRoute backup for latency-sensitive, mission-critical, or bandwidth-intensive workloads. For Adatum, prefer multi-site ExpressRoute resilience when large-video transfers must continue to meet normal service requirements during an outage.
>
> If you retain VPN for reduced service during an outage, define which traffic it must carry and assess its throughput, latency, and availability. Keep the backup monitored and maintained. Failover tests can interrupt production traffic, so perform them during a planned maintenance window.
