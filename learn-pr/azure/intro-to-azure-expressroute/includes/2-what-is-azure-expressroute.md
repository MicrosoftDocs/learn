Azure ExpressRoute connects an organization's on-premises network to Microsoft cloud services over private connectivity that doesn't traverse the public internet. You can connect through a connectivity provider or use ExpressRoute Direct at a Microsoft peering location. ExpressRoute can provide more consistent performance than typical internet connections, but it doesn't guarantee uninterrupted access, fixed latency, or a particular application transfer rate.

The following diagram illustrates provider-based connectivity and the two peering types.

:::image type="content" source="../images/expressroute-structure.png" alt-text="Diagram that shows redundant ExpressRoute connections carrying Microsoft and Azure private peering traffic.":::

ExpressRoute supports access to Azure virtual machines and other resources reachable through Azure virtual networks. It also supports selected public service endpoints, including Azure Storage, Azure SQL Database, and supported Microsoft 365 and Dynamics 365 endpoints. The required peering depends on whether you use a service's VNet address, private endpoint, or supported public endpoint.

> [!IMPORTANT]
> Microsoft recommends internet connectivity for most Microsoft 365 customers. Using ExpressRoute for Microsoft 365 requires Microsoft authorization, ExpressRoute Premium, and the appropriate Microsoft peering route filters. Only supported endpoints use this path, and internet connectivity is still required for other endpoints and dependencies. These Microsoft 365 requirements don't apply uniformly to Dynamics 365. Supported Dynamics 365 endpoints can use the appropriate Azure regional routes without Premium when the circuit is in the same geopolitical region.

ExpressRoute provides Open Systems Interconnection (OSI) Layer 3 connectivity. It exchanges IP routes by using Border Gateway Protocol (BGP). An on-premises computer can communicate with an Azure VM through its routed VNet IP address. ExpressRoute doesn't extend the on-premises Ethernet broadcast domain to the VM.

ExpressRoute provides redundant connections and an availability SLA subject to the applicable configuration and terms. End-to-end availability also depends on the customer network, provider connectivity, Azure gateways, and workloads.

## ExpressRoute Global Reach

ExpressRoute Global Reach links eligible ExpressRoute circuits so that on-premises networks can exchange traffic over Microsoft's global network. For example, Adatum could connect its Sydney and London networks through their ExpressRoute circuits instead of carrying that intersite traffic over the public internet.

Global Reach requires provisioned Standard or Premium circuits with Azure private peering at different supported peering locations. Local circuits don't support Global Reach. Both circuits need Premium when the connection crosses geopolitical regions, as in the Sydney-to-London example.

You must explicitly configure the Global Reach connection. For an IPv4 connection, reserve a separate, unused /29 subnet for connectivity between the circuits. Don't reuse addresses from the on-premises networks, Azure virtual networks, or peering-interface subnets.

## ExpressRoute connectivity models

There are three provider-based connectivity models and a fourth option, ExpressRoute Direct:

- **Point-to-point Ethernet**: A provider supplies an Ethernet connection between your premises and the Microsoft peering location. The provider can supply a Layer 2 handoff, while BGP provides Layer 3 connectivity to Microsoft cloud resources.
- **Cloud exchange colocation**: A provider supplies a virtual cross-connection from infrastructure at a colocation facility. Providers can offer Layer 2 connectivity or managed Layer 3 connectivity.
- **Any-to-any IPVPN**: A provider integrates Microsoft cloud connectivity into your private WAN, typically as a managed Layer 3 service.
- **ExpressRoute Direct**: You connect directly to Microsoft's network at a peering location by using a dedicated port pair. Direct supports dual 10-Gbps, 100-Gbps, or 400-Gbps ports. The 400-Gbps option is available only at selected locations and requires enrollment. Logical circuits on the port pair have their own configured bandwidth.

The endpoint addresses, configured peerings, and routes determine which traffic uses ExpressRoute. Selecting a connectivity model doesn't automatically route every Azure interaction through the circuit.

:::image type="content" source="../images/expressroute-connectivity-models.png" alt-text="Diagram that shows cloud exchange colocation, point-to-point Ethernet, any-to-any IPVPN, and ExpressRoute Direct.":::

## ExpressRoute security

Private connectivity and encryption solve different problems. ExpressRoute keeps the traffic it carries off the public internet, but it doesn't encrypt that traffic by default. An internet-based site-to-site VPN encrypts its tunnel with IPsec even though the encrypted packets use the internet.

Keep application encryption, such as TLS or SMB encryption, where appropriate. If you need network-layer encryption, you can design an IPsec tunnel over ExpressRoute between your on-premises network and an Azure virtual network. Choose a supported gateway combination and route the traffic that needs protection through the tunnel in both directions. ExpressRoute Direct also supports optional MACsec encryption on the physical links between your equipment and Microsoft's equipment. MACsec doesn't provide end-to-end encryption to the Azure workload.

> [!IMPORTANT]
> For Azure VPN Gateway over ExpressRoute private peering, an established IPsec tunnel doesn't encrypt traffic that takes the direct ExpressRoute path. If the same destination prefixes are advertised over both paths, Azure prefers ExpressRoute without IPsec protection. Use more-specific VPN prefixes or disjoint prefix advertisements for the protected networks, and configure the corresponding on-premises routes to prefer the tunnel. Keep the tunnel endpoints reachable over ExpressRoute.
>
> ErGwScale doesn't currently support IPsec traffic over ExpressRoute. Select a supported gateway design if this encryption method is required. This restriction is separate from using an independent internet-based site-to-site VPN as an ExpressRoute backup.

When you add IPsec over ExpressRoute, size both VPN endpoints and the tunnel configuration for the required encrypted throughput. Increasing the ExpressRoute circuit bandwidth doesn't remove VPN processing limits. Azure VPN Gateway aggregate throughput benchmarks aren't guaranteed throughput for an individual tunnel, and other connections can share the gateway's capacity. For a third-party VPN device, also check the vendor's performance guidance. Measure representative encrypted video transfers before selecting Adatum's design.

ExpressRoute doesn't remove every internet dependency. Public DNS, certificate-validation endpoints, and other service dependencies can still require internet access. Content-delivery endpoints, including Azure Front Door Standard/Premium and CDNs, aren't supported over ExpressRoute Microsoft peering. Private DNS queries can instead use the private connection when you configure a reachable DNS forwarder or Azure DNS Private Resolver inbound endpoint.
