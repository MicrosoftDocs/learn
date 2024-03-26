---
author: mumian
ms.topic: include
ms.date: 06/09/2021
ms.author: jgao
---
### Sign in to Azure by using Azure CLI

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

   The Visual Studio Code terminal displays a list of the subscriptions associated with this account. 

1. In the list, find the subscription that you want to use for this exercise. 
 
   If you missed the list from the sign-in, you can use the following snippet to list your subscriptions again.

    ```azurecli
    az account list --output table
    ```

1. Set the default subscription for all the Azure CLI commands that you run in this session.

    ```azurecli
    az account set --subscription "Your Subscription Name or ID"
    ```
