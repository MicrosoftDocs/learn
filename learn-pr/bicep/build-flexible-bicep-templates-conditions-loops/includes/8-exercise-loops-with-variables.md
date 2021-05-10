For your toy company, you need to deploy virtual networks in each Azure region you're using. You need flexibility to have different subnets for each virtual network. You want to specify subnet configuration by using Bicep parameters.

During exercise you'll:

> [!div class="checklist"]
> * Create a Bicep template with parameter for subnet configuration and variable loop to create subnet array used in virtual network resource declaration
> * Deploy Bicep template and verify virtual network deployment.
> * Update parameter for subnet configuration, redeploy template and observe changes to virtual network.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template with parameters, variables and resources to deploy virtual network

1. Open Visual Studio Code, and create a new file called *vnet.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.
1. Add the following content into the file.
  
   ```bicep
    param subnetDefinitions array = [
      {
        name: 'application'
        iprange: '10.10.5.0/24'
      }
      {
        name: 'database'
        iprange: '10.10.10.0/24'
      }
    ]
    
    var subnets = [for subnet in subnetDefinitions: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.iprange
      }
    }]
    
    resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
      name: 'vnet'
      location: resourceGroup().location
      properties:{
        addressSpace:{
          addressPrefixes:[
            '10.10.0.0/16'
          ]
        }
        subnets: subnets
      }
    }
   ```

    Notice that within Bicep definition for variable in line 11 you used variable loop with ```for``` keyword that iterates through parameter ```subnetDefinitions``` array.

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file vnet.bicep
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile vnet.bicep
```

::: zone-end

You'll see ```Running...``` in the terminal. Wait for deployment to finish.

## Verify the deployment

After deployment is finished, you want to verify that new virtual network is deployed and it has subnet configuration as specified in parameter value.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Select virtual network ```vnet``` and select Subnets under Settings category in left menu.

1. Verify that deployed subnets have names and IP addresses that were specified in parameter ```subnetDefinitions``` default value.

    :::image type="content" source="../media/8-varloop-deployment.png" alt-text="Screenshot of the Azure portal interface for virtual network subnets after deployment." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Update subnet configuration parameter and redeploy the template to Azure

You deployed virtual network with two subnets, now you want to add additional subnet to your virtual network.

1. Return to Visual Studio Code and in the *vnet.bicep* file add additional subnet configuration to default values of parameter ```subnetDefinitions```.

   ```bicep
    param subnetDefinitions array = [
      {
        name: 'frontend'
        iprange: '10.10.0.0/24'
      }
      {
        name: 'application'
        iprange: '10.10.5.0/24'
      }
      {
        name: 'database'
        iprange: '10.10.10.0/24'
      }
    ]
    ```

1. Save the changes to the file.

1. Redeploy template by running following code from the terminal in Visual Studio Code and wait for deployment to finish.

::: zone pivot="cli"

```azurecli
az deployment group create --template-file vnet.bicep
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile vnet.bicep
```

::: zone-end

## Verify the redeployment

With redeployment of updated Bicep template finished you want to verify that additional subnet was created in virtual network ```vnet```.

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true), select **<rgn>[sandbox resource group name]</rgn>** Resource Group and select ```vnet``` virtual network. Select Subnets under Settings category in left menu. In case are already in subnet section of virtual network you can just select Refresh from Subnet menu.

1. Verify new subnet is deployed to virtual network.

    :::image type="content" source="../media/8-varloop-redeployment.png" alt-text="Screenshot of the Azure portal interface for virtual network subnets after redeployment." border="true":::
