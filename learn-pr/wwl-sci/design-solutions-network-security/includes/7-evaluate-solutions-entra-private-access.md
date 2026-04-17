Microsoft Entra Private Access is the Zero Trust Network Access (ZTNA) component of Microsoft's Security Service Edge (SSE) solution. Where traditional VPNs grant broad network-level access once a tunnel is established, Private Access restricts connectivity to only the specific FQDNs, IP addresses, and ports you define. Each connection is brokered through the Global Secure Access service, which evaluates identity, device compliance, and Conditional Access policies before allowing traffic to reach the private resource.

This identity-centric model means users never sit directly on the corporate network. The Global Secure Access client on their device tunnels only the traffic you explicitly configure, and the service enforces access controls at every connection. As a security architect, you evaluate Private Access to determine how it replaces or complements your existing VPN infrastructure while improving segmentation and reducing lateral movement risk.

## Understand the connector architecture

Private Access relies on **private network connectors**—lightweight agents installed on Windows Server machines inside your network. Connectors create outbound-only connections to the Global Secure Access cloud service. Because traffic initiates outbound, you don't need to open inbound firewall ports or expose internal resources to the internet.

You organize connectors into **connector groups**, and each Private Access application maps to a specific connector group. This design supports several architectural patterns:

- **Geographic distribution.** Place connectors close to application servers in each region to minimize latency. The connector communicates locally with the resource and outbound to the cloud service.
- **Application isolation.** Assign different applications to different connector groups so that a compromise in one group doesn't expose resources served by another.
- **High availability.** Deploy at least two connectors per group. The service load-balances traffic across active connectors and fails over automatically if one becomes unavailable.

Connectors require Windows Server 2016 or later, .NET 4.7.2+, TLS 1.2 enabled, and outbound access on ports 80 and 443. Microsoft recommends 4 CPU cores and 8 GB of RAM per connector, with capacity for approximately 2,000 requests per second under standard web traffic. Connectors are available through the Microsoft Entra admin center and also through the Azure, AWS, and GCP marketplaces for simplified VM deployment.

## Choose between Quick Access and per-app access

Private Access offers two application models. Your choice between them shapes the granularity of access control and the complexity of your deployment.

**Quick Access** is a single enterprise application that serves as the primary container for all private resources you want to tunnel through the service. You add FQDNs, IP addresses, and IP ranges as application segments, each with specific ports and protocols. Quick Access is the fastest path to replacing a VPN—one application, one connector group, one set of user assignments.

> [!NOTE]
> Microsoft recommends using Quick Access as a transition step in your Zero Trust journey. After it replaces your VPN, migrate to per-app access to achieve application-level segmentation and granular controls.

**Per-app access** uses individual Global Secure Access enterprise applications, each containing its own set of application segments and mapped to its own connector group. This model enables you to:

- Apply different Conditional Access policies to different applications. For example, require multifactor authentication for RDP access to servers but allow SSO-only access to an internal web application.
- Assign different user groups to different applications, enforcing least-privilege access.
- Isolate sensitive applications behind dedicated connector groups with stricter network controls.

When application segments overlap between Quick Access and a per-app enterprise application, the enterprise application takes priority. This allows you to gradually carve out specific applications from Quick Access into their own per-app configurations without disrupting other users.

Each Quick Access or per-app application supports up to 500 application segments. Segments can use IP addresses, CIDR ranges, IP-to-IP ranges, or FQDNs (including wildcard FQDNs in the format `*.contoso.com`).

## Enable private DNS and single sign-on

Two features extend Private Access beyond basic tunnel replacement: private DNS and Kerberos-based single sign-on (SSO).

**Private DNS** lets users access internal resources by short name or internal FQDN without configuring each resource individually. You add DNS suffixes to the Quick Access configuration, and the Global Secure Access client routes DNS queries for those suffixes through the service to your internal DNS servers. This is essential for environments where users access resources like `https://benefits` or `https://intranet.corp.contoso.com` that aren't resolvable through public DNS.

**Kerberos SSO** provides a seamless authentication experience for on-premises resources. For Microsoft Entra ID-joined devices using password-based authentication, Kerberos SSO works without extra configuration—the device uses the user's UPN and password synced through Microsoft Entra Connect to request Kerberos tickets. For devices using Windows Hello for Business, you deploy Hybrid Cloud Kerberos Trust so the device can exchange a partial Ticket-Granting Ticket (TGT) from Microsoft Entra ID for a full TGT from an on-premises domain controller.

To support Kerberos SSO, publish your domain controllers as application segments with the required ports (Kerberos on 88, LDAP on 389/636, SMB on 445, and ephemeral ports for RPC). Only publish domain controllers in the Active Directory sites where your Private Access connectors are installed.

## Apply Conditional Access to private resources

Every Quick Access and per-app enterprise application integrates with Microsoft Entra Conditional Access. You create Conditional Access policies that target the specific application and enforce conditions such as:

- **Multifactor authentication** for accessing sensitive internal applications.
- **Device compliance** to ensure only managed devices reach private resources.
- **Hybrid join requirements** to restrict access to domain-joined or Microsoft Entra hybrid-joined devices.
- **Risk-based controls** that block access when user or sign-in risk is elevated.

This per-application Conditional Access enforcement is a fundamental advantage over VPN-based access. With a VPN, all users who authenticate receive the same network-level access. With Private Access, each application can have its own policy, and users who don't meet the conditions are denied access to that specific resource without affecting their access to others.

> [!TIP]
> Always exclude emergency access (break-glass) accounts from Conditional Access policies to prevent lockout. Nested groups aren't supported for user assignments—assign users directly or through flat group membership.

## Design recommendations

- **Start with Quick Access** to replace your VPN, then progressively migrate high-value applications to per-app access for application-level segmentation.
- **Deploy at least two connectors per group** and locate them close to the application servers they serve. Monitor CPU and memory utilization and keep sustained utilization under 70%.
- **Enable private DNS** for environments that rely on internal name resolution. Add the top-level DNS suffixes for all Active Directory forests that host synchronized users.
- **Publish domain controllers** as dedicated application segments to support Kerberos SSO and domain operations for remote users.
- **Apply Conditional Access per application** rather than relying on a single broad policy. This achieves true microsegmentation based on identity and device posture.
- **Use report-only mode** when deploying new Conditional Access policies. Validate the policy impact through sign-in logs before enforcing.

