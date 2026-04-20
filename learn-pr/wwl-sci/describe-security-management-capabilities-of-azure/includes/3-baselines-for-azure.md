
Microsoft Defender for Cloud enables organizations to improve their security posture by continuously assessing resources and workloads against a set of security policies, standards, and recommendations. Understanding how these concepts work together is essential to understanding how Defender for Cloud helps you protect your environment.

## Security policies and initiatives

Security policies in Microsoft Defender for Cloud are backed by Azure Policy—Microsoft's governance service for enforcing organizational rules across Azure resources. There are a few related concepts to understand:

- An **Azure Policy definition** is a rule about a specific security condition that you want controlled. Azure Policy supports many built-in policy definitions, and you can also create custom definitions for your organization.
- A **security initiative** is a collection of Azure Policy definitions grouped together toward a specific goal or purpose. Security initiatives simplify management by grouping related policies logically as a single item.
- To implement policy definitions or initiatives, you **assign** them to any scope of resources that are supported—such as management groups, subscriptions, resource groups, or individual resources.

Microsoft Defender for Cloud applies security initiatives to your subscriptions. These initiatives contain one or more security policies. Each of those policies results in a security recommendation when your resources aren't compliant with the policy.

## Security standards

Security administrators can build their own custom security initiatives in Defender for Cloud. However, a default, built-in security initiative is automatically assigned when you first enable Defender for Cloud: the **Microsoft cloud security benchmark (MCSB)**.

### Microsoft cloud security benchmark

The Microsoft cloud security benchmark is a Microsoft-authored set of guidelines for security and compliance that provides best practices and recommendations to help improve the security of workloads, data, and services on Azure and multicloud environments. The MCSB builds on the controls from the Center for Internet Security (CIS) and the National Institute of Standards and Technology (NIST), with a focus on cloud-centric security.

The MCSB organizes its security guidance across control domains and provides the following key information:

- **ID and control domain**—Each line item in the MCSB has an identifier that maps to a specific recommendation within a control domain. Control domains include network security, data protection, identity management, privileged access, incident response, and endpoint security, among others.
- **Mapping to industry frameworks**—The MCSB maps recommendations to existing industry frameworks including CIS, NIST, and the Payment Card Industry Data Security Standards (PCI DSS). This mapping makes security and compliance simpler for organizations operating in regulated industries or those already working with these frameworks.
- **Recommendation**—For each control domain, there can be many distinct recommendations. For example, the "Network Security" control domain includes recommendations for establishing network segmentation boundaries, securing network traffic, and protecting web applications, among others.
- **Azure Guidance**—Provides guidance on how to implement a control using Azure features and services, with relevant technical details.
- **AWS and GCP Guidance**—The MCSB also provides implementation guidance for Amazon Web Services and Google Cloud Platform environments, making it valuable for multicloud organizations.

The MCSB also includes links to additional implementation information and details about which security functions in the customer organization may be accountable or responsible for each control.

:::image type="content" source="../media/microsoft-cloud-security-benchmark-v1-inline.png" lightbox="../media/microsoft-cloud-security-benchmark-v1-expanded.png" alt-text="Screenshot of a subset of information from the Microsoft cloud security benchmark v1.":::

### Microsoft cloud security benchmark in Defender for Cloud

Microsoft Defender for Cloud continuously assesses your hybrid cloud environment to analyze risk factors according to the controls and best practices in the MCSB. The regulatory compliance dashboard in Defender for Cloud reflects the status of your compliance with the MCSB and any other standards that you've applied to your subscriptions.

Some of the control domains used in the MCSB include network security, identity and access control, data protection, data recovery, incident response, and more.

:::image type="content" source="../media/defender-cloud-compliance-inline.png" lightbox="../media/defender-cloud-compliance-expanded.png" alt-text="Screenshot of Microsoft Defender for Cloud showing status of regulatory compliance against Microsoft cloud security benchmark.":::

## Security recommendations

Recommendations are the result of assessing your resources against the relevant policies and identifying resources that aren't meeting your defined requirements.

Defender for Cloud periodically analyzes the compliance status of your resources to identify potential security misconfigurations and weaknesses. It then provides recommendations on how to remediate those issues. Recommendations are based on your chosen initiatives and the MCSB default initiative. When a policy from an initiative is compared against your resources and finds one or more that aren't compliant, it's presented as a recommendation in Defender for Cloud.

Each recommendation provides you with the following information:

- A short description of the security issue
- The remediation steps to carry out to implement the recommendation
- The affected resources

Recommendations also include a severity level—high, medium, or low—indicating how urgently the issue should be addressed. A high-severity recommendation points to a significant exposure that could be exploited quickly. A low-severity recommendation still represents a risk, but one that is less likely to be targeted immediately. Prioritizing recommendations by severity helps security teams focus first on the actions that have the greatest impact on their security posture.

In the Defender CSPM plan, recommendations are further enriched with risk prioritization. This capability considers factors like internet exposure and whether the affected resource holds sensitive data, so that a recommendation for a resource that is both publicly accessible and contains customer records appears more urgently than one for an isolated internal resource with a similar configuration gap.

## Regulatory compliance standards

The Microsoft cloud security benchmark is the default standard in Defender for Cloud, but many organizations must also demonstrate compliance with other regulatory and industry frameworks. Defender for Cloud lets you add standards such as ISO 27001, SOC 2, NIST SP 800-53, and PCI DSS to your compliance assessments.

When you add a regulatory standard to Defender for Cloud, it assesses your environment against that standard and shows your compliance status in the regulatory compliance dashboard. The dashboard displays each control within the standard and indicates how many of your resources pass or fail that control. This view helps compliance teams understand where gaps exist and what actions are needed to close them.

A significant benefit of this approach is that addressing a single security recommendation can improve your compliance status across multiple standards at once. For example, enabling multifactor authentication (MFA) for all privileged accounts might contribute to compliance with ISO's 27001 access management controls, NIST's identity management requirements, and PCI DSS's authentication standards simultaneously. This overlap means that security improvements and compliance improvements reinforce each other, making both efforts more efficient.

Security policies, standards, and recommendations work together in a continuous cycle that helps organizations systematically reduce their attack surface and strengthen their security posture.
