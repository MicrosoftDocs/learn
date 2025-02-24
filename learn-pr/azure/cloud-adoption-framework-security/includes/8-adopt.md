This unit describes areas of security optimization to consider as you move through the [Adopt methodology](/azure/cloud-adoption-framework/secure/ready/) phase of your journey.

:::image type="content" source="../media/caf-secure-adopt.png" alt-text="Diagram that shows the Ready phase of the Adopt methodology." lightbox="../media/caf-secure-adopt.png" border="false":::

When you implement your cloud estate and migrate workloads, establish robust security mechanisms from the start to avoid gaps later. Prioritize security during the Adopt phase to ensure consistent workloads. Established security practices also prepare IT teams for cloud operations with well-designed policies and procedures.

Whether migrating or building a new cloud estate, apply the Cloud Adoption Framework's Adopt methodology, which includes Migrate, Modernize, Innovate, and Relocate scenarios. Consider these recommendations to establish a secure foundation for your cloud estate.

## Modernize your security posture

To modernize your security posture during the Adopt phase, consider the following recommendations:

- **Define security baselines** with availability requirements. Use pre-configured tools to analyze environments and reduce human error.

- **Embrace automation** for routine tasks to improve consistency and reduce errors. Automate failover, recovery, infrastructure deployments, software development, testing, monitoring, alerting, and scaling.

- **Implement Zero Trust access and authorization controls.** Use role-based access control (RBAC) and multifactor authentication (MFA) to prevent unauthorized access and ensure service availability.

## Incorporate ACM methodologies

Effective adoption and change management (ACM) methodologies are crucial for implementing access controls. Key methodologies include:

- **The Prosci ADKAR Model:** This model focuses on Awareness, Desire, Knowledge, Ability, and Reinforcement. Address each element to ensure that employees understand and support access controls.

- **The Kotter's 8-Step Change Model:** This model outlines steps for change, including creating urgency, forming a coalition, developing a vision, and anchoring new approaches into the culture.

- **The Lewin's Change Management Model:** This model consists of three stages: Unfreeze (prepare for change), Change (implement new processes), and Refreeze (solidify new practices).

- **The Microsoft 365 Adoption Framework:** This framework provides a structured approach with success criteria, stakeholder engagement, and support to ensure effective adoption.

## Azure facilitation

- **Establish a security baseline.** Use Microsoft Secure Score from the Microsoft Defender XDR suite to set security baselines and get improvement recommendations.

- **Automate infrastructure deployment.** Use Bicep, Terraform, or Azure Resource Manager templates (ARM templates) for infrastructure as code (IaC). Integrate them into Azure Pipelines or GitHub Actions CI/CD pipelines. Use Microsoft Defender for Cloud to identify misconfigurations in IaC.

- **Use Azure Deployment Environments** to create consistent app infrastructure via project-based templates. These templates help ensure security, compliance, and cost efficiency.

  Define deployment environments as catalog items in GitHub or Azure DevOps repositories. A catalog item consists of an IaC template and a manifest.yml file.
- **For routine task automation, use the following services:**

  - Azure Functions automates tasks via serverless functions with event-driven triggers.

  - Azure Automation uses PowerShell and Python for operational tasks. Automation has features like run history, logging, and integration with secrets stores and source control.
  - Azure Update Manager manages updates for virtual machines to help ensure compliance and schedule updates.
- **Use Azure Logic Apps and Power Automate** to build workflows for tasks, like approval flows or ChatOps integrations, via built-in connectors and templates.

- **Use the built-in scaling capabilities** of Azure technologies or program other services to scale automatically by using APIs.

- **Use Azure Monitor action groups** to automate self-healing operations when alerts are triggered. Define the operations via runbooks, Azure functions, or webhooks.

## Incident preparedness and response adoption

Develop mechanisms and an incident response plan to align your cloud estate with business goals. Address incident preparedness from two perspectives: threat readiness and mitigation, and infrastructure and application security.

### Threat detection and mitigation

- **Set up alert systems** to detect unusual activities in real-time, and integrate XDR and SIEM solutions.

- **Identify and mitigate vulnerabilities** regularly through patch management and security updates.

- **Develop and maintain an incident response plan** that has detection, analysis, and remediation steps. Automate mitigation activities to enhance efficiency and reduce human error. For example, use a runbook to automatically lock SQL connections if a SQL injection is detected.

### Infrastructure and application security

- **Integrate security checks into CI/CD pipelines** to ensure secure development, testing, and deployment. Include static code analysis, vulnerability scanning, and compliance checks.

- **Deploy all infrastructure through code** to prevent misconfigurations and unauthorized deployments. Colocate IaC assets with application code and apply the same deployment practices as software.

### Azure facilitation

- Use Microsoft Defender XDR to automate threat detection and response.

- Use deployment stacks to manage Azure resources as a single, cohesive unit. Prevent users from performing unauthorized modifications by using deny settings.

## Adopt the principle of confidentiality

In this step, you effectively implement and institutionalize encryption and secure access controls across the enterprise cloud environment. Implement data loss prevention (DLP) measures to protect sensitive data in transit and data at rest. 

