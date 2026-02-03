As organizations adopt cloud services across SaaS, PaaS, and IaaS models while maintaining on-premises infrastructure, security architects must design identity solutions that provide secure, consistent access across all environments. This unit provides guidance for designing access strategies that span cloud, hybrid, and multicloud scenarios.

## Access strategy design considerations

When designing access strategies, consider the level of integration required with existing identity infrastructure:

| Scenario | Characteristics | Design Approach |
|----------|----------------|-----------------|
| **Cloud-only** | No on-premises directory; cloud-native workloads | Microsoft Entra ID as the sole identity provider |
| **Hybrid** | Existing on-premises AD; mix of cloud and on-premises resources | Directory synchronization with Microsoft Entra Connect |
| **Multicloud** | Resources across Azure, AWS, GCP, and other clouds | Federated identity with Microsoft Entra ID as primary provider |

Your access strategy should address authentication methods, authorization models, and the principle of least privilege across all environments.


## Designing for SaaS application access

SaaS applications require secure authentication without exposing credentials to third parties. Design your SaaS access strategy to:

- **Integrate applications with Microsoft Entra ID** - Use SAML, OAuth 2.0, or OpenID Connect for single sign-on (SSO)
- **Enforce Conditional Access** - Apply policies based on user risk, device compliance, and location
- **Implement application governance** - Use Microsoft Defender for Cloud Apps to discover shadow IT and govern sanctioned applications

Microsoft Entra ID provides a gallery of pre-integrated applications and supports custom application registration for applications that support modern authentication protocols.

## Designing for PaaS and IaaS access

Platform and infrastructure services require both user and workload identity management. Key design considerations include:

### User access to Azure resources

- Use Microsoft Entra ID for authentication to the Azure portal, CLI, and APIs
- Implement Azure role-based access control (RBAC) for authorization
- Apply Conditional Access policies to protect administrative access
- Use Privileged Identity Management (PIM) for just-in-time privileged access

### Workload identity access

Applications and services need identities to access other resources. Design for:

- **Managed identities** - Eliminate credential management for Azure resources accessing other Azure services
- **Workload identity federation** - Enable external workloads (GitHub Actions, Kubernetes) to access Azure resources without storing secrets
- **Service principals** - Use for automation scenarios requiring explicit credential management

## Designing for hybrid environments

When your organization maintains both on-premises Active Directory and cloud resources, you need directory synchronization to provide a consistent identity experience.

### Microsoft Entra Connect Sync

Microsoft Entra Connect Sync synchronizes users, groups, and credentials between on-premises AD and Microsoft Entra ID. Design your synchronization strategy to:

- Determine which objects to synchronize based on organizational structure
- Choose the appropriate authentication method (password hash sync, pass-through authentication, or federation)
- Plan for high availability using multiple provisioning agents

Password hash synchronization provides the simplest deployment and enables features like leaked credential detection. Pass-through authentication keeps password validation on-premises, while federation with AD FS supports complex scenarios requiring on-premises policy evaluation.

### Legacy application support

Some applications require legacy authentication protocols like Kerberos or NTLM. Consider these options for supporting legacy authentication in hybrid environments:

- **Microsoft Entra Domain Services** - Provides managed domain services (domain join, group policy, LDAP, Kerberos/NTLM) without deploying domain controllers
- **Self-managed AD DS in Azure** - Deploy domain controllers in Azure VMs for full control over the directory

Microsoft Entra Domain Services is appropriate for lift-and-shift scenarios where applications need domain services but don't require direct access to domain controllers.

## Designing for multicloud access

Organizations using multiple cloud providers need consistent identity management. Design your multicloud strategy to:

- **Federate with Microsoft Entra ID** - Configure AWS, GCP, and other providers to trust Microsoft Entra ID as an identity provider
- **Use Conditional Access** - Apply consistent access policies regardless of which cloud hosts the resource
- **Implement cross-cloud governance** - Use Microsoft Entra Permissions Management to discover and remediate excessive permissions across clouds

## Security principles and controls for access strategies

A Zero Trust approach provides the foundation for your access strategy design. Apply these principles and their corresponding security controls across all environments:

| Zero Trust Principle | Security Controls |
|---------------------|-------------------|
| **Verify explicitly** | Require phishing-resistant MFA for all users; enforce Conditional Access based on user risk, device compliance, and location; block legacy authentication protocols |
| **Use least privilege** | Implement Azure RBAC with minimal permissions; use Privileged Identity Management (PIM) for just-in-time privileged access; configure time-limited access for sensitive roles |
| **Assume breach** | Enable sign-in and audit logs; integrate with Microsoft Sentinel for security monitoring; require compliant or hybrid-joined devices; configure session controls and sign-in frequency |

Beyond these core principles, consider these additional design guidelines:

- **Consolidate identity providers** - Use Microsoft Entra ID as the primary identity provider across cloud, hybrid, and multicloud environments to simplify governance and ensure consistent policy enforcement
- **Plan authentication evolution** - Design for phishing-resistant authentication methods like passkeys and certificate-based authentication, even if you can't deploy them immediately
- **Address legacy systems** - Identify applications that can't use modern authentication and plan appropriate solutions (Microsoft Entra Domain Services, federation, or application proxy)
- **Enable visibility** - Ensure all authentication events across all environments flow to centralized logging for security monitoring and incident response
