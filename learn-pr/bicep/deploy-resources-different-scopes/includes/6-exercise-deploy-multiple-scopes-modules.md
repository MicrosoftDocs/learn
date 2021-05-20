> [!NOTE]
> This exercise requires an Azure subscription. If you don't have an Azure subscription, you can get a [free subscription](https://azure.microsoft.com/free/?azure-portal=true).

The R&D team have asked for your help to create a virtual network in the Project Teddybear subscription. You know you'll be helping the R&D team with more subscriptions in the future, so you decide to extend your reusable Bicep template to deploy a virtual network for them to use. In this exercise, you'll update the template you started to build in the last exercise. During the process, you'll:

> [!div class="checklist"]
> * Update the subscription-scoped template to create a new resource group.
> * Create a separate Bicep module with a virtual network, and use parameters to control how the virtual network is configured.
> * Update the template to deploy the module into the resource group.
> * Deploy the template.

## Create a resource group

1. In the *main.bicep* file in Visual Studio Code, add the following variable definition under the current variable definitions:

   :::code language="bicep" source="code/6-template.bicep" range="8" :::

1. Add the following resource definition at the bottom of the file:

   :::code language="bicep" source="code/6-template.bicep" range="51-54" :::

   Notice that you're defining the resource group just like you would another resource. A resource group is a subscription-scoped resource that can be deployed and managed in subscription-scope Bicep files.

1. Save the changes to the file.

## Add a module to create a virtual network

Next, you will create a Bicep module for the R&D team's virtual network. The resources in the module will be deployed into the resource group later in this exercise.

1. In Visual Studio Code, create a new folder called *modules* in the same folder where you created your *main.bicep* file.

1. In the *modules* folder, create a file called *virtualNetwork.bicep*. Save the file.

1. Add the following content into the *virtualNetwork.bicep* file:

   :::code language="bicep" source="code/modules/virtualNetwork.bicep" :::

   Notice that you haven't specified a `targetScope` for this module. You don't need to specify a target scope when the Bicep file is targeting a resource group.

1. Save the changes to the file.

## Use the module in the subscription deployment

Now you're ready to tell Bicep to deploy the module into the resource group.

1. In the *main.bicep* file in Visual Studio Code, add the following parameter definitions underneath the `targetScope` line:

   :::code language="bicep" source="code/6-template.bicep" range="3-4" :::

   These parameters make the template reusable, so anytime the R&D team needs a new subscription you can create a virtual network with a unique name and IP address range.

1. At the bottom of the file, add the following module definition:

   :::code language="bicep" source="code/6-template.bicep" range="56-63" :::

   Notice that you're explicitly specifying the `scope` for the module. Bicep understands that the resources within the module should be deployed into the resource group created earlier in the templates.

## Verify your template

Your *main.bicep* file should look like the following:

:::code language="bicep" source="code/6-template.bicep" :::

Your *modules/virtualNetwork.bicep* file should look like the following:

:::code language="bicep" source="code/modules/virtualNetwork.bicep" :::

If either file doesn't match the example, either copy the example or adjust your template.

## Deploy the template to Azure

::: zone pivot="cli"

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

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

Deploy the template by using Azure PowerShell commands in the terminal.

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

Notice that you're passing in values for the `virtualNetworkName` and `virtualNetworkAddressPrefix` parameters. When another R&D team asks you to prepare a subscription for them, you'll be able to change these values to give them their own virtual network.

The deployment might take a minute or two to complete, and then you'll see a successful deployment.

### Clean up the resources

You've successfully deployed subscription-scoped resources, including a resource group, and used a module to deploy into the resource group you created. You can remove the policy resources and resource group that you've created.

> [!CAUTION]
> This command will permanently delete the resource group named *ToyNetworking* and all of its resources. If you've deployed anything else into this resource group, you should skip this step.

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
