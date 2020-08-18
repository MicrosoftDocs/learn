Managing security, governance, and compliance within an Azure estate through a centralized set of controls will ensure the proper guard rails are in place as the business adopts cloud capabilities. These guard rails mitigate against unintended configurations that may expose the organization to risk.

## Encryption and key management

Encryption is a vital step towards ensuring data privacy, compliance, and data residency in Microsoft Azure. It is also one of the most important security concerns of many enterprises.

Design Recommendations:

- Use a federated Azure Key Vault model to avoid transaction scale limits.
- Provision Azure Key Vault with the soft delete and purge policies enabled to allow retention protection for deleted objects.
- Automate the certificate management and renewal process with public certificate authorities to ease administration.
- Establish an automated process for key and certificate rotation.

## Governance

    Governance focuses on the mechanisms and processes to maintain control over applications and resources in Azure. Within Enteprise Scale, Azure Policy is an essential service to ensuring security and compliance within the enterprise estate. Policies enforce vital management and security conventions across Azure resources and platform services.
    
    A well planned combination of RBAC assignments and policies will ensure the appropriate guard rails are in place to control who can deploy and configure resources and what resources they can deploy and configure.

    Design Recommendations:
    - Map regulatory and compliance requirements to Azure Policy definitions and Azure AD role-based access control assignments.
    - Manage policy assignments at the highest appropriate level with exclusions at bottom levels, if required.
    - Define regulatory and compliance standards at the landing zone level. Not all applications within an enterprise estate must adhere to the same standards.

## Security monitoring and an audit policy

It is crucial for an enterprise to have visibility into what is happening within their enterprise estate. Security monitoring and audit logging of Azure platform services are key components of Enterprise Scale.

Design Recommendations:

- Use Azure AD reporting capabilities to generate access control audit reports.
- Export Azure activity logs to Azure Monitor logs for long-term data retention and export to Azure Storage for long-term storage beyond two years, if necessary.
- Use Azure Security Center and Azure Sentinel for monitoring and alerting.
- Baseline security requirements for Azure services and desired state for VMs.
- Determine patch level assessment, management and update process and responsibilities for VMs. Including emergency patch process.

## Platform security

It is essential to maintain a healthy security posture as you adopt Azure. Besides visibility, you must be able to control the initial settings and changes as the Azure services evolve. Therefore, planning for platform security is key.

Design Recommendations

- Develop a security allow-list plan to assess services security configuration, monitoring, alerts, and how to integrate these with existing systems.
- Determine incident response plan for Azure services before allowing.
- Align your security requirements with Azure platform roadmaps to stay up to date with newly released security controls.
- Implement a zero-trust approach for access to the Azure platform, where appropriate.
