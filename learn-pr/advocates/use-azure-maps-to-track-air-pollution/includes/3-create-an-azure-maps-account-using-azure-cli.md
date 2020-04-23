Before you can use Azure Maps on a web page, you'll need an Azure Maps account. In this unit, you'll use the Azure CLI to create an Azure Maps account, and get a key needed by web SDK to access the Maps account.

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

In this unit, you created an Azure Maps account and got the primary key. Next lets do a quick knowledge check on what you have learned so far.
