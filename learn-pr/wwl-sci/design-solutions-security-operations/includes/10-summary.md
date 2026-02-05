As a security architect designing security operations for hybrid and multicloud environments, you now have the knowledge to build a unified security operations strategy using Microsoft's integrated platform. You can design monitoring, logging, detection, and response capabilities that scale across Azure, AWS, GCP, and on-premises infrastructure while optimizing costs and analyst efficiency.

## Key takeaways

- **Unified operations platform**: The Microsoft Defender portal consolidates SIEM, SOAR, and XDR capabilities into a single interface, reducing tool sprawl and enabling correlated incident management across all environments.
- **Data tiering strategy**: Use Microsoft Sentinel's analytics tier for real-time detection (30-day default retention) and data lake tier for long-term retention (up to 12 years), balancing cost with investigative needs.
- **Automation boundaries**: Design SOAR automation that starts with high-value, low-risk use cases and includes human oversight for high-impact actions like account disablement or network isolation.
- **Coverage-driven detection**: Use MITRE ATT&CK matrices (Enterprise, Cloud, Mobile, ICS) to evaluate and improve threat detection coverage systematically, including ATLAS for AI workload protection.

## Learning objectives

You learned how to:

- Design security operations capabilities in hybrid and multicloud environments
- Design centralized logging and auditing
- Design a solution for detection and response that includes extended detection and response (XDR) and security information and event management (SIEM)
- Design a solution for security orchestration, automation, and response (SOAR)
- Design security workflows
- Design and evaluate threat detection with the MITRE ATT&CK framework

## Learn more with security documentation

- [Cloud SOC functions - Cloud Adoption Framework | Microsoft Learn](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)
- [Unified operations for hybrid, multicloud, and edge - Cloud Adoption Framework | Microsoft Learn](/azure/cloud-adoption-framework/scenarios/hybrid/unified-operations)
- [Azure Monitor overview](/azure/azure-monitor/overview)
- [Evaluate and pilot Microsoft Defender XDR, an XDR solution | Microsoft Learn](/microsoft-365/security/defender/eval-overview)
- [Introduction to automation in Microsoft Sentinel | Microsoft Learn](/azure/sentinel/automation)
- [Understand threat intelligence in Microsoft Sentinel | Microsoft Learn](/azure/sentinel/understand-threat-intelligence?source=recommendations)
- [Hunting capabilities in Microsoft Sentinel | Microsoft Learn](/azure/sentinel/hunting)
- [View MITRE coverage for your organization from Microsoft Sentinel | Microsoft Learn](/azure/sentinel/mitre-coverage)
- [Design a Log Analytics workspace architecture](/azure/azure-monitor/logs/workspace-design)
- [Designing and configuring data access in a workspace](/azure/azure-monitor/logs/manage-access).
- [Sample workspace architectures for Microsoft Sentinel](/azure/sentinel/sample-workspace-designs).
- [Automate threat response with playbooks in Microsoft Sentinel](/azure/sentinel/automation/automate-responses-with-playbooks)
- [Automate threat response in Microsoft Sentinel with automation rules](/azure/sentinel/automate-incident-handling-with-automation-rules)
- [Azure Logic Apps for Microsoft Sentinel playbooks](/azure/sentinel/automation/logic-apps-playbooks)
- [Manage Microsoft Sentinel workspaces at scale](/azure/lighthouse/how-to/manage-sentinel-workspaces)
- [Protecting MSSP intellectual property in Microsoft Sentinel](/azure/sentinel/mssp-protect-intellectual-property)

## Learn more with reference architectures

- [Microsoft Sentinel automated responses - Azure Architecture Center | Microsoft Learn](/azure/architecture/solution-ideas/articles/microsoft-sentinel-automated-response)
- [Hybrid security monitoring with Microsoft Sentinel - Azure Architecture Center | Microsoft Learn](/azure/architecture/hybrid/hybrid-security-monitoring)
