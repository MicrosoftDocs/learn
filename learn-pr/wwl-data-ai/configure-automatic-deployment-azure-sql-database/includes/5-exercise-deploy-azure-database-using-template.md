You've been hired as a Senior Data Engineer to help automate day to day operations of database administration. This automation is to help ensure that the databases for AdventureWorks continue to operate at peak performance and provide methods for alerting based on certain criteria. AdventureWorks uses SQL Server in both Infrastructure as a Service and Platform as a Service offerings. 

## Deploy an Azure SQL Database

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. In the virtual machine, open the **Microsoft Edge** browser, and in the `https://portal.azure.com` page, sign into Microsoft Azure using the Azure portal username and password provided on the **Resources** tab above.
1. In Microsoft Edge, open a new tab and navigate to the following path in a GitHub repository, which contains an ARM template to deploy a SQL Database resource

    ```
    https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.sql/sql-database
    ```

1. Right-click **azuredeploy.json**, and select **Open link in new tab** to view the ARM template, which should look similar to this

    ```JSON
    {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "serverName": {
        "type": "string",
        "defaultValue": "[uniqueString('sql', resourceGroup().id)]",
        "metadata": {
            "description": "The name of the SQL logical server."
        }
        },
        "sqlDBName": {
        "type": "string",
        "defaultValue": "SampleDB",
        "metadata": {
            "description": "The name of the SQL Database."
        }
        },
        "location": {
        "type": "string",
        "defaultValue": "[resourceGroup().location]",
        "metadata": {
            "description": "Location for all resources."
        }
        },
        "administratorLogin": {
        "type": "string",
        "metadata": {
            "description": "The administrator username of the SQL logical server."
        }
        },
        "administratorLoginPassword": {
        "type": "securestring",
        "metadata": {
            "description": "The administrator password of the SQL logical server."
        }
        }
    },
    "variables": {},
    "resources": [
        {
        "type": "Microsoft.Sql/servers",
        "apiVersion": "2020-02-02-preview",
        "name": "[parameters('serverName')]",
        "location": "[parameters('location')]",
        "properties": {
            "administratorLogin": "[parameters('administratorLogin')]",
            "administratorLoginPassword": "[parameters('administratorLoginPassword')]"
        },
        "resources": [
            {
            "type": "databases",
            "apiVersion": "2020-08-01-preview",
            "name": "[parameters('sqlDBName')]",
            "location": "[parameters('location')]",
            "sku": {
                "name": "Standard",
                "tier": "Standard"
            },
            "dependsOn": [
                "[resourceId('Microsoft.Sql/servers', concat(parameters('serverName')))]"
            ]
            }
        ]
        }
    ]
    }
    ```

1. Review the JSON in the ARM template, noting how you can write a template that can create a random server name, and that you can create databases inside a server.

1. Close the **azuredeploy.json** tab and return to the tab containing the **sql-database** GitHub folder.

1. On the GitHub web page, scroll down and select **Deploy to Azure**.

    :::image type="content" source="../media/deploy-to-azure.png" alt-text="Deploy to Azure button":::

1. The Azure portal will open at the deployment details page for a **SQL Server and Database** resource with resource details partially filled in from the ARM template  To deploy this resource, complete the blank fields with this information:
    - Resource group: *Select the existing **automateLablod...** resource group*
    - Sql Administrator Login: **labadmin**
    - Sql Administrator Login Password: Enter a strong password

1. Select **Review + create**, and then select **Create**.

    Your deployment will take 5 minutes or so to deploy.

1. When deployment has completed, select **Go to resource group**. You'll be taken to the Azure Resource Group your, which contains a randomly named **SQL Server** resource created by the deployment.

You've just seen how, with a single click on an Azure Resource Manager template link, you can create both an Azure SQL server and database in minutes.
