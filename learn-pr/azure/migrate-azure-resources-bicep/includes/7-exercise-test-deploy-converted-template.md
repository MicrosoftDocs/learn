[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

TODO: Introduction - Insert text here.

During the process, you'll:

> [!div class="checklist"]
>
> - TODO: Task - Insert text here.
> - TODO: Task - Insert text here.
> - TODO: Task - Insert text here.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Run what-if

TODO

Output:

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