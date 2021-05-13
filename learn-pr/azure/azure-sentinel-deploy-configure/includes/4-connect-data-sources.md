After you enable Azure Sentinel, the next step is to connect it to the services that you want to use.

## Service-to-service data connectors

At the time of writing, there are 56 out-of-the-box data connectors to support common data source integrations. These connectors are classified as *service-to-service* because a communication service layer is built in to these applications. The communication service layer allows the connector service in Azure Sentinel to communicate with the communication service of the chosen application.

### Native service-to-service connectors

Azure Sentinel natively interoperates with these Azure and non-Azure services:

- Azure Activity log
- Azure AD (audit logs and sign-in logs)
- Azure Security Center
- Azure AD Identity Protection
- Azure ATP
- Amazon Web Services CloudTrail
- Cloud App Security
- Domain name servers
- Office 365
- Microsoft Defender ATP
- Azure Web Application Firewall
- Windows Defender Firewall
- Windows security events

Because these solutions use Azure Foundation for out-of-the-box interoperability, you can connect Azure Sentinel to them with only a few steps.

### External solution connections through APIs

Some data sources are connected by using APIs that the connected data source provides. Most security technologies provide a set of APIs through which event logs can be retrieved. These APIs connect to Azure Sentinel, gather specific data types, and store the data in the selected Azure Monitor Log Analytics workspace:

- Alcide kAudit
- Barracuda Web Application Firewall
- Barracuda CloudGen Firewall
- Citrix Analytics for Security
- F5 BIG-IP
- Forcepoint DLP
- Perimeter 81 activity logs
- Squadra Technologies secRMM
- Symantec ICDx
- Zimperium Mobile Threat Defense

### Connect to Azure AD

The most direct way to collect data is to use the built-in Azure Sentinel connectors. A list of the built-in connectors is accessible through the Azure Sentinel interface.

Azure Sentinel provides recommendations for which workbooks you should install for each connector to get insights from your data.

You can also select what type of Azure AD logs you want to get:

- **Sign-in logs**: Provide information about the usage of managed applications and user sign-in activities.
- **Audit logs**: Provide system activity information about users and group management, managed applications, and directory activities.

In this example, we'll connect to Azure AD from Azure Sentinel:

1. On the Azure portal, under the **All service** option, select **Azure Sentinel**.
1. From the **navigation** menu, select **Data Connectors**. This page lists all the connectors that Azure Sentinel provides and their status.

    :::image type="content" source="../media/sentinel-azure-ad-connector-page.png" alt-text="Screenshot of the Azure Sentinel connector page with the list of connectors." border="true":::

1. On the **Data Connectors** page, select the **Azure Active Directory** tile. The Azure Sentinel **Azure Active Directory** connector page opens.

    :::image type="content" source="../media/sentinel-azure-ad-connector-2.png" alt-text="Screenshot of the Azure Sentinel Azure Active Directory connector page." border="true":::

1. Read the prerequisites and make sure you've fulfilled them. Then follow the instructions to connect the data source.

1. Select both **Azure Active Directory Sign-in logs** and **Azure Active Directory Audit logs**.

    :::image type="content" source="../media/sentinel-azure-ad-connector-3.png" alt-text="Screenshot of the Azure Sentinel connector configuration options." border="true":::

### Validate your data source connection

After you connect your data sources to Azure Sentinel, you get data visualizations and analysis so you can know what happens across all your connected data sources.

To confirm that your connectors work, go to the Azure portal. In the Azure portal, select **Azure Sentinel**, and then select the workspace that you used when you enabled Azure Sentinel.

:::image type="content" source="../media/sentinel-analytics.png" alt-text="Screenshot of the Azure Sentinel - Analytics overview page." border="false":::

The main body of the overview page provides insight into the security status of your workspace. The following screenshot shows the events and alerts over time section.

:::image type="content" source="../media/sentinel-analytics-2.png" alt-text="Screenshot of the events and alerts over time section." border="false":::

The events and alerts over time section lists the number of events and how many alerts were created from those events. If events are being registered, you know your connectors work.

Depending on what service the Contoso administrator initially connected to, there might be a delay before some alerts display. Informational alerts should be the first to display.

### Threat detection rule templates

After you connect your data sources to Azure Sentinel, you'll want to be notified when something suspicious occurs. To do this, Azure Sentinel provides threat detection rule templates that you can use as-is or customize. These templates are designed by Microsoft security experts and analysts. They're based on known threats, common attack vectors, and suspicious activity escalation chains.

Rules that are created from these templates automatically search across your environment for any activity that looks suspicious. You can customize many of the templates to search for activities, or filter them out, as needed.

Azure Sentinel uses a fusion technology to correlate the alerts that these rules generate into *incidents*. Incidents are groups of related alerts that together create an actionable incident that you assign and investigate in your environment. You can review the logs in the built-in dashboards and build queries in Log Analytics to investigate the data.

### Built-in workbooks

Azure Sentinel gives you workbooks that provide analytics for your logs and queries. The workbooks are based on Monitor workbooks. They use the tools that are already available in Azure, in addition to built-in tables and charts. You can use built-in workbooks, customize an existing workbook, or create a new workbook from scratch.

Built-in workbooks provide integrated data from your connected data sources. They let you examine the events that those services generate. The built-in workbooks include Azure AD, Azure activity events, and on-premises events. These on-premises events can include data from Windows events from servers or from Microsoft alerts. 

Events can also be gathered from any non-Microsoft services. These events include firewall traffic logs, Office 365, and protocols that aren't secure and that are based on Windows events.
