---
author: johndowns
ms.prod: learning-azure
ms.topic: include
ms.date: 05/22/2021
ms.author: jodowns
---
To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu. This menu usually opens at the bottom of the screen.

1. If the dropdown menu on the right of the terminal window says **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../../../bicep/shared/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with pwsh in the dropdown menu." border="true":::

   If not, select the dropdown menu, and choose **Select Default Shell**. Then select **pwsh** or **PowerShell**.

    :::image type="content" source="../../../../bicep/shared/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window showing the select shell dropdown menu." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with *pwsh* or *PowerShell* as the shell.

1. You might have to switch your terminal to the directory where you saved your ARM template. For example, if you saved it in the *scripts* folder, you can use this command:

   ```azurepowershell
   cd scripts
   ```

### Check the version of Azure PowerShell

From the terminal in Visual Studio Code, run the following command to check the version of Azure PowerShell that you've installed:

```azurepowershell
(Get-InstalledModule Az).Version
```

If the version number is `5.6.0` or later, go to the next section ("Sign in to Azure").

Otherwise, you need to [install the latest version of Azure PowerShell](/powershell/azure/install-az-ps).

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. A browser opens so you can sign in to your account.

    ```azurepowershell
    Connect-AzAccount
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, you see one called *Concierge Subscription*. Use this one for the rest of the exercise.

1. Set the default subscription for all of the Azure PowerShell commands that you run in this session.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionName 'Concierge Subscription'
    Set-AzContext $context
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, there might be more than one Concierge Subscription listed. In this case, use the next two steps to set the default subscription. If the previous command was successful, skip the next two steps.

1. Get the subscription ID. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for `Concierge Subscription`, and copy the second column. It looks something like `cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0`.

    ```azurepowershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute *{Your subscription ID}* with the one that you copied.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

### Set the default resource group

You can set the default resource group and omit the parameter from the rest of the Azure PowerShell commands in this exercise. Set this default to the resource group created for you in the sandbox environment.

```azurepowershell
Set-AzDefault -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
```
