You're on sprint 2 for the new deposits application. You want to test updating the deployment stack by defining an Azure SQL database in the Bicep file. You want to verify that the stack is managing the newly defined resources.

In this exercise, you update the Bicep file you previously created to include new resources. You also update and delete the deployment stack that manages your resources.

> [!div class="checklist"]
>
> - Update the Bicep file to include an Azure SQL database.
> - Update the deployment stack to deploy the new database.
> - Validate the deployment stack's managed resources.
> - Delete the deployment stack and managed resources.
> - Validate the deletion of the deployment stack and the managed resources.

## Update the Bicep file to include the Azure SQL database

1. Open the _main.bicep_ file in Visual Studio Code.

1. Add the highlighted code to the parameters section of your file:

    :::code language="bicep" source="code/1-template.bicep" range="1-23" highlight="5-16":::

1. Add the following code to the bottom of the file:

    :::code language="bicep" source="code/1-template.bicep" range="44-63":::

1. Save the changes to the file.

## Update the deployment stack

::: zone pivot="cli"

With the Bicep file updated, we want to update the deployment stack so that the new Azure SQL database is deployed to the environment as a managed resource.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group create \
        --name stack-deposits \
        --resource-group rg-depositsApplication \
        --template-file ./main.bicep \
        --action-on-unmanage deleteAll \
        --deny-settings-mode none
    ```

1. You receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changed, the warning alerts you of the new values. Press `y`, followed by 'Enter`.

    :::image type="content" source="../media/stack-exists-cli.png" alt-text="A screenshot showing the Azure CLI command line warning that the deployment stack already exists.":::

1. You're prompted to enter a value for `sqlServerAdminUserName`. Create a name for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-admin-cli.png" alt-text="A screenshot showing the Azure CLI command line prompting you to enter an SQL server administrator user name.":::

1. You're prompted to enter a value for `sqlServerAdminPassword`. Create a complex password for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-password-cli.png" alt-text="A screenshot showing the Azure CLI command line prompting you to enter an SQL server administrator password.":::

Wait for the update operation to complete before moving on to the next task.

::: zone-end

::: zone pivot="powershell"

With the Bicep file updated, we want to update the deployment stack so that the new Azure SQL database is deployed to the environment as a managed resource.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Set-AzResourceGroupDeploymentStack `
        -Name stack-deposits `
        -ResourceGroupName rg-depositsApplication `
        -TemplateFile ./main.bicep `
        -ActionOnUnmanage DeleteAll `
        -DenySettingsMode none
    ```

2. You're prompted to enter a value for `sqlServerAdminUserName`. Create a name for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-admin-powershell.png" alt-text="A screenshot showing the Azure PowerShell command line prompting you to enter an SQL server administrator user name.":::

3. You're prompted to enter a value for `sqlServerAdminPassword`. Create a complex password for the SQL server administrator, followed by 'Enter.'

    :::image type="content" source="../media/sql-password-powershell.png" alt-text="A screenshot showing the Azure PowerShell command line prompting you to enter an SQL server administrator password.":::

4. Wait for the update operation to complete before moving on to the next task.

::: zone-end

## Verify the update to the deployment stack and the managed resources

::: zone pivot="cli"

With the update complete, we want to validate that the deployment stack is managing the Azure SQL database. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurecli
az stack group show \
    --resource-group rg-depositsApplication \
    --name stack-deposits
```

The result should appear familiar to the following output:

:::code language="json" source="code/2-json.json":::

Take notice of the resources section of the output. We now see the SQL server and SQL database listed as managed resources.

::: zone-end

::: zone pivot="powershell"

With the update complete, we want to validate that the deployment stack is managing the Azure SQL database. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurepowershell
Get-AzResourceGroupDeploymentStack `
    -ResourceGroupName rg-depositsApplication `
    -Name stack-deposits
```

The result should appear familiar to the following output:

:::code language="json" source="code/3-powershell.ps1":::

Take notice of the resources section of the output. We now see the SQL server and SQL database listed as managed resources.

::: zone-end

## Delete the deployment stack

::: zone pivot="cli"

1. To delete the deployment stack and its managed resources, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group delete \
        --name stack-deposits \
        --resource-group rg-depositsApplication \
        --action-on-unmanage deleteAll
    ```

1. You're asked to confirm if you would like to delete the stack and the specified resources.

    :::image type="content" source="../media/confirm-cli.png" alt-text="A screenshot showing a command line confirmation to delete the deployment stack using Azure CLI.":::

1. After the delete operation completes, open the Azure portal and verify that the deployment stack and its resources are removed.

1. To delete the resource group used in these exercises, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    az group delete \
        -name rg-depositsApplication
    ```

1. You're asked to confirm if you would like to remove the resource group. Press 'Y', followed by 'Enter.'

    :::image type="content" source="../media/confirm-resource-group-cli.png" alt-text="A screenshot showing a command line confirmation to delete the resource group using Azure CLI.":::

::: zone-end

::: zone pivot="powershell"

1. To delete the deployment stack and its managed resources, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Remove-AzResourceGroupDeploymentStack `
        -Name stack-deposits `
        -ResourceGroupName rg-depositsApplication `
        -ActionOnUnmanage DeleteAll
    ```

2. You're asked to confirm if you would like to delete the stack and the specified resources.

    :::image type="content" source="../media/confirm-powershell.png" alt-text="A screenshot showing a command line confirmation to delete the deployment stack using Azure PowerShell.":::

3. After the delete operation completes, open the Azure portal and verify that the deployment stack and its resources are removed.

4. To delete the resource group used in these exercises, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Remove-AzResourceGroup `
        -Name rg-depositsApplication
    ```

5. You're asked to confirm if you would like to remove the resource group. Press 'Y', followed by 'Enter.'

    :::image type="content" source="../media/confirm-resource-group-powershell.png" alt-text="A screenshot showing a command line confirmation to delete the resource group using Azure PowerShell.":::

::: zone-end
