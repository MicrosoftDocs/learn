---
author: johndowns
ms.prod: learning-azure
ms.topic: include
ms.date: 04/22/2021
ms.author: jodowns
---
To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu. This menu usually opens at the bottom of the screen.

1. If the dropdown control to the right of the terminal window says **pwsh** or **PowerShell**, you have the right shell to work from and can skip to the next section.

    :::image type="content" source="../media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with pwsh in the dropdown menu." border="true":::

   Otherwise, in the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.

    :::image type="content" source="../media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window showing the select shell dropdown menu." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with *pwsh* or *PowerShell* as the shell.

1. You might have to switch your terminal to the directory where you saved your Bicep template. For example, if you saved it to the *scripts* folder, you can use this command:

   ```azurepowershell
   cd scripts
   ```

### Check the version of Azure PowerShell

1. From the terminal in Visual Studio Code, run the following command to check the version of Azure PowerShell that you've installed:

   ```azurepowershell
   (Get-InstalledModule Az).Version
   ```

   If the version number is `5.6.0` or later, go to the next section ("Sign in to Azure").

   Otherwise, you need to [install the latest version of Azure PowerShell](/powershell/azure/install-az-ps).

### Sign in to Azure

1. In the Visual Studio Code terminal, run the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

   A browser opens so that you can sign in to your Azure account.

1. After you've signed in to Azure, the terminal displays a list of the subscriptions associated with this account. 
 
   If you've activated the sandbox, a subscription named *Concierge Subscription* is displayed. Use it for the rest of the exercise.

1. Set the default subscription for all of the Azure PowerShell commands that you run in this session.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionName 'Concierge Subscription'
    Set-AzContext $context
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, the terminal might display more than one instance of *Concierge Subscription*. In this case, use the next two steps to set one as the default subscription. If the preceding command was successful, and only one *Concierge Subscription* is listed, skip the next two steps.

1. Get the subscription ID. Running the following command lists your subscriptions and their IDs. Look for `Concierge Subscription`, and then copy the ID from the second column. It looks something like `cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0`.

    ```azurepowershell
    Get-AzSubscription
    ```

1. Change your active subscription to *Concierge Subscription*. Be sure to replace *{Your subscription ID}* with the one that you copied.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

### Install the Bicep CLI

Azure PowerShell doesn't include the tooling to understand Bicep files, so you need to [install the Bicep CLI](/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#install-manually).

### Set the default resource group

You can set the default resource group and omit the parameter from the rest of the Azure PowerShell commands in this exercise. Set this default to the resource group created for you in the sandbox environment.

```azurepowershell
Set-AzDefault -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
```