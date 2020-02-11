In this exercise, you'll lay the groundwork for using the Azure Data Migration Assistant. You'll use the Azure Cloud Shell to deploy a template that will create resources you'll need to perform the exercises, including a virtual machine, an Azure SQL Database, and other supporting resources.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Deploy the template

1. Select the **Deploy to Azure** button below to deploy the resources needed for the exercises.

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-migrate-sql-server-relational-data%2Fmaster%2Fazuredeploy.json?azure-portal=true)

1. Complete the template with the following values:

    |Parameter  |Value  |
    |---------|---------|
    |**BASICS**| |
    |Subscription     | Select the Azure subscription you would like to use |
    |Resource group     | Select **Create new**, enter **admsdemorg**, and select **OK**.        |
    |Location     | Select a [location that supports the Azure Database Migration Servivce](https://azure.microsoft.com/en-us/global-infrastructure/services/?products=database-migration&regions=all&azure-portal=true)        |
    |**SETTINGS**     |         |
    |Location     | Leave at default value of `[resourceGroup().location]`         |
    |Create Public IP     | true        |
    |Source Windows Admin User Name     |  vmadmin       |
    |Source Windows Admin Password     | Enter a complex password        |
    |Source SQL Authentication Password     | Enter a complex password        |
    |Target SQL DB Administrator Login     | sqladmin        |
    |Target SQL DB Administrator Password     | Enter a complex password        |
    |_artifacts Location     | Leave at default value        |
    | _artifacts Location Sas Token | Leave blank |

1. Select **I agree to the terms and conditions stated above** and select **Purchase**.

<!-- 1. Log in to the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with credentials that have access to your Azure account. Select the **Bash** version of cloud shell once logged in.

1. Once you are logged in, confirm that you are in the subscription you would like to create your resources in. 

    ```azurecli
    az account show
    ```

    If you need to change to a different subscription, use the following command and replace `<Subscription Name>` with the name of the subscription you would like to use.

    ```azurecli
    az account set --subscription "<Subscription Name>"
    ```

1. Next, create a resource group for the resources to be deployed to. This command will create a resource group named **admsdemorg** in the **centralus** region. You may wish to use a different location. Not all regions support the Azure Data Migration Service, so confirm that the region of your choice is supported.

    ```azurecli
    az group create --location centralus --name admsdemorg
    ```

1. Now run this command to create resources you'll need in the exercises.

    ```azurecli
    az group deployment create \
        --name admsdemodeploy \
        --resource-group admsdemorg \
        --template-uri https://raw.githubusercontent.com/MicrosoftDocs/mslearn-migrate-sql-server-relational-data/master/azuredeploy.json \
        --parameters "C:\Users\arcan\OneDrive\Pluralsight\Azure Migrate your SQL Data to Azure SQL\Microsoft-Written-PoC\migrate-sql-server-relational-data\demos\adms.parameters.json"
    ``` -->

When finished, you can navigate to your Azure Portal and open the newly created **admsdemorg** Resource Group. You should see something similar to the image below. Note that not all names will match exactly, as some names are dynamically generated at creation time.

![Migration Workflow](../media/2-01-results.png)
