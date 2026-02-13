Microsoft Entra Internet Access is one of two components of Microsoft's Security Service Edge (SSE) solution, collectively called Global Secure Access. Where traditional secure web gateways rely on network topology to enforce policy, Internet Access ties enforcement directly to identity. This identity-centric approach means the same filtering and access controls follow users whether they work from the office, from home, or from a branch location.

Internet Access operates through two traffic forwarding profiles. The **Internet access profile** routes general internet and SaaS traffic through the service for web content filtering and threat protection. The **Microsoft traffic profile** routes traffic to Microsoft 365 services—Exchange Online, SharePoint Online, OneDrive, Teams, and Microsoft 365 Common—for optimized security and performance. As a security architect, you evaluate both profiles to determine how each addresses your organization's access control, data protection, and compliance requirements.

## Evaluate Internet Access as a secure web gateway

A secure web gateway (SWG) inspects outbound traffic and enforces policies that block access to malicious, unsafe, or inappropriate destinations. Microsoft Entra Internet Access provides SWG capabilities through web content filtering, which gives you granular control based on web categories and fully qualified domain names (FQDNs).

When traffic reaches Microsoft's Security Service Edge, the service inspects it in two ways. For unencrypted HTTP traffic, it evaluates the full URL. For HTTPS traffic encrypted with TLS, it uses the Server Name Indication (SNI) to determine the destination. This dual approach ensures coverage across both encrypted and unencrypted connections.

What distinguishes Internet Access from network-based SWG solutions is the policy delivery model. You create **web content filtering policies** that define which categories or FQDNs to allow or block, group those policies into **security profiles**, and then link the security profiles to **Conditional Access policies**. This architecture means filtering decisions aren't just based on network location—they incorporate user identity, device compliance, risk level, and session context.

### Design the policy hierarchy

Within a security profile, you assign each filtering policy a unique priority number. Priority 100 is the highest, and 65,000 is the lowest. The service evaluates policies in priority order and stops at the first match, similar to traditional firewall rule processing. As a best practice, space priorities by increments of 100 to give yourself room for future insertions.

When multiple Conditional Access policies match a request, the service processes all matching security profiles in their priority order. This layered evaluation lets you build targeted policies for specific user groups while maintaining broad protection across the organization.

> [!IMPORTANT]
> The **baseline security profile** applies to all internet traffic routed through the service, even without a linked Conditional Access policy. It acts as a catch-all at the lowest priority in the policy stack. Use it to define your organization's default blocking rules—for example, blocking known malicious categories—while using higher-priority profiles for role-specific exceptions.

### Integration with Conditional Access

The connection between security profiles and Conditional Access is central to the design. When you create a Conditional Access policy, you target **All internet resources with Global Secure Access** as the resource and select a security profile under session controls. This approach lets you apply different filtering policies based on conditions such as:

- **User or group membership.** Stricter policies for contractors or guest accounts, more permissive policies for specific roles.
- **Device compliance.** Require managed or compliant devices before allowing access to certain web categories.
- **Risk level.** Block high-risk web categories when the user or sign-in risk is elevated.

New security profile assignments can take 60 to 90 minutes to propagate because the security profile identifier is embedded in the access token. Changes to existing security profiles take effect more quickly.

## Evaluate Internet Access for Microsoft 365

The Microsoft traffic profile provides a separate forwarding path dedicated to Microsoft 365 services. Unlike the general internet access profile, this profile uses a prepopulated set of FQDNs and IP address ranges organized into policy groups: Exchange Online, SharePoint Online and OneDrive, Microsoft Teams, and Microsoft 365 Common and Office Online.

You can forward or bypass traffic for each policy group individually. For example, you might forward Exchange Online and SharePoint traffic through the service while bypassing Microsoft Teams if latency-sensitive real-time media requires a direct path. When you set a rule to bypass in the Microsoft traffic profile, the internet access profile doesn't acquire that traffic either—it goes directly out through the client's local network path.

### Source IP restoration

When traffic flows through any cloud proxy, the destination service sees the proxy's egress IP address instead of the user's actual IP. This creates a problem for organizations that rely on IP-based Conditional Access policies or need accurate location data in sign-in logs.

Source IP restoration solves this by securely communicating the user's original egress IP address to Microsoft Entra ID and Microsoft Graph. With this feature enabled, your organization can:

- Continue enforcing IP-based location policies in Conditional Access.
- Improve the accuracy of risk detections in Microsoft Entra ID Protection.
- Record accurate source IP addresses in sign-in and audit logs for investigations.

### Compliant network check

The compliant network check is a Conditional Access condition that verifies whether a user connects through the Global Secure Access service for your tenant. This check introduces two levels of protection:

- **Authentication plane.** At sign-in, Microsoft Entra ID denies requests from devices not connected to your compliant network. This blocks token theft and replay attacks where an adversary tries to use stolen refresh tokens from outside your network.
- **Data plane.** For services that support Continuous Access Evaluation (CAE), such as Microsoft Graph, stolen access tokens replayed from outside the compliant network are rejected in near-real time.

Unlike IP-based named locations, the compliant network check doesn't require you to maintain lists of egress IP addresses. The Global Secure Access client or remote network connectivity establishes the compliant network relationship automatically.

## Protect against cross-tenant data exfiltration

Organizations that collaborate with external partners face the risk that users on corporate devices sign in to unauthorized external tenants and exfiltrate data. **Universal tenant restrictions**, built on the tenant restrictions v2 policy, address this risk at both the authentication and data planes.

When you enable universal tenant restrictions, Global Secure Access tags all Microsoft Entra ID and Microsoft Graph traffic with your tenant restrictions v2 policy information. This tagging works across all operating systems, browsers, and device form factors—without requiring proxy server configurations.

Tenant restrictions v2 operates through cross-tenant access settings. You define which external tenants and applications are allowed and block everything else. There are two enforcement points:

| Enforcement point | Protection |
|---|---|
| **Authentication plane** | Blocks users from authenticating to unauthorized external tenants at sign-in time. Works with all Microsoft Entra-integrated apps, including third-party apps. |
| **Data plane** | Prevents replayed tokens from unauthorized tenants. If someone obtains a Microsoft Graph access token on an unmanaged device and brings it into your environment, the token is rejected. |

From a design perspective, evaluate universal tenant restrictions when your organization needs to prevent data exfiltration through external Microsoft 365 tenants or personal Microsoft accounts. The feature requires the Microsoft traffic profile to be enabled and the Global Secure Access client deployed or remote network connectivity configured.

## Design recommendations

- **Enable both traffic profiles** for comprehensive coverage. The internet access profile doesn't include destinations covered by the Microsoft traffic profile.
- **Define a baseline security profile** that blocks known malicious and inappropriate web categories for all users, then layer role-specific exceptions through additional security profiles linked to Conditional Access.
- **Enable source IP restoration** to maintain accurate location data for Conditional Access policies, risk detection, and audit logs.
- **Require the compliant network check** for all Microsoft Entra-integrated applications to mitigate token theft and replay attacks.
- **Deploy universal tenant restrictions** alongside tenant restrictions v2 to prevent data exfiltration to unauthorized external tenants. Test with a small group before enforcing broadly.
