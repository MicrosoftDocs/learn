In this unit, you'll create an Azure Maps account using the Azure CLI. Once created, you'll get the primary key needed to give the web SDK access to the Maps account. This key will be used in the coding units later in this module.

## Create an Azure Maps account

1. Make sure you've activated the sandbox, using the button above. The sandbox will give you access to free Azure resources for the duration of this module.

1. Run this command to create a new Azure Maps account

    ```Azure CLI
    az maps account create --name pollution_map --resource-group <rgn>[sandbox resource group name]</rgn> --accept-tos
    ```

## Retrieve the primary key

Azure Maps accounts are secured by either Azure Active Directory or via a key. Later in this module, you'll use the key to give the web SDK access to the Maps account. The key can be retrieved using the Azure CLI.

1. Run this command to view the keys

    ```Azure CLI
    az maps account keys list --name pollution_map --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

1. Note down the value of the `"primaryKey"`. You need the value inside the quotes.