- **Implement encryption and secure access controls** to protect sensitive information. Train employees on data confidentiality and DLP policies.

- **Incorporate and adopt associated standards** for encryption, such as AES-256, and access controls, such as RBAC and conditional access. Regularly review permissions and restrict write access to configuration systems.
  - *Enable encryption on data stores* and consider managing your own keys. Use extra encryption layers when possible.

  - *Apply RBAC, conditional access, just-in-time, and just-enough-access controls* to all data stores. Regularly review permissions and restrict write access to configuration systems.
  - *Develop standards.* For example, encrypt sensitive emails by using Microsoft Purview Information Protection to ensure data protection during transmission.

  ### Azure faciliation

- **Microsoft Sentinel** is a scalable, cloud-native SIEM and SOAR solution for threat detection, investigation, response, and proactive hunting.

- **Azure encryption** provides encryption for services like Azure SQL Database, Cosmos DB, and Azure Data Lake. It supports server-side and client-side encryption models.

- **Microsoft Entra ID** offers identity and access management with multifactor authentication, conditional access, and single sign-on.

  - *Microsoft Entra ID Protection* uses machine learning to identify sign-in risks and unusual behavior, which prevents identity compromise and credential theft.

  - *Microsoft Defender for Identity* is a cloud-based solution for detecting and investigating advanced identity threats.

- **Azure Confidential Computing** protects data in use with hardware-based trusted implementation environments, which ensures data security even from cloud administrators.

## Adopt the principle of integrity

In this step, you build your systems according to the standards that you developed in earlier phases to ensure data and system integrity. Train engineers, administrators, and operators on the relevant protocols and procedures.

- **Adopt data integrity.**
  - *Automate data classification* when possible. Manually label documents and containers as needed. Use ready-made tools to identify sensitive information and curate data sets with expert input.

  - *Use built-in verification features* in services like Azure Data Factory. Use SQL functions like `CHECKSUM` and `BINARY_CHECKSUM` to ensure data integrity and store hashes to track changes.
  - *Monitor data stores* for changes and configure alerts for incidents that affect data integrity.
  - *Apply backup policies across systems.* Understand and configure backup capabilities in PaaS and SaaS services, like Azure SQL Database.
  - *Publish application design standards* that include data integrity mechanisms, such as tracking configuration and data changes within the data schema and using standard logging mechanisms.

- **Adopt system integrity.**
  - *Use a robust monitoring solution* to automatically enroll all resources and enable alerting for incident notifications.

  - *Deploy a system that continuously enrolls and manages configurations* for new systems.
  - *Implement a patch management system* that automatically enrolls new systems and manages patching according to your policies, preferably by using native cloud platform tools.

### Azure facilitation

- **Microsoft Purview** provides manual and automatic data classification and sensitivity labeling to govern, protect, and manage data.

- **Azure Arc** provides centralized management for cloud and on-premises systems, which extends security baselines, policies, and monitoring.
- **Azure Update Manager** supports unified update management for Windows and Linux machines across Azure, on-premises, and multicloud environments, with built-in support for Azure Policy and Azure Arc.

## Adopt the principle of availability

This step focuses on establishing and codifying operational practices that support availability.

- **Plan for continuous operations**, even under attack conditions, with rapid recovery processes and maintaining critical services at a degraded level.

- **Implement a well-designed monitoring and alerting system** to detect security incidents in real-time and initiate response plans quickly.

- **Standardize system updates, schedule regular maintenance, and conduct health checks** to ensure optimal functioning.

- **Enforce security standards** through tooling-supported policies to ensure compliance and auditability.

- **Develop and test disaster recovery plans**, and automate recovery activities, such as using automatic failover in Azure SQL Database.

- **Use cloud platform service-level agreements (SLAs)** to develop target metrics for your own SLAs and help ensure guaranteed uptime for your workloads.

- **Adhere to regulations like GDPR and HIPAA** to ensure that systems meet high standards. Train staff regularly on compliance and risk management.

### Azure facilitation

- Azure Policy is a policy management solution that helps enforce organizational standards and assess compliance at scale.

- Defender for Cloud provides security policies that can automate compliance with your security standards.
- Azure built-in recovery capabilities support operational continuity and disaster recovery plans.

## Adopt security sustainment

In this step, you ensure that you can sustain and contiuously improve the security mechanisms and practices that you put in place as part of your cloud adoption.

- **Institute a security review board.** Continuously review projects and mandate security controls. Regularly improve processes to keep security top of mind.

- **Implement a vulnerability management solution.** Monitor and act on security vulnerability risk scores, track common vulnerabilities, and apply mitigations regularly.

- **Harden production infrastructure.** Follow industry best practices like CIS benchmarks to secure your cloud estate.

- **Use the MITRE ATT&CK knowledge base.** Develop threat models and methodologies based on real-world attack tactics and techniques.

- **Shift left.** Use segregated environments for preproduction and production to integrate security into all development phases.

### Azure facilitation

Microsoft Defender Vulnerability Management is a comprehensive risk-based vulnerability management solution that you can use to identify, assess, remediate, and track all your biggest vulnerabilities across your most critical assets.