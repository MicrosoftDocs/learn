Azure Storage Explorer doesn't just access Azure Storage. It can also access data in Azure Cosmos DB and Azure Data Lake.

You've worked through the basics of connecting Storage Explorer to your Azure account. In the CRM system, your developers use Azure Cosmos DB for day-to-day operations, and Data Lake for big data storage. You want to use Storage Explorer to connect to both of these databases.

> [!NOTE]
> The Azure Cosmos DB integration with Storage Explorer has been deprecated. Any existing functionality will not be removed for a minimum of one year from this release. You should use the [Azure Portal](https://portal.azure.com/?azure-portal=true), [Azure Portal desktop app](https://portal.azure.com/App/Download?azure-portal=true) or the standalone [Azure Cosmos explorer](https://cosmos.azure.com/?azure-portal=true) instead. The alternative options contain many new features that aren’t currently supported in Storage Explorer.

## Use Storage Explorer to manage Azure Cosmos DB

You can use Storage Explorer to connect to Azure Cosmos DB and do useful activities like creating and deleting databases, collections, documents, and graphs.

### Connect by using a connection string

There are multiple ways to connect to Azure Cosmos DB from Storage Explorer. The primary method is to use a connection string. A connection string contains all the information that you need to find and connect to a particular database in Azure Cosmos DB. The connection string has a specific composition, as shown here:

```plaintext
AccountEndpoint=https://<YOUR-COSMOS-DB-NAME>.documents.azure.com:443/;AccountKey=<PRIMARY-MASTER-KEY>;
```

In this template, replace `<YOUR-COSMOS-DB-NAME>` with the name of your database. `<PRIMARY-MASTER-KEY>` is a unique key for the database.

There are two ways to obtain the connection string.

You can use the Azure portal to find the database that you want to connect to. Look for the **Keys** menu item and make a copy of the primary connection string.

The other way is to use the Azure CLI. This method gives you the primary master key for the Cosmos DB database. Use this command:

```azurecli
az cosmosdb keys list \
    --name COSMOS-DB-NAME \
    --resource-group myresourcegroup \
    --subscription "My Subscription" \
    --type keys
```

By using the connection string template, add the name of the database, along with the primary master key returned from the preceding command.

Now that you have a connection string, you can use Storage Explorer to connect to your database. You can create or delete a database, create or delete collections, and create or delete documents.

1. Open Storage Explorer.
1. Open the resource tree and select the branch **Local & Attached**.
1. Right-click **Cosmos DB Accounts** and select **Connect to Cosmos DB**.
1. When the Azure Cosmos DB wizard opens, paste in the connection string. The name of the database appears in the **Account label** field.
1. A summary of the connection information is displayed before the connection finishes.

## Use Storage Explorer to manage Data Lake

Azure Data Lake is a service used for storing and analyzing large data sets. It supports large data workloads. It's well suited to capture data of any type or size, and at any speed. Data Lake supports all the expected enterprise-grade capabilities like security, scalability, reliability, manageability, and availability.

There are two types of Azure Data Lake: Gen1 and Gen2. Both types are supported in Storage Explorer.

You can use Storage Explorer to connect to Data Lake accounts. Just like storage accounts, you can use it to:

- Create, delete, and manage containers.
- Upload, manage, and administer blobs.

Let's go through creating Azure Cosmos DB and Data Lake storage, and then use Storage Explorer to connect to them.
