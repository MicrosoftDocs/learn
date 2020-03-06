Azure Storage Explorer doesn't just access Azure Storage. You can also use it to access data in Cosmos DB and Azure Data Lake.

You've worked through the basics of connecting Storage Explorer to your Azure account. In the customer relationship management system, your developers use Cosmos DB for day-to-day operations, and an Azure Data Lake for big data storage. You want to understand if Storage Explorer can be used to connect to both of these databases.

## Using Storage Explorer to manage Cosmos DB

You can use Storage Explorer to connect to a Cosmos DB and do useful activities like creating and deleting databases, collections, documents, and graphs.

### Connect by using a connection string

There are a multiple ways to connect to Cosmos DB from Storage Explorer. The primary method is to use a connection string. A connection string contains all the information you need to find and connect to a particular Cosmos DB. The connection string has a specific composition, as shown here:

```plaintext
AccountEndpoint=https://<YOUR-COSMOS-DB-NAME>.documents.azure.com:443/;AccountKey=<PRIMARY-MASTER-KEY>;
```

In this template, replace `<YOUR-COSMOS-DB-NAME>` with the name of your Cosmos DB. The `<PRIMARY-MASTER-KEY>` is a unique key for the Cosmos DB.

There are two ways to obtain the connection string.

You could use the Azure portal to find the Cosmos DB that you want to connect to. You'd look for the **Keys** menu item and make a copy of the primary connection string.

The other way is to use the Azure Cloud CLI. This method gives you the primary master key for the Cosmos DB database. Use this command:

```azurecli
az cosmosdb keys list \
    --name COSMOS-DB-NAME \
    --resource-group myresourcegroup \
    --subscription "My Subscription" \
    --type keys
```

Using the connection string template, add the name of the Cosmos DB, along with the primary master key returned from the above command.

Now you have a connection string, you can use Storage Explorer to connect to your Cosmos DB. You'll be able to create or delete a database, create or delete collections, and create or delete documents.

1. Launch Storage Explorer.
1. Open the resource tree and select the branch **Local & Attached**.
1. Right-click Cosmos DB Accounts, and select **Connect to Cosmos DB...**.
1. When the Cosmos DB wizard launches, paste in the connection string.  You'll see the name of the Cosmos DB appear in the Account label field.
1. A summary of the connection information is displayed before the connection completes.

## Use Storage Explorer to manage Azure Data Lake

Azure Data Lake is a service used for storing and analyzing large data sets. It supports large data workloads, and is well suited to capture data of any type or size, and at any speed. Azure Data Lake supports all the expected enterprise-grade capabilities like security, scalability, reliability, manageability, and availability.

There are two types of Azure Data Lake: Gen1 and Gen 2. Both types are supported in Storage Explorer.

You can use Storage explorer to connect to Azure Data Lake accounts. You can use it to create, delete, and manage containers, as well as uploading, managing, and administration of blobs, just like storage accounts.

Let's go through creating Cosmos DB and Data Lake storage, and use Storage Explorer to connect to them.
