This unit describes areas of security optimization to consider as you move through the [Manage methodology](/azure/cloud-adoption-framework/secure/manage/) phase of your journey.

:::image type="content" source="../media/caf-secure-manage.png" alt-text="Diagram that shows the Govern phase of the Manage methodology." lightbox="../media/caf-secure-manage.png" border="false":::

The Manage phase of a cloud adoption journey focuses on the ongoing operation of your cloud estate. You must maintain and strengthen your security posture continuously to successfully manage your estate.

## Modernize your security posture

Ensure that your observability platform includes thorough monitoring and intelligent alerting. To modernize this platform, adopt a proactive mindset and Zero Trust principles.

- **Proactively assume a breach** in your systems to drive threat hunting and detection engineering. Threat hunting uses a hypothesis-based approach to analyze systems for potential breaches. Detection engineering develops specialized mechanisms to enhance observability platforms for detecting new cyberattacks.

- **Verify explicitly.** Shift from "trust by default" to "trust by exception" by validating trusted activities through visibility. Enhance your observability platform with intelligent identity and access monitoring to detect anomalous behavior in real-time.

### Azure facilitation

Microsoft Defender XDR provides advanced threat hunting across multiple domains, like endpoints, cloud apps, and identity.

## Manage incident preparedness and response

- Prepare for incidents:
  - Implement a security information and event management (SIEM) and security orchestration, automation, and response (SOAR) solution to enhance monitoring and respond to security incidents.

  - Proactively scan for vulnerabilities and integrate with SIEM to consolidate security data and respond efficiently.
  - Implement extended detection and response (XDR) to increase visibility into security risks and feed data into SIEM for unified monitoring and optimized security operations.

- Plan for incident response:
  - Modernize observability to help detect incidents detection and maintain an up-to-date incident response plan.
  
  - Keep the incident response plan current with threat hunting, detection engineering, and risk information like MITRE ATT&CK.
  - Develop and maintain both incident response and disaster recovery plans.

- Incorporate business continuity and disaster recovery:
  - Develop and test plans to ensure that your cloud environment is resilient and can quickly recover from incidents.

  - Create backup and recovery strategies to support business continuity with robust strategies.
  - Create workload-based recovery plans instead of a single plan for the entire business.

### Azure facilitation

- Microsoft Defender for Cloud monitors and protects resources like servers, storage, containers, SQL databases, and DNS, providing deep insights.

- Defender for Servers includes Microsoft Defender Vulnerability Management for scanning Azure-based or Azure Arc-enabled VMs.
- Microsoft Sentinel is a cloud-native SIEM and SOAR solution that integrates with Microsoft Defender for a unified security operations platform.
- Defender XDR provides automated detection and self-healing capabilities to efficiently address threats.

## Manage confidentiality

Ongoing management of your security posture for confidentiality involves regular monitoring and auditing, maintaining codified audit procedures, and finding continuous improvement opportunities.

- **Establish a regular schedule for monitoring and auditing** to detect security threats early and verify the effectiveness of policies and controls. Audits provide a comprehensive review of your security posture and identify gaps.

- **Document audit procedures** for consistency and accountability. Ensure that audits are systematic and regular, including scope, methodologies, tools, and frequency.

- **Divide responsibilities among different individuals** to prevent conflicts of interest and reduce fraud risk.

- **Update and manage user accounts regularly, revoke access for inactive users, and update permissions as roles change** to prevent unauthorized access. Include these measures in standard operating procedures.

### Azure facilitation

