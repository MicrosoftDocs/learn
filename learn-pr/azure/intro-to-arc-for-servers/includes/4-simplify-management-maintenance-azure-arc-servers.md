Azure Arc also simplifies the process of centralizing and standardizing enterprise-wide management, monitoring, and protection of technology assets regardless of their location. In this unit, you will learn how this principle applies to on-premises servers, including Azure Arc enabled servers considerations.

## What are the benefits of Azure Monitor in hybrid scenarios?

With Azure Arc enabled servers, the Azure portal can serve as a centralized dashboard for status monitoring and a launching pad for management of all your Azure Arc enabled servers, along with all of your Azure and Azure Arc enabled resources. The home page of the Azure Arc enabled servers lists all of your servers, along with their resource group, location, and associated subscription. For each server, you can readily identify its name, OS version and build. 

More in-depth monitoring, alerting, log collection, and log analytics are available through integration with Azure Monitor. Azure Monitor is a comprehensive solution for collecting, analyzing, and responding to telemetry from cloud and on-premises environments. Azure Monitor offers three main capabilities:

- Monitoring and metrics visualization. Metrics are numerical values that represent the health status of monitored systems.
- Querying and analyzing logs. Logs include activity, diagnostic, and telemetry. Their analysis provides deep insights into the state of monitored systems and helps facilitate troubleshooting.
- Alerting and remediation. Alerts notify you of anomalous conditions. You can also configure them to automatically initiate a corrective action to remediate the issue that resulted in the alert. It is also possible to configure alerts to raise an incident or create a work item through integration between Azure Monitor and your internal IT Service Management platform.

You can store and analyze near real-time and historical data in a Log Analytics workspace. This requires installing the Log Analytics agent. For additional insight into interaction between servers and other systems in your environment, you can install the Dependency Agent. The same Log Analytics agent allows you to onboard your serves to other Azure services, such as Update Management, Change Tracking and Inventory, and Azure Security Center.

![Screenshot that depicts the Map tab on the Insights page for a VM in Azure. ContosoVM1 is displayed with details of open TCP ports. A VM summary is also displayed, detailing the VM's operating system, IP address, and links for Health, Machine properties, and Azure VM properties. Three buttons are displayed for access to Properties (selected), Log Events, Alerts, and Connections.](../media/4-insights-map.png)

Once you install and configure the agent, servers will start forwarding telemetry to the Log Analytics workspace of your choice. You can subsequently display the collected data via Azure Monitor dashboards and analyze via Log Analytics queries. You also have the option of implementing metric or log-based rules that will trigger alerts and autoremediation tasks. 

## What are the benefits of Azure Security Center in hybrid scenarios?

To address the security challenges inherent to hybrid environment, such as high volatility and dependencies on external services, you need sophisticated tools that help assess your security posture and identify and remediate risks. Ideally, you want to deploy those tools with minimal effort. Security Center can help you address these requirements.

Security Center is a cloud-based service for managing the security of your cloud and on-premises infrastructure and workloads. With Security Center capabilities, you can:

- Improve your security stance. Use Security Center to implement security best practices across your cloud services and on-premises servers. In addition to security best practices, you can also track compliance against regulatory standards.
- Protect your environment. Monitor for security threats to your cloud and on-premises servers with Azure Defender.
- Protect your data. Identify suspicious activity against your servers, files, and databases including potential data breaches. 

Security Center relies on the Log Analytics agent to collect security-related events, application crash dumps, and operating system configuration settings. It continuously analyzes collected data, provides you with remediation recommendations, and generates security alerts in response to attempted and actual security breaches and exploits. 

> [!NOTE] 
> Azure Arc enabled servers require Azure Defender. 

## What are the benefits of Azure Automation Update Management in hybrid scenarios?

Azure Automation is an Azure service that helps you automate maintenance tasks in Azure and in on-premises environments by using custom PowerShell or Python scripts. In addition, Azure Automation supports configuration management by using several built-in solutions that include Update Management. 

Azure Automation Update Management is a hybrid solution that facilitates management and monitoring of operating system updates in hybrid scenarios. It provides comprehensive information on the update status and helps remediate any gaps in an automated manner. It supports integration with any of standard update deployment technologies, including Windows Update Services, Windows Server Update Services (WSUS), and Endpoint Configuration Manager.

Just as Azure Security Center, the Update Management solution relies on data collected from Windows servers by Azure Monitor and stored in the Log Analytics workspace you designate. This, in turn, requires locally installed Log Analytics agent, which registers managed computers with the Log Analytics workspace and continually uploads into it locally collected data. Log Analytics engine analyzes collected data to determine the update compliance status of each managed server.

In general, Update Management allows you to:

- Track the status of updates on your servers. The service includes the Azure portal-based interface where you can review the status of updates across your managed environment.
- Configure dynamic groups of machines to target deployments of updates. The service supports targeting updates to groups based on Log Analytics queries or groups imported from another source like WSUS or Endpoint Configuration Manager.
- Search Azure Monitor logs. The service provides the ability to run queries against logs stored in Log Analytics.

## What are the benefits of the Azure Automation Desired State Configuration (DSC) in hybrid scenarios?

PowerShell DSC is a technology that implements declarative configuration management through a combination of PowerShell scripts and operating system features. The configuration can be as simple as ensuring a specific Windows feature is enabled or as complex as deploying SharePoint. You can deploy DSC configuration in either push mode or pull mode. The push mode involves invoking deployment from a management computer against one or more managed computers. In the pull mode, managed computers perform deployment automatically, based on configuration data from a designated location, referred to as a *pull server*. Azure Automation includes a managed, Azure-resident DSC pull server. You can apply DSC configuration in the push mode to non-Azure computers, including Azure Arc enabled servers by using VM extension. Alternatively, you can onboard both types of systems into Azure Automation and manage their configuration via a pull server.

## Are there any additional benefits specific to Azure Arc enabled servers?

All of the services described in this unit are available to non-Azure servers, including those which are not Azure Arc enabled. However, Azure Arc offers advantages when it comes to the onboarding process, because you can use VM extensions or Azure Policy to deploy the Log Analytics agent. This streamlines the deployment process, allows for centralized, at-scale management from any location via the Azure portal, and facilitates agent maintenance, considerably simplifying identifying and upgrading out-of-date agents.

In addition, integration with Azure Resource Manager provides support for the resource context access to Log Analytics data. Resource context allows you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because each Azure Arc enabled server exists as an Azure resource, you can control access to its Log Analytics logs by relying on Azure role-based access control (Azure RBAC) permissions assigned to that resource.

Choose the best response for each of the following questions. Then select "Check your answers".
