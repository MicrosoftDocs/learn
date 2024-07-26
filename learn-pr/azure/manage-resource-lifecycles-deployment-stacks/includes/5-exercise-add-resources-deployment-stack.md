You are on sprint 3 for the new deposits application. Recently, the deposits team requested changes to some of the Azure services in use. They also requested the creation of other services needed to support the application.

In this exercise, you create a deployment stack scoped to a resource group that references a Bicep file. The file defines an app service plan, an app service, and an Azure SQL database. You then modify the SKU of the app service plan and update the deployment stack. Finally, you add an existing log analytics workspace and a new application insights instance to support monitoring of the application.

During the process, you'll:

> [!div class="checklist"]
>
> - Create a Bicep file that defines your initial architecture
> - Create a deployment stack scoped to a resource group using your Bicep file.
> - Modify the properties of an existing managed resource
> - Update the Bicep file to include an existing log analytics workspace and a new application insights instance
> - Update the deployment stack to deploy the managed resources
> - Validate the deployment stack's managed resources.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create the Bicep file

Our first step is to create a Bicep file that defines our resources to use with the deployment stack.

1. Open Visual Studio Code.

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you saved the file. For example, you might want to create a _templates_ folder in which to save the file.

1. Add the following Bicep code into the file. You deploy the template soon. It's a good idea to type the code yourself instead of copying and pasting, so you can see how the tooling helps you to write your Bicep files.

    :::code language="bicep" source="code/1a-template.bicep" range="1-63":::

    Notice that you're using expressions that include string interpolation and the `uniqueString()` function to define default parameter values. Someone deploying this template can override the default parameter values by specifying the values at deployment time, but they can't override the variable values.

    Also notice that you're using a variable for the App Service plan name, but you're using parameters for the other names. Storage accounts and App Service apps need globally unique names, but App Service plan names need to be unique only within their resource group. This difference means it's not a concern to use the same App Service plan name across different deployments, as long as the deployments are all going into different resource groups.

1. Save the changes to the file.

## Create the deployment stack and deploy your resources to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first deployment stack exercise - CLI](../../includes/azure-deployment-stacks-exercise-nosandbox-deploy-cli.md)]

### Create a resource group

We need to create a resource group for our deployment stack and managed resources. To create a resource group, run the following command from the terminal in Visual Studio Code.

```azurecli
az group create \
    --name rg-depositsApplication \
    --location eastus
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first deployment stack exercise - PowerShell](../../includes/azure-deployment-stacks-exercise-nosandbox-deploy-powershell.md)]

### Create a resource group

We need to create a resource group for our deployment stack and managed resources. To create a resource group, run the following command from the terminal in Visual Studio Code.

```azurepowershell
New-AzResourceGroup `
    -Name rg-depositsApplication `
    -Location eastus
```

::: zone-end

### Create the deployment stack

Next, we need to create our deployment stack scoped to our recently created resource group. To create the deployment stack, run the following command from the terminal in Visual Studio Code.

::: zone pivot="cli"

1. To create the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group create \
        --name stack-deposits \
        --resource-group rg-depositsApplication \
        --template-file ./main.bicep \
        --action-on-unmanage detachAll \
        --deny-settings-mode none
    ```

1. It prompts you to enter a value for `sqlServerAdminUserName`. Create a name for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-admin-cli.png" alt-text="A screenshot showing the Azure CLI command line prompting you to enter an SQL server administrator user name.":::

1. It prompts you to enter a value for `sqlServerAdminPassword`. Create a complex password for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-password-cli.png" alt-text="A screenshot showing the Azure CLI command line prompting you to enter an SQL server administrator password.":::

1. Wait for the update operation to complete before moving on to the next task.

::: zone-end

::: zone pivot="powershell"

1. To create the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    New-AzResourceGroupDeploymentStack `
        -Name stack-deposits `
        -ResourceGroupName rg-depositsApplication `
        -TemplateFile ./main.bicep `
        -ActionOnUnmanage DetachAll `
        -DenySettingsMode None
    ```

1. It prompts you to enter a value for `sqlServerAdminUserName`. Create a name for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-admin-powershell.png" alt-text="A screenshot showing the Azure PowerShell command line prompting you to enter an SQL server administrator user name.":::

1. It prompts you to enter a value for `sqlServerAdminPassword`. Create a complex password for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-password-powershell.png" alt-text="A screenshot showing the Azure PowerShell command line prompting you to enter an SQL server administrator password.":::

1. Wait for the update operation to complete before moving on to the next task.

::: zone-end

## Modify the Bicep file to add the existing log analytics workspace and a new application insights instance

1. Open the _main.bicep_ file in Visual Studio Code.

1. Add the highlighted code to the variables section of your file:

    :::code language="bicep" source="code/1b-template.bicep" range="21-30" highlight="2-3,8-9":::

1. Add the following code to the bottom of the file:

    :::code language="bicep" source="code/1b-template.bicep" range="79-100":::

1. Save the changes to the file.

## Modify the Bicep file to modify the app service plan and app service

1. Open the _main.bicep_ file in Visual Studio Code.

1. Change the sku name of the app service plan from `F1` to `S1`:

    :::code language="bicep" source="code/1b-template.bicep" range="31-39" highlight="6":::

1. Add the highlighted code to wire in the application insights instance:

    :::code language="bicep" source="code/1b-template.bicep" range="41-56" highlight="7-14":::

1. Save the changes to the file.

## Update the deployment stack

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group create \
        --name stack-deposits \
        --resource-group rg-depositsApplication \
        --template-file ./main.bicep \
        --action-on-unmanage detachAll \
        --deny-settings-mode none
    ```

1. You receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changed, the warning alerts you of the new values. Press `y`, followed by 'Enter`.

    :::image type="content" source="../media/stack-exists-cli.png" alt-text="A screenshot showing the Azure CLI command line warning that the deployment stack already exists.":::

1. It prompts you to enter a value for `sqlServerAdminUserName`. Create a name for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-admin-cli.png" alt-text="A screenshot showing the Azure CLI command line prompting you to enter an SQL server administrator user name.":::

1. It prompts you to enter a value for `sqlServerAdminPassword`. Create a complex password for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-password-cli.png" alt-text="A screenshot showing the Azure CLI command line prompting you to enter an SQL server administrator password.":::

1. Wait for the update operation to complete before moving on to the next task.

::: zone-end

::: zone pivot="powershell"

With the Bicep file modified, we want to update the deployment stack so that the changes made to the app service plan are implemented.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Set-AzResourceGroupDeploymentStack `
        -Name stack-deposits `
        -ResourceGroupName rg-depositsApplication `
        -TemplateFile ./main.bicep `
        -ActionOnUnmanage DetachAll `
        -DenySettingsMode none
    ```

1. It prompts you to enter a value for `sqlServerAdminUserName`. Create a name for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-admin-powershell.png" alt-text="A screenshot showing the Azure PowerShell command line prompting you to enter an SQL server administrator user name.":::

1. It prompts you to enter a value for `sqlServerAdminPassword`. Create a complex password for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-password-powershell.png" alt-text="A screenshot showing the Azure PowerShell command line prompting you to enter an SQL server administrator password.":::

1. Wait for the update operation to complete before moving on to the next task.

::: zone-end

## Verify the update to the deployment stack and the managed resources

With the update complete, we want to validate that the app service plan's sku is updated and that the deployment stack is managing the existing log analytics workspace and the new application insights instance.

::: zone pivot="cli"

1. To view the configuration of the app service plan, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az appservice plan show \
        --name plan-deposits
        --resource-group rg-depositsApplication
    ```

1. Take notice of the sku section of the output. The app service plan is now on the S1 sku. It should be similar to the following output:

    ```json
    "sku": {
        "capacity": 1,
        "family": "S",
        "name": "S1",
        "size": "S1",
        "tier": "Standard"
    },
    ```

1. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group show \
        --resource-group rg-depositsApplication \
        --name stack-deposits
    ```

1. Take notice of the resources section of the output. We now see the existing log analytics workspace and the new application insights instance listed as managed resources. The result should appear similar to the following output:

    :::code language="json" source="code/2a-json.json" range="43-80" highlight="68-79":::

::: zone-end

::: zone pivot="powershell"

1. To view the configuration of the app service plan, run the following command from the terminal in Visual Studio Code.

    ```powershell
    $plan = Get-AzAppServicePlan `
        -ResourceGroupName rg-depositsApplication `
        -Name plan-deposits
    $sku = $plan.Sku
    $sku
    ```

1. Take notice of the output. The app service plan is now on the S1 sku. It should be similar to the following:

    ```powershell
    Name         : S1
    Tier         : Standard
    Size         : S1
    Family       : S
    Capacity     : 1
    ```

1. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Get-AzResourceGroupDeploymentStack `
        -ResourceGroupName rg-depositsApplication `
        -Name stack-deposits
    ```

1. Take notice of the resources section of the output. We now see the existing log analytics workspace and the new application insights instance listed as managed resources. The result should appear similar to the following output:

    :::code language="powershell" source="code/3a-powershell.ps1" range="11-16" highlight="5-6":::

::: zone-end
