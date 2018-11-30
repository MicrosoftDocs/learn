The first thing we need to do is create an empty Azure Cosmos DB database and collection to work with. We want them to match the ones you created in the last module in this Learning Path: a database named **"Products"** and a collection named **"Clothing"**. Use the following instructions and the Azure Cloud Shell on the right side of the screen to recreate the database.

## Create an Azure Cosmos DB account + database with the Azure CLI

[!include[](../../../includes/azure-sandbox-activate.md)]

### Select a subscription

If you've been using Azure for a while, you might have multiple subscriptions available to you. This is often the case for developers who might have a subscription for Visual Studio, and another for corporate resources.

The Azure sandbox has already selected the Concierge Subscription for you in the Cloud Shell, and you can validate the subscription setting using these steps. Or, when you are working with your own subscription, you can use the following steps to switch subscriptions with the Azure CLI.

1. Start by listing the available subscriptions.

    ```azurecli
    az account list --output table
    ```

   If you're working with a Concierge Subscription, it should be the only one listed.

1. Next, if the default subscription isn't the one you want to use, you can change it with the `account set` command:

    ```azurecli
    az account set --subscription "<subscription name>"
    ```
    
1. Get the Resource Group that has been created for you by the sandbox. If you are using your own subscription, skip this step and just supply a unique name you want to use in the `RESOURCE_GROUP` environment variable below. Take note of the Resource Group name. This is where we will create our database.

    ```azurecli
    az group list --out table
    ```
### Setup environment variables

1. Set a few environment variables so you don't have to type the common values each time. Start by setting a name for the Azure Cosmos DB account, for example `export NAME="mycosmosdbaccount"`. The field can contain only lowercase letters, numbers and the '-' character, and must be between 3 and 31 characters.

    ```azurecli
    export NAME="<Azure Cosmos DB account name>"
    ```

1. Set the resource group to use the existing sandbox resource group.

    ```azurecli
    export RESOURCE_GROUP="<rgn>[sandbox resource group name]</rgn>"
    ```

1. Select the region closest to you, and set the environment variable, such as `export LOCATION="EastUS"`.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

    ```azurecli
    export LOCATION="<location>"
    ```

1. Set a variable for the database name. Name it "Products" so it matches the database we created in the last module.

    ```azurecli
    export DB_NAME="Products"
    ```

### Create a resource group in your subscription

When you are creating a Cosmos DB on your own subscription you will want to create a new resource group to hold all the related resources.

> [!IMPORTANT]
> If you are using the Azure sandbox provided by Microsoft Learn, then you do not need to execute this step. Instead, make sure the `RESOURCE_GROUP` variable above is set to **<rgn>[sandbox Resource Group Name</rgn>**.

In your own subscription you would use the following command to create the Resource Group. 

```azurecli
az group create --name <name> --location <location>
```

### Create the Azure Cosmos DB account

1. Create the Azure Cosmos DB account with the `cosmosdb create` command. The command uses the following parameters and can be run with no modifications if you set the environment variables as recommended.
    - `--name`: Unique name for the resource.
    - `--kind`: Kind of database, use _GlobalDocumentDB_.
    - `--resource-group`: The resource group. Use **<rgn>[sandbox Resource Group]</rgn>**. It should be assigned to the `RESOURCE_GROUP` variable.

    ```azurecli
    az cosmosdb create --name $NAME --kind GlobalDocumentDB --resource-group $RESOURCE_GROUP
    ```

    The command takes a few minutes to complete and the cloud shell displays the settings for the new account once it's deployed.

1. Create the `Products` database in the account.

    ```azurecli
    az cosmosdb database create --name $NAME --db-name $DB_NAME --resource-group $RESOURCE_GROUP
    ```

1. Finally, create the `Clothing` collection.

    ```azurecli
    az cosmosdb collection create --collection-name "Clothing" --partition-key-path "/productId" --throughput 1000 --name $NAME --db-name $DB_NAME --resource-group $RESOURCE_GROUP
    ```

Now that you have your Azure Cosmos DB account, database, and collection, let's go add some data!
