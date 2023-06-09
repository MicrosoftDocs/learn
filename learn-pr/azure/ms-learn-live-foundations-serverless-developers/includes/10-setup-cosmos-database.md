Our API reads data from a CosmosDB instance. You must create a database instance to complete all the exercises.

## Objectives

- Set up a CosmosDB instance on Azure for use with the client app.
- Populate the database with sample data.
- Configure the Functions API project to connect to the database.

> [!NOTE]
> In this series, we don't cover CosmosDB in depth, and only use it as our data store. If you want to learn more about CosmosDB, see the links at the end of this document.

## Create a Cosmos DB instance

The following scripts and instructions create a CosmosDB instance with the following parameters:

- Name: `dbbacktoschool`
- Database name: `maindb`
- Container name: `data`
- Partition key: `/itemType`

The test data is using this format:

```json
{
    "id": "p001",
    "itemType": "product",
    "name": "Pre-sharpened Wood Cased Pencils",
    "description": "Rounded hexagonal shape with satin-smooth finish for a secure, comfortable grip",
    "price": 499,
    "category": "Pencils",
    "stockUnits": 500,
    "thumbnailImage": "p001.png"
  }
```

### If you're using your Azure subscription

1. Open [Azure portal](https://portal.azure.com) in your browser and select your subscription.

1. Open Azure Cloud Shell (the button is located at the top, next to the notifications bell and looks like this: >_). Select it to use a *Bash* shell.

### If you're using the Learn Live Sandbox

> [!IMPORTANT]
> Activate the Azure Sandbox to execute the lab instructions in a free subscription and locate Azure Cloud Shell on the right-hand side.

### Use a Bash script to create the database

1. Copy the following command, and paste it into Cloud Shell:

    ```azurecli
    wget -O create-cosmosdb.sh https://raw.githubusercontent.com/MicrosoftDocs/mslearn-live-azure-fundamentals/master/scripts/create-cosmosdb.sh && 
    chmod +x ./create-cosmosdb.sh &&
    ./create-cosmosdb.sh
    ```

     It's probably a good idea to go and grab a cup of coffee or tea - creating a CosmosDB instance can take a while. It's not uncommon to wait for about ten minutes. Don't cancel the script execution.

    When finished, the script outputs three essential bits of data:

    - Name of the database
    - (Secret!) master key to get read and write access
    - A connection string you can use to connect to the database. You will add this to the configuration of the Azure functions project.

1. Copy the name, the master key, and the connection string into a temporary text document. You'll need them later.

### Populate the database with test data

Right now, the database you created is empty. To get some sample data, we've prepared another script.

1. Run the following command and make sure to replace the placeholders with the database name and the master key you previously copied.

    ```azurecli
    databaseName="[DB NAME GOES HERE]"
    masterKey="[MASTER KEY GOES HERE]"
    ```

2. Now you're ready to create test data by running this script.

    ```azurecli
    wget -O populate-cosmosdb.sh https://raw.githubusercontent.com/MicrosoftDocs/mslearn-live-azure-fundamentals/master/scripts/populate-cosmosdb.sh && 
    chmod +x ./populate-cosmosdb.sh &&
    ./populate-cosmosdb.sh $databaseName $masterKey
    ```

## Configure the Azure functions API project

Configuration data for locally running projects is stored in a file called `local.settings.json`. You find it in the root folder of the functions app. This file is **never** under source control: it may contain sensitive data, like the connection string you should have in the clipboard.

1. Clone our GitHub repository from [https://aka.ms/learn-live-foundations-serverless-dev-repo](https://aka.ms/learn-live-foundations-serverless-dev-repo).

1. Add a new file named `local.settings.json` to the root folder of the functions project you find in the folder `api-functions`.

1. Copy the configuration settings that follow into the new file.

1. Replace the value of the setting `CONNECTION_STRING` with the connection string returned by the script.

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "",
        "FUNCTIONS_WORKER_RUNTIME": "node",
        "CONNECTION_STRING": "[PASTE CONNECTION STRING HERE]",
        "COSMOS_DB_NAME": "maindb",
        "COSMOS_DB_CONTAINER": "data"
      }
    }
    ```

## Resources

- Learn modules for [CosmosDB](/training/browse/?products=azure-cosmos-db)
