Managing security, governance, and compliance within an Azure estate through a centralized set of controls will ensure the proper guard rails are in place as the business adopts cloud capabilities. These guard rails mitigate against unintended configurations that may expose the organization to risk.

## Encryption and key management

Encryption is a vital step towards ensuring data privacy, compliance, and data residency in Microsoft Azure. It is also one of the most important security concerns of many enterprises.

Azure supports various encryption models, including server-side encryption that uses service-managed keys, customer-managed keys in Key Vault, or customer-managed keys on customer-controlled hardware. With client-side encryption, you can manage and store keys on-premises or in another secure location. An organization should define their encryption requirements for the services they use, and enforce the encryption configurations with Azure Policy.

Without proper protection and management of the keys, encryption is rendered useless. Key Vault is the Enterprise Scale recommended solution for managing and controlling access to encryption keys used by cloud services. Permissions to access keys can be assigned to services or to users through Azure Active Directory accounts.

Key Vault relieves organizations of the need to configure, patch, and maintain hardware security modules (HSMs) and key management software.

## Governance

Governance focuses on the mechanisms and processes to maintain control over applications and resources in Azure. Within Enterprise Scale, Azure Policy is an essential service to ensuring security and compliance within the enterprise estate. Policies enforce vital management and security conventions across Azure resources and platform services.

The process of enforcing compliance begins with a defined set of regulatory and compliance standards at the landing zone level. The focus is at the landing zone level because not all applications within an enterprise estate must adhere to the same standards. While the idea of using a workload with restrictive compliance requirements as a baseline for all workloads may appear to be a good approach for ensuring security of the enterprise estate, applying highly restrictive policies to workloads where they are not required can negatively impact the ability of the business to fully leverage cloud capabilities.

After the compliance standards have been defined, they must be mapped to Azure Policy definitions and Azure AD role-based access control (RBAC) assignments. A well-planned combination of RBAC assignments and policies will ensure the appropriate guard rails are in place to control who can deploy and configure resources and what resources they can deploy and configure.

After the compliance standards have been mapped to Azure Policy definitions, the policies must be applied within the organizational hierarchy. As a general best practice, policy assignments should be applied at the highest appropriate level within the hierarchy to minimize redundancy and simplify management.

## Security monitoring and an audit policy

It is crucial for an enterprise to have visibility into what is happening within their enterprise estate. Security monitoring and audit logging of Azure platform services are key components of Enterprise Scale.

For insights and analysis of the changes occurring within an enterprise estate, all subscriptions must be configured to export the Azure Activity Log to Log Analytics. There is no data ingestion or data retention charge for Activity log data stored in a Log Analytics workspace. If an organization has requirements to retain audit logs past two years, the Activity log should be exported to Azure storage as well.

Azure AD reports provide another important view into activity within the enterprise estate and should be regularly reviewed as part of the security monitoring processes. The reports include Security reports and Activity reports. Security reports provide insight into an organization's identities, and activity reports provide insight into user behaviors.

Azure Security Center should be the starting point for security monitoring of Azure resources. Enterprise Scale recommends all subscriptions have the Standard tier enabled via Azure Policy.

## Platform security

Planning for platform security is essential to maintain a healthy security posture in Azure. An organization must be able to control the initial platform settings and account for changes as the Azure services evolve.

Effectively controlling an enterprise estate requires an organization to develop a security allow-list plan to assess services and their security configurations. The security configuration standards can then be enforced with Azure policy to ensure the organization remains compliant with the standards. In addition to defining security standards for allowed services, an organization must establish a regular review cadence to align configurations with new service and platform capabilities.

Incident response plans must also be incorporated into the platform security strategy. Each allowed service should have a plan for how to manage security-related incidents. The plans should include prescriptive remediation activities and designated responsible teams for escalation.
