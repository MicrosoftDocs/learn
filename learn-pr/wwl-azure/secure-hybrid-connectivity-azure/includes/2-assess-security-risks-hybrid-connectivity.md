When a virtual private network (VPN) credential is compromised, the attacker doesn't just gain access to a single application—they gain network-level access to everything the tunnel reaches. In Contoso's case, the stolen P2S certificate gave the attacker access to production databases, internal APIs, and management endpoints across multiple VNets. Here, you learn how to identify the specific security risks in VPN gateway configurations so you can assess where your organization is vulnerable.

| Risk category | Primary concern |
|---------------|-----------------|
| Weak authentication | Shared certificates or passwords allow credential reuse and broad access |
| Outdated encryption | IKEv1 and weak IPsec policies expose tunnels to known vulnerabilities |
| Over-broad access | VPN grants network-level access to all resources, not just what the role requires |
| Missing access controls | No per-user or per-app restrictions after tunnel authentication succeeds |

## Understanding the VPN security challenge

Traditional VPN design operates on a perimeter model: if you successfully authenticate to the VPN, you're trusted to access everything inside the network. Azure VPN Gateway extends this model to hybrid connectivity, connecting branch offices through **site-to-site (S2S)** tunnels and remote users through **point-to-site (P2S)** connections to Azure virtual networks.

The architectural problem emerges after the tunnel is established. A connected device or user typically receives network-level access to every resource in the virtual network—databases, internal APIs, management endpoints, and virtual machines. The access scope doesn't match what their role requires—it matches what the network allows.

Compare misconfigured access scope to Zero Trust architecture. VPN grants network access first, then relies on other security controls to limit what authenticated users can reach. Zero Trust grants application access only, verifying identity and device health before allowing access to each specific resource. When a VPN credential is compromised, the attacker inherits the full **blast radius** of that network connection—they can reach everything the tunnel reaches.

> [!NOTE]
> Network access and application access represent fundamentally different security boundaries. VPN provides network access (layer 3), meaning you can reach any IP address in the connected network. Application access provides identity-based access (layer 7), meaning you can reach only the specific applications your identity is authorized to use.

Consider the blast radius in Contoso's scenario. The compromised P2S certificate allowed the attacker to reach production SQL databases, internal web APIs, and Azure Kubernetes Service management endpoints. The attacker reached the resources not because the certificate holder needed access to all of those resources, but because the VPN provided access to the entire virtual network address space.

## Site-to-site VPN security risks

S2S VPN tunnels connect entire branch networks to Azure VNets. Each risk category in S2S configurations affects both the tunnel security and the scope of access granted to the branch network.

**IKEv1 vs. IKEv2** represents the most critical protocol choice. **IKEv1** has known weaknesses including aggressive mode vulnerability, which exposes preshared keys to offline dictionary attacks, and weaker key negotiation that allows downgrade attacks. **IKEv2** is the current Internet Engineering Task Force (IETF) standard and is required for modern encryption profiles. Azure VPN Gateway supports both, but IKEv1 should be disabled unless legacy device compatibility requires it.

**IP Security (IPsec)/Internet Key Exchange (IKE) policy** strength determines tunnel encryption quality. Default IKE settings can use weaker encryption algorithms (3DES, SHA-1) and small Diffie-Hellman (DH) groups (Group 2 = 1024-bit). Organizations should enforce custom policies requiring AES-256, SHA-256 or SHA-384, and DH Group 14 (2048-bit) or higher. Weak policies make the tunnel vulnerable to cryptanalysis, especially as computing power increases.

**Over-broad access** affects every device on the branch network. An S2S tunnel gives the entire branch network access to the Azure virtual network. If 100 employees work at a branch location but only 10 need Azure access for their roles, all 100 have it. The tunnel doesn't distinguish between a developer who needs database access and a sales employee who doesn't.

**No branch network monitoring** limits visibility. Azure monitors traffic crossing the tunnel boundary—connection logs, bytes transferred, tunnel health—but doesn't inspect traffic within the branch network. If a compromised device on the branch network uses the S2S tunnel to exfiltrate data, Azure sees only that traffic crossed the tunnel, not what the traffic contained or which branch device initiated it.

## Point-to-site VPN security risks

