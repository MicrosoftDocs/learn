In this module, you hardened Contoso's hybrid connectivity by replacing shared-certificate point-to-site authentication with Microsoft Entra ID and multifactor authentication (MFA), eliminating the blast radius of a leaked credential. You configured custom IPsec/IKE policies using IKEv2 with AES-256-GCM and SHA-256 to secure site-to-site virtual private network (VPN) tunnels from branch offices, then enforced forced tunneling to route remote user internet traffic through Azure Firewall for inspection and logging. Finally, you deployed Microsoft Entra Private Access with application-specific access segments to restrict access to sensitive resources like financial reporting and HR portals, integrating Conditional Access to enforce device compliance and real-time risk signals on every session.

Contoso's remote employees now authenticate using organizational credentials with MFA instead of a shared certificate file. Branch offices use modern cryptographic standards. A compromised VPN session can no longer reach production databases because Private Access enforces per-application authorization and continuous session evaluation. Private Access dramatically reduces the organization's attack surface for remote access.

> [!NOTE]
> Organizations with dedicated bandwidth and latency requirements between on-premises and Azure use Azure ExpressRoute instead of VPN. ExpressRoute provides a private, high-throughput circuit that doesn't traverse the public internet, but it's a connectivity solution rather than a Zero Trust access control—Private Access complements ExpressRoute deployments by enforcing per-application authorization and Conditional Access policies.

Users and branch offices now connect securely, but platform services like Azure SQL Database, Storage accounts, Key Vault, and Azure OpenAI still expose public endpoints. In the next module, you eliminate that exposure using private endpoints and Azure Policy enforcement to ensure sensitive data never touches the public internet.

## Learn more

- [Azure VPN Gateway overview](/azure/vpn-gateway/vpn-gateway-about-vpngateways)
- [Configure P2S VPN—Microsoft Entra ID authentication](/azure/vpn-gateway/openvpn-azure-ad-tenant)
- [Custom IPsec/IKE policy for S2S VPN](/azure/vpn-gateway/ipsec-ike-policy-howto)
- [Microsoft Entra Private Access overview](/entra/global-secure-access/concept-private-access)
- [Global Secure Access Private Network Connector](/entra/global-secure-access/concept-connectors)
