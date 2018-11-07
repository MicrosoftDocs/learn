You decide to create an Azure Database for PostgreSQL server to store routes captured from runners' fitness devices. Based on historic captured data volumes, you know your server storage requirements should be set at 20 GB. To support your processing requirements, you need compute Gen 5 support with 1 vCore. You also know that you require a retention period of 15 days for data backups.

## Create an Azure PostgreSQL database server with the Azure CLI

Keep in mind you want to set your server storage size at 20 GB, compute Gen 5 support with 1 vCore and a retention period of 15 days for data backups.

1. Use the `az postgres server create` method to create a new database. There are several parameters that you'll specify:
    - `--resource-group <resource_group_name>`
    - `--name <new_server_name>`
    - `--location <location>`
    - `--admin-user <admin_user_name>`
    - `--admin-password <server_admin_password>`
    - `--sku-name <sku>`
    - `--storage-size <size>`
    - `--backup-retention <days>`
    - `--version <version_number>`

2. See if you can build the command and complete the parameters without looking at the solution below. Here are some tips.
    - Replace the `<values>` with your own values. 
    - Remember that the server name must be  made up of lowercase letters 'a'-'z', the numbers 0-9 and the hyphen.
    - Use <rgn>[sandbox resource group name]</rgn> as the resource group.
    - Use a location from the following list:  
        [!include[](../../../includes/azure-sandbox-regions-note.md)]

    ```azurecli
    az postgres server create \
        --name <unique_server_name> \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --location eastus \
        --sku-name B_Gen5_1 \
        --storage-size 20480 \
        --backup-retention 15 \
        --version 10 \
        --admin-user <admin_user_name> \
        --admin-password <server_admin_password>
    ```

    The system will take a few minutes to process the information when executed. Go ahead and wait for the command to complete.

    Once it's done, a JavaScript Object Notation (JSON) string that describes the server is returned. If there was a failure, an error message is displayed. You can use this error information to review and fix your command parameters and try again.

    The JSON object will look something like:

    ```json
    {
      "administratorLogin": "azureuser",
      "earliestRestoreDate": "2018-09-17T00:35:50.170000+00:00",
      "fullyQualifiedDomainName": "secondserver8.postgres.database.azure.com",
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rgn>[sandbox Resource Group]</rgn>/providers/Microsoft.DBforPostgreSQL/servers/secondserver8",
      "location": "eastus",
      "name": "secondserver8",
      "resourceGroup": "<rgn>[sandbox Resource Group]</rgn>",
      "sku": {
        "capacity": 1,
        "family": "Gen5",
        "name": "B_Gen5_1",
        "size": null,
        "tier": "Basic"
      },
      "sslEnforcement": "Enabled",
      "storageProfile": {
        "backupRetentionDays": 15,
        "geoRedundantBackup": "Disabled",
        "storageMb": 20480
      },
      "tags": null,
      "type": "Microsoft.DBforPostgreSQL/servers",
      "userVisibleState": "Ready",
      "version": "10"
    }
    ```

You've successfully created a PostgreSQL server using the Azure CLI. In the next unit, you'll see how to configure your server's security settings.
