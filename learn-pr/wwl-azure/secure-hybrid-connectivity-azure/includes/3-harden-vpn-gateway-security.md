Contoso identified four risk categories in its virtual private network (VPN) gateway deployment: shared certificate authentication that exposes the network if compromised. The cause, outdated IKEv1 protocol with weak encryption, over-broad network access once connected, and unmonitored gateway activity. Here, you configure VPN gateway security settings to enforce strong authentication, modern encryption, and controlled traffic routing.

| Hardening control | Security action |
|---|---|
| Authentication | Replace shared certificates with Microsoft Entra ID and Conditional Access |
| Encryption | Enforce custom IPsec/IKE policy with AES-256 and SHA-256 |
| Traffic routing | Enable forced tunneling to route internet traffic through Azure Firewall |
| Monitoring | Configure diagnostic logs to detect authentication failures and tunnel anomalies |

## Change point-to-site authentication from certificates to Microsoft Entra ID

The highest-priority hardening control replaces shared certificate authentication with Microsoft Entra ID authentication, which binds VPN access to specific user identities in your directory.

With certificate-based **point-to-site (P2S)** authentication, Azure VPN Gateway validates a client certificate against a trusted root certificate uploaded to the gateway. Every remote user receives a copy of the same client certificate. If one user's device is compromised and the certificate extracted, an attacker gains VPN access until you revoke and reissue certificates to all users. With Microsoft Entra ID authentication, each user authenticates with their corporate credentials and **multifactor authentication (MFA)**, enforced through Conditional Access policies. Compromising one user's credentials no longer grants network access without also satisfying MFA and device compliance requirements.

To update P2S authentication to Microsoft Entra ID:

1. In the Azure portal, go to your VPN gateway resource and select **Point-to-site configuration**.
2. Set **Tunnel type** to **OpenVPN (SSL)**. Microsoft Entra ID authentication requires OpenVPN; IKEv2 and Secure Sockets Tunneling Protocol (SSTP) don't support Microsoft Entra authentication.
3. Under **Authentication type**, select **Azure Active Directory**. (The portal displays this legacy label, but the service uses Microsoft Entra ID.)
4. Provide the **Tenant ID** from the Microsoft Entra admin center > Overview page.
5. Provide the **Audience** value—this is the application ID of the Azure VPN Client registered in Microsoft Entra ID. For Azure Public Cloud, use the Microsoft-registered Azure VPN Client App ID `c632b3df-fb67-4d84-bdcf-b95ad541b5c8`. This value has global consent preapplied and requires no tenant registration or Cloud Application Administrator role.
6. Select **Save**, then download the updated VPN client configuration and distribute it to users.

After you configure Microsoft Entra ID authentication, Conditional Access policies control VPN sign-in. You can block VPN access from noncompliant devices, require MFA for every connection, or restrict access to users in specific groups—controls that certificate authentication can't enforce.

> [!NOTE]
> Microsoft Entra ID authentication requires VPN gateway SKU VpnGw1 or higher. The Basic SKU supports only certificate-based authentication.

## Configure a custom IPsec/IKE policy

Azure VPN Gateway default policies negotiate **Internet Key Exchange (IKE)** and **IP Security (IPsec)** parameters automatically, which can result in older algorithms like SHA-1, 3DES encryption, or **Diffie-Hellman (DH)** Group 2 (1024-bit key exchange). A **custom IPsec/IKE policy** enforces specific algorithms for every connection.

Contoso's security baseline requires AES-256 encryption, SHA-256 integrity validation, and DH Group 14 (2048-bit) or higher for both IKE Phase 1 (key exchange) and Phase 2 (data encryption). Custom policies apply to **site-to-site (S2S)** and VNet-to-VNet connections. (P2S connections use a different configuration model and inherit encryption from the gateway SKU and tunnel type.)

| Parameter | Default (generation 1 policy) | Recommended |
|---|---|---|
| IKE version | IKEv1 or IKEv2 (negotiated) | IKEv2 only |
| Encryption | 3DES or AES-256 | AES-256 |
| Integrity | SHA-1 or SHA-256 | SHA-256 |
| DH group | Group 2 (1024-bit) | Group 14 (2048-bit) |

