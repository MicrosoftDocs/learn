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

## Incorporate Azure

- **Establish a security baseline:** Use Microsoft Secure Score from the Microsoft Defender XDR suite to set security baselines and get improvement recommendations.

- **Infrastructure deployment automation:** Use Bicep, Terraform, or Azure Resource Manager templates (ARM templates) for infrastructure as code (IaC). Integrate them into Azure Pipelines or GitHub Actions CI/CD pipelines. Use Microsoft Defender for Cloud to identify misconfigurations in IaC.

  - Use Azure Deployment Environments to create consistent app infrastructure via project-based templates. These templates help ensure security, compliance, and cost efficiency.

  - Define deployment environments as catalog items in GitHub or Azure DevOps repositories. A catalog item consists of an IaC template and a manifest.yml file.
- For routine task automation, use the following services:

  - Azure Functions automates tasks via serverless functions with event-driven triggers.

  - Azure Automation uses PowerShell and Python for operational tasks. Automation has features like run history, logging, and integration with secrets stores and source control.
  - Azure Update Manager manages updates for virtual machines to help ensure compliance and schedule updates.
- Azure Logic Apps and Power Automate: Build workflows for tasks, like approval flows or ChatOps integrations, via built-in connectors and templates.

- Automatic scaling: Use built-in scaling capabilities of Azure technologies or program other services to scale automatically using APIs.

- Azure Monitor action groups: Automate self-healing operations when alerts are triggered. Define the operations via runbooks, Azure functions, or webhooks.

## Incident preparedness and response adoption

After you establish your landing zone or platform design with secure network segmentation and organized resources, focus on incident preparedness and response. Develop mechanisms and an incident response plan to align your cloud estate with business goals, which maintains efficiency and strategic objectives. Address incident preparedness from two perspectives: threat readiness and mitigation, and infrastructure and application security.

### Threat detection and mitigation

- **Threat detection:** Set up alert systems to detect unusual activities in real-time, and integrate XDR and SIEM solutions.

- **Vulnerability management:** Regularly identify and mitigate vulnerabilities through patch management and security updates.

- **Incident response:** Develop and maintain an incident response plan with detection, analysis, and remediation steps. Automate mitigation activities to enhance efficiency and reduce human error. For example, use a runbook to automatically lock SQL connections if a SQL injection is detected.
