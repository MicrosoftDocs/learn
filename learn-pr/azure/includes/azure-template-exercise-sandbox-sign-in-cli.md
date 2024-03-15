---
author: mumian
ms.topic: include
ms.date: 06/09/2021
ms.author: jgao
---
### Sign in to Azure

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```
   
1. In the browser that opens, sign in to your Azure account.

   The Visual Studio Code terminal displays a list of the subscriptions associated with this account. 

1. Set the default subscription for all of the Azure CLI commands that you run in this session.

    ```azurecli
    az account set --subscription "Concierge Subscription"
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, the terminal might display more than one instance of *Concierge Subscription*. In this case, use the next two steps to set one as the default subscription. If the preceding command was successful, and only one *Concierge Subscription* is listed, skip the next two steps.

1. Get the Concierge Subscription IDs.

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

When you use the Azure CLI, you can set the default resource group and omit the parameter from the rest of the Azure CLI commands in this exercise. Set the default to the resource group that's created for you in the sandbox environment.

```azurecli
az configure --defaults group="<rgn>[sandbox resource group name]</rgn>"
```
