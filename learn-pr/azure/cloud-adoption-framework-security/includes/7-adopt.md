This unit describes areas of security optimization to consider as you move through the [Adopt methodology](/azure/cloud-adoption-framework/secure/adopt/) phase of your journey.

:::image type="content" source="../media/caf-secure-adopt.svg" alt-text="Diagram that shows the Adopt phase of the Secure methodology." lightbox="../media/caf-secure-adopt.svg" border="false":::

When you implement your cloud estate and migrate workloads, establish robust security mechanisms from the start to avoid gaps later. Prioritize security during the Adopt phase to ensure consistent workloads. To prepare IT teams for cloud operations, establish well-designed policies and procedures.

The Adopt methodology includes the [Migrate](/azure/cloud-adoption-framework/migrate/), [Modernize](/azure/cloud-adoption-framework/modernize/), [Innovate](/azure/cloud-adoption-framework/innovate/), and [Relocate](/azure/cloud-adoption-framework/relocate/) scenarios. Consider the recommendations in this unit to help establish a secure foundation for your cloud estate.

## Modernize your security posture

To [modernize your security posture](/azure/cloud-adoption-framework/secure/adopt#security-posture-modernization-adoption) during the Adopt phase, consider the following recommendations:

- **Define security baselines** that include availability requirements to establish a clear foundation. Use tools to analyze environments and reduce human error.

- **Embrace automation** for routine tasks to improve consistency and reduce errors. Automate failover, recovery, infrastructure deployments, software development, testing, monitoring, alerting, and scaling.

- **Implement Zero Trust access and authorization controls.** Use role-based access control (RBAC) and multifactor authentication (MFA) to help prevent unauthorized access and ensure service availability.

## Incorporate ACM methodologies

Effective [adoption and change management (ACM) methodologies](/azure/cloud-adoption-framework/secure/adopt#change-management-institutionalization) are crucial for implementing access controls. Key methodologies include:

- **[The Prosci ADKAR Model](https://www.prosci.com/methodology/adkar):** This model focuses on Awareness, Desire, Knowledge, Ability, and Reinforcement. Address each element to ensure that employees understand and support access controls.

- **[The Kotter's 8-Step Change Model](https://www.kotterinc.com/methodology/8-steps/):** This model outlines steps for change, including creating urgency, forming a coalition, developing a vision, and anchoring new approaches into the culture.

- **[The Lewin's Change Management Model](https://whatfix.com/blog/lewins-change-model/):** This model consists of three stages: Unfreeze (prepare for change), Change (implement new processes), and Refreeze (solidify new practices).

- **[The Microsoft 365 Adoption Framework](https://adoption.microsoft.com/files/assets/M365AdoptionGuide.pdf):** This framework provides a structured approach that includes success criteria, stakeholder engagement, and support to help ensure effective adoption.

## Azure facilitation

- [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) from the Defender XDR suite helps you set security baselines and provides improvement recommendations.

- [Bicep](/azure/azure-resource-manager/bicep/overview), [Terraform](/azure/developer/terraform/overview), or [Azure Resource Manager (ARM)](/azure/azure-resource-manager/templates/overview) templates deploy infrastructure as code (IaC). Integrate them into [Azure Pipelines](/azure/azure-resource-manager/bicep/add-template-to-azure-pipelines) or [GitHub Actions](/devops/deliver/iac-github-actions) CI/CD pipelines. Use Microsoft Defender for Cloud to [identify misconfigurations in IaC](/azure/defender-for-cloud/iac-vulnerabilities).

- [Azure Deployment Environments](/azure/deployment-environments/overview-what-is-azure-deployment-environments) create consistent app infrastructure via project-based templates. These templates help ensure security, compliance, and cost efficiency.

  Define deployment environments as catalog items in GitHub or Azure DevOps repositories. A catalog item consists of an IaC template and a manifest.yml file.

- [Azure Logic Apps](/azure/logic-apps/logic-apps-overview) and [Power Automate](/power-automate/flow-types) build workflows for tasks, like approval flows or ChatOps integrations, via built-in connectors and templates.

- The [built-in scaling capabilities](/azure/architecture/best-practices/auto-scaling) of Azure technologies dynamically allocate resources to match performance requirements. You can also program other services to scale automatically via APIs.

- [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups) automate self-healing operations when alerts are triggered. You can define the operations via runbooks, Azure functions, or webhooks.

- For routine task automation, use the following services:

  - [Azure Functions](/azure/azure-functions/functions-overview) automates tasks via serverless functions with event-driven triggers.

  - [Azure Automation](/azure/automation/overview) uses PowerShell and Python for operational tasks. Automation has features like run history, logging, and integration with secrets stores and source control.
  - [Azure Update Manager](/azure/update-manager/overview) manages updates for virtual machines to help ensure compliance and schedule updates.

## Adopt incident preparedness and response

To align your cloud estate with business goals, develop preparedness and response mechanisms and an incident response plan. Address incident preparedness from two perspectives: threat readiness and mitigation, and infrastructure and application security.

- **Threat detection and mitigation**

  - Set up alert systems to detect unusual activities in real-time, and integrate extended detection and response (XDR) and security information and event management (SIEM) solutions.

  - Identify and mitigate vulnerabilities regularly through patch management and security updates.

  - Develop and maintain an incident response plan that has detection, analysis, and remediation steps. Automate mitigation activities to enhance efficiency and reduce human error. For example, use a runbook to automatically lock SQL connections if a SQL injection is detected.

- **Infrastructure and application security**

  - Integrate security checks into CI/CD pipelines to help ensure secure development, testing, and deployment. Include static code analysis, vulnerability scanning, and compliance checks.

  - Deploy all infrastructure through code to prevent misconfigurations and unauthorized deployments. Colocate IaC assets with application code, and apply the same [deployment practices](/azure/well-architected/operational-excellence/safe-deployments) as software.

### Azure facilitation

- [Defender XDR](/defender-xdr/m365d-autoir) automates threat detection and response.

- [Deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks) manage Azure resources as a single, cohesive unit. You can use [deny settings](/azure/azure-resource-manager/bicep/deployment-stacks) to prevent users from performing unauthorized modifications.

## Adopt the principle of confidentiality

Effectively implement and institutionalize encryption and secure access controls across your enterprise cloud environment. Implement data loss prevention (DLP) measures to protect sensitive data in transit and data at rest. 

- **Implement encryption and secure access controls** to protect sensitive information. Train employees on data confidentiality and DLP policies.

- **Incorporate and adopt associated standards** for encryption, such as AES-256, and access controls, such as RBAC and conditional access.
  - Enable encryption on data stores, and consider managing your own keys. Use extra encryption layers when possible.

  - Apply RBAC, conditional access, just-in-time, and just-enough-access controls to all data stores. Regularly review permissions and restrict write access to configuration systems.
  - Develop standards to help ensure data protection. For example, encrypt sensitive emails by using Microsoft Purview Information Protection to ensure data protection during transmission.

### Azure facilitation

- [Microsoft Sentinel](/azure/sentinel/overview) is a scalable, cloud-native SIEM and SOAR solution for threat detection, investigation, response, and proactive hunting.

- [Azure encryption](/azure/security/fundamentals/encryption-overview) provides encryption for services like Azure SQL Database, Cosmos DB, and Azure Data Lake. It supports server-side and client-side encryption models.

- [Azure confidential computing](/azure/confidential-computing/overview) helps protect data in use with hardware-based trusted implementation environments, which enhances data security even from cloud administrator access.

- [Microsoft Entra ID](/entra/fundamentals/whatis) provides identity and access management with MFA, conditional access, and single sign-on.

  - [Microsoft Entra ID Protection](/entra/id-protection/overview-identity-protection) uses machine learning to identify sign-in risks and unusual behavior, which prevents identity compromise and credential theft.

  - [Microsoft Defender for Identity](/defender-for-identity/what-is) is a cloud-based solution for detecting and investigating advanced identity threats.

## Adopt the principle of integrity

Build your systems according to the standards that you developed in earlier phases to [help ensure data and system integrity](/azure/cloud-adoption-framework/secure/adopt#adopt-the-principle-of-integrity). Train engineers, administrators, and operators on the relevant protocols and procedures.

- **Adopt data integrity.**
  - Automate data classification when possible. Manually label documents and containers as needed. Use ready-made tools to identify sensitive information and curate data sets with expert input.

  - Use built-in verification features in services like Azure Data Factory. To help ensure data integrity and store hashes to track changes, use SQL functions like `CHECKSUM` and `BINARY_CHECKSUM`.
  - Monitor data stores for changes, and configure alerts for incidents that affect data integrity.
  - Apply backup policies across systems. Understand and configure backup capabilities in PaaS and SaaS services, like SQL Database.
  - Publish application design standards that include data integrity mechanisms, such as tracking configuration and data changes within your data schema.

- **Adopt system integrity.**
  - Use a robust monitoring solution to automatically enroll all resources and enable alerting for incident notifications.

  - Deploy a system that continuously enrolls and manages configurations for new systems.
  - Implement a patch management system that automatically enrolls new systems and manages patching according to your policies, preferably by using native cloud platform tools.

### Azure facilitation

- [Microsoft Purview](/purview/purview) provides manual and automatic [data classification](/purview/concept-classification) and [sensitivity labeling](/purview/create-sensitivity-label) to govern, protect, and manage data.

- [Azure Arc](/azure/azure-arc/overview) provides centralized management for cloud and on-premises systems, which extends security baselines, policies, and monitoring.
- [Update Manager](/azure/update-manager/overview) supports unified update management for Windows and Linux machines across Azure, on-premises, and multicloud environments, with built-in support for Azure Policy and Azure Arc.

## Adopt the principle of availability

Focus on establishing and codifying operational practices that [support availability](/azure/cloud-adoption-framework/secure/adopt#adopt-the-principle-of-availability).

- **Plan for continuous operations**, even under attack conditions. Establish rapid recovery processes and maintain critical services at a degraded level.

- **Implement a well-designed monitoring and alerting system** to detect security incidents in real-time, and initiate response plans quickly.

- **Standardize system updates, schedule regular maintenance, and conduct health checks** to ensure optimal functioning.

- **Enforce security standards** through tooling-supported policies to help ensure compliance and auditability.

- **Develop and test disaster recovery plans.** Automate recovery activities, such as automatic failover in SQL Database.

- **Use cloud platform service-level agreements (SLAs)** to develop target metrics for your own SLAs and help ensure guaranteed uptime for your workloads.

- **Adhere to regulations like the GDPR and HIPAA** to help ensure that systems meet high standards. Train staff regularly on compliance and risk management.

### Azure facilitation

- [Azure Policy](/azure/governance/policy/overview) is a policy management solution that helps enforce organizational standards and assess compliance at scale.

- [Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) provides security policies that can automate compliance with your security standards.
- Azure [built-in recovery capabilities](/azure/reliability/overview-reliability-guidance) support operational continuity and disaster recovery plans.

## Adopt security sustainment

Ensure that your workload can sustain and continuously improve your new security mechanisms and practices.

- **Create a security review board.** Continuously review projects and mandate security controls. Regularly improve processes to keep security a priority.

- **Implement a vulnerability management solution.** Monitor and act on security vulnerability risk scores, track common vulnerabilities, and apply mitigations regularly.

- **Harden production infrastructure.** To help secure your cloud estate, follow industry best practices like Center for Internet Security (CIS) benchmarks.

- **Use the MITRE ATT&CK knowledge base.** Develop threat models and methodologies based on real-world attack tactics and techniques.

- **Shift left.** Use segregated environments for preproduction and production to integrate security into all development phases.

### Azure facilitation

[Microsoft Defender Vulnerability Management](/defender-vulnerability-management/defender-vulnerability-management) is a comprehensive risk-based vulnerability management solution. It identifies, assesses, remediates, and tracks your biggest vulnerabilities across your most critical assets.