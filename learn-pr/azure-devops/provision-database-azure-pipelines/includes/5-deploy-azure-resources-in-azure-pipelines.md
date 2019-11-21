In this exercise, you put the team's vision into place and add the Azure Resource Manager template deployment to the pipeline. 

Here you:

> [!div class="checklist"]
> * Get the source code
> * Create a Key Vault to store the SQL Server admin password
> * Create the service connection and pipeline variables that the deployment will need.
> * Create the template parameter file, explore the template, and explore the pipeline.
> * Run the pipeline, approve the database changes, and see the successful deployment of the web app

## Get the starter code from GitHub

In the previous exercise, you forked and cloned the repo you'll need for this module. Here, you checkout the branch you'll use for this deployment. This branch contains the _Space Game_ project you worked with in the previous modules, the SQL Server Data Tools project for the database schema, the Azure Resource Manager template file and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `starter` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream starter
    git checkout starter
    ```

    The format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

## Create the Key Vault and store a secret

1. If you closed your Cloud Shell, open it again and reset your default location and unique id. Run this command and enter a location at the prompt

    ```bash
    read AZ_LOCATION
    ```

    Run this command to set the default location

    ```azurecli
    az configure --defaults location=$AZ_LOCATION
    ```

1. Choose a random number for the Key Vault name. Run this command and enter a number at the prompt. You can use the one you generated earlier if you like.

    ```bash
    read UNIQUE_ID
    ```

1. Run the following to create a Key Vault to store adminPassword. Notice the `enabled-for-template-deployment` parameter. This will allow your template to query the key vault once permissions are established.

    ```azurecli
    az keyvault create \
      --name tailspin-vault-$UNIQUE_ID \
      --resource-group tailspin-spacegame-web-rg \
      --location $AZ_LOCATION \
      --enabled-for-template-deployment true
    ```

1. Wait for the key vault to be created, then scroll up and copy the "id: ...." line and save it somewhere. You need this to get to the key vault in the template parameters file.
1. Run the following to set the secret in the Key Vault. Replace **[your password]** with a strong password.

    ```azurecli
    az keyvault secret set --vault-name tailspin-vault-$UNIQUE_ID --name "adminPassword" --value "[your password]"
    ```

1. In VS Code, create a file in the same directory as the template.json file called **deploymentParameters.json**.
    Paste the following into the file. Replace the **"id:...."** line with what you copied when you set the secret, and **NNN** with your unique number for the Key Vault and *XXXXX* with a unique number for the resource name suffix.

    ```json
   {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "deployPrefix": {
                "value": "-dev-"
            },
            "keyVaultName": {
              "value": "tailspin-vault-NNN"
            },
            "uniqueSuffix": {
                "value": "XXXXX"
            },
            "adminPassword": {
                "reference": {
                  "keyVault": {
                    "id": "/subscriptions/de53e040-65b5-4cee-bab9-5505db93125a/resourceGroups/tailspin-spacegame-web-rg/providers/Microsoft.KeyVault/vaults/tailspin-vault-NNN"
                  },
                  "secretName": "adminPassword"
                }
            }
        }
    }
    ```

    The template will read this file to discover the deploymentPrefix and uniqueSuffix we want to use for this specific deployment, the adminPassword for the SQL Server instance it will create, and the keyVaultName. The template will need the name of the Key Vault to add the database connection string to the Key Vault for us.

    Save the file.

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in previous modules.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Tailspin-SpaceGame-Template** project.
1. Select **Project settings** from the bottom corner of the page.
1. Under **Pipelines**, select **Service connections**.
1. Select **+ New service connection** and then choose **Azure Resource Manager**.

    The **Add an Azure Resource Manager service connection** dialog appears.
1. From the dialog, ensure **Service Principal Authentication** is selected. Then fill in these fields:

    | Field               | Value                                        |
    |---------------------|----------------------------------------------|
    | **Connection name** | **Resource Manager - Tailspin - Space Game** |
    | **Scope level**     | **Subscription**                             |
    | **Subscription**    | Your Azure subscription                      |
    | **Resource Group**  | Leave this blank to include all resource groups.|

    During the process, you might be prompted to sign in to your Microsoft account.

1. Select **OK**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps is unable to connect, you'll have the chance to sign in a second time.

## Create a personal access token and pipeline variables in Azure Pipelines

Here you create a personal access token to allow Azure Pipelines REST API to access the pipeline variables. You will need this to set the template outputs to pipeline variables. This allows the variables to be accessed across stages.

1. Navigate to your Azure DevOps organization and select your profile in the upper right corner.
1. Select **Azure DevOps Profile**.
1. In the **User Settings** pane, select **Personal access tokens**.

    ![Profile page select personal access token](../media/5-select-personal-access-token.png)

1. Select **+ New Token**
1. Enter **Database Changes IaC** as the name and select **Full access**.
1. Select **Create**.
1. Copy the token to a safe place.

    > [!IMPORTANT]
    > Be sure to do this now because the token will never be shown in plain text again.

1. Add a variable group and variables to the pipeline.
    1. Navigate to your **Tailspin-SpaceGame-Template** project and select **Pipelines**.
    1. Under **Pipelines**, select **Library**.
    1. Create a new variable group called **Release**.
    1. Select **Release** and add the following variables:

        | Variable name         | Example value                            |
        |-----------------------|------------------------------------------|
        | **Acct**    | The name of your organization in Azure DevOps. |
        | **PAT** | Enter your personal access token. |
        | **location** | Enter a location near you. For example, **eastus** |
        | **subscription** | Enter your subscription GUID. This can be found under **Subscriptions** on the far left in the Azure portal.|
        | **keyVaultName** | **tailspin-vault-NNN**. Where NNN is your unique number.|
        | **uniqueSuffix** | **XXXXX**. Where XXXXX matches the number you used in the *deploymentParameters.json* file.|

        Select the lock icon next to the value for **PAT** to ensure this value is encrypted.
    1. Select **Save** near the top of the page to save your variables to the pipeline.

    Your variable group should like similar to this:

    ![Pipeline library variables](../media/5-library-variables.png)

## Allow the service connection to access the key vault

1. Navigate to the Azure portal and choose **Resource groups**, then the **tailspin-spacegame-web-rg** resource group.
1. Select **tailspin-vault-NNN**. Where NNN is your unique number.
1. Open the **Overview** for the vault.
1. Choose **Access policies**, then **Add Access Policy**.
1. In the **Add access policy** blade, choose **Select principal** and search for the service principal for your client account. It will be the **[organization name]-[project name]-[subscription id]** format.
1. In the **Add access policy** blade, choose **Secret permissions** and ensure that **Get** and **List** are checked.
1. Select **Add**.
1. Save the changes.

## Explore the Azure Resource Manager template and Azure Pipelines pipeline files

1. Open the *template.json* file that came with the projects. This is the same file you used in the last exercise. Replace the code in that file with the following:

[!code-json[](code/completetemplate.json?highlight=88-119,123-133,189-194)]

Recall, a template can be created from scratch, downloaded from starter templates, or created from resources you already have. The [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines/azure-pipelines=true) module had you create the infrastructure needed manually in the Azure portal. This template file is a result of exporting the resource group that was created in that module. It has been edited to add the parts that the team discussed for pipeline deployment, and to remove the _test_ and _staging_ App Service deployments. Some default policies have also been removed to shorten the file for learning purposes.

Notice the creation of the database. Just as you did in the [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines/azure-pipelines=true) module, the database is created and the data is inserted through a .bacpac file using an import extension in the resources section in a resource called *Import*.

```json
{
    "type": "Microsoft.Sql/servers/databases",
    "apiVersion": "2017-03-01-preview",
    "name": "[concat(concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName')), '/tailspindatabase')]",
    "location": "[parameters('location')]",
    "dependsOn": [
        "[resourceId('Microsoft.Sql/servers', concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName')))]"
    ],
    "sku": {
        "name": "S1",
        "tier": "Standard"
    },
    "kind": "v12.0,user,vcore",
    "properties": {
        "collation": "SQL_Latin1_General_CP1_CI_AS",
        "catalogCollation": "SQL_Latin1_General_CP1_CI_AS",
        "zoneRedundant": false
    },
    "resources": [{
        "name": "Import",
        "type": "extensions",
        "apiVersion": "2014-04-01",
        "dependsOn": [
            "[resourceId('Microsoft.Sql/servers/databases', concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName')), 'tailspindatabase')]"
        ],
        "properties": {
            "storageKeyType": "SharedAccessKey",
            "storageKey": "?",
            "storageUri": "https://sqldbtutorial.blob.core.windows.net/bacpacs/tailspindatabase.bacpac",
            "administratorLogin": "azuresql",
            "administratorLoginPassword": "[parameters('adminPassword')]",
            "operationMode": "Import"
        }
    }]
},
```

The next part is the creation of Key Vault secrets. Here you add the database connection string to the Key Vault. You will use this secret to add the connection string to the App Service configuration in the pipeline after the WebApp is deployed. This is the reason you need the keyVaultName parameter.

```json
{
    "type": "Microsoft.KeyVault/vaults/secrets",
    "name": "[concat(parameters('keyVaultName'),'/connectionString')]",
    "apiVersion": "2015-06-01",
    "properties": {
        "contentType": "text/plain",
        "value": "[concat('Server=tcp:',reference(concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName'))).fullyQualifiedDomainName,',1433;Initial Catalog=tailspindatabase;Persist Security Info=False;User ID=',reference(concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName'))).administratorLogin,';Password=',parameters('adminPassword'),';MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;')]"
    },
    "dependsOn": [
        "[resourceId('Microsoft.Sql/servers/databases', concat(parameters('servers_tailspin_space_game_sql_name'), variables('uniqueName')), 'tailspindatabase')]"
    ]
},
```

1. Save the file and commit it, but do not push your branch to GitHub yet.

    ```bash
    git add template.json
    git commit -m "Add complete provisioning to template.json"
    ```

1. Open the **azure-pipelines.yml** file. This is the same file you used in the [Manage database changes in Azure Pipelines](https://docs.microsoft.com/learn/modules/manage-database-changes-in-azure-pipelines/azure-pipelines=true) module. Replace the code in that file with the following:

[!code-yml[](code/5-azure-pipelines.yml?highlight=94-116,132-136,211-215,277-281,290-296)]

Notice the addition of the *Provision* stage. Here you have the task `AzureResourceManagerTemplateDeployment@3` to deploy the *template.json* file using the *deploymentParameters.json* file.

```yml
- task: AzureResourceManagerTemplateDeployment@3
    inputs:
    deploymentScope: 'Resource Group'
    ConnectedServiceName: 'Resource Manager - Tailspin - Space Game'
    subscriptionName: '$(subscription)'
    action: 'Create Or Update Resource Group'
    resourceGroupName: 'tailspin-spacegame-web-rg'
    location: '$(location)'
    templateLocation: 'Linked artifact'
    csmFile: 'template.json'
    csmParametersFile: 'deploymentParameters.json'
    deploymentMode: 'Incremental'
    deploymentOutputs: ResourceGroupDeploymentOutputs
