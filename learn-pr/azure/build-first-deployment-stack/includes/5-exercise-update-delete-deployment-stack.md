You are on sprint 2 for the new deposits application. You want to test updating the deployment stack by defining an Azure SQL database in the bicep file. You want to verify that the newly defined resources are managed by the stack. In this exercise, you update the Bicep file you previously created to include additional resources. You also update and delete the deployment stack that manages your resources.

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

With the Bicep file updated, we want to update the deployment stack so that the new Azure SQL database is deployed to the environment as a managed resource. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --deny-settings-mode none
```

You are prompted to enter a value for `sqlServerAdminUserName` and `sqlServerAdminPassword`. You need to create a complex password for the SQL server.

![a graphic representing an the command line prompting you to endter an administrator user name and password for the sql server](../media/sql-admin-username-password-cli.png)

> [!NOTE]
> AZ CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

::: zone-end

::: zone pivot="powershell"

With the Bicep file updated, we want to update the deployment stack so that the new Azure SQL database is deployed to the environment as a managed resource. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -DenySettingsMode none
```

You are prompted to enter a value for `sqlServerAdminUserName` and `sqlServerAdminPassword`. You need to create a complex password for the SQL server.

![a graphic representing an the command line prompting you to endter an administrator user name and password for the sql server](../media/sql-admin-username-password-cli.png)

::: zone-end

## Verify the update to the deployment stack and the managed resources

::: zone pivot="cli"

With the update complete, we want to validate that the Azure SQL database is now managed by the deployment stack. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurecli
az stack group show \
    --resource-group rg-depositsApplication \
    --name stack-deposits
```

The output should appear familiar to the following:

:::code language="json" source="code/2-json.json":::

Take notice of the resources section of the output. We now see the SQL server and SQL database listed as managed resources.

::: zone-end

::: zone pivot="powershell"

With the update complete, we want to validate that the Azure SQL database is now managed by the deployment stack. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurepowershell
Get-AzResourceGroupDeploymentStack `
    -ResourceGroupName rg-depositsApplication `
    -Name stack-deposits
```

The output should appear familiar to the following:

:::code language="json" source="code/3-powershell.ps1":::

Take notice of the resources section of the output. We now see the SQL server and SQL database listed as managed resources.

::: zone-end

## Delete the deployment stack

::: zone pivot="cli"

To delete the deployment stack and its managed resources, run the following command from the terminal in Visual Studio Code.

```azurecli
az stack group delete \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --action-on-unmanage deleteAll
```

::: zone-end

::: zone pivot="powershell"

To delete the deployment stack and its managed resources, run the following command from the terminal in Visual Studio Code.

```azurepowershell
Remove-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -ActionOnUnmanage -DeleteAll
```

::: zone-end
