Applying a label to a file, an email, a SharePoint Site, or a Microsoft Team is a great option to control access and sharing options.

## Pulling a report

The sensitivity labels are a part of the Reporting system in the Security center and Microsoft Purview compliance portal.  For sensitivity labeling, we'll focus on the Microsoft Purview compliance portal reports.

An existing sensitivity label report may be accessed with these steps:

1. Navigate to the **Microsoft Purview compliance portal** at [https://compliance.microsoft.com](https://compliance.microsoft.com/?azure-portal=true).

1. Navigate to **Reports**.

1. Within the Labels area, select **View details** for one of the boxes that provide reporting data of interest.

The Organizational data of this dashboard provides an overview of the DLP matches that occurred in SharePoint, OneDrive, Exchange Online, or Microsoft Teams.

> [!TIP]
> The reports in the Reports area are based on the organizational level information. For reports in detail and on a user level, please choose Microsoft Defender for Apps or the Data classification area with the Content explorer and the Activity explorer.

## Planning log analytics

Log analytics is a tool in Azure portal. A log analytics workspace is required to use Azure Information Protection to gather information for these organizational reports.  To start log analytics, you must create a Log Analytics workspace to collect and analyze the information. You need an additional Azure Subscription to create a Log Analytics workspace.

## Roles required for log analytics

To create your Log Analytics workspace or to create custom queries, you need one of the following roles:

- Azure Information Protection administrator

- Security administrator

- Compliance administrator

- Compliance data administrator

- Global administrator

After the workspace has been created, you can then use the following roles with lower permissions to view the data collected:

- Security reader

- Global reader

To create the workspace or to create custom queries, you need one of the following:

- Log Analytics Contributor

- Contributor

- Owner

After the workspace has been created, you can then use one of the following roles with lower permissions to view the data collected:

- Log Analytics Reader

- Reader

### Understanding the storage requirements

The amount of data collected and stored in your Azure Information Protection workspace will vary significantly for each tenant, depending on factors such as how many Azure Information Protection clients and other supported endpoints you have, whether you're collecting endpoint discovery data, you've deployed scanners, the number of protected documents that are accessed, and so on.

## Monitoring with Microsoft Sentinel

A Sensitivity Label monitoring and analyzing is also possible with Microsoft Sentinel workspace. The Log files will be collected by Microsoft Sentinel to get an overview of the entire environment with all signals.

## Learn more

- [Microsoft Sentinel documentation](/azure/sentinel/?azure-portal=true)
- [Quickstart: Onboard Microsoft Sentinel](/azure/sentinel/quickstart-onboard?azure-portal=true)
- [Azure Monitor Logs cost calculations and options](/azure/azure-monitor/logs/cost-logs?azure-portal=true)
- [Analytics and central reporting for Azure Information Protection](/azure/information-protection/reports-aip?azure-portal=true)
