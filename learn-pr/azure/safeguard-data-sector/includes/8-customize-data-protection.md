While data protection is essential for everyone in the public sector, each customer has unique requirements. Government agencies can take advantage of many additional Azure services for more protection or to comply with local regulations. 

Customers can use the following Azure services for in-depth insight into their Azure resources and to get alerted about suspicious activity, including outside attacks aimed at their applications and data. The [Microsoft cloud security benchmark](/security/benchmark/azure/) also provides security recommendations and implementation details to help customers improve the security posture with respect to Azure resources.

**[Microsoft Defender for Cloud](https://azure.microsoft.com/services/security-center/)** provides unified security management and advanced threat protection across hybrid cloud workloads. This is a key service for customers to limit their exposure to threats, protect cloud resources, [respond to incidents](/azure/security-center/security-center-alerts-overview), and improve their regulatory compliance posture.

With Microsoft Defender for Cloud, customers can:

* Monitor security across on-premises and cloud workloads.
* Use advanced analytics and threat intelligence to detect attacks.
* Use access and application controls to block malicious activity.
* Find and fix vulnerabilities before they can be exploited.
* Simplify investigation when responding to threats.
* Apply policy to follow security standards.

**[Azure Monitor](https://azure.microsoft.com/services/monitor/)** helps customers increase application availability and performance delivering a comprehensive solution for collecting, analyzing, and acting on telemetry from both cloud and on-premises environments. It helps customers understand how their applications are performing and proactively identifies issues affecting deployed applications and resources on which they depend. Azure Monitor has access to the capabilities of Log Analytics and [Application Insights](/azure/azure-monitor/app/app-insights-overview), previously available as standalone services.

Azure Monitor collects data from each of the following tiers:

* **Application monitoring data**: Data about the performance and functionality of the code customers have written, regardless of its platform.

* **Guest OS monitoring data**: Data about the operating system on which customer application is running. The application could be running in Azure, another cloud, or on-premises.

* **Azure resource monitoring data**: Data about an Azure resource's operation.

* **Azure subscription monitoring data:** Data about an Azure subscription's operation and management, as well as data about Azure itself's health and operation.

* **Azure tenant monitoring data:** Data about tenant-level Azure services' operation; for example, Azure Active Directory.

With Azure Monitor, customers can get a 360-degree view of their applications, infrastructure, and network with advanced analytics, dashboards, and visualization maps. Azure Monitor provides intelligent insights and allows for better decisions with AI. Customers can analyze, correlate, and monitor data from various sources using a powerful query language and built-in machine-learning constructs. Azure Monitor also provides out-of-the-box integration with popular DevOps, IT Service Management (ITSM), and Security Information and Event Management (SIEM) tools.

**[Azure Policy](/azure/governance/policy/overview)** enables effective governance of Azure resources by creating, assigning, and managing policies. These policies enforce various rules over provisioned Azure resources to keep them compliant with specific customer corporate security and privacy standards. For example, one of the built-in policies for Allowed Locations can be used to restrict available locations for new resources to enforce customer's geo-compliance requirements. Azure Policy provides a complete compliance view of all provisioned resources and enables cloud policy management and security at scale.

**[Azure Firewall](https://azure.microsoft.com/services/azure-firewall/)** provides a managed, cloud-based network-security service that protects customer Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability that works with Azure Monitor for logging and analytics.

**[Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview)** allows customers to monitor, diagnose, and gain insights into their Azure virtual network performance and health. With Network Security Group flow logs, customers can gain deeper understanding of their network traffic patterns and collect data for compliance, auditing, and monitoring of their network-security profile. Packet capture allows customers to capture traffic to and from their virtual machines to diagnose network anomalies and gather network statistics, including information on network intrusions.

**[Azure DDoS Protection](https://azure.microsoft.com/services/ddos-protection/)** provides extensive Distributed Denial of Service (DDoS) mitigation capability to help customers protect their Azure resources from attacks. Always-on traffic monitoring provides near real-time detection of a DDoS attack, with automatic mitigation of the attack as soon as it's detected. In combination with Web Application Firewall, DDoS Protection defends against a comprehensive set of network-layer attacks, including SQL injection, cross-site scripting attacks, and session hijacks. Azure DDoS Protection is integrated with Azure Monitor for analytics and insight.

**[Microsoft Sentinel](https://azure.microsoft.com/services/azure-sentinel/)** is a cloud-native SIEM platform that uses built-in AI to help customers quickly analyze large amounts of data across an enterprise. Microsoft Sentinel aggregates data from a variety of sources, including users, applications, servers, and devices running on-premises or in any cloud, letting customers reason over millions of records in a few seconds. With Microsoft Sentinel, customers can:

* **Collect** data at cloud scale across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
* **Detect** previously uncovered threats and minimize false positives using analytics and unparalleled threat intelligence from Microsoft.
* **Investigate** threats with AI and hunt suspicious activities at scale, tapping into decades of cybersecurity work at Microsoft.
* **Respond** to incidents rapidly with built-in orchestration and automation of common tasks.

**[Azure Advisor](https://azure.microsoft.com/services/advisor/)** helps customers follow best practices to optimize their Azure deployments. It analyzes resource configurations and usage telemetry and then recommends solutions that can help customers improve the cost effectiveness, performance, high availability, and security of Azure resources.

**[Azure Blueprints](https://azure.microsoft.com/services/blueprints/)** is a service that helps customers deploy and update cloud environments in a repeatable manner. It uses composable artifacts such as Azure Resource Manager templates to provision resources, role-based access controls, and policies that adhere to an organization's standards, patterns, and requirements. Customers can use predefined standard blueprints, as well as customize these solutions to meet specific requirements, including data encryption, host and service configuration, network and connectivity configuration, identity, and other security aspects of deployed resources.

The overarching goal of Azure Blueprints is to help automate compliance and cybersecurity risk management in cloud environments. For more information on Azure Blueprints, including production-ready blueprint solutions for ISO 27001, NIST SP 800-53, PCI DSS, HITRUST, and other standards, see the [Azure Blueprints guidance](/azure/governance/blueprints/overview).

Now, let's review what you've learned with a brief knowledge check.
