---
author: mumian
ms.topic: include
ms.date: 01/15/2025
ms.author: jgao
---
### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

   A browser opens so that you can sign in to your Azure account. The browser might be opened in the background.  

1. After you've signed in to Azure, the terminal displays a list of the subscriptions associated with this account. If you've activated the sandbox, a subscription named *Concierge Subscription* is displayed. Select it for the rest of the exercise.

    If you've used more than one sandbox recently, the terminal might display more than one instance of *Concierge Subscription*. In this case, use the next two steps to set one as the default subscription. 

    1. Get the subscription ID. Running the following command lists your subscriptions and their IDs. Look for `Concierge Subscription`, and then copy the ID from the second column. It looks something like `aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e`.
    
        ```azurepowershell
        Get-AzSubscription
        ```
    
    1. Change your active subscription to *Concierge Subscription*. Be sure to replace *{Your subscription ID}* with the one that you copied.
    
        ```azurepowershell
        $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
        Set-AzContext $context
        ```
    
### Set the default resource group

You can set the default resource group and omit the parameter from the rest of the Azure PowerShell commands in this exercise. Set this default to the resource group created for you in the sandbox environment.

```azurepowershell
Set-AzDefault -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
```
