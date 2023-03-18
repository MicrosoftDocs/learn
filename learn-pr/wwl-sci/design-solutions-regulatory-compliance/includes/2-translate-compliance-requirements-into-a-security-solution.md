Security baseline is one of the [Five Disciplines of Cloud Governance](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/governance-disciplines) within the [Cloud Adoption Framework governance model](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/). Security is a component of any IT deployment, and the cloud introduces unique security concerns. Many businesses are subject to regulatory requirements that make protecting sensitive data a major organizational priority when considering a cloud transformation. Identifying potential security threats to your cloud environment and establishing processes and procedures for addressing these threats should be a priority for any IT security or cybersecurity team. The Security Baseline discipline ensures technical requirements and security constraints are consistently applied to cloud environments, as those requirements mature.

This article outlines the approach to developing a Security Baseline discipline as part of your cloud governance strategy. The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of your IT and security teams, especially those technical leaders responsible for implementing networking, encryption, and identity services.

Making the correct security decisions is critical to the success of your cloud deployments and wider business success. If your organization lacks in-house expertise in cybersecurity, consider engaging external security consultants as a component of this discipline. Also consider engaging [Microsoft Consulting Services](https://www.microsoft.com/industry/services/consulting), the [Microsoft FastTrack](https://azure.microsoft.com/programs/azure-fasttrack/) cloud adoption service, or other external cloud adoption experts to discuss concerns related to this discipline.

### Policy statements

Actionable policy statements and the resulting architecture requirements serve as the foundation of a Security Baseline discipline. Use [sample policy statements](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/policy-statements) as a starting point for defining your Security Baseline policies.

 Caution

The sample policies come from common customer experiences. To better align these policies to specific cloud governance needs, execute the following steps to create policy statements that meet your unique business needs.

### Develop governance policy statements

The following steps offer examples and potential options to consider when developing your Security Baseline discipline. Use each step as a starting point for discussions within your cloud governance team and with affected business, IT, and security teams across your organization to establish the policies and processes needed to manage security-related risks.

[Security Baseline discipline template](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/template): Download the template for documenting a Security Baseline discipline.
  
[Business risks](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/business-risks): Understand the motives and risks commonly associated with the Security Baseline discipline.
  
[Indicators and metrics](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/metrics-tolerance): Indicators to understand whether it's the right time to invest in the Security Baseline discipline.
  
[Policy adherence processes](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/compliance-processes): Suggested processes for supporting policy compliance in the Security Baseline discipline.

[Maturity](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/discipline-improvement): Align cloud management maturity with phases of cloud adoption.
  
[Toolchain](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/toolchain): Azure services that can be implemented to support the Security Baseline discipline.

## Security Baseline tools in Azure

The [Security Baseline discipline](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/security-baseline/) is one of the [Five Disciplines of Cloud Governance](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/governance-disciplines). This discipline focuses on ways of establishing policies that protect the network, assets, and most importantly the data that will reside on a cloud provider's solution. Within the Five Disciplines of Cloud Governance, the Security Baseline discipline involves classification of the digital estate and data. It also involves documentation of risks, business tolerance, and mitigation strategies associated with the security of data, assets, and networks. From a technical perspective, this discipline also includes involvement in decisions regarding [encryption](https://learn.microsoft.com//azure/cloud-adoption-framework/decision-guides/encryption/), [network requirements](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/azure-best-practices/define-an-azure-network-topology), [hybrid identity strategies](https://learn.microsoft.com//azure/cloud-adoption-framework/decision-guides/identity/), and tools to [automate enforcement](https://learn.microsoft.com//azure/cloud-adoption-framework/govern/policy-compliance/processes#automation-of-monitoring-and-compliance) of security policies across [resource groups](https://learn.microsoft.com//azure/cloud-adoption-framework/decision-guides/resource-consistency/). The following list of Azure tools can help mature the policies and processes that support this discipline.

| Tool | [Azure portal](https://azure.microsoft.com/features/azure-portal/) and [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | [Azure Key Vault](/azure/key-vault/)  | [Azure AD](/azure/active-directory/fundamentals/active-directory-whatis) | [Azure Policy](/azure/governance/policy/overview) | [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) | [Azure Monitor](/azure/azure-monitor/overview) |
|------------------------------------------------------------|---------------------------------|-----------------|----------|--------------|-----------------------|---------------|
| Apply access controls to resources and resource creation   | Yes                             | No              | Yes      | No           | No                    | No            |
| Secure virtual networks                                    | Yes                             | No              | No       | Yes          | No                    | No            |
| Encrypt virtual drives                                     | No                              | Yes             | No       | No           | No                    | No            |
| Encrypt PaaS storage and databases                         | No                              | Yes             | No       | No           | No                    | No            |
| Manage hybrid identity services                            | No                              | No              | Yes      | No           | No                    | No            |
| Restrict allowed types of resource                         | No                              | No              | No       | Yes          | No                    | No            |
| Enforce geo-regional restrictions                          | No                              | No              | No       | Yes          | No                    | No            |
| Monitor security health of networks and resources          | No                              | No              | No       | No           | Yes                   | Yes           |
| Detect malicious activity                                  | No                              | No              | No       | No           | Yes                   | Yes           |
| Preemptively detect vulnerabilities                        | No                              | No              | No       | No           | Yes                   | No            |
| Configure backup and disaster recovery                     | Yes                             | No              | No       | No           | No                    | No            |

For a complete list of Azure security tools and services, see [Security services and technologies available on Azure](https://learn.microsoft.com//azure/security/fundamentals/services-technologies).

Customers commonly use third-party tools to enable Security Baseline discipline activities. For more information, see the article [integrate security solutions in Microsoft Defender for Cloud](https://learn.microsoft.com//azure/security-center/security-center-partner-integration).

In addition to security tools, [Compliance Management in Microsoft 365](https://www.microsoft.com/security/business/compliance/compliance-management) provides extensive guidance, reports, and related documentation that can help you perform risk assessments as part of your migration planning process.