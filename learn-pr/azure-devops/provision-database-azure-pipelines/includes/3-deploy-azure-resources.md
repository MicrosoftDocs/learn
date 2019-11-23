In this exercise, you use a template that creates an Azure SQL Server logical instance, an Azure App Service Plan, and an Azure App Service. You deploy this template from Azure Cloud Shell and see that the resources are deployed. Then you delete the resource group and all of the resources in it.

## Bring up Cloud Shell through the Azure portal

Here, you bring up Cloud Shell through the Azure portal so that you can run your Azure Resource Manager template.

You can also [install and run Azure CLI locally](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true).

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu bar, select Cloud Shell. Select the **Bash** experience.

    ![Selecting Cloud Shell from the menu bar](../../shared/media/azure-portal-menu-cloud-shell.png)

    > [!NOTE]
    > Cloud Shell requires an Azure storage resource to persist any files you create while working in Cloud Shell. On first launch, Cloud Shell prompts to create a resource group, storage account, and Azure Files share on your behalf. This is a one-time step and will be automatically attached for all future Cloud Shell sessions.

## Create a working directory

Here, you create a directory to hold your Resource Manager template.

1. In Cloud Shell, create a directory named *mslearn-resource-manager-template*.

    ```bash
    mkdir ~/mslearn-resource-manager-template
    ```

1. Move to the *mslearn-resource-manager-template* directory.

    ```bash
    cd ~/mslearn-resource-manager-template
    ```

## Add the Resource Manager template

Here, you create a basic Resource Manager template in a file named *template.json*.

1. From the *mslearn-resource-manager-template* directory, open the editor.

    ```bash
    code template.json
    ```

1. Add this to *template.json* and then save the file.

    [!code-json[](code/startertemplate.json)]

## Understand the template

Here, you briefly walk through each section of the Resource Manager template to better understand how it works.

The `parameters` section of the template file specifies the information that needs to be passed in to the template. It has parameters for the names of the resources to be created. The defaults are the base names that will have the deployment prefix and unique suffix added to it. The deployment prefix, unique suffix, and admin password will be passed in. The location will be set by default to be the location of the resource group you are deploying into.

```json
"parameters": {
    "serverfarms_tailspin_space_game_asp_name": {
        "defaultValue": "tailspin-space-game-asp",
        "type": "String"
    },
    "servers_tailspin_space_game_sql_name": {
        "defaultValue": "tailspin-space-game-sql",
        "type": "String"
    },
    "sites_tailspin_space_game_web_name": {
        "defaultValue": "tailspin-space-game-web",
        "type": "String"
    },
    "location": {
        "type": "string",
        "defaultValue": "[resourceGroup().location]"
    },
    "deployPrefix": {
        "type": "string",
        "minLength": 3,
        "maxLength": 11
    },
    "uniqueSuffix": {
        "type": "string",
        "minLength": 3,
        "maxLength": 11
    },
    "adminPassword": {
        "type": "string"
    }
},
```

The variables section creates a uniqueName variable that is a combination of the `deploymentPrefix` parameter and the `uniqueSuffix` parameter. This will be used to create unique names for the resources.

```json
"variables": {
        "uniqueName": "[concat(parameters('deployPrefix'), parameters('uniqueSuffix'))]"
    },
```

The rest of the file is the resources that will be created. Take a moment to read through those.

### The SQL Server instance

Notice the `name` parameter. Here you use the default name of the resource you set up in the parameters section and concatenate the `uniqueName` from the variables section. You get the administrator login password from the `adminPassword` parameter.

```json
"type": "Microsoft.Sql/servers",
    "apiVersion": "2015-05-01-preview",
    "name": "[concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName'))]",
    "location": "[parameters('location')]",
    "kind": "v12.0",
    "properties": {
        "administratorLogin": "azuresql",
        "administratorLoginPassword": "[parameters('adminPassword')]",
        "version": "12.0"
    }
```

You also set a firewall rule to allow Azure to access the server. You need this to deploy the database to the server. We add database deployment to the template when we deploy in the pipeline later.

```json
"type": "Microsoft.Sql/servers/firewallRules",
    "apiVersion": "2015-05-01-preview",
    "name": "[concat(concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName')), '/AllowAllWindowsAzureIps')]",
    "dependsOn": [
        "[resourceId('Microsoft.Sql/servers', concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName')))]"
    ],
    "properties": {
        "startIpAddress": "0.0.0.0",
        "endIpAddress": "0.0.0.0"
    }
```

### The App Service plan

The App Service plan does not need the unique suffix. It uses the name of the plan directly from the parameter default.

```json
"type": "Microsoft.Web/serverfarms",
    "apiVersion": "2016-09-01",
    "name": "[parameters('serverfarms_tailspin_space_game_asp_name')]",
    "location": "[parameters('location')]",
    "sku": {
        "name": "B1",
        "tier": "Basic",
        "size": "B1",
        "family": "B",
        "capacity": 1
    },
    "kind": "app",
    "properties": {
        "name": "[parameters('serverfarms_tailspin_space_game_asp_name')]"
    }
```

### The App Service instance

Here, the name properties concatenate the name of the web site from the parameter default with the unique suffix. You also disable SSL in the `hostNameSslStates` property.

