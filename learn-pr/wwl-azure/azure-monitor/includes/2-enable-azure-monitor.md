
Earlier, this course discussed Microsoft Azure Monitor. The following high-level diagram depicts the two fundamental data types that Azure Monitor uses, Metrics and Logs.

:::image type="content" source="../media/az500-azure-monitor-1-bb53ff11.png" alt-text="Data sources create metrics and logs that are displayed by Azure Monitor.":::


On the left side of the figure are the sources of monitoring data that populate these data stores. On the right side are the different functions that Azure Monitor performs with this collected data, such as analysis, alerting, and streaming to external systems.

For many Azure resources, you’ll find the data that Azure Monitor collects right in the resource’s **Overview page** in the Azure portal. Check out any virtual machine (VM). for example, and you'll notice several charts displaying performance metrics. Select any of the graphs to open the data in **Metrics Explorer**, which allows you to chart the values of multiple metrics over time. You can view the charts interactively or pin them to a dashboard to view them with other visualizations.

:::image type="content" source="../media/az500-azure-monitor-2-f8e702e7.png" alt-text="Screenshot of a Metrics Explorer graph.":::


You can analyze log data that Azure Monitor collects by using queries to quickly retrieve, consolidate, and analyze the collected data. You can create and test queries by using log analytics in the Azure portal and then either directly analyze the data by using these tools or save queries for use with visualizations or alert rules.

This module will discuss streaming the collected monitor data to external Security Information and Event Management (SIEM) solutions via Microsoft Defender for Cloud. The forwarding or streaming is typically done directly from monitored resources through Azure Event Hubs.

### Exporting data to a SIEM

Processed events that Microsoft Defender for Cloud produces are published to the Azure activity log, one of the log types available through Azure Monitor. Azure Monitor offers a consolidated pipeline for routing any of your monitoring data into a SIEM tool. This is done by streaming that data to an event hub, where it can then be pulled into a partner tool.

This pipe uses the Azure Monitor single pipeline for getting access to the monitoring data from your Azure environment. This allows you to easily set up SIEMs and monitoring tools to consume the data. Currently, the exposed security data from Microsoft Defender for Cloud to a SIEM consists of security alerts.

### Microsoft Defender for Cloud security alerts

Microsoft Defender for Cloud automatically collects, analyzes, and integrates log data from your Azure resources; the network; and connected partner solutions, like firewall and endpoint protection solutions, to detect real threats and reduce false positives. Microsoft Defender for Cloud displays a list of prioritized security alerts along with the information you need to quickly investigate the problem and recommendations for how to remediate an attack.

The following sections describe how you can configure data to be streamed to an event hub. The steps assume that you already have Microsoft Defender for Cloud configured in your Azure subscription.

### Azure Event Hubs

Azure Event Hubs is a streaming platform and event ingestion service that can transform and store data by using any real-time analytics provider or batching/storage adapters. Use Event Hubs to stream log data from Azure Monitor to a Microsoft Sentinel or a partner SIEM and monitoring tools.

### What data can be sent into an event hub?

Within your Azure environment, there are several 'tiers' of monitoring data, and the method of accessing data from each tier varies slightly. Typically, these tiers can be described as:

 -  **Application monitoring data** \- Data about the performance and functionality of the code you have written and are running on Azure. Examples of application monitoring data include performance traces, application logs, and user telemetry. Application monitoring data is usually collected in one of the following ways:
     -  By instrumenting your code with an SDK such as the **Application Insights SDK**.
     -  By running a monitoring agent that listens for new application logs on the machine running your application, such as the **Windows Azure Diagnostic Agent** or **Linux Azure Diagnostic Agent**.
 -  **Guest OS monitoring data** \- Data about the operating system on which your application is running. Examples of guest OS monitoring data would be Linux syslog or Windows system events. To collect this type of data, you need to install an agent such as the **Windows Azure Diagnostic Agent** or **Linux Azure Diagnostic Agent**.
 -  **Azure resource monitoring data** \- Data about the operation of an Azure resource. For some Azure resource types, such as virtual machines, there is a guest OS and application(s) to monitor inside of that Azure service. For other Azure resources, such as Network Security Groups, the resource monitoring data is the highest tier of data available (since there is no guest OS or application running in those resources). This data can be collected using resource diagnostic settings.
 -  **Azure subscription monitoring data** \- Data about the operation and management of an Azure subscription, as well as data about the health and operation of Azure itself. The activity log contains most subscription monitoring data, such as service health incidents and Azure Resource Manager audits. You can collect this data using a Log Profile.
 -  **Azure tenant monitoring data** \- Data about the operation of tenant-level Azure services, such as Azure Active Directory. The Azure Active Directory audits and sign-ins are examples of tenant monitoring data. This data can be collected using a tenant diagnostic setting.

Data from any tier can be sent into an event hub, where it can be pulled into a tool. Some sources can be configured to send data directly to an event hub while another process such as a Logic App may be required to retrieve the required data.

### Connecting to Microsoft Sentinel

Microsoft Sentinel is now generally available. With Microsoft Sentinel, enterprises worldwide can now keep pace with the exponential growth in security data, improve security outcomes without adding analyst resources, and reduce hardware and operational costs. Microsoft Sentinel brings together the power of Azure and AI to enable Security Operations Centers to achieve more.

Some of the features of Microsoft Sentinel are:

 -  **More than 100 built-in alert rules**
     -  Sentinel's alert rule wizard to create your own.
     -  Alerts can be triggered by a single event or based on a threshold, or by correlating different datasets or by using built-in machine learning algorithms.
 -  **Jupyter Notebooks** that use a growing collection of hunting queries, exploratory queries, and python libraries.
 -  **Investigation graph** for visualizing and traversing the connections between entities like users, assets, applications, or URLs and related activities like logins, data transfers, or application usage to rapidly understand the scope and impact of an incident.

The Microsoft Sentinel GitHub repository has grown to over 400 detection, exploratory, and hunting queries, plus Azure Notebooks samples and related Python libraries, playbooks samples, and parsers. The bulk of these were developed by Microsoft's security researchers based on their vast global security experience and threat intelligence.

To on-board Microsoft Sentinel, you first need to enable Microsoft Sentinel, and then connect your data sources. Microsoft Sentinel comes with a number of connectors for Microsoft solutions, available out of the box and providing real-time integration, including **Microsoft Threat Protection solutions**, **Microsoft 365 sources**, including **Microsoft 365, Azure AD, Azure ATP**, and **Microsoft Cloud App Security**, and more. In addition, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions. You can also use common event format, Syslog or REST-API to connect your data sources with Azure Sentinel.

After you connect your data sources, choose from a gallery of expertly created dashboards that surface insights based on your data. These dashboards can be easily customized to your needs.