To configure a custom IPsec/IKE policy for an S2S connection:

1. In the VPN gateway resource, select **Connections** and open the S2S connection.
2. Select **Configuration**, then under **IPsec/IKE policy**, select **Custom**.
3. Set **IKE version** to **IKEv2**.
4. Set **IKE encryption** to **AES256**, **IKE integrity** to **SHA256**, and **DH group** to **DHGroup14**.
5. Set **IPsec encryption** to **AES256**, **IPsec integrity** to **SHA256**, and **PFS group** to **PFS14**.
6. Set **SA lifetime (seconds)** to **27000** and **SA lifetime (kilobytes)** to **102400000**.
7. Select **Save**.

After you save the policy, the VPN gateway renegotiates the IKE session with the on-premises device. Verify that your on-premises VPN device supports the same algorithms, or the tunnel fails to establish. The custom policy blocks fallback to weaker algorithms, preventing downgrade attacks.

## Enable forced tunneling

**Forced tunneling** routes all internet-bound traffic from connected clients through the VPN tunnel back to Azure, rather than allowing clients to break out directly to the internet while the VPN is active.

Without forced tunneling, a remote user's device establishes a **split tunnel**: corporate resources route through the VPN to Azure, but internet traffic uses the local ISP connection. The split-tunnel configuration bypasses Azure Firewall, preventing Contoso from applying **fully qualified domain name (FQDN)** filtering, threat intelligence blocking, or logging for user internet activity. With forced tunneling, the VPN client uses the tunnel as its default gateway. All traffic—including internet destinations—flows through Azure, where Azure Firewall inspects and logs every connection before allowing egress.

To configure forced tunneling for P2S connections:

1. Verify that **Tunnel type** remains set to **OpenVPN (SSL)**—the setting you configured for Microsoft Entra authentication. Forced tunneling for OpenVPN P2S connections is controlled through the VPN client profile, not through the tunnel type. The downloaded profile includes a 0.0.0.0/0 route that routes all traffic through the VPN tunnel.
2. Download the updated VPN client profile and distribute it to users. The profile configures the client to route all traffic through the VPN.
3. Verify that Azure Firewall (or your egress security appliance) has a default route (0.0.0.0/0) that forwards internet traffic to its next hop.

For S2S connections, forced tunneling requires configuring the on-premises VPN device to advertise a default route (0.0.0.0/0) to Azure over the tunnel. Consult your device documentation for the specific BGP or static route configuration.

> [!IMPORTANT]
> Forced tunneling increases latency and bandwidth consumption on the VPN gateway because all internet traffic traverses the tunnel. Evaluate your gateway SKU and connection capacity before enabling forced tunneling for all users. Use Azure Firewall or a network virtual appliance as the centralized egress point to handle the extra throughput.

## Review gateway logs and diagnostics

Azure VPN Gateway emits diagnostic logs to Azure Monitor that reveal authentication failures, tunnel drops, and IKE negotiation errors. Enable diagnostic logging by configuring diagnostic settings on the VPN gateway resource: select **Diagnostic settings**, add a new setting, and send **GatewayDiagnosticLog**, **TunnelDiagnosticLog**, **RouteDiagnosticLog**, **IKEDiagnosticLog**, and **P2SDiagnosticLog** to a Log Analytics workspace. After hardening the gateway, query **IKEDiagnosticLog** filtered by `OperationName == "IKEPhase1"` to verify that all new connections negotiate IKEv2 with your custom policy parameters. Authentication failures appear in **GatewayDiagnosticLog** and indicate users or devices blocked by Conditional Access or certificate mismatches.

---

Hardening the VPN gateway addresses authentication weaknesses, enforces strong encryption, and routes traffic through centralized security controls. But hardening doesn't change the fundamental problem: once authenticated, users still have network-level access to everything in the virtual network. The next unit explores how Microsoft Entra Private Access replaces broad network access with per-application Zero Trust access.
