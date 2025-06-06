Azure Arc helps simplify and standardize enterprise-wide management, monitoring, and protection of technology assets, regardless of their location. In this unit, you'll learn how these benefits apply to Azure Arc-enabled servers through Microsoft Defender for Cloud, Microsoft Sentinel, and Azure Monitor.

## What are the security benefits of Microsoft Defender for Cloud in hybrid scenarios?

To address the security challenges inherent to hybrid environments—such as high volatility and dependencies on external services—you need sophisticated tools that help assess your security posture and identify and remediate risks. Ideally, you want to deploy those tools with minimal effort. Microsoft Defender for Cloud can help you address these requirements.

Defender for Cloud helps manage the security of your cloud and on-premises infrastructure and workloads. With Defender for Cloud capabilities, you can:

- **Improve your security stance**: Implement security best practices across your cloud services and on-premises servers, and track compliance against regulatory standards.
- **Protect your environment**: Monitor for security threats to your servers.
- **Protect your data**: Identify suspicious activity against your servers, files, and databases, including potential data breaches.

Defender for Cloud continuously analyzes collected data, provides you with remediation recommendations, and generates security alerts in response to attempted and actual security breaches and exploits.

## What are the security benefits of Microsoft Sentinel in hybrid scenarios?

Microsoft Sentinel is a scalable, cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution. Microsoft Sentinel delivers intelligent security analytics and threat intelligence, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response. y providing a birds-eye view across the enterprise, Microsoft Sentinel helps alleviate the stress of dealing with increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

With Microsoft Sentinel, you can:

- Collect data at cloud scale across all users, devices, applications, and infrastructure, including on-premises and across multiple clouds.
- Detect previously undetected threats and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- Investigate threats with artificial intelligence and hunt for suspicious activities at scale.
- Respond to incidents rapidly with built-in orchestration and automation of common tasks.

## What are the observability benefits of Azure Monitor in hybrid scenarios?

The Azure portal can serve as a centralized dashboard for status monitoring and a launching pad for management of your Arc-enabled servers. You can view details for each server, including its name, OS version, location, associated subscription, and other details.

More in-depth monitoring, alerting, log collection, and log analytics are available through integration with Azure Monitor. Azure Monitor is a comprehensive solution for collecting, analyzing, and responding to telemetry from cloud and on-premises environments. Azure Monitor offers three main capabilities that can be used with Azure Arc-enabled servers:

- **Monitoring and metrics visualization**: Metrics are numerical values that represent the health status of monitored systems, presented in ways that help you understand the state of your servers.
- **Querying and analyzing logs**: Logs include activity, diagnostic, and telemetry. Their analysis provides deep insights and helps facilitate troubleshooting.
- **Alerting and remediation**: Alerts notify you of anomalous conditions. You can configure alerts to automatically initiate a corrective action that remediates these issues. You can also configure alerts to raise an incident or create a work item through integration between Azure Monitor and your internal IT Service Management platform.

Once you install and configure Azure Monitor agent, servers will start forwarding telemetry to a Log Analytics workspace. You can subsequently display the collected data in Azure Monitor dashboards, and analyze it through Log Analytics queries. You can also implement rules that trigger alerts and autoremediation tasks.