P2S VPN connections bring remote users into Azure VNets. The risk categories for P2S differ from S2S because P2S authenticates individual users rather than branch networks, but access control limitations remain.

**Shared certificate authentication** creates the highest risk in P2S deployments. A certificate file (.pfx or .cer) can be copied from the authorized device and installed on any other device. The certificate contains no binding to the specific user or device that received it. A compromised certificate grants VPN access to anyone who possesses it, and certificate revocation lists (CRLs) aren't enforced by default in Azure VPN Gateway P2S configurations.

**Username/password authentication over RADIUS** introduces different risks. If RADIUS is misconfigured or uses weak password policies, brute force attacks become possible. RADIUS authentication also depends on the security of the RADIUS server itself—if the RADIUS server is compromised, all VPN authentication is compromised.

**No multifactor authentication (MFA) by default** means certificate-based P2S relies on a single factor—possession of the certificate. If an attacker steals the certificate file from a user's device or email, no second factor blocks the connection. RADIUS-based authentication can enforce MFA if the RADIUS server supports it, but this requires extra configuration.

**Broad access post-connection** affects every P2S user. A remote employee on P2S VPN receives network access to the same scope as the virtual network allows. A developer's laptop can reach production databases, a contractor's device can reach internal management APIs, and an executive's tablet can reach Azure Kubernetes Service control planes—not because their roles require it, but because the VPN provides it.

**No per-user access control** prevents role-based restrictions. You can't configure "user A reaches only the web tier, user B reaches everything." Everyone using the same P2S configuration receives the same network access. The only way to restrict access is to create multiple VPN Gateways with different virtual network peerings or route tables, which increases cost and complexity.

## Assessing Contoso's configuration

Map Contoso's specific configuration to the risk categories you learned. Each configuration decision creates a security gap that contributed to the incident.

| Configuration | Risk | Severity |
|---------------|------|----------|
| P2S using shared certificate authentication | Certificate compromise grants VPN access to anyone | Critical |
| S2S using IKEv1 with default encryption | Weaker key negotiation and known IKEv1 vulnerabilities | High |
| All employees receive same network access scope | Role-irrelevant access to production databases and APIs | High |
| No MFA on P2S connections | Single-factor authentication for 3,000 remote users | High |
| No per-app access control after authentication | Compromised session reaches all Azure-hosted workloads | Medium |

The critical severity of certificate-based P2S stems from the combination of factors: 3,000 remote users, shared credentials, and broad post-connection access. When the certificate was compromised, the attacker inherited network access to production resources that the certificate holder's role didn't require.

The S2S configuration multiplied risk. IKEv1 made the tunnel vulnerable to known protocol weaknesses, and default encryption policies used SHA-1 and DH Group 2. The branch office network had 200 employees, but only 15 needed Azure access—the other 185 had it anyway.

## Planning a two-tier security response

Addressing these risks requires two distinct security improvements that work together.

**Tier 1: Harden the VPN gateway**. Fix the authentication mechanism by replacing shared certificates with Microsoft Entra ID authentication, enforce IKEv2 for all connections, and configure strong IPsec/IKE policies requiring AES-256, SHA-256, and DH Group 14 or higher. Tier 1 addresses the authentication and encryption weaknesses you identified in the risk assessment.

**Tier 2: Replace broad VPN access with per-app access**. Microsoft Entra Private Access grants users access to specific applications, not the entire network. Instead of connecting to a virtual network and reaching everything in it, users connect directly to authorized applications. Tier 2 addresses the post-connection over-broad access problem that VPN hardening alone can't solve.

Both tiers are needed because they address different security boundaries. Hardening the VPN makes the tunnel more secure and improves authentication quality, but it doesn't limit what authenticated users can reach once the tunnel is established. Per-app access enforces least privilege after authentication by removing network-level access entirely.

Not every organization can immediately replace all VPN access with per-app access. Legacy applications, branch office networks, and external integrations can require VPN connectivity. The two-tier approach lets you harden VPN configurations first and migrate to per-app access incrementally as applications and users are ready.

Now that you understand the specific risk categories in Contoso's VPN configuration, the next step is applying hardening controls—starting with authentication, encryption policy, and forced tunneling.
