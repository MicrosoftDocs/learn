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
