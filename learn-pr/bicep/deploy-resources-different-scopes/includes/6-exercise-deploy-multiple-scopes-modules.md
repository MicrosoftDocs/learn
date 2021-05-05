2. Create a new Bicep file, which will run at resource group scope.
3. Add the second Bicep file as a module, with a target scope of the resource group created earlier.
4. Deploy the Bicep template.

TODO intro

## Create a resource group

TODO intro

1. In the *main.bicep* file in Visual Studio Code, add the following resource definition at the bottom of the file:

   :::code language="bicep" source="code/6-template.bicep" range="51-54" :::

   TODO describe

1. Add the following variable definition under the current variable definitions:

   :::code language="bicep" source="code/modules/virtualNetwork.bicep" range="8" :::

1. Save the changes to the file.

## Add a module to create a virtual network

TODO intro

1. In Visual Studio Code, create a new folder called *modules* in the same folder where you created your *main.bicep* file. In the *modules* folder, create a file called *virtualNetwork.bicep*. Save the file.

1. Add the following content into the *virtualNetwork.bicep* file:

   :::code language="bicep" source="code/modules/virtualNetwork.bicep" :::

1. Save the changes to the file.

## Use the module in the subscription deployment

TODO intro

1. In the *main.bicep* file in Visual Studio Code, add the following parameter definitions underneath the `targetScope` line:

   :::code language="bicep" source="code/modules/virtualNetwork.bicep" range="3-4" :::

1. At the bottom of the file, add the following module definition:

   :::code language="bicep" source="code/modules/virtualNetwork.bicep" range="56-63" :::

### Deploy the template to Azure

The following code deploys the template to Azure. You'll see a successful deployment.

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
$deploymentName = "sub-scope-$Today"
$virtualNetworkName = 'rnd-vnet-001'
$virtualNetworkAddressPrefix = '10.0.0.0/24'

New-AzSubscriptionDeployment `
  -Name $DeploymentName `
  -Location westus `
  -TemplateFile $TemplateFile `
  -virtualNetworkName $virtualNetworkName `
  -virtualNetworkAddressPrefix $virtualNetworkAddressPrefix
```

::: zone-end

TODO notice you are passing parameters
