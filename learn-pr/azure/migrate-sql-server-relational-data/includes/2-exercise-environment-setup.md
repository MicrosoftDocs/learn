In this exercise, you lay the groundwork for using Data Migration Assistant. You use the Azure portal to deploy a template that will create resources you'll need to perform the exercises.

> [!IMPORTANT]
> [!INCLUDE [azure-subscription-prerequisite](../../../includes/azure-subscription-prerequisite.md)]

This deployment will create the following resources:

- A resource group.
- A SQL Server instance.
- An empty Azure SQL database.
- A virtual machine running SQL Server.
- Network and storage resources to support the previous items.

## Deploy the template

1. To open the Azure portal and deploy the resources needed for the exercises, select **Deploy to Azure**.

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-migrate-sql-server-relational-data%2Fmaster%2Fazuredeploy.json?azure-portal=true)

1. Complete the **Custom deployment** template with the following values.

    | Field | Value |
    |---------|---------|
    | **Basics** tab > **Deployment scope** section | |
    | Subscription | Select the Azure subscription that you want to use. |
    | Resource group | Select **Create new**, enter **admsdemorg**, and select **OK**. |
    | **Parameters** section | |
    | Region | Select a [location that supports the Azure Database Migration Service](https://azure.microsoft.com/global-infrastructure/services/?products=database-migration&regions=all&azure-portal=true). |
    | Source Windows Admin User Name | windowsadmin |
    | Source Windows Admin Password | Enter a complex password |
    | Source Sql Admin User Name | sqladmin |
    | Source Sql Admin Password | Enter a complex password |
    | Target Sql Db Administrator Login | azuresqladmin |
    | Target Sql Db Administrator Password | Enter a complex password |

1. Select **Review + create**.

1. Upon receiving *Validation Passed* notification, select **Create**.

Make note of the passwords that you used for the accounts, because you'll use them later. This deployment will take 10 to 15 minutes. While this is in progress, continue to the next unit to learn about the migration process.
