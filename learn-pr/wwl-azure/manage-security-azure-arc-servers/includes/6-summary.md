Contoso Manufacturing's factory servers are now secured with defense-in-depth controls that span cloud-based governance and agent-level enforcement. You configured RBAC to limit who can manage Arc servers, applied extension allow lists to prevent unauthorized software installation, assigned Azure Policy to enforce security baselines at scale, and enabled Microsoft Defender for Cloud to monitor security posture and compliance across hybrid infrastructure.

## Key security decisions

Effective Arc server security requires layered controls operating at multiple enforcement points:

- **Agent-level extension controls cannot be overridden by cloud users**, providing immutable protection against insider threats and compromised privileged accounts. Cloud-based Azure Policy provides ease of management and visibility but allows users with sufficient permissions of make modifications. Use both controls together.
- **Azure Policy assigned at management group scope** covers all subscriptions automatically, reducing configuration drift, and ensuring consistent security posture as infrastructure scales. DeployIfNotExists policies automate extension deployment and configuration, but require remediation tasks for existing resources.
- **Defender for Cloud treats Arc-enabled servers as first-class resources**, providing unified security recommendations, regulatory compliance tracking, and security alert correlation across Azure and on-premises environments. Arc servers running legacy operating systems receive Extended Security Updates at no extra cost, reducing risks from unpatched vulnerabilities.
- **Role-based access control separates enrollment privileges from operational management**. Use the Azure Connected Machine Onboarding role for server registration automation and the Azure Connected Machine Resource Administrator role (with PIM) for operational tasks requiring extension deployment.

## Learn more

- [Security overview for Azure Arc-enabled servers](/azure/azure-arc/servers/security-overview)
- [Extensions security for Azure Arc-enabled servers](/azure/azure-arc/servers/security-extensions)
- [Azure Policy built-in definitions for Arc-enabled servers](/azure/azure-arc/servers/policy-reference)
