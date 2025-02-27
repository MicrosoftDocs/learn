This unit describes areas of security optimization to consider as you move through the [Manage methodology](/azure/cloud-adoption-framework/secure/manage/) phase of your journey.

:::image type="content" source="../media/caf-secure-manage.png" alt-text="Diagram that shows the Manage phase of the Secure methodology." lightbox="../media/caf-secure-manage.png" border="false":::

The Manage phase focuses on the ongoing operation of your cloud estate. You must maintain and strengthen your security posture continuously to successfully manage your estate.

## Modernize your security posture

Ensure that your observability platform includes thorough monitoring and intelligent alerting. To modernize this platform, adopt a proactive mindset and Zero Trust principles.

- **Assume a breach** in your systems to drive threat hunting and detection engineering. Threat hunting uses a hypothesis-based approach to analyze systems for potential breaches. Detection engineering develops specialized mechanisms to enhance observability platforms for detecting new cyberattacks.

- **Verify explicitly.** Shift from "trust by default" to "trust by exception" by validating trusted activities through visibility. Enhance your observability platform with intelligent identity and access monitoring to detect anomalous behavior in real-time.

### Azure facilitation

[Defender XDR](/defender-xdr/m365d-enable) provides advanced threat hunting across multiple domains, like endpoints, cloud apps, and identity.

## Manage incident preparedness and response

- **Prepare for incidents.**
  - Implement a security information and event management (SIEM) and security orchestration, automation, and response (SOAR) solution to enhance monitoring and respond to security incidents.

  - Scan for vulnerabilities proactively and integrate with SIEM to consolidate security data and respond efficiently.
  - Implement extended detection and response (XDR) to increase visibility into security risks and feed data into SIEM for unified monitoring and optimized security operations.

- **Plan for incident response.**
  - Modernize observability to help detect incidents detection and maintain an up-to-date incident response plan.
  
  - Keep the incident response plan current with threat hunting, detection engineering, and risk information like MITRE ATT&CK.
  - Develop and maintain incident response and disaster recovery plans.

- **Incorporate business continuity and disaster recovery.**
  - Develop and test plans to help ensure that your cloud environment is resilient and can quickly recover from incidents.

  - Create backup and recovery strategies to support business continuity with robust strategies.
  - Create workload-based recovery plans instead of a single plan for the entire business.

### Azure facilitation

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) monitors and protects resources like [servers](/azure/defender-for-cloud/plan-defender-for-servers-select-plan), [storage](/azure/defender-for-cloud/defender-for-storage-introduction), [containers](/azure/defender-for-cloud/defender-for-containers-introduction), [SQL databases](/azure/defender-for-cloud/tutorial-enable-databases-plan), and [Domain Name System (DNS)](/azure/defender-for-cloud/defender-for-dns-introduction). Defender for Cloud provides deep insights.

- [Microsoft Defender Vulnerability Management](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management) scans Azure-based or Azure Arc-enabled VMs.
- [Microsoft Sentinel](/azure/sentinel/overview) is a cloud-native SIEM and SOAR solution that integrates with Microsoft Defender for a [unified security operations platform](/azure/sentinel/microsoft-sentinel-defender-portal).
- [Automated detection and self-healing capabilities](/defender-xdr/m365d-autoir) in Defender XDR help efficiently address threats.

## Manage confidentiality

Ongoing [management of your security posture for confidentiality](/azure/cloud-adoption-framework/secure/manage#managing-confidentiality) involves regular monitoring and auditing, maintaining codified audit procedures, and finding continuous improvement opportunities.

- **Establish a regular schedule for monitoring and auditing** to detect security threats early and verify the effectiveness of policies and controls. Audits provide a comprehensive review of your security posture and identify gaps.

- **Document audit procedures** for consistency and accountability. Ensure that audits are systematic and regular, including scope, methodologies, tools, and frequency.

- **Divide responsibilities among different individuals** to prevent conflicts of interest and reduce fraud risk.

- **Update and manage user accounts regularly, revoke access for inactive users, and update permissions as roles change** to prevent unauthorized access. Include these measures in standard operating procedures.

### Azure facilitation

- [Microsoft Purview Data Loss Prevention](/purview/dlp-learn-about-dlp) detects and prevents data exfiltration through common processes that attackers use, including first-time use or renamed cloud applications.

- [Microsoft Purview Insider Risk Management](/purview/insider-risk-management-solution-overview) helps detect and prevent malicious or inadvertent insider risks, like IP theft, data leakage, and security violations.

## Manage integrity

To [manage your data and system integrity](/azure/cloud-adoption-framework/secure/manage#managing-integrity), use robust monitoring that has specific configurations to detect unauthorized asset changes. 

- **Use intelligent tooling with SIEM and SOAR solutions** to monitor data integrity, detect unauthorized access and changes, and automate incident responses like immediate lockouts.

- **Use modern monitoring platforms** to detect system changes. Implement guardrails around deployments. Immediately detect and investigate changes that are outside of approved protocols.

### Azure facilitation

[Microsoft Purview health management](/purview/data-estate-health) codifies data standards and measures compliance over time. It provides reports to track data health and assists data owners in remediating problems.

## Manage availability

- **Configure monitoring and alerting** for all infrastructure and applications. Use cloud-native logging and instrumentation to simplify monitoring and reduce operational burden.

- **Test infrastructure and applications for availability regularly.** Use fault injection and chaos testing to introduce malfunctions and test availability and security.

### Azure facilitation

In addition to Defender for Cloud solutions, use the following tools:

- [Application Insights in Azure Monitor](/azure/azure-monitor/app/codeless-overview) provides automatic instrumentation for rich telemetry monitoring. It supports many Azure-based and on-premises hosting types.

- [Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a managed service that uses chaos engineering to measure, understand, and improve cloud application and service resilience.

## Manage security sustainment

### Continuous education

- **Train teams to use advanced analytics and tools** like Microsoft Sentinel for early threat detection, continuous monitoring, and proactive identification. Include preplanned responses for rapid reaction.

- **Train your security operations team on robust strategies** that integrate Zero Trust principles, continuous identity verification, and securing access. Use decision trees and flowcharts for specific scenarios.

- **Train teams on deploying high availability and disaster recovery solutions** by using Azure services. Include preplanned responses and hands-on training for managing disruptions.

- **Conduct regular security drills** to prepare for real-world scenarios. Emphasize containment, communication, and evidence preservation. Use incident playbooks and communication protocols for consistent actions.

- **Test plans with stakeholders regularly.** Incorporate the CIA Triad and Zero Trust principles. Focus on effective coordination and rapid containment. Document actions that you take during testing for post-incident review and improvement.

### Continuous improvement strategies for confidentiality and integrity

- **Confidentiality strategies:**
  - Analyze previous audits to identify weaknesses and implement corrective actions for continuous improvement.

  - Employ real-time monitoring to quickly identify and respond to threats. This practice helps ensure up-to-date security measures.
  - Train employees on confidentiality policies and procedures. Focus on encryption and access controls. Include deeper training for security team members.

- **Integrity strategies:**
  - Perform manual audits to ensure that data governance and monitoring tools are effective.

  - Adopt proper data hygiene habits:
    - Audit data for quality and consistency.
    - Use normalization to reduce inconsistencies.
    - Archive or purge unnecessary data.
    - Review encryption configurations regularly.
  - Review and test backup configurations to ensure data validity and compliance with RTO and RPO targets.
  - Review access permissions regularly to ensure that you have extensive controls.
  - Train employees on data and system integrity policies. Provide deeper training for security team members. Emphasize DevOps practices to maintain data accuracy and reliability.