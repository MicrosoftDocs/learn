---
author: mumian
ms.topic: include
ms.date: 01/15/2025
ms.author: jgao
---
### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

1. Get the ID of the subscription that you want to use for this exercise by running the following command:

    ```azurepowershell
    Get-AzSubscription
    ```

    The subscription ID is the second column. Copy the second column. It looks something like *aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e*.

1. Set the default subscription for all the Azure PowerShell commands that you run in this session.

    ```azurepowershell
    Set-AzContext -SubscriptionId {Your subscription ID}
    ```
