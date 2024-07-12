The deposits application continues to evolve throughout development. The team is adding resources and testing features on a daily basis. Observability is being added to the application with an existing log analytics workspace and a new application insights instance. You want to continue to manage the resources as a single atomic unit. You need to learn more about adding both existing and new resources to a deployment stack.

In this unit you learn how to add both existing and new resources to a deployment stack as managed resources.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Add an existing resource

The resources that an application uses change over time. How do we update a deployment stack to include an already existing resource in Azure? The process of adding an existing resource to a deployment stack is identical to adding a new resource to the stack. We simply need to define the existing resource in our ARM JSON template, Bicep file, or template spec. In the end, the existing resource is managed by the deployment stack.

Let's consider our Bicep file from the last unit. Our file defines an app service plan, a web app, and an Azure SQL server and database. We want to add an existing log analytics workspace to our deployment stack. The workspace is in the same resource group where our managed resources exist.

:::code language="bicep" source="code/1b-template.bicep" range="1-21,25-27,31-46,55-77":::

To add the existing log analytics workspace, we need to add its definition to our Bicep file. Notice that we do not need to include any code that describes the workspace as an existing resource.

:::code language="bicep" source="code/1b-template.bicep" range="1-21,25-46,55-89" highlight="25-26,68-78":::

::: zone pivot="cli"

With the Bicep file updated, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

To update a deployment stack using Azure CLI, use the `az stack group create` command.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage detachAll \
    --deny-settings-mode none
```

> [!NOTE]
> Azure CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

When performing an update on the stack, you receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changes, the warning alerts you of the new values.

::: zone-end

::: zone pivot="powershell"

With the Bicep file updated, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DetachAll `
    -DenySettingsMode None
```

::: zone-end

## Add a new managed resource

The process of adding a new resource to a deployment stack is identical to adding an existing resource to the stack. We simply need to define the existing resource in our ARM JSON template, Bicep file, or template spec. In the end, the new resource is managed by the deployment stack.

Let's consider our Bicep file from the previous section. Our file now defines an app service plan, app service, an Azure SQL server and database, and a log analytics workspace. We want to add a new application insights instance to our deployment stack and configure the app service to use the instance.

:::code language="bicep" source="code/1b-template.bicep" range="1-21,25-46,55-89":::

To add the new application insights instance, we need to add its definition to our Bicep file and update the app service to use the new instance.

:::code language="bicep" source="code/1b-template.bicep" range="1-100" highlight="22-23,47-54,91-100":::

::: zone pivot="cli"

With the Bicep file updated, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

To update a deployment stack using Azure CLI, use the `az stack group create` command.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage detachAll \
    --deny-settings-mode none
```

> [!NOTE]
> Azure CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

When performing an update on the stack, you receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changes, the warning alerts you of the new values.

::: zone-end

::: zone pivot="powershell"

With the Bicep file updated, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DetachAll `
    -DenySettingsMode None
```

::: zone-end

As you can see, the process of adding an existing resource or a new resource is the same.
