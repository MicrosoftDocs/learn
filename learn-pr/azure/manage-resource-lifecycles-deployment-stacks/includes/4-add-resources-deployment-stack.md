The deposits application continues to evolve throughout development. The team is adding resources and testing features on a daily basis. Observability is being added to the application with an existing Log Analytics workspace and a new Application Insights instance. You want to continue to manage the resources as a single atomic unit. You need to learn more about adding both existing and new resources to a deployment stack.

In this unit, you learn how to add both existing and new resources to a deployment stack as managed resources.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Add an existing resource

The resources that an application uses change over time. How do we update a deployment stack to include an already existing resource in Azure? 

Bicep allows you to define a resource that already exists in Azure. Defining an existing resource is similar to defining a new resource with slight differences. For example, you can define an existing resource in a resource declaration using the `existing` keyword:

```bicep
resource logAnalyticsWorkspace 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' existing  = {
    name: 'log-deposits'
}
```

When we are adding an existing resource as a managed resource to a deployment stack, we do not need to use this `existing` keyword. We simply need to define the existing resource in our Bicep file, ARM JSON template, or template spec. In the end, the deployment stack manages the existing resource.

Let's consider our Bicep file from the last unit. Our file defines an app service plan, a web app, and an Azure SQL server and database. We want to add an existing Log Analytics workspace to our deployment stack. The workspace is in the same resource group where our managed resources exist.

To add the existing Log Analytics workspace, we need to add its definition to our Bicep file. Notice that we don't need to include any code that describes the workspace as an existing resource.

:::code language="bicep" source="code/1b-template.bicep" range="1-21,25-46,55-89" highlight="25-26,68-78":::

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

To update a deployment stack using Azure CLI, use the `az stack group create` command.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage detachAll \
    --deny-settings-mode none
```

::: zone-end

::: zone pivot="powershell"

With the Bicep file modified, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

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

The process of adding a new resource to a deployment stack is identical to adding an existing resource to the stack. We simply need to define the existing resource in our Bicep file, ARM JSON template, or template spec. In the end, the deployment stack manages the new resource.

Let's consider our Bicep file from the previous section. Our file now defines an app service plan, app service, an Azure SQL server and database, and a Log Analytics workspace. We want to add a new Application Insights instance to our deployment stack and configure the app service to use the instance. To add the new Application Insights instance, we need to add its definition to our Bicep file and update the app service to use the new instance.

:::code language="bicep" source="code/1b-template.bicep" range="1-100" highlight="22-23,47-54,91-100":::

::: zone pivot="cli"

With the Bicep file modified, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

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

With the Bicep file modified, we want to update the deployment stack so that the changes made to the resources in the Bicep file are implemented.

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
