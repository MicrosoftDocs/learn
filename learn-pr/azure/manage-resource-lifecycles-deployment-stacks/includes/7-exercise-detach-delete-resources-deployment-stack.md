Sprint 3 for the new deposits application is coming to an end. The deposits team has requested that you detach the log analytics workspace and application insights instance from the deployment stack. Those resources need to continue to exist in Azure. Additionally, they requested that the Azure SQL server and database be deleted from the deployment stack and Azure.

In this exercise, you detach and delete Azure resources from the deployment stack that are no longer needed for the deposits application. You start by detaching resources from the deployment stack that need to continue to exist within Azure. You then delete resources from the deployment stack that are no longer needed. Finally, you delete the deployment stack, its managed resources, and the resource group.

During the process, you'll

> [!div class="checklist"]
>
> - Modify the Bicep file to remove the log analytics workspace and the application insights instance
> - Update the deployment stack to detach the managed resources
> - Validate the deployment stack's managed resources and the detached resources
> - Modify the Bicep file to remove the Azure SQL server and database
> - Update the deployment stack to delete the managed resources
> - Validate the deployment stack's managed resources and the deleted resources
> - Delete the deployment stack and managed resources.
> - Validate the deletion of the deployment stack and the managed resources.

## Modify the Bicep file to detach the log analytics workspace and the application insights instance

The deposits team has requested that we detach the log analytics workspace and application insights instance from the deployment stack. They have also requested that the resources continue to exist in Azure. We start by modifying the Bicep file.

1. Open the _main.bicep_ file in Visual Studio Code.

2. Remove the highlighted code from the variables section of your file:

    :::code language="bicep" source="code/1b-template.bicep" range="21-30" highlight="22-23,28-29":::

3. Remove the highligthed code from the resources section of the file:

    :::code language="bicep" source="code/1b-template.bicep" range="31-100" highlight="7-14,39-60":::

4. Save the changes to the file.

## Update the deployment stack to detach the managed resources

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the log analytics workspace and application insights instance are detached from the stack. We use `--action-on-unmanage detachAll` to accomplish this.

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

With the Bicep file modified, we want to update the deployment stack so that the log analytics workspace and application insights instance are detached from the stack. We use `ActionOnUnmanage DetachAll` to accomplish this.

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

## Validate the deployment stack's managed resources and the detached resources

::: zone pivot="cli"

With the update complete, we want to validate that the deployment stack is no longer managing the log analytics workspace and application insights instance.

1. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group show \
        --resource-group rg-depositsApplication \
        --name stack-deposits
    ```

1. Take notice of the `actionOnUnmanage` section of the output. The values are all set to `detach`. This is because you performed the deployment stack update with the `--action-on-unmanage detachAll`.

    :::code language="json" source="code/2b-json.json" range="2-6":::

1. Now look at the resources section of the output. We no longer see the log analytics workspace and application insights instance as managed resources.

    :::code language="json" source="code/2b-json.json" range="43-68":::

::: zone-end

::: zone pivot="powershell"

With the update complete, we want to validate that the deployment stack is no longer managing the log analytics workspace and application insights instance.

1. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Get-AzResourceGroupDeploymentStack `
        -ResourceGroupName rg-depositsApplication `
        -Name stack-deposits
    ```

1. Take notice of the values for `resourcesCleanupAction`, `resourceGroupsCleanupAction`, and `managementGroupsCleanupAction`. The values are all set to `detach`. This is because you performed the deployment stack update with the `-ActionOnUnmanage DetachAll`.

    :::code language="json" source="code/3b-powershell.ps1" range="4-6":::

1. Now look at the resources section of the output. We no longer see the log analytics workspace and application insights instance as managed resources.

    :::code language="json" source="code/3b-powershell.ps1" range="11-14":::

::: zone-end

Let's validate this in the Azure portal.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Resource groups**.

1. Select **rg-depositsApplication**.

