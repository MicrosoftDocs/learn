---
author: johndowns
ms.prod: learning-azure
ms.topic: include
ms.date: 04/22/2021
ms.author: jodowns
---
To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) tools installed, and sign in with the same account that you used to activate the sandbox.

1. Open a terminal window by using the **Terminal** menu. This usually opens at the bottom of the screen.

1. If the dropdown menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

    :::image type="content" source="../media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash in the dropdown menu." border="true":::

    If not, select the dropdown menu, and choose **Select Default Shell**. Then select **bash**.

    :::image type="content" source="../media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, showing the select shell dropdown menu." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

1. Switch your terminal to the directory where you saved your Bicep template. For example, if you saved it in the *scripts* folder, you can use this command:

    ```azurecli
    cd scripts
    ```

### Check the version of the Azure CLI

1. From the terminal in Visual Studio Code, run this command to check the version of the Azure CLI:

   ```azurecli
   az -v
   ```

1. Look at the version number on the first line, which starts with `azure-cli`.

   - If the version number is version `2.20.0` or later, go to the next section ("Install the Bicep tooling").

   - If the version number is later than `2.11.0` and earlier than `2.20.0`, update your Azure CLI version by using this command:
  
      ```azurecli
      az upgrade
      ```

   - If the version number is earlier than `2.11.0`, you might need to [reinstall the Azure CLI](/cli/azure/install-azure-cli) to get the latest version.

### Install the Bicep tooling

Run the following command to install the Bicep template compilation support:

```azurecli
az bicep install
```

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. A browser opens so you can sign in to your account.

    ```azurecli
    az login
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, you see one called *Concierge Subscription*. Use this one for the rest of the exercise.

1. Set the default subscription for all of the Azure CLI commands that you run in this session:

    ```azurecli
    az account set --subscription "Concierge Subscription"
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, there might be more than one Concierge Subscription listed. In this case, use the next two steps to set the default subscription. If the previous command was successful, skip the next two steps.

1. Get the Concierge Subscription IDs:

   ```azurecli
    az account list \
      --refresh \
      --query "[?contains(name, 'Concierge Subscription')].id" \
      --output table
    ```

1. Set the default subscription by using the subscription ID. Replace *{your subscription ID}* with the latest Concierge Subscription ID.

    ```azurecli
    az account set --subscription {your subscription ID}
    ```

### Set the default resource group

When you use the CLI, you can set the default resource group and omit the parameter from the rest of the Azure CLI commands in this exercise. Set the default to the resource group created for you in the sandbox environment.

```azurecli
az configure --defaults group=<rgn>[sandbox resource group name]</rgn>
```
