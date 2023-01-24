When you configure a virtual network gateway, you need to specify the type VPN to create. There are two options: route-based or policy-based.

The VPN type you choose depends on the connection topology you want to create. To create a point-to-site (P2S) connection, you would create a route-based VPN. The VPN type can also depend on your hardware. For a site-to-site (S2S) configuration, you need a VPN device. Some VPN devices only support a certain VPN type.

> [!Important]
> After a virtual network gateway is created, you can't change the VPN type.

### Things to know about the VPN gateway type

As we reviewed in the previous section, you select the VPN type on the configuration page to create a new virtual network gateway. Let's review the details about your choices for the VPN gateway type.

- **Route-based VPNs** use *routes* in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces. The tunnel interfaces then encrypt or decrypt the packets in and out of the VPN tunnels. The policy (or traffic selector) for route-based VPNs are configured as any-to-any (or wild cards).

   - Most VPN gateway configurations require a route-based VPN.
   
   - Use a route-based VPN when your virtual network coexists with an Azure ExpressRoute gateway, or if you need to use the IKEv2 protocol.

- **Policy-based VPNs** encrypt and direct packets through IPsec tunnels based on the IPsec policies. The policies are configured with the combinations of address prefixes between your on-premises network and the Azure virtual network. The policy (or traffic selector) is defined as an access list in the VPN device configuration.

   Keep in mind the following limitations about policy-based VPNs:
    
   - A policy-based VPN can be used on the Basic gateway SKU only. The policy-based VPN type isn't compatible with other gateway SKUs.
   
   - When you use a policy-based VPN, you can have only one VPN tunnel.
   
   - You can only use policy-based VPNs for S2S connections, and only for certain configurations.