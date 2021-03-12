Applying a label to a file, an email, a SharePoint Site, or a Microsoft Team is a great option to control access and sharing options.

## Pulling a report

The sensitivity labels are a part of the Reporting system in the Security and the Compliance center.  For sensitivity labeling, we will focus on the Compliance center reports.

An existing sensitivity label report may be accessed with these steps:

1. Navigate to the **Microsoft 365 compliance center** at [https://compliance.microsoft.com](https://compliance.microsoft.com/?azure-portal=true).

1. Navigate to **Reports**.

1. Within the Sensitivity labels, select **view details**.

Organizational data provides an overview of the DLP matches that occurred in SharePoint, OneDrive for Business, Exchange Online or Microsoft Teams.

> [!TIP]
> The reports in the Reporting area are base on the organizational level. For reports in detail and on user level, please choose Microsoft Cloud App Security or the Data classification area with the Content explorer and the Activity explorer.

## Planning label analytics

Label analytics is a tool in Azure portal. To start Label analytics, you must create a Log Analytics workspace to collect and analyze the information. You need an additional Azure Subscription to create a Log Analytics workspace to use Label analytics.

## Roles required for label analytics

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

### Costs of label analytics

Azure Monitor Logs has a **Usage and estimated costs** feature to help you estimate and review the amount of data stored. You can also control the data retention period for your Log Analytics workspace.

## Monitoring with Azure Sentinel

A Sensitivity Label monitoring and analyzing is also possible with Azure Sentinel workspace. The Log files will be collected at Azure Sentinel to get an overview of the entire environment with all signals.

## Learn more

[Azure Sentinel documentation | Microsoft Docs](https://docs.microsoft.com/azure/sentinel/?azure-portal=true)

[Quickstart: Onboard in Azure Sentinel | Microsoft Docs](https://docs.microsoft.com/azure/sentinel/quickstart-onboard?azure-portal=true)

[Manage usage and costs with Azure Monitor Logs](https://docs.microsoft.com/azure/azure-monitor/platform/manage-cost-storage?azure-portal=true)

[Central reporting for Azure Information Protection | Microsoft Docs](https://docs.microsoft.com/azure/information-protection/reports-aip?azure-portal=true)

### Applying manually

It's possible to apply a sensitivity label to a file with these options:

- Unified Labeling Client (Windows, Mac)

- Native Office Desktop Apps (limited)

- Mobile Office Apps (iOS, Android)

When using the native labeling functionality, assigning a label is different and works with the native ribbon button:

:::image type="content" source="../media/labeling-native-client.png" alt-text="Graphical user interface, application":::

Assigning a label is also possible with the mobile versions of Word like Word mobile app on iOS.

### Users apply the access rights

It´s possible to create a label for files and emails that grants the user the opportunity to configure the permissions. Users can control the level of rights assigned to an element, which users and groups may access it, and whether the content will expire.