1. If necessary, expand the **settings** menu.

1. Select **Deployment stacks**.

1. Select **stack-deposits**.

1. Verify that you have 4 managed resources and 2 detached resources (log analytics and application insights).

    :::image type="content" source="../media/azure-portal-deployment-stacks-resources-1.png" alt-text="A screenshot showing the Azure portal representing a deployment stack and its managed resources and detached resources.":::

## Modify the Bicep file to detach and delete the Azure SQL server and database

The deposits team has requested that we detach and delete the Azure SQL server and database from the deployment stack and Azure. We start by modifying the Bicep file.

1. Re-open the _main.bicep_ file in Visual Studio Code.

2. Remove the highlighted code from the parameters section of your file:

    :::code language="bicep" source="code/1b-template.bicep" range="1-20" highlight="5-6,8-9,11-13,15-16":::

3. Remove the highligthed code from the resources section of the file:

    :::code language="bicep" source="code/1b-template.bicep" range="31-46,55-77" highlight="20-28,30-39":::

4. Save the changes to the file.

## Update the deployment stack to delete the managed resources

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the Azure SQL server and database are detached from the stack and deleted from Azure. We use `--action-on-unmanage deleteAll` to accomplish this. Note that this will also delete the log analytics workspace and application insights instance we detached in the last section.

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

3. Wait for the update operation to complete before moving on to the next task.

::: zone-end

::: zone pivot="powershell"

With the Bicep file modified, we want to update the deployment stack so that the Azure SQL server and database are detached from the stack and deleted from Azure. We use `-ActionOnUnmanage DeleteAll` to accomplish this. Note that this will also delete the log analytics workspace and application insights instance we detached in the last section.

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

## Validate the deployment stack's managed resources

::: zone pivot="cli"

With the update complete, we want to validate that the deployment stack is no longer managing the log analytics workspace, application insights instance, and the Azure SQL server and database. We also want to verify that the resources have been deleted from Azure.

1. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurecli
    az stack group show \
        --resource-group rg-depositsApplication \
        --name stack-deposits
    ```

2. Take notice of the `actionOnUnmanage` section of the output. The values are all set to `delete`. This is because you performed the deployment stack update with the `--action-on-unmanage deleteAll`.

    :::code language="json" source="code/2c-json.json" range="2-6":::

3. Now look at the resources section of the output. We no longer see the Azure SQL server and database as managed resources.

    :::code language="json" source="code/2c-json.json" range="32-45":::

::: zone-end

::: zone pivot="powershell"

With the update complete, we want to validate that the deployment stack is no longer managing the log analytics workspace, application insights instance, and the Azure SQL server and database. We also want to verify that the resources have been deleted from Azure.

1. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

    ```azurepowershell
    Get-AzResourceGroupDeploymentStack `
        -ResourceGroupName rg-depositsApplication `
        -Name stack-deposits
    ```

1. Take notice of the values for `resourcesCleanupAction`, `resourceGroupsCleanupAction`, and `managementGroupsCleanupAction`. The values are all set to `delete`. This is because you performed the deployment stack update with the `-ActionOnUnmanage DeleteAll`.

    :::code language="json" source="code/3c-powershell.ps1" range="4-6":::

1. Now look at the resources section of the output. We no longer see the Azure SQL server and database as managed resources.

    :::code language="json" source="code/3c-powershell.ps1" range="11-12":::

::: zone-end

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Resource groups**.

1. Select **rg-depositsApplication**.

1. If necessary, expand the **settings** menu.

1. Select **Deployment stacks**.

1. Select **stack-deposits**.

1. Verify that the app service plan and app service still exist as managed resources, and our other resources have been deleted.

    :::image type="content" source="../media/azure-portal-deployment-stacks-resources-2.png" alt-text="A screenshot showing the Azure portal representing a deployment stack and its two managed resources.":::

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

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Resource groups**.

1. Verify that the **rg-depositsApplication** no longer exists.
