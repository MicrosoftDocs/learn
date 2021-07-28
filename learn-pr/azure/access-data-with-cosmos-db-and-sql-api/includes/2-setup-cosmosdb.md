The first thing we need to do is create an empty Azure Cosmos DB database and container to work with. We want them to match the ones you created in the last module in this Learning Path: a database named **"Products"** and a container named **"Clothing"**. Use the following instructions and Azure Cloud Shell on the right side of the screen to recreate the database.

## Create an Azure Cosmos DB account + database with the Azure CLI

We'll start by creating an environment variable to hold the Azure Cosmos DB account name so you don't have to type the same value each time in the following commands. The database account name must be unique across all Azure Cosmos DB instances.

Run the following command to generate a random database account name, by using the Bash $RANDOM variable, and store it in an environment variable to use later.

```azurecli
export NAME=cosmos$RANDOM
```

### Create the Azure Cosmos DB account

We'll run the Azure CLI `cosmosdb create` command to create a new Azure Cosmos DB account. Recall from previous lessons that the command accepts the following parameters:

| Parameter | Required | Description |
|---|---|---|
| `--name` | Yes | The unique name for the resource. |
| `--kind` | No | Kind of database, we'll use _GlobalDocumentDB_. |
| `--resource-group` | Yes | The resource group that owns this database. Normally you would create one in your Azure subscription, but in this case, we're using the Azure Sandbox and a Resource Group named **<rgn>[sandbox Resource Group]</rgn>** has been created for you. |

1. Paste the following command into Cloud Shell on the right to create a new Azure Cosmos DB account with your specified name.

    ```azurecli
    az cosmosdb create \
        --name $NAME \
        --kind GlobalDocumentDB \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    The command takes a few minutes to complete.

    Cloud Shell displays the settings as a JSON object for the new account once it's deployed that looks something like the following code:

    ```json
    {
      "capabilities": [],
      "consistencyPolicy": {
        "defaultConsistencyLevel": "Session",
        "maxIntervalInSeconds": 5,
        "maxStalenessPrefix": 100
      },
      "databaseAccountOfferType": "Standard",
      "documentEndpoint": "https://example.documents.azure.com:443/",
      "enableAutomaticFailover": false,
      "enableMultipleWriteLocations": false,
      "failoverPolicies": [
        {
          "failoverPriority": 0,
          "id": "example-southcentralus",
          "locationName": "South Central US"
        }
      ],
      ...
    }
    ```

1. Create the `Products` database in the account by running the `cosmosdb database create` command. It takes a `db-name` parameter that we'll set to **"Products"** since this database will hold the inventory data.

    ```azurecli
    az cosmosdb sql database create \
        --account-name $NAME \
        --name "Products" \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    This command won't take long to run and should produce something like the following code:

    ```json
    {
      "_colls": "colls/",
      "_etag": "\"12345678-1234-1234-1234-123456789abc\"",
      "_rid": "abcABC==",
      "_self": "dbs/abcABC==/",
      "_ts": 1234567890,
      "_users": "users/",
      "id": "Products"
    }
    ```

1. Finally, create the `Clothing` container by running the `cosmosdb container create` command in Cloud Shell.

    ```azurecli
    az cosmosdb sql container create \
        --account-name $NAME \
        --database-name "Products" \
        --name "Clothing" \
        --partition-key-path "/productId" \
        --throughput 1000 \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

Now that you have your Azure Cosmos DB account, database, and container, let's go add some data!
