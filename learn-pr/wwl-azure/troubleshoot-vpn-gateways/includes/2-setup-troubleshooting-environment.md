[!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.
You’ll troubleshoot a site-to-site connection problem in a later exercise. Use the following instructions and the Azure Cloud Shell on the right of the screen to create the environment for this exercise.

> **NOTE**:
> The resource group **sandbox-rg** has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.

In the sandbox to the right, follow these steps:

1. Enter this Azure CLI command:

    ```azurecli
    az deployment group create \
    --resource-group sandbox-rg \
    --template-uri "https://raw.githubusercontent.com/MicrosoftDocs/mslearn-troubleshoot-vpn-gateways/main/arm-lab.json"
    ```

1. You can continue to the next unit as this command runs in the background.

The command creates two virtual networks (VNET) and connects them using a network gateway, and border gateway protocol. One VNET is in the US, and one is in Europe.
