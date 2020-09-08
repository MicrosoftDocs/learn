Now that you have enabled Azure Sentinel, the next step is to connect it to the services that you want to use.

## Service-to-service data connectors

At the time of writing, there are 56 out-of-the-box data connectors to support common data source integrations. These connectors are classified as *service-to-service* because a communication service layer that's built into these applications allows the connector service in Azure Sentinel to communicate with the communication service of the chosen application.

Azure Sentinel uses a fusion technique to correlate alerts into *incidents*. Incidents are groups of related alerts that together create an actionable incident that you can investigate and resolve.

### Native service-to-service connectors

Azure Sentinel interoperates natively with the following Azure and non-Azure services:

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

### Connect to Azure AD

The most direct way to start collecting data is to use the built-in Azure Sentinel connectors. A list of the built-in connectors is accessible through the Azure Sentinel interface.

In this example, we'll connect to Azure AD from Azure Sentinel:

1. On the Azure portal, under the **All service** option, select **Azure Sentinel**.
1. From the **navigation** menu, select **Data Connectors**. This page lists all the connectors that Azure Sentinel provides and their status.

    :::image type="content" source="../media/Sentinel-AAD-connector-page.png" alt-text="The screenshot depicts the Azure Sentinel connector page with the list of connectors." border="true":::

1. On the **Data Connectors** page is a tile for each data source to which you can connect. Select the **Azure Active Directory** tile.

1. The Azure Sentinel **Azure Active Directory** connector page will display, as the following screenshot depicts.

    :::image type="content" source="../media/Sentinel-AAD-Connector-2.png" alt-text="The screenshot depicts the Azure Sentinel Azure Active Directory connector page." border="true":::

1. Read the prerequisites and make sure you have fulfilled them, and then follow the instructions to connect the data source.

    > [!NOTE]
    > Azure Sentinel provides recommendations for which workbooks you should install for each connector so that you can immediately get interesting insights from your data.

1. Select both **Azure Active Directory Sign-in logs** and **Azure Active Directory Audit logs**.

    :::image type="content" source="../media/Sentinel-AAD-connector-3.png" alt-text="The screenshot depicts the Azure Sentinel connector configuration options." border="true":::

    > [!NOTE]
    > You can select what type of Azure AD logs you want to get:
    >
    > - **Sign-in logs** provide information about the usage of managed applications and user sign-in activities.
    > - **Audit logs** provide system activity information about users and group management, managed applications, and directory activities.

### Threat detection rule templates

After connecting your data sources to Azure Sentinel, you'll want to be notified when something suspicious occurs. To support this, Azure Sentinel provides out-of-the-box, built-in threat detection-rule templates that you can use as-is or customize. These templates were designed by Microsoft security experts and analysts based on known threats, common attack vectors, and suspicious activity escalation chains. Rules that are created from these templates will automatically search across your environment for any activity that looks suspicious. You can customize many of the templates to search for activities, or filter them out, according to your needs. The alerts that these rules generate will create incidents that you can assign and investigate in your environment. You can review the logs in the built-in dashboards and start building queries in Log Analytics to investigate the data.

### External solution connections through APIs

Some data sources are connected by using APIs that the connected data source provides. Typically, most security technologies provide a set of APIs through which event logs can be retrieved. These APIs connect to Azure Sentinel, gather specific data types, and then send them to Azure Monitor Logs:

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

### Validate your data source connection

After connecting your data sources to Azure Sentinel, you get data visualizations and analysis so that you can know what's happening across all your connected data sources. To confirm that your connectors are working, go to the Azure portal. In the Azure portal, after selecting **Azure Sentinel**, select the workspace that you used when you enabled Azure Sentinel.

:::image type="content" source="../media/Sentinel-analytics.png" alt-text="The screenshot depicts the Azure Sentinel - Analytics overview page." border="false":::

The main body of the overview page provides insight into the security status of your workspace. The following screenshot depicts the events and alerts over time section.

:::image type="content" source="../media/Sentinel-analytics 2.png" alt-text="The screenshot depicts the events and alerts over time section." border="false":::

The events and alerts over time section lists the number of events and how many alerts were created from those events. If events are being registered, you know your connectors are working.

Depending on what service the Contoso administrator initially connected to, there could be a delay before some alerts display. Informational alerts should be the first to display.

### Built-in workbooks

Azure Sentinel gives you workbooks that provide analytics for your logs and queries by using the full power of tools that are already available in Azure, in addition to built-in tables and charts. You can use built-in workbooks, or you can create a new workbook from scratch or base it on an existing workbook. The workbooks are based on Monitor workbooks, are highly customizable, and provide you flexibility when designing your own workbooks.

Built-in workbooks provide integrated data from your connected data sources to let you examine the events that those services generate. The built-in workbooks include Azure AD, Azure activity events, and on-premises events. These on-premises events can include data from Windows events from servers or from Microsoft alerts. Events can also be gathered from any non-Microsoft services, including firewall traffic logs, Office 365, and protocols that aren't secure and that are based on Windows events.
