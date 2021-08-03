You've now created a Bicep file to represent the virtual machine that runs the toy truck services. Before you commit to using the file in your pipelines, you need to first verify that the file accurately represents your current Azure environment. In this module, you'll test and then deploy your Bicep file over the top of your existing Azure resources. During the process, you'll:

> [!div class="checklist"]
>
> - Run the what-if command to determine the effects of your deployment.
> - Deploy the template and verify the deployment status.

## Run what-if

Before you deploy your new Bicep file for real, you first run the what-if command. This command verifies that your Bicep file is valid, and it provides you with a list of changes that will occur in your Azure environment once you deploy the file.

> [!NOTE]
> In a real migration, you should run the what-if command against your production and non-production environments, with the appropriate set of parameters for each environment. This helps you to detect any differences in configuration that you might not have uncovered already. In this example you use a single environment, so you run the what-if operation against that one environment.

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurecli
   az deployment group what-if --resource-group ToyTruck --file main.bicep --parameters main.parameters.production.json
   ```

1. Review the output, which looks like the following:   

   # [Screenshot](#tab/screenshpt)   

   :::image type="content" source="../media/7-whatif-output.png" alt-text="Screenshot of the Visual Studio Code terminal showing the output from the what-if operation." :::   

   # [Text](#tab/textoutput)   

   ```output
   Note: The result may contain false positive predictions (noise).
   You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.   

   Resource and property changes are indicated with these symbols:
     - Delete
     ~ Modify
     = Nochange
     * Ignore   

   The deployment will update the following scope:   

   Scope: /subscriptions/8952eed4-dfa3-4518-93d0-62f8a8ae0d0c/resourceGroups/LEARN-B44B5D84-E9A2-4B1B-8D33-FDF6122B54AD   

     ~ Microsoft.Network/networkInterfaces/toytruckserver686 [2020-11-01]
       - properties.vnetEncryptionSupported: false   

     = Microsoft.Compute/virtualMachines/ToyTruckServer [2021-03-01]
     = Microsoft.Network/networkSecurityGroups/ToyTruckServer-nsg [2020-11-01]
     = Microsoft.Network/publicIPAddresses/ToyTruckServer-ip [2020-11-01]
     = Microsoft.Network/virtualNetworks/learn-b44b5d84-e9a2-4b1b-8d33-fdf6122b54ad-vnet [2020-11-01]
     = Microsoft.Network/virtualNetworks/learn-b44b5d84-e9a2-4b1b-8d33-fdf6122b54ad-vnet/subnets/default [2020-11-01]
     * Microsoft.Compute/disks/ToyTruckServer_OsDisk_1_3b5a980955c54f1c838b7efa21e1ddd3
     * Microsoft.Storage/storageAccounts/cloudshell982026958   

   Resource changes: 1 to modify, 5 no change, 2 to ignore.
   ```

   ---

<!-- TODO update the above - use the correct names and what-if output given the changes in the exercise -->
<!-- TODO review results -->

<!-- TODO note that anything on the OS disk wouldn't be included - you'd need to do a separate backup or image -->

## Deploy your template

You know that your Bicep file is valid, and the what-if operation has indicated that your template has the effects that you expect. You're now ready to deploy your template. If this step succeeds, you should see no effect.

1. In the Visual Studio Code **Terminal**, run the following command:

   ```azurecli
   az deployment group create --resource-group ToyTruck --file main.bicep --parameters main.parameters.production.json
   ```

   The deployment takes a few seconds and then completes successfully.

1. In the Azure portal, open the resource group and navigate to the deployment.

   Verify that the deployment succeeded.

> [!TIP]
> In a real migration, you should also run smoke tests to verify that your resources are still behaving correctly. This acts as a final check to ensure that you didn't accidentally change something you didn't mean to.
