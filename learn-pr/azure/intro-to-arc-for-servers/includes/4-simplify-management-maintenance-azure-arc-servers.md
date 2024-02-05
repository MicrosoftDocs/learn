Azure Arc also simplifies the process of centralizing and standardizing enterprise-wide management, monitoring, and protection of technology assets regardless of their location. In this unit, you'll learn how this principle applies to on-premises servers, including Azure Arc-enabled servers.

## What are the security benefits of Microsoft Defender for Cloud in hybrid scenarios?

To address the security challenges inherent to hybrid environment, such as high volatility and dependencies on external services, you need sophisticated tools that help assess your security posture and identify and remediate risks. Ideally, you want to deploy those tools with minimal effort. Microsoft Defender for Cloud can help you address these requirements.

Defender for Cloud is a cloud-based service for managing the security of your cloud and on-premises infrastructure and workloads. With Defender for Cloud capabilities, you can:

- **Improve your security stance**: Use Defender for Cloud to implement security best practices across your cloud services and on-premises servers. In addition to security best practices, you can also track compliance against regulatory standards.
- **Protect your environment**: Monitor for security threats to your cloud and on-premises servers with Defender for Cloud.
- **Protect your data**: Identify suspicious activity against your servers, files, and databases including potential data breaches.

Defender for Cloud relies on the Log Analytics agent to collect security-related events, application crash dumps, and operating system configuration settings. It continuously analyzes collected data, provides you with remediation recommendations, and generates security alerts in response to attempted and actual security breaches and exploits.

> [!NOTE]
> Azure Arc-enabled servers require Microsoft Defender for Cloud.

## What are the security benefits of Microsoft Sentinel in hybrid scenarios?

Microsoft Sentinel is a scalable, cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution. Microsoft Sentinel delivers intelligent security analytics and threat intelligence, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response.

Microsoft Sentinel is your birds-eye view across your multicloud and hybrid infrastructure, alleviating the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames. With Microsoft Sentinel, you can:

- Collect data at cloud scale across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- Detect previously undetected threats, and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- Investigate threats with artificial intelligence and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
- Respond to incidents rapidly with built-in orchestration and automation of common tasks.

## What are the observability benefits of Azure Monitor in hybrid scenarios?

With Azure Arc-enabled servers, the Azure portal can serve as a centralized dashboard for status monitoring and a launching pad for management of all your Azure Arc-enabled servers, along with all of your Azure and Azure Arc-enabled resources. The home page of the Azure Arc-enabled servers lists all of your servers, along with their resource groups, locations, and associated subscriptions. For each server, you can readily identify its name, OS version, and build.

More in-depth monitoring, alerting, log collection, and log analytics are available through integration with Azure Monitor. Azure Monitor is a comprehensive solution for collecting, analyzing, and responding to telemetry from cloud and on-premises environments. Azure Monitor offers three main capabilities:

- **Monitoring and metrics visualization**: Metrics are numerical values that represent the health status of monitored systems.
- **Querying and analyzing logs**: Logs include activity, diagnostic, and telemetry. Their analysis provides deep insights into the state of monitored systems and helps facilitate troubleshooting.
- **Alerting and remediation**: Alerts notify you of anomalous conditions. You can also configure them to automatically initiate a corrective action to remediate the issue that resulted in the alert. It's also possible to configure alerts to raise an incident or create a work item through integration between Azure Monitor and your internal IT Service Management platform.

You can store and analyze near real-time and historical data in a Log Analytics workspace. This requires installing the Log Analytics agent. For additional insight into interaction between servers and other systems in your environment, you can install the Dependency Agent. The same Log Analytics agent allows you to onboard your serves to other Azure services, such as Update Management, Change Tracking and Inventory, and Microsoft Defender for Cloud.

![Screenshot that depicts the Map tab on the Insights page for a VM in Azure. ContosoVM1 is displayed with details of open TCP ports. A VM summary is also displayed, detailing the VM's operating system, IP address, and links for Health, Machine properties, and Azure VM properties. Three buttons are displayed for access to Properties (selected), Log Events, Alerts, and Connections.](../media/4-insights-map.png)

Once you install and configure the agent, servers will start forwarding telemetry to the Log Analytics workspace of your choice. You can subsequently display the collected data via Azure Monitor dashboards and analyze via Log Analytics queries. You can also implement metric or log-based rules that trigger alerts and autoremediation tasks.

## What are the benefits of Log Analytics with Azure Arc-enabled servers?

Azure Arc-enabled servers offers advantages when it comes to the onboarding process, because you can use VM extensions or Azure Policy to deploy the Log Analytics agent. This streamlines the deployment process, allows for centralized, at-scale management from any location via the Azure portal, and facilitates agent maintenance, considerably simplifying identifying and upgrading out-of-date agents.

In addition, integration with Azure Resource Manager provides support for the resource context access to Log Analytics data. Resource context allows you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because each Azure Arc-enabled server exists as an Azure resource, you can control access to its Log Analytics logs by relying on Azure role-based access control (Azure RBAC) permissions assigned to that resource.

Choose the best response for each of the following questions, then select **Check your answers**.