```json
"type": "Microsoft.Web/sites",
    "apiVersion": "2016-08-01",
    "name": "[concat(parameters('sites_tailspin_space_game_web_name'), variables('uniqueName'))]",
    "location": "[parameters('location')]",
    "dependsOn": [
        "[resourceId('Microsoft.Web/serverfarms', parameters('serverfarms_tailspin_space_game_asp_name'))]"
    ],
    "kind": "app",
    "properties": {
        "enabled": true,
        "hostNameSslStates": [
            {
                "name": "[concat(concat(parameters('sites_tailspin_space_game_web_name'), variables('uniqueName')), '.azurewebsites.net')]",
                "sslState": "Disabled",
                "hostType": "Standard"
            },
            {
                "name": "[concat(concat(parameters('sites_tailspin_space_game_web_name'), variables('uniqueName')), '.scm.azurewebsites.net')]",
                "sslState": "Disabled",
                "hostType": "Repository"
            }
        ],
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', parameters('serverfarms_tailspin_space_game_asp_name'))]"
    }
```

The `hostNameBindings` type sets the web site name and the type.

```json
"type": "Microsoft.Web/sites/hostNameBindings",
    "apiVersion": "2016-08-01",
    "name": "[concat(concat(parameters('sites_tailspin_space_game_web_name'), variables('uniqueName')), '/', concat(parameters('sites_tailspin_space_game_web_name'), variables('uniqueName'), '.azurewebsites.net'))]",
    "location": "[parameters('location')]",
    "dependsOn": [
        "[resourceId('Microsoft.Web/sites', concat(parameters('sites_tailspin_space_game_web_name'), variables('uniqueName')))]"
    ],
    "properties": {
        "siteName": "tailspin-space-game-web",
        "hostNameType": "Verified"
    }
```

1. Save the file. Select the ellipsis (...) and choose **Save**.

> [!TIP]
> In Cloud Shell, you can close the editor now if you'd like. But leave the command window open for the next part.

## Select an Azure region for deployment

A _region_ is one or more Azure datacenters within a specific geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an App Service instance, is assigned a region.

To make the commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

1. From Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription.

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the **Name** column in the output, choose a region that's close to you, for example, **eastasia** or **westus2**.

1. Run the following `read` command to set a Bash variable that's named `AZ_LOCATION`.

    ```bash
    read AZ_LOCATION
    ```

    At the prompt, enter the region that you chose in the previous step.

    This Bash variable makes it easier to run the command that comes next. In practice, this Bash variable isn't required.

1. Print the Bash variable to verify it was set correctly.

    ```bash
    echo $AZ_LOCATION
    ```

    You see your region, for example, "northeurope".

1. Set your default location for the resources.

    ```azurecli
    az configure --defaults location=$AZ_LOCATION
    ```

## Make your resource names unique

The name of the SQL Server instance and the web app must be unique.

For learning purposes, here you generate a random number and assign it to the `UNIQUE_ID` Bash variable.

1. From Cloud Shell, generate a random number and assign it to the `UNIQUE_ID` variable.

    ```bash
    UNIQUE_ID=$RANDOM
    ```

1. Print this  to the console. Write it down for later.

    ```bash
    echo $UNIQUE_ID
    ```

1. The output resembles this:

    ```output
    24536
    ```

## Create a random password

Here, you generate a random password to use with your Azure SQL Database.

There are many ways generate random passwords. The method you choose depends on your workflow and requirements. This method uses the **openssl** utility to generate 32 random bytes and base64 encode the output. Base64 encoding ensures that the result contains only printable characters.

Run the **openssl** utility to generate a random password.

```bash
SQL_PASSWORD=$(openssl rand -base64 32)
```

## Run the template

1. Run the following to create a resource group for the template to deploy into.

    ```azurecli
    az group create --name tailspin-spacegame-web-rg
    ```

1. Run the following to deploy the template.

    ```azurecli
    az group deployment create \
      --name deploytemplate \
      --resource-group tailspin-spacegame-web-rg \
      --template-file template.json \
      --parameters deployPrefix="-dev-" uniqueSuffix=$UNIQUE_ID adminPassword="$SQL_PASSWORD"
    ```

az group deployment create \
  --name deploytemplate \
  --resource-group tailspin-spacegame-web-rg \
  --template-file template.json \
  --parameters deploymentParameters.json

    It might take a minute to get running. Notice that we are passing in the parameters we need. Later you'll move them to a parameter file, pipeline variables, and Azure Key Vault.

1. Navigate to the Azure portal and choose **Resource groups**, then the **tailspin-spacegame-web-rg** resource group. Notice that you have an App Service Plan, App Service, and a SQL Server instance. Take note of the suffix on each of these resources. It is made from the `deployPrefix` and your `uniqueSuffix`.

    ![List of resources created by the template run](../media/3-resource-list.png)

1. Run the template a second time. Notice that it is idempotent, meaning it will not try to create a resource that is already there. However, if you delete a resource or change some of its properties, the new resource or resource changes will be created.

## Clean up

Here, you delete everything in your resource group, but not the resource group itself. You'll add more resources to your resource group shortly.

From the Azure portal, delete the resources group by selecting the resources in the resource group and then selecting **Delete** from the menu bar. Do not delete the resource group. When prompted, enter *Yes* to confirm. This will delete everything in the resource group along but not the resource group. Make sure the resources are deleted but the resource group remains.

![Delete resources in the resource group](../media/3-delete-resources.png)
