This unit describes areas of security optimization to consider as you move through the [Govern methodology](/azure/cloud-adoption-framework/secure/govern/) phase of your journey.

:::image type="content" source="../media/caf-secure-govern.svg" alt-text="Diagram that shows the Govern phase of the Secure methodology." lightbox="../media/caf-secure-govern.svg" border="false":::

Security governance aligns your business priorities with technical implementations like architecture, standards, and policies. Your governance teams oversee and monitor security to maintain and enhance your security posture.

## Modernize your security posture

Cloud technology provides on-demand visibility into your [security posture](/azure/cloud-adoption-framework/secure/govern#security-posture-modernization) and asset coverage. Cloud governance fosters close collaboration with security teams to monitor security standards, provide guidance, and enhance processes. Proper governance drives continuous improvement throughout your organization.

- **Discover assets and asset types continuously in your dynamic cloud environment** to manage inventory effectively. Workload owners dynamically adjust the number of application and service instances as needed, which creates a constantly changing environment. 

- **Improve and enforce standards** to adapt to new threats and evolving attacker techniques.
- **Define and apply policies** automatically across resources to ensure consistent implementation and reduce manual tasks, often by using Azure Policy or other frameworks.

### Azure facilitation

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) can help you continuously discover and automatically manage virtual machines in your environment through automatic data collection provisioning.

- [Microsoft Defender for Cloud Apps](/defender-cloud-apps/what-is-defender-for-cloud-apps) can help you continuously discover and govern software as a service (SaaS) apps in your environments.

## Govern incident preparedness and response

To strictly enforce standards, robust governance mechanisms and practices must support the implementation of [preparedness and response](/azure/cloud-adoption-framework/secure/govern#incident-preparedness-and-response) mechanisms and operational practices.

- **Govern incident preparedness.**

  - Use tools to automate policy management, hardening measures, data protection, and identity standards. This practice helps ensure compliance with security standards and frameworks.

  - Follow Microsoft security recommendations to help secure existing deployments and correctly configure new deployments. This approach helps reduce misconfiguration risks.

- **Govern incident response.**

  - Maintain your incident response plan with critical care. Store it in a highly available and secure location, review and update it regularly, and ensure that teams use the latest version.

  - Version control incident response training materials. Review and update them regularly.

### Azure facilitation

- [Azure Policy](/azure/governance/policy/overview) is a policy management solution that you can use to help enforce organizational standards and to assess compliance at-scale. 

- [Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) provides security policies that can automate compliance with your security standards.

## Govern confidentiality

[Govern confidentiality](/azure/cloud-adoption-framework/secure/govern#confidentiality-governance) to protect sensitive information and maintain trust.

- **Implement access control, data encryption, and data masking or tokenization policies** to maintain data confidentiality through stringent controls and robust encryption.

- **Establish written policies** for data handling, access, and protection to help ensure consistency, compliance, and clear guidelines for employees. These documents serve as a reference for audits and assessments.

- **Continuously monitor and audit data loss protection (DLP) measures, review and update policies, conduct security assessments, and respond to incidents.** Implement DLP programmatically for a consistent and scalable approach to protect sensitive data.

## Monitor compliance and methods of enforcement

[Monitor compliance and enforce policies](/azure/cloud-adoption-framework/secure/govern#monitor-compliance-and-methods-of-enforcement) to ensure robust security standards. This practice helps protect sensitive data from unauthorized access and breaches.

- **Conduct regular security audits** to help ensure policy compliance and identify improvements. These audits should cover regulatory, industry, and organizational standards and might involve partner assessors.

- **Use tools like Azure Policy for real-time compliance monitoring and alerts.** These tools help detect and respond to policy violations quickly, which improves continuous adherence to security standards.

- **Educate employees on data confidentiality policies and best practices** through regular training sessions. Update programs to reflect policy changes and emerging threats. Ensure that employees have the latest knowledge and skills.

## Govern integrity

To [maintain integrity practices](/azure/cloud-adoption-framework/secure/govern#integrity-governance), consider the following recommendations:

- **Use a preconfigured solution to automate data quality validation.** This approach reduces manual effort and minimizes the risk of unauthorized access and data alterations.

- **Implement a centralized tool like Azure Arc to govern systems across multiple environments.** This approach simplifies governance and reduces operational burden.

### Azure facilitation

[Microsoft Purview Data Quality](/purview/data-quality-overview) uses no-code or low-code, out-of-the-box (OOB), and AI-generated rules to assess data quality at the column level. These rules are aggregated to provide scores for data assets, products, and business domains. This approach helps ensure comprehensive visibility of data quality across each domain.

## Govern availability

To [maintain availability](/azure/cloud-adoption-framework/secure/govern#availability-governance) and avoid nonconforming patterns, follow standardized architecture designs. Regularly maintain and govern disaster recovery plans to ensure their effectiveness.

- **Govern your architecture design.**
  
  - Strictly enforce infrastructure and application design patterns.
  - Keep design standards up-to-date and secure from unauthorized changes.
  - Use policies to control resource types and deployment regions.

- **Govern disaster recovery.**

  - Govern disaster recovery plans. Store them in a highly available and secure location, review and update them regularly, and ensure that teams use the latest version.

  - Use disaster recovery drills to improve plans and refine standards. Keep meticulous records to identify improvements and ensure compliance. Store them with the plans for organization and security.

## Sustain highly secure governance

[Modern Service Management (MSM)](/azure/cloud-adoption-framework/secure/govern#modern-service-management-msm) is a set of practices and tools that manage and optimize IT services in the cloud. MSM has the following key benefits:

- MSM helps ensure efficient service delivery, high security, and compliance standards.

- MSM provides a structured approach to manage complex environments, which enables risk mitigation, continuous improvement, and quick responses to changes.

- MSM enforces data protection and monitors access controls to support the principle of confidentiality.

- MSM tools integrate security functions for a holistic view of the cloud environment. This capability helps enforce policies and detect threats in real-time.

- MSM creates, enforces, and monitors policies, which helps ensure compliance with standards and regulations. It also provides real-time insights and alerts.

- MSM continuously monitors the cloud environment to proactively address problems. This feature optimizes and improves IT services to align with business objectives.
