The first thing we need to do is create an empty Azure Cosmos DB database and collection to work with. We want them to match the ones you created in the last module in this Learning Path: a database named **"Products"** and a collection named **"Clothing"**. Use the following instructions and the Azure Cloud Shell on the right side of the screen to recreate the database.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create an Azure Cosmos DB account + database with the Azure CLI

We'll start by creating an environment variable to hold the Azure Cosmos DB account name so you don't have to type the same value each time in the following commands.

> [!IMPORTANT]
> This name must be globally unique, between 3 and 31 characters, and can only contain lowercase letters, numbers, and the dash ('-') character. Try using a word prefix, dash and your initials, or some random numbers to the end to ensure it's unique.

1. Create a **NAME** environment variable in the Cloud Shell on the right with your selected name. Make sure to replace the `{account-name}` value below with your chosen name.

    ```azurecli
    export NAME="{account-name}"
    ```

### Create the Azure Cosmos DB account

We'll use the Azure CLI `cosmosdb create` command to create a new Azure Cosmos DB account. Recall from previous lessons that the command has three required parameters:

| Parameter | Description |
|-----------|-------------|
| `--name`  | The unique name for the resource. |
| `--kind`  | Kind of database, we'll use _GlobalDocumentDB_. |
| `--resource-group` | The resource group that owns this database. Normally you would create one in your Azure subscription, but in this case, we're using the Azure Sandbox and a Resource Group named **<rgn>[sandbox Resource Group]</rgn>** has been created for you. |

1. Paste the following command into the Cloud Shell on the right to create a new Azure Cosmos DB account with your specified name.

    ```azurecli
    az cosmosdb create --name $NAME \
        --kind GlobalDocumentDB \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    The command takes a few minutes to complete. If you get an error like:

    ```output
    Operation failed with status: 'BadRequest'. Details: DatabaseAccount name 'xyz-southcentralus' already exists.
    ActivityId: 12c59444-7760-11e9-a9c9-0a580af45c60, Microsoft.Azure.Documents.Common/2.2.0.0
    ```

    Then your **NAME** environment variable isn't unique - some other database in the selected region is using that ID. Change your **NAME** value by re-typing the `export` command from above with a new name.

    The cloud shell displays the settings as a JSON object for the new account once it's deployed - something like the following:

    ```json
    {
      "capabilities": [],
      "consistencyPolicy": {
        "defaultConsistencyLevel": "Session",
        "maxIntervalInSeconds": 5,
        "maxStalenessPrefix": 100
      },
      "databaseAccountOfferType": "Standard",
      "documentEndpoint": "https://xyz.documents.azure.com:443/",
      "enableAutomaticFailover": false,
      "enableMultipleWriteLocations": false,
      "failoverPolicies": [
        {
          "failoverPriority": 0,
          "id": "xyz-southcentralus",
          "locationName": "South Central US"
        }
      ],
      ...
    }
    ```

1. Create the `Products` database in the account using the `cosmosdb database create` command. It takes a `db-name` parameter that we'll set to **"Products"** since this database will hold the inventory data.

    ```azurecli
    az cosmosdb database create --name $NAME \
        --db-name "Products" \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    This command won't take long and should produce something like:

    ```json
    {
      "_colls": "colls/",
      "_etag": "\"00005d64-0000-0500-0000-5cdc936d0000\"",
      "_rid": "hxoKAA==",
      "_self": "dbs/hxoKAA==/",
      "_ts": 1557959533,
      "_users": "users/",
      "id": "Products"
    }
    ```

1. Finally, create the `Clothing` collection with the `cosmosdb collection create` command in the Cloud Shell.

    ```azurecli
    az cosmosdb collection create \
        --name $NAME \
        --db-name "Products" \
        --collection-name "Clothing" \
        --partition-key-path "/productId" \
        --throughput 1000 \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

Now that you have your Azure Cosmos DB account, database, and collection, let's go add some data!
