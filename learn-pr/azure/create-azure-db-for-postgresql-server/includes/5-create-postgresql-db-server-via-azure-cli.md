You decide to create an Azure Database for PostgreSQL server to store routes captured from runners' fitness devices. Based on historic captured data volumes, you know your server storage requirements should be set at 20 GB. To support your processing requirements, you need compute Gen 5 support with 1 vCore. You also know that you require a retention period of 15 days for data backups.

## Create an Azure PostgreSQL database server with the Azure CLI

Keep in mind you want to set your server storage size at 20 GB, compute Gen 5 support with 1 vCore and a retention period of 15 days for data backups.

1. Use the `az postgres server create` method to create a new database using the following syntax.

   ```azurecli
   az postgres server create \
      --name [unique_server_name] \
      --resource-group [resource_group_name] \
      --location [your_region] \
      --sku-name [sku_name] \
      --storage-size [size_in_mb] \
      --backup-retention [number_days] \
      --version [server_version] \
      --admin-user [admin_user_name] \
      --admin-password [server_admin_password]
   ```
   
   Where:
   
   | Parameter | Description |
   |---|---|
   | `--name` | Specify a unique server name using lowercase letters 'a'-'z', the numbers 0-9, and the hyphen. |
   | `--resource-group` | Specify your resource group; use <rgn>[sandbox resource group name]</rgn> for this exercise. |
   | `--location` | Specify a location from the following list: [!include[](../../../includes/azure-sandbox-regions-note.md)] |
   | `--admin-user` | Specify the admin username for your server. |
   | `--admin-password` | Specify the admin password for your server. |
   | `--sku-name` | For this exercise, specify `B_Gen5_1` for pricing tier B, generation 5 hardware, and 1 vCore. |
   | `--storage-size` | Specify the storage capacity of the server in megabytes. |
   | `--backup-retention` | Specify the number of days a backup is retained. |
   | `--version` | Specify the major version of the server. |

   For example:
   
   ```azurecli
   az postgres server create \
      --name wingtiptoys \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --location centralus \
      --sku-name B_Gen5_1 \
      --storage-size 20480 \
      --backup-retention 15 \
      --version 10 \
      --admin-user "azureuser" \
      --admin-password "P@ssw0rd"
   ```

2. The system will take a few minutes to process the information when executed. Go ahead and wait for the command to complete.

3. Once the command has completed, a JavaScript Object Notation (JSON) string that describes the server is returned. If there was a failure, an error message is displayed. You can use this error information to review and fix your command parameters and try again.

   The JSON object will look something like:

   ```json
   {
      "administratorLogin": "azureuser",
      "earliestRestoreDate": "2018-09-17T00:35:50.170000+00:00",
      "fullyQualifiedDomainName": "wingtiptoys.postgres.database.azure.com",
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rgn>[sandbox Resource Group]</rgn>/providers/Microsoft.DBforPostgreSQL/servers/wingtiptoys",
      "location": "centralus",
      "name": "wingtiptoys",
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