```

Several stages need the information stored in Key Vault. They use the `AzureKeyVault@1` task to get the secrets. The `secretsFilter` parameter can specify just one secret, or get them all. This task will add the secret to the job variables for easy access within that job.

```yml
- task: AzureKeyVault@1
    inputs:
    azureSubscription: 'Resource Manager - Tailspin - Space Game'
    keyVaultName: '$(keyVaultName)'
    secretsFilter: '*'
```

The `AzureAppServiceSettings@0` task will set the connection string that it gets from from the Key Vault as a `connectionStrings` setting in the App Service configuration.

```yml
- task: AzureAppServiceSettings@1
    displayName: Azure App Service Settings
    inputs:
    azureSubscription: 'Resource Manager - Tailspin - Space Game'
    appName: $(webAppName)
    connectionStrings: |
    [{ "name": "DefaultConnection","value": "$(connectionString)","type": "SQLAzure","slotSetting": false }]
```

1. Save the file and commit it, but do not push your branch to GitHub yet.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add provisioning to the pipeline"
    ```

### Create an environment for manual approval

Here you create the manual approval for the `DBAVerificationApply` stage. You learned about manual approvals in [Create a multi-stage pipeline with Azure Pipelines](https://docs.microsoft.com/learn/modules/create-multi-stage-pipeline/index?azure-portal=true). Recall that you need to set up an environment and add an approver.

1. From Azure Pipelines, select **Environments**
1. Select **Create environment**.
1. Under **Name**, enter **dbaverificationapply**.
1. Leave the remaining fields at their default values.
1. Select **Create**.
1. On the **dbaverificationapply** environment page, select the drop down menu, then select **Checks**.

    ![Azure Pipelines showing the Checks menu option](../media/5-add-check-to-environment.png)

1. On the **Use manual approvals** page, select **Create**.
1. Under **Approvers**, select **Add users and groups** and then select your account.
1. Under **Instructions to approvers**, enter **Approve this change to the database schema**.
1. Select **Create**.

## Run the pipeline

1. Push the changes to the pipeline up to your GitHub remote, `origin`. This triggers the pipeline to run.

    ```bash
    git push origin starter
    ```

1. Go to your pipeline and wait for the manual approval of the database schema.

    When the pipeline stops for approval, click on the `DBAVerificationScript` stage and look at the change script that was created. It will be in the **Show automated SQL Script** section. The script will have a change to **ALTER** the Profiles table adding a favoriteMap column.
1. Go back to the pipeline and select the **Waiting** button on the `DBAVerificationApply`. Select **Review** and then **Approve**.
1. Wait for the pipeline to finish deployments.

## Add the new data

You need data for the new column before you can run the web site. To do that you'll add data from a script directly into the Profiles table.

### Set a firewall rule

Before you can explore your database and add the new data needed for the new column, you need to set a firewall rule that permits access access to the database from your local machine.

1. From the Azure portal, on the left, select **SQL databases**.
1. Choose the **tailspindatabase**.
1. At the top of the **tailspindatabase** page, select **Set server firewall**.

    Your current IP address is printed next to **Client IP address**. For example, **123.12.123.123**.
1. Enter the following rule:

    | Property  | Value  |
    |---|---|
    | Rule name| LocalIP |
    | Start IP | Your IP address. Change the last octet to `0`. For example, 123.12.123.**0** |
    | End IP | Your IP address. Change the last octet to `255`. For example 123.12.123.**255** |

1. Ensure that **Allow Azure services and resources to access this server** is set to **On**.
1. Select **Save** at the top and then select **OK**.

### Add data for the new column

1. You still need to add data to the new column before you can try the new website.
    1. Navigate back to your [Azure portal](https://portal.azure.com?azure-portal=true) and select **SQL Databases**.
    1. Select your database, **tailspindatabase**.
    1. Select **Query editor** and sign in.
    1. In your local `starter` branch, you see *FavoriteMapData.sql*. This SQL script adds a favorite galaxy string to each profile by filling in the `favoriteMap` column. Copy the contents of this file.
    1. Paste the file contents into **Query 1** and select **Run** to populate the new table.
    1. Verify that the queries ran successfully.
    1. Select **New Query**.
    1. In **Query 2**, add the following T-SQL code:

        ```sql
        SELECT * FROM dbo.Profiles
        ```

        Verify that the `favoriteMap` column is populated with data.

## Verify that the application was deployed

1. Navigate to your host name, for example **tailspin-space-game-web-dev-1234.azurewebsites.net**, and select a player to see the new data on the profile.

    ![The website with a profile showing the player's favorite galaxy](../media/5-profile-with-favorite-galaxy.png)

> [!NOTE]
> This is an initial deployment template. Creating the database from a bacpac file is not idempotent. If you run the pipeline again, you will get an error because you already have a database with the same name as the one you are trying to create.
