Organizations today operate across SaaS, PaaS, IaaS, hybrid, and multicloud environments. Securing access to resources in these diverse environments requires a coordinated strategy that addresses three control planes: identity, networking, and application controls. This unit helps you design access solutions that apply Zero Trust principles across all deployment models.

## Design considerations for access across deployment models

Each deployment model presents distinct access challenges. Your access strategy should address how users and workloads authenticate, how network traffic reaches resources, and how applications enforce authorization.

| Deployment model | Identity controls | Networking controls | Application controls |
|-----------------|-------------------|--------------------|--------------------|
| **SaaS** | SSO federation, Conditional Access | Secure Web Gateway, tenant restrictions | Cloud Access Security Broker (CASB), app consent policies |
| **PaaS** | Managed identities, RBAC | Private endpoints, VNet integration | API authentication, token validation |
| **IaaS** | Entra ID authentication, PIM | NSGs, Azure Firewall, Private Link | Application Proxy, host-based controls |
| **Hybrid/on-premises** | Directory synchronization, federation | VPN/ExpressRoute, Private Access | Application Proxy, Kerberos constrained delegation |
| **Multicloud** | Federated identity, workload identity federation | Cross-cloud network peering, Internet Access | Conditional Access across cloud providers |

## Identity controls

Identity controls determine who or what can access resources and under what conditions.

### User identity

Use Microsoft Entra ID as the primary identity provider across all environments. Key design decisions include:

- **Single sign-on (SSO)** for SaaS applications using SAML, OAuth 2.0, or OpenID Connect. Microsoft Entra ID provides a gallery of preintegrated applications and supports custom app registrations.
- **Azure role-based access control (RBAC)** for authorization to PaaS and IaaS resources. Assign roles at the narrowest scope necessary.
- **Privileged Identity Management (PIM)** for just-in-time access to sensitive roles, reducing standing administrative privileges.
- **Conditional Access** policies that evaluate signals like user risk, device compliance, location, and application sensitivity before granting access.

### Workload identity

Applications, services, and automation pipelines also need identities. Design for:

- **Managed identities** to eliminate credential management for Azure resources that access other Azure services.
- **Workload identity federation** to enable external workloads, such as GitHub Actions or Kubernetes pods, to access Azure resources without storing secrets.
- **Service principals with certificates** for automation scenarios that require explicit credential management. Avoid long-lived client secrets.

## Networking controls

Networking controls determine how traffic flows between users, devices, and resources. Microsoft Entra's Security Service Edge (SSE) solution, called Global Secure Access, provides identity-aware network security.

### Microsoft Entra Internet Access

Microsoft Entra Internet Access is an identity-based Secure Web Gateway (SWG) that protects access to SaaS applications and internet destinations. Use it to:

- Apply web content filtering based on categories or fully qualified domain names (FQDNs).
- Enforce Conditional Access policies for internet traffic, even for destinations not federated with Microsoft Entra ID.
- Enable universal tenant restrictions to prevent data exfiltration to unauthorized tenants or personal accounts.

### Microsoft Entra Private Access

Microsoft Entra Private Access replaces traditional VPNs with Zero Trust Network Access (ZTNA). Use it to:

- Provide per-app access to on-premises and IaaS-hosted private applications based on Conditional Access policies.
- Eliminate broad network access by routing only authorized traffic to specific applications.
- Secure access across hybrid and multicloud environments without requiring users to connect to corporate networks.

### Additional network controls

For PaaS and IaaS resources, layer network controls alongside identity controls:

- **Azure Private Link and private endpoints** to ensure traffic to PaaS services stays on the Microsoft backbone network.
- **Network security groups (NSGs)** and **Azure Firewall** to limit inbound and outbound traffic for IaaS workloads.
- **ExpressRoute or site-to-site VPN** for dedicated connectivity between on-premises networks and Azure.

## Application controls

Application controls govern what apps users can access and how those apps handle data.

### Microsoft Defender for Cloud Apps

Microsoft Defender for Cloud Apps provides CASB capabilities to secure SaaS usage. Use it to:

- Discover shadow IT by identifying unsanctioned SaaS applications in use.
- Apply session controls that restrict downloads, uploads, or copy/paste actions based on Conditional Access policies.
- Monitor and govern sanctioned applications with real-time activity policies.

### Microsoft Entra Application Proxy

For on-premises web applications that can't be exposed directly to the internet, Application Proxy provides secure remote access. It integrates with Conditional Access to enforce MFA and device compliance checks for legacy web applications without modifying the application code.

### Application consent and permissions

Control which applications users can consent to by configuring app consent policies in Microsoft Entra ID. For applications that request high-privilege permissions, require admin consent to prevent users from inadvertently granting broad access to organizational data.

## Access strategy for multicloud environments

When resources span multiple cloud providers, establish Microsoft Entra ID as the central identity provider:

- **Federate AWS accounts** with Microsoft Entra ID through AWS IAM Identity Center for SSO and automated user lifecycle management.
- **Federate Google Cloud** projects by configuring Google as a service provider that trusts Microsoft Entra ID for authentication.
- **Use Conditional Access** to enforce consistent authentication policies regardless of which cloud provider hosts the resource, requiring MFA, device compliance, and risk evaluation for every sign-in.
- **Monitor cross-cloud permissions** using Microsoft Defender for Cloud to identify overprovisioned identities and enforce least privilege across Azure, AWS, and GCP.

## Apply Zero Trust principles across all environments

A Zero Trust approach provides the foundation for your access strategy. Apply these principles across all control planes:

| Principle | How to apply |
|-----------|-------------|
| **Verify explicitly** | Require phishing-resistant MFA; enforce Conditional Access based on risk, device, and location; block legacy authentication |
| **Use least privilege** | Implement RBAC with minimal permissions; use PIM for just-in-time access; right-size workload identity permissions |
| **Assume breach** | Route traffic through Global Secure Access for inspection; integrate authentication events with Microsoft Sentinel; configure session controls and sign-in frequency |

When you design your access strategy, ensure all authentication events across all environments flow to centralized logging for security monitoring and incident response.
