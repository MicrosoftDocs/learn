This unit describes areas of security optimization to consider as you move through the [Govern methodology](/azure/cloud-adoption-framework/secure/govern/) phase of your journey.

:::image type="content" source="../media/caf-secure-govern.png" alt-text="Diagram that shows the Govern phase of the Adopt methodology." lightbox="../media/caf-secure-govern.png" border="false":::

Security governance aligns your business priorities with technical implementations like architecture, standards, and policies. Your governance teams oversee and monitor security to maintain and enhance your security posture.

## Modernize your security posture

Cloud technology provides on-demand visibility into your security posture and asset coverage. Cloud governance fosters closer collaboration with other security teams to monitor security standards, provide guidance, and enhance processes. Proper governance drives continuous improvement throughout the organization.

Consider the following key principles for security governance:

- **Discover assets and asset types in the dynamic cloud environment continuously** to manage inventory effectively. Workload owners dynamically adjust the number of application and service instances as needed, which creates a constantly changing environment. 

- **Improve and enforce standards** to adapt to new threats and evolving attacker techniques.
- **Define and apply policies** automatically across resources to ensure consistent implementation and reduce manual tasks, often by using Azure Policy or other frameworks.

### Azure facilitation

- Microsoft Defender for Cloud can help you continuously discover and automatically manage virtual machines in your environment through automatic data collection provisioning.

- Defender for Cloud apps can help you continuously discover and govern software as a service (SaaS) apps in your environments.

## Support incident preparedness and response

To strictly enforce standards, robust governance mechanisms and practices must support the implementation of preparedness and response mechanisms and operational practices.

- **Govern incident preparedness.**

  - *Use tools to automate policy management, hardening measures, data protection, and identity standards.* This practice helps ensure compliance with security standards and frameworks.

  - *Follow Microsoft security recommendations* to help secure existing deployments and correctly configure new ones. This approach helps reduce misconfiguration risks.

- **Govern incident response.**

  - *Maintain the incident response plan with critical care.* Store it in a highly available and secure location, review and update it regularly, and ensure that teams use the latest version.

  - *Version control incident response training materials.* Review and update them regulary.

### Azure facilitation

- Azure Policy is a policy management solution that you can use to help enforce organizational standards and to assess compliance at-scale. 

- Defender for Cloud provides security policies that can automate compliance with your security standards.

## Govern confidentiality

Govern confidentiality to protect sensitive information and maintain trust.

- **Implement access control, data encryption, and data masking or tokenization policies** to maintain data confidentiality through stringent controls and robust encryption.

- **Establish written policies** for data handling, access, and protection to help ensure consistency, compliance, and clear guidelines for employees. These documents serve as a reference for audits and assessments.

- **Continuously monitor and audit data loss protection (DLP) measures, review and update policies, conduct security assessments, and respond to incidents.** Implement DLP programmatically for a consistent and scalable approach to protecting sensitive data.

## Monitor compliance and methods of enforcement

Monitor compliance and enforce policies to ensure robust security standards, which protects sensitive data from unauthorized access and breaches. Use the following practices:

- **Conduct regular security audits** to help ensure policy compliance and identify improvements. Include regulatory, industry, and organizational standards, possibly involving partner assessors.

- **Use tools like Azure Policy for real-time compliance monitoring and alerts.** This practice helps detect and respond to policy violations quickly, which ensures continuous adherence to security standards.

- **Educate employees on data confidentiality policies and best practices** through regular training sessions. Update programs to reflect policy changes and emerging threats. Ensure that employees have the latest knowledge and skills.

## Govern integrity

To maintain integrity practices, consider the following recomomendations:

- **Use a prebuilt solution to automate data quality validation.** This approach reduces manual effort and minimizes the risk of unauthorized access and data alterations.

- **Implement a centralized tool like Azure Arc to govern systems across multiple environments.** This approach simplifies governance and reduces operational burden.

### Azure facilitation

Microsoft Purview Data Quality uses no-code or low-code, out-of-the-box (OOB), and AI-generated rules to assess data quality at the column level. These rules are aggregated to provide scores for data assets, products, and business domains. This approach helps ensure comprehensive visibility of data quality across each domain.

## Govern availability

To maintain availability and avoid nonconforming patterns, follow standardized architecture designs. Regularly maintain and govern disaster recovery plans to ensure their effectiveness.

- **Govern your architecture design.**
  
  - Strictly enforce infrastructure and application design patterns.
  - Keep design standards up-to-date and secure from unauthorized changes.
  - Use policies to control resource types and deployment regions.

- **Govern disaster recovery.**

  - **Govern disaster recovery plans.** Store them in a highly available and secure location, review and update them regularly, and ensure that teams use the latest version.

- **Use disaster recovery drills** to improve plans and refine standards. Keep meticulous records to identify improvements and ensure compliance. Store them with the plans for organization and security.

## Sustain highly secure governance


