In this module, you learned how to design identity and access management solutions that protect organizational resources across cloud, hybrid, and multicloud environments.

You learned how to:

- Design access strategies for SaaS, PaaS, IaaS, hybrid, and multicloud resources using identity, networking, and application controls
- Design a solution for Microsoft Entra ID, including hybrid and multicloud environments
- Design a solution for external identities, including B2B collaboration and customer identity
- Design modern authentication and authorization strategies
- Validate Conditional Access alignment with Zero Trust
- Specify requirements for securing Active Directory Domain Services
- Design a solution for managing secrets, keys, and certificates

## Key takeaways

- **Consolidate identity on Microsoft Entra ID** as the central identity provider across all environments, including AWS and GCP, to simplify governance and enable consistent access policies.
- **Choose Cloud Sync for new hybrid deployments** and password hash synchronization as the default authentication method for the strongest security features and resiliency.
- **Apply Zero Trust across all identity decisions** — verify explicitly with Conditional Access, enforce least privilege with PIM and access reviews, and assume breach with continuous monitoring.
- **Protect secrets with Azure Key Vault** using RBAC, managed identities, and automated rotation to eliminate hardcoded credentials.
- **Harden AD DS with tiered administration** and integrate sign-in signals with Microsoft Sentinel for centralized threat detection across hybrid and multicloud environments.

## Learn more

- [Microsoft Entra ID documentation](/entra/identity/)
- [Microsoft Entra Conditional Access](/entra/identity/conditional-access/)
- [Microsoft Entra External ID](/entra/external-id/)
- [Best practices for securing Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory)
- [Azure Key Vault documentation](/azure/key-vault/)
- [What is Microsoft Entra Cloud Sync?](/entra/identity/hybrid/cloud-sync/what-is-cloud-sync)
- [What is Microsoft Entra Connect?](/entra/identity/hybrid/connect/whatis-azure-ad-connect)
- [Choose the right authentication method for your Microsoft Entra hybrid identity solution](/entra/identity/hybrid/connect/choose-ad-authn)
- [Microsoft Entra seamless single sign-on](/entra/identity/hybrid/connect/how-to-connect-sso-how-it-works)
- [What is workload identity federation?](/entra/workload-id/workload-identity-federation)
- [What is Microsoft Entra Domain Services?](/entra/identity/domain-services/overview)
- [Microsoft Entra identity management and access management for AWS](/azure/architecture/reference-architectures/aws/aws-azure-ad-security)
- [Microsoft security solutions for AWS](/azure/architecture/guide/aws/aws-azure-security-solutions)
- [Hybrid identity scenarios](/entra/identity/hybrid/common-scenarios)
- [Authentication vs. authorization in the Microsoft identity platform](/entra/identity-platform/authentication-vs-authorization)
- [Hybrid modern authentication overview](/microsoft-365/enterprise/hybrid-modern-auth-overview)
- [Microsoft Entra authentication methods](/entra/identity/authentication/overview-authentication)
- [Authentication strengths in Conditional Access](/entra/identity/authentication/concept-authentication-strengths)
- [Conditional Access policies](/entra/identity/conditional-access/concept-conditional-access-policies)
- [Conditional Access session controls](/entra/identity/conditional-access/concept-conditional-access-session)
- [Plan a Conditional Access deployment](/entra/identity/conditional-access/plan-conditional-access)
- [Common Conditional Access policy templates](/entra/identity/conditional-access/concept-conditional-access-policy-common)
- [Microsoft-managed Conditional Access policies](/entra/identity/conditional-access/managed-policies)
- [Block legacy authentication with Conditional Access](/entra/identity/conditional-access/policy-block-legacy-authentication)
- [Conditional Access What If tool](/entra/identity/conditional-access/what-if-tool)
- [Report-only mode for Conditional Access](/entra/identity/conditional-access/concept-conditional-access-report-only)
- [Conditional Access insights and reporting](/entra/identity/conditional-access/howto-conditional-access-insights-reporting)
- [Conditional Access gap analyzer workbook](/entra/identity/monitoring-health/workbook-conditional-access-gap-analyzer)
- [Conditional Access optimization agent](/entra/security-copilot/conditional-access-agent-optimization)
- [Filter for applications in Conditional Access](/entra/identity/conditional-access/concept-filter-for-applications)
- [Continuous access evaluation](/entra/identity/conditional-access/concept-continuous-access-evaluation)
- [Conditional Access for Agent ID](/entra/identity/conditional-access/agent-id)
- [Security for AI agents](/entra/agent-id/identity-professional/security-for-ai)
- [Microsoft Entra agent identities for AI agents](/entra/agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents)
- [Risky agents in ID Protection](/entra/id-protection/concept-risky-agents)
- [Microsoft Entra ID Protection](/entra/id-protection/overview-identity-protection)
- [Identity Protection policies](/entra/id-protection/concept-identity-protection-policies)
- [Risk detection types](/entra/id-protection/concept-risk-detection-types)
- [Protected actions overview](/entra/identity/role-based-access-control/protected-actions-overview)
- [Add protected actions](/entra/identity/role-based-access-control/protected-actions-add)
- [Emergency access accounts](/entra/identity/role-based-access-control/security-emergency-access)
- [Securing privileged access overview](/entra/identity/role-based-access-control/security-planning)
- [Securing identity with Zero Trust](/security/zero-trust/deploy/identity)
- [Zero Trust identity and device access policies](/security/zero-trust/zero-trust-identity-device-access-policies-overview)
- [Common identity and device access policies](/security/zero-trust/zero-trust-identity-device-access-policies-common)
- [Zero Trust security in Azure](/azure/security/fundamentals/zero-trust)
