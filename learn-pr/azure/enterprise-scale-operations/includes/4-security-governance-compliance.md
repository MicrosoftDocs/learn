You can manage security, governance, and compliance within an Azure estate by using a centralized set of controls. This approach ensures that the proper guardrails are in place as the business adopts cloud capabilities. These guardrails help protect against unintended configurations that might expose the organization to risk.

## Encryption and key management

Encryption is a vital step towards ensuring data privacy, compliance, and data residency in Azure. It's also one of the most important security concerns of many enterprises.

Azure supports various encryption models, including:

- Server-side encryption by using service-managed keys.
- Customer-managed keys in Azure Key Vault.
- Customer-managed keys on customer-controlled hardware.

With client-side encryption, you can manage and store keys on-premises or in another secure location. An organization should define its encryption requirements for the services it uses, and enforce encryption configurations via Azure Policy.

Without proper protection and management of the keys, encryption is useless. Key Vault is the recommended enterprise-scale solution for managing and controlling access to encryption keys used by cloud services. Permissions to access keys can be assigned to services or users via Azure Active Directory (Azure AD) accounts.

Key Vault relieves organizations of the need to configure, patch, and maintain hardware security modules (HSMs) and key management software.

## Governance

Governance focuses on the mechanisms and processes to maintain control over applications and resources in Azure. In an enterprise-scale architecture, Azure Policy is essential for ensuring security and compliance within the enterprise estate. Policies enforce vital management and security conventions across Azure resources and platform services.

The process of enforcing compliance begins with a defined set of regulatory and compliance standards at the landing-zone level. The focus is at the landing-zone level because not all applications within an enterprise estate must adhere to the same standards. To ensure security, it might appear to be a good idea to use a workload with restrictive compliance requirements as a baseline for all workloads. However, applying highly restrictive policies to workloads where they're not required can negatively impact the business's ability to use cloud capabilities fully.

After the compliance standards have been defined, you must map them to Azure Policy definitions and Azure AD role-based access control (RBAC) assignments. A well-planned combination of RBAC assignments and policies puts appropriate guardrails in place. These guardrails control who can deploy and configure resources and what resources they can deploy and configure.

After you've mapped the compliance standards to Azure Policy definitions, you must apply the policies within the organizational hierarchy. As a best practice, apply policy assignments at the highest appropriate level within the hierarchy to minimize redundancy and simplify management.

## Security monitoring and an audit policy

It's crucial for an enterprise to have visibility into what's happening within its enterprise estate. Security monitoring and audit logging of Azure platform services are key components of an enterprise-scale architecture.

For insights and analysis of the changes that occur within an enterprise estate, you must configure all subscriptions to export the Azure activity log to Log Analytics. There's no data-ingestion or data-retention charge for activity-log data stored in a Log Analytics workspace. If an organization is required to retain audit logs for more than two years, we recommend also exporting the activity log to Azure Storage.

Azure AD reports provide another important view into activity within the enterprise estate. Review the reports regularly as part of your security-monitoring processes. The reports include *security reports* and *activity reports*. Security reports provide insight into an organization's identities, and activity reports provide insight into user behaviors.

Make Azure Security Center the starting point for security monitoring of Azure resources. Enable the standard tier for all subscriptions via Azure Policy.

## Platform security

Planning for platform security is essential to maintaining a healthy security posture in Azure. An organization must be able to control the initial platform settings and account for changes as the Azure services evolve.

To effectively control an enterprise estate, an organization must develop a security allow-list plan to assess services and their security configurations. The security-configuration standards can then be enforced by using Azure Policy to ensure that the organization remains compliant with those standards. In addition to defining security standards for allowed services, an organization must establish a regular review cadence to align configurations with new service and platform capabilities.

Incident-response plans must also be incorporated into the platform security strategy. For each allowed service, make a plan for how to manage security-related incidents. The plans should include prescriptive remediation activities and designate responsible teams for escalation.
