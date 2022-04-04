> [!NOTE]
> The resource group <rgn>[sandbox resource group name]</rgn> has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.

In the sandbox to the right, follow these steps:

1. Enter this Azure CLI command:

    ```azurecli
    az deployment group create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-uri "https://raw.githubusercontent.com/MicrosoftDocs/mslearn-troubleshoot-vpn-gateways/main/arm-lab.json"
    ```

1. You can continue to the next unit as this command runs in the background.

The command creates two virtual networks (VNET) and connects them using a network gateway, and border gateway protocol. One VNET is in the US, and one is in Europe.
