
When using Azure migration extension for Azure Data Studio, users can choose between online or offline migration based on the Azure target selected. They can also configure a self-hosted integration runtime to access backup files from the source SQL Server instance in their on-premises environment. 

The extension also provides a secure and improved user experience for migrating Transparent Data Encryption (TDE) databases and SQL Server and Windows logins to Azure SQL.

## Install Azure migration extension for Azure Data Studio

As a prerequisite, you need to install [Azure Data Studio](https://learn.microsoft.com/sql/azure-data-studio/download-azure-data-studio) first. The extension is available in Azure Data Studio marketplace.

:::image type="content" border="false" source="../media/4-install-migration-extension.png" alt-text="Screenshot of the Azure migration extension for Azure Data Studio available in the marketplace.":::

To install the migration extension, follow these steps:

1. Open the extensions manager in Azure Data Studio.
1. Search for ***Azure SQL Migration*** and select the extension.
1. Install the extension. Once you install it, you'll find the Azure SQL Migration extension in the list of installed extensions.
1. Connect to a SQL Server instance in Azure Data Studio.
1. Right-click on the instance name and select **Manage** to access the dashboard and the landing page of the Azure SQL Migration extension.

    ![Animated GIF of the Azure migration extension for Azure Data Studio installation.](../media/4-install-migration-extension-data-studio.gif)

## Assess database readiness

The migration extension performs detailed evaluation of the source SQL Server instance by executing multiple rules to identify critical issues that must be addressed before migrating your SQL Server database to Azure SQL.

An Azure account isn't required for assessments or SKU recommendations. Not requiring an Azure account for assessments or SKU recommendations has the benefit of enabling users to evaluate the readiness and cost of migrating their databases to Azure without the need to commit to creating an Azure account. This saves time and effort for users who are still in the decision-making process.

:::image type="content" border="false" source="../media/4-assessment-page.png" alt-text="Screenshot of the assessment results page for the migration extension wizard.":::

As we can see, several Azure SQL targets are available for selection, and the results are automatically updated based on your choice. This feature helps you identify any potential roadblocks and determine if another target option may be more suitable for your environment.

You can also save the assessment report, this generates a JSON file containing all the main properties about your database, and also the assessment results. Additionally, you can use the JSON file to programmatically extract specific data or information for further analysis or processing.

## Right-sized SKU recommendations (Preview)

The extension also provides recommended compute and storage configuration for your Azure SQL target based on the performance data collected from your source SQL instance, whether it's on-premises or in another cloud environment. This feature helps ensure that the Azure SQL target meets the needs of your workload.

:::image type="content" border="false" source="../media/4-architecture-diagram-recommendation.png" alt-text="Screenshot of the Azure recommendation architecture.":::

While the Azure recommendations feature doesn't provide price estimates due to the fluctuating nature of pricing, there are alternative methods to obtain price estimates. You can access the [**Azure Pricing Calculator**](https://azure.microsoft.com/pricing/calculator/), or generate a SQL assessment within **Azure Migrate** to gather accurate price estimates. These options allow you to make informed decisions by considering the specific pricing details relevant to your scenario.

:::image type="content" border="false" source="../media/4-sku-recommendations.png" alt-text="Screenshot of the Azure recommendation sidebar featuring configurations about where the performance data will be saved.":::

As we can see, once you initiate the Azure Migration extension wizard, you have the option to select **Get Azure recommendation** to enable performance data collection. 

> [!IMPORTANT]
> We collect performance data from all databases on a specific instance simultaneously, and the same data can be used multiple times for migrating different source databases.

## Assessment automation

In addition to running the assessment and Azure recommendation steps through the migration extension wizard, you can run them in either PowerShell or Azure CLI to perform these tasks at scale.

For example, to run the assessment on a sample SQL server database with the assessment report being saved in output folder in C drive, in PowerShell.

```
Get-AzDataMigrationAssessment -ConnectionString "Data Source=localhost;Initial Catalog=AdventureWorks;Integrated Security=True" -OutputFolder C:\Output -Overwrite
```

Alternatively, you can perform the same task using Azure CLI.

```
az datamigration get-assessment --connection-string "Data Source=localhost;Initial Catalog=AdventureWorks;Integrated Security=True" --output-folder "C:\Output" --overwrite
```

To learn more about the Azure migration extension PowerShell and Azure CLI commands available, refer to the following links: [PowerShell module for data migration extension](https://learn.microsoft.com/powershell/module/az.datamigration) and [Azure CLI for data migration extension](https://learn.microsoft.com/cli/azure/datamigration).