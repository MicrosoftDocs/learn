In this module, you learned how to design identity and access management solutions that protect organizational resources across cloud, hybrid, and multicloud environments.

You learned how to:

- Design access strategies for SaaS, PaaS, IaaS, hybrid, and multicloud resources using identity, networking, and application controls
- Design a solution for Microsoft Entra ID, including hybrid and multicloud environments
- Design a solution for external identities, including B2B collaboration and customer identity
- Design a solution for agent identities using Microsoft Entra Agent ID
- Design modern authentication and authorization strategies
- Validate Conditional Access alignment with Zero Trust
- Specify requirements for securing Active Directory Domain Services
- Design a solution for managing secrets, keys, and certificates

## Key takeaways

- **Consolidate identity on Microsoft Entra ID** as the central identity provider across all environments, including AWS and GCP, to simplify governance and enable consistent access policies.
- **Choose Cloud Sync for new hybrid deployments** and password hash synchronization as the default authentication method for the strongest security features and resiliency.
- **Apply Zero Trust across all identity decisions—verify explicitly with Conditional Access, enforce least privilege with PIM and access reviews, and assume breach with continuous monitoring.
- **Protect secrets with Azure Key Vault** using RBAC, managed identities, and automated rotation to eliminate hardcoded credentials.
- **Harden AD DS with tiered administration** and integrate sign-in signals with Microsoft Sentinel for centralized threat detection across hybrid and multicloud environments.

## Learn more

### Design a solution for access to SaaS, PaaS, IaaS, hybrid, and multicloud resources

- [Microsoft Entra identity management and access management for AWS](/azure/architecture/reference-architectures/aws/aws-azure-ad-security)
- [Microsoft security solutions for AWS](/azure/architecture/guide/aws/aws-azure-security-solutions)

### Design a solution for Microsoft Entra ID, including hybrid and multicloud environments

- [Microsoft Entra ID documentation](/entra/identity/)
- [What is Microsoft Entra Cloud Sync?](/entra/identity/hybrid/cloud-sync/what-is-cloud-sync)
- [Choose the right authentication method for your Microsoft Entra hybrid identity solution](/entra/identity/hybrid/connect/choose-ad-authn)
- [Microsoft Entra seamless single sign-on](/entra/identity/hybrid/connect/how-to-connect-sso-how-it-works)
- [Hybrid identity scenarios](/entra/identity/hybrid/common-scenarios)
- [What is Microsoft Entra Domain Services?](/entra/identity/domain-services/overview)
- [What is workload identity federation?](/entra/workload-id/workload-identity-federation)

### Design a solution for external identities

- [Microsoft Entra External ID](/entra/external-id/)

### Design modern authentication and authorization strategies

- [Authentication vs. authorization in the Microsoft identity platform](/entra/identity-platform/authentication-vs-authorization)
- [Hybrid modern authentication overview](/microsoft-365/enterprise/hybrid-modern-auth-overview)
- [Microsoft Entra authentication methods](/entra/identity/authentication/overview-authentication)
- [Authentication strengths in Conditional Access](/entra/identity/authentication/concept-authentication-strengths)
- [Microsoft Entra Conditional Access](/entra/identity/conditional-access/)
- [Continuous access evaluation](/entra/identity/conditional-access/concept-continuous-access-evaluation)
- [Microsoft Entra ID Protection](/entra/id-protection/overview-identity-protection)
- [Protected actions overview](/entra/identity/role-based-access-control/protected-actions-overview)
- [Emergency access accounts](/entra/identity/role-based-access-control/security-emergency-access)
- [Securing privileged access overview](/entra/identity/role-based-access-control/security-planning)

### Design Conditional Access policies for AI agents

- [Conditional Access for Agent ID](/entra/identity/conditional-access/agent-id)
- [Security for AI agents](/entra/agent-id/identity-professional/security-for-ai)
- [Microsoft Entra agent identities for AI agents](/entra/agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents)
- [Risky agents in ID Protection](/entra/id-protection/concept-risky-agents)

### Validate alignment of Conditional Access policies with a Zero Trust strategy

- [Securing identity with Zero Trust](/security/zero-trust/deploy/identity)
- [Zero Trust identity and device access policies](/security/zero-trust/zero-trust-identity-device-access-policies-overview)
- [Common identity and device access policies](/security/zero-trust/zero-trust-identity-device-access-policies-common)
- [Zero Trust security in Azure](/azure/security/fundamentals/zero-trust)

### Specify requirements for securing Active Directory Domain Services

- [Credential Guard overview](/windows/security/identity-protection/credential-guard/)
- [Best practices for securing Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory)
- [Privileged access: Enterprise access model](/security/privileged-access-workstations/privileged-access-access-model)
- [Pilot and deploy Microsoft Defender for Identity](/defender-xdr/pilot-deploy-defender-identity)
- [Windows LAPS overview](/windows-server/identity/laps/laps-overview)
- [Microsoft Entra Password Protection for on-premises AD DS](/entra/identity/authentication/concept-password-ban-bad-on-premises)

### Design a solution to manage secrets, keys, and certificates

- [Azure Key Vault documentation](/azure/key-vault/)
