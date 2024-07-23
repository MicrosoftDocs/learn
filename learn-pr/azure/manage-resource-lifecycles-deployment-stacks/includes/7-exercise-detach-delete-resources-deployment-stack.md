Sprint 3 for the new deposits application is coming to an end. The deposits team has requested that you detach the log analytics workspace and application insights instance from the deployment stack. Those resources need to continue to exist in Azure. Additionally, they requested that the Azure SQL server and database be deleted from the deployment stack and Azure.

In this exercise, you detach and delete Azure resources from the deployment stack that are no longer needed for the deposits application. You start by detaching resources from the deployment stack that need to continue to exist within Azure. You finish by deleteing resources from the deployment stack that are no longer needed.

During the process, you'll

> [!div class="checklist"]
>
> - Modify the Bicep file to remove the log analytics workspace and the application insights instance
> - Update the deployment stack to detach the managed resources
> - Modify the Bicep file to remove the Azure SQL server and database
> - Update the deployment stack to delete the managed resources
> - Validate the deployment stack's managed resources and the detached resources

## Modify the Bicep file to detach the log analytics workspace and the application insights instance

1. Open the _main.bicep_ file in Visual Studio Code.

1. Remove the highlighted code from the variables section of your file:

    :::code language="bicep" source="code/code/1b-template.bicep" range="21-30" highlight="22-23,28-29":::

1. Remove the highligthed code from the resources section of the file:

    :::code language="bicep" source="code/1b-template.bicep" range="31-100" highlight="47-54,79-100":::

1. Save the changes to the file.

## Update the deployment stack to detach the managed resources

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the log analytics workspace and application insights instance are detached from the stack.

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

Wait for the update operation to complete before moving on to the next task.

::: zone-end

::: zone pivot="powershell"

With the Bicep file modified, we want to update the deployment stack so that the log analytics workspace and application insights instance are detached from the stack.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Set-AzResourceGroupDeploymentStack `
        -Name stack-deposits `
        -ResourceGroupName rg-depositsApplication `
        -TemplateFile ./main.bicep `
        -ActionOnUnmanage DetachAll `
        -DenySettingsMode none
    ```

1. Wait for the update operation to complete before moving on to the next task.

::: zone-end

## Modify the Bicep file to delete the Azure SQL server and database

1. Re-open the _main.bicep_ file in Visual Studio Code.

1. Remove the highlighted code from the parameters section of your file:

    :::code language="bicep" source="code/1b-template.bicep" range="1-20" highlight="5-6,8-9,11-13,15-16":::

1. Remove the highligthed code from the resources section of the file:

    :::code language="bicep" source="code/1b-template.bicep" range="31-46,55-77" highlight="20-28,30-39":::

1. Save the changes to the file.

## Update the deployment stack to delete the managed resources

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the Azure SQL server and database is detached from the stack.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group create \
        --name stack-deposits \
        --resource-group rg-depositsApplication \
        --template-file ./main.bicep \
        --action-on-unmanage deleteAll \
        --deny-settings-mode none
    ```

2. You receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changed, the warning alerts you of the new values. Press `y`, followed by 'Enter`.

    :::image type="content" source="../media/stack-exists-cli.png" alt-text="A screenshot showing the Azure CLI command line warning that the deployment stack already exists.":::

Wait for the update operation to complete before moving on to the next task.

::: zone-end

::: zone pivot="powershell"

With the Bicep file modified, we want to update the deployment stack so that the Azure SQL server and database is detached from the stack.

1. To update the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Set-AzResourceGroupDeploymentStack `
        -Name stack-deposits `
        -ResourceGroupName rg-depositsApplication `
        -TemplateFile ./main.bicep `
        -ActionOnUnmanage DeleteAll `
        -DenySettingsMode none
    ```

1. Wait for the update operation to complete before moving on to the next task.

::: zone-end

## Validate the deployment stack's managed resources and the detached resources

Insert text here.
