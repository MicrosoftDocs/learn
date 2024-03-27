> [!NOTE]
> This exercise requires an Azure subscription. If you don't already have one, you can get a [free subscription](https://azure.microsoft.com/free/?azure-portal=true).

The R&D team has asked for your help to create a virtual network in the Project Teddybear subscription. You know you'll be helping the team with more subscriptions in the future, so you decide to extend your reusable Bicep template to deploy a virtual network for the team members to use. 

In this exercise, you'll update the template that you started to build in the last exercise. 

During the process, you'll:

> [!div class="checklist"]
> * Update the subscription-scoped template to create a new resource group.
> * Create a separate Bicep module with a virtual network, and use parameters to control how the virtual network is configured.
> * Update the template to deploy the module to the resource group.
> * Deploy the template.

This exercise requires that you have permission to deploy subscription-scoped resources. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant. Alternatively, you can skip the deployment steps in this exercise.

## Create a resource group

1. In Visual Studio Code, open the *main.bicep* file that you created in the earlier exercise.

1. Under the current variable definitions, add the following variable definition:

   :::code language="bicep" source="code/6-template.bicep" range="8" :::

1. At the bottom of the file, add the following resource definition:

   :::code language="bicep" source="code/6-template.bicep" range="51-54" :::

   Notice that you're defining the resource group just as you would define another resource. A resource group is a subscription-scoped resource that can be deployed and managed in Bicep files with the `targetScope` set to `subscription`.

1. Save the changes to the file.

## Add a module to create a virtual network

Next, you'll create a Bicep module for the R&D team's virtual network. You'll deploy the resources in the module to the resource group later in this exercise.

1. In Visual Studio Code, create a new folder called *modules* in the same folder where you created your *main.bicep* file.

1. In the *modules* folder, create and save a file called *virtualNetwork.bicep*.

1. In the *virtualNetwork.bicep* file, add the following content:

   :::code language="bicep" source="code/6-virtual-network.bicep" :::

   Notice that you haven't specified a `targetScope` for this module. You don't need to specify a target scope when the Bicep file is targeting a resource group.

1. Save the changes to the file.

## Use the module in the subscription deployment

Now you're ready to tell Bicep to deploy the module to the resource group.

1. In the *main.bicep* file in Visual Studio Code, under the `targetScope` line, add the following parameter definitions:

   :::code language="bicep" source="code/6-template.bicep" range="3-4" :::

   These parameters make the template reusable. Anytime the R&D team needs a new subscription, you can create a virtual network with a unique name and IP address range.

1. At the bottom of the file, add the following module definition:

   :::code language="bicep" source="code/6-template.bicep" range="56-63" :::

   Notice that you're explicitly specifying the `scope` for the module. Bicep understands that the resources within the module should be deployed to the resource group that you created earlier in the file.

## Verify your template

Your *main.bicep* file should look like the following:

:::code language="bicep" source="code/6-template.bicep" :::

Your *modules/virtualNetwork.bicep* file should look like the following:

:::code language="bicep" source="code/6-virtual-network.bicep" :::

If either file doesn't match the example, either copy the example or adjust your template.

## Deploy the template to Azure

::: zone pivot="cli"

In the Visual Studio Code terminal, deploy the template by using the following Azure CLI commands:

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="sub-scope-"$today
virtualNetworkName="rnd-vnet-001"
virtualNetworkAddressPrefix="10.0.0.0/24"

az deployment sub create \
    --name $deploymentName \
    --location westus \
    --template-file $templateFile \
    --parameters virtualNetworkName=$virtualNetworkName \
                 virtualNetworkAddressPrefix=$virtualNetworkAddressPrefix
```

::: zone-end

::: zone pivot="powershell"

In the Visual Studio Code terminal, deploy the template by using the following Azure PowerShell commands:

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "sub-scope-$today"
$virtualNetworkName = 'rnd-vnet-001'
$virtualNetworkAddressPrefix = '10.0.0.0/24'

New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile `
  -virtualNetworkName $virtualNetworkName `
  -virtualNetworkAddressPrefix $virtualNetworkAddressPrefix
```

::: zone-end

Notice that you're passing in values for the `virtualNetworkName` and `virtualNetworkAddressPrefix` parameters. When another R&D team asks you to prepare a subscription for them, you'll be able to change these values to give that team its own virtual network.

The deployment might take a minute or two to finish, and then you'll see a successful deployment.

## Verify the deployment

Now you'll check the resource group and the deployment that the module created.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left pane, select **Resource groups**. Notice that the *ToyNetworking* resource group has been created.

1. Select the *ToyNetworking* resource group. Notice that the module has been deployed to the resource group successfully, and that the virtual network has been created:

   :::image type="content" source="../media/6-resource-group.png" alt-text="Screenshot of the Azure portal, showing the ToyNetworking resource group." border="true":::

### Clean up the resources

You've successfully deployed the subscription-scoped resources, including a resource group, and you've used a module to deploy the resource to the resource group you created. You can remove the policy resources and resource group that you've created.

> [!CAUTION]
> This command will permanently delete the resource group named *ToyNetworking* and all its resources. If you've deployed anything else to this resource group, you should skip this step.

::: zone pivot="cli"

```azurecli
subscriptionId=$(az account show --query 'id' --output tsv)

az policy assignment delete --name 'DenyFandGSeriesVMs' --scope "/subscriptions/$subscriptionId"
az policy definition delete --name 'DenyFandGSeriesVMs' --subscription $subscriptionId
az group delete --name ToyNetworking
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
$subscriptionId = (Get-AzContext).Subscription.Id

Remove-AzPolicyAssignment -Name 'DenyFandGSeriesVMs' -Scope "/subscriptions/$subscriptionId"
Remove-AzPolicyDefinition -Name 'DenyFandGSeriesVMs' -SubscriptionId $subscriptionId
Remove-AzResourceGroup -Name ToyNetworking
```

::: zone-end
