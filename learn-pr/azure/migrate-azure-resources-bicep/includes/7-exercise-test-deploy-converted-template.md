You've now created a Bicep file to represent the virtual machine that runs the toy truck services. Before you commit to using the file in your pipelines, you need to first verify that the file accurately represents your current Azure environment. In this module, you'll test and then deploy your Bicep file over the top of your existing Azure resources. During the process, you'll:

> [!div class="checklist"]
>
> - Run the what-if command to determine the effects of your deployment.
> - Deploy the template and verify the deployment status.

<!--
TODO: still to write:
- Complete mode, and how the disk won't actually be deleted
- Anything on the OS disk isn't included in the export - you'd need to do a separate backup, image, or run scripts to deploy app components etc
-->

## Run what-if

Before you deploy your new Bicep file for real, you first run the what-if command. This command verifies that your Bicep file is valid, and it provides you with a list of changes that will occur in your Azure environment once you deploy the file.

> [!NOTE]
> In a real migration, you should run the what-if command against your production and non-production environments, with the appropriate set of parameters for each environment. This helps you to detect any differences in configuration that you might not have uncovered already. In this example you use a single environment, so you only run the what-if operation against that one environment.

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurecli
   az deployment group what-if --resource-group ToyTruck --template-file main.bicep --parameters main.parameters.production.json
   ```

1. When prompted, enter a secure password for the `virtualMachineAdminPassword` parameter value.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurepowershell
   New-AzResourceGroupDeployment `
     -WhatIf `
     -ResourceGroupName ToyTruck `
     -TemplateFile main.bicep `
     -TemplateParameterFile main.parameters.production.json
   ```

1. When prompted, enter a secure password for the `virtualMachineAdminPassword` parameter value.

::: zone-end

### Review the what-if output

Review the what-if output, which looks like the following:

# [Screenshot](#tab/screenshpt)   

:::image type="content" source="../media/7-whatif-output-1.png" alt-text="Screenshot of the Visual Studio Code terminal showing the output from the what-if operation, with three changes detected.." :::   

# [Text](#tab/textoutput)   

:::code language="output" source="code/7-whatif-output-1.txt" :::

---

The output includes three important pieces of information. Let's review each one.

1. On the `networkInterface` resource, the `vnetEncryptionSupported` property is detected to no longer be set to the value `false`. You'll resolve this shortly.

1. Also on the `networkInterface` resource, the `privateIPAddress` property is detected to be removed. This is OK, because you removed that property intentionally. The IP address allocation mode property (`privateIPAllocationMethod`) is set to _Dynamic_, so removing the `privateIPAddress` property won't have any effect, even though it's a change.

1. The what-if command detects that the disk isn't described in your template, and it will ignore it. This is OK, because Azure creates the disk for you.

### Resolve the vnetEncryptionSupported property issue by updating the API version

1. Open your *main.bicep* file in Visual Studio Code.

1. Update the API version of the `networkInterface` resource from `2020-11-01` to `2020-07-11`:

   :::code language="bicep" source="code/7-main-final.bicep" range="134-160" highlight="1" :::

### Re-run the what-if command

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurecli
   az deployment group what-if --resource-group ToyTruck --template-file main.bicep --parameters main.parameters.production.json
   ```

1. When prompted, enter a secure password for the `virtualMachineAdminPassword` parameter value.

1. Wait for the what-if operation to complete, and inspect the output, which looks like the following:

   # [Screenshot](#tab/screenshpt)   
   
   :::image type="content" source="../media/7-whatif-output-2.png" alt-text="Screenshot of the Visual Studio Code terminal showing the output from the what-if operation, with two changes detected." :::   
   
   # [Text](#tab/textoutput)   
   
   :::code language="output" source="code/7-whatif-output-2.txt" :::
   
   ---

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurepowershell
   New-AzResourceGroupDeployment `
     -WhatIf `
     -ResourceGroupName ToyTruck `
     -TemplateFile main.bicep `
     -TemplateParameterFile main.parameters.production.json
   ```

1. When prompted, enter a secure password for the `virtualMachineAdminPassword` parameter value.

1. Wait for the what-if operation to complete, and inspect the output, which looks like the following:

   # [Screenshot](#tab/screenshpt)   
   
   :::image type="content" source="../media/7-whatif-output-2.png" alt-text="Screenshot of the Visual Studio Code terminal showing the output from the what-if operation, with two changes detected." :::   
   
   # [Text](#tab/textoutput)   
   
   :::code language="output" source="code/7-whatif-output-2.txt" :::
   
   ---

::: zone-end

## Deploy your template

You know that your Bicep file is valid, and the what-if operation has indicated that your template has the effects that you expect. You're now ready to deploy your template. If this step succeeds, you should see no effect.

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurecli
   az deployment group create --resource-group ToyTruck --template-file main.bicep --parameters main.parameters.production.json
   ```

   The deployment takes a few seconds and then completes successfully.

1. In the Azure portal, open the resource group. Select the **2 Succeeded** link to view the list of deployments.

   :::image type="content" source="../media/7-resource-group.png" alt-text="Screenshot of the Azure portal showing the resource group, with the 2 successful deployment link highlighted." :::

1. Notice that the deployment succeeded.

   :::image type="content" source="../media/7-deployment-list.png" alt-text="Screenshot of the Azure portal showing the resource group deployments, with the successful deployment highlighted." :::

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurepowershell
   New-AzResourceGroupDeployment `
     -ResourceGroupName ToyTruck `
     -TemplateFile main.bicep `
     -TemplateParameterFile main.parameters.production.json
   ```

   The deployment takes a few seconds and then completes successfully.

1. In the Azure portal, open the resource group. Select the **2 Succeeded** link to view the list of deployments.

   :::image type="content" source="../media/7-resource-group.png" alt-text="Screenshot of the Azure portal showing the resource group, with the 2 successful deployment link highlighted." :::

1. Notice that the deployment succeeded.

   :::image type="content" source="../media/7-deployment-list.png" alt-text="Screenshot of the Azure portal showing the resource group deployments, with the successful deployment highlighted." :::

::: zone-end

> [!TIP]
> In a real migration, you should also run smoke tests to verify that your resources are still behaving correctly. This acts as a final check to ensure that you didn't accidentally change something you didn't mean to.
