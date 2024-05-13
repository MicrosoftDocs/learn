In this exercise, you update the Bicep file you previously created to include additional resources. You also update and delete the deployment stack that manages your resources.

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

    :::code language="bicep" source="code/1-template-1.bicep" range="1-23" highlight="5-16:::

1. Add the following code to the bottom of the file:

    :::code language="bicep" source="code/1-template-1.bicep" range="44-63":::

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

![a graphic representing an the command line prompting you to endter an administrator user name and password for the sql server](../media/deployment-stack-application-cli.png)

> [!NOTE]
> Rember, AZ CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack

::: zone-end

::: zone pivot="powershell"

To update the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -DenySettingsMode none
```

You are prompted to enter a value for `sqlServerAdminUserName` and `sqlServerAdminPassword`. You need to create a complex password for the SQL server.

![a graphic representing an the command line prompting you to endter an administrator user name and password for the sql server](../media/deployment-stack-application-powershell.png)

::: zone-end

## Verify the update to the deployment stack and the managed resources

::: zone pivot="cli"

Insert text here.

::: zone-end

::: zone pivot="powershell"

Insert text here.

::: zone-end

## Delete the deployment stack

::: zone pivot="cli"

Insert text here.

::: zone-end

::: zone pivot="powershell"

Insert text here.

::: zone-end
