When you create the virtual network gateway, you must specify a VPN type. The VPN type that you choose depends on the connection topology that you want to create. For example, a Point-to-Site (P2S) connection requires a Route-based VPN type.

A VPN type can also depend on the hardware that you are using. Site-to-Site (S2S) configurations require a VPN device. Some VPN devices only support a certain VPN type.

:::image type="content" source="../media/gateway-types-528160ca.png" alt-text="Screenshot of the VPN type selection radio buttons.":::


 -  **Route-based VPNs**. Route-based VPNs use *routes* in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces. The tunnel interfaces then encrypt or decrypt the packets in and out of the tunnels. The policy (or traffic selector) for Route-based VPNs are configured as any-to-any (or wild cards).
 -  **Policy-based VPNs**. Policy-based VPNs encrypt and direct packets through IPsec tunnels based on the IPsec policies configured with the combinations of address prefixes between your on-premises network and the Azure VNet. The policy (or traffic selector) is defined as an access list in the VPN device configuration. When using a Policy-based VPN, keep in mind the following limitations:
    
     -  Policy-Based VPNs can only be used on the Basic gateway SKU and is not compatible with other gateway SKUs.
     -  You can have only one tunnel when using a Policy-based VPN.
     -  You can only use Policy-based VPNs for S2S connections, and only for certain configurations. Most VPN Gateway configurations require a Route-based VPN.

> [!NOTE]
> Once a virtual network gateway has been created, you can't change the VPN type.
