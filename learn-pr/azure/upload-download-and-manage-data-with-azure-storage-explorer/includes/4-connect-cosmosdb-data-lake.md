Now you've worked through the basics of connecting Storage Explorer to your Azure account.  Your developers are using Cosmos DB for their day-to-day operations, and an Azure Data Lake for their big data analysis.  You want to understand if Storage Explorer can be used to connect to both of these databases.

Here, you'll learn about connecting to a Cosmos DB and creating and manipulating data stored there.  Finally, you'll see how you can use Storage Explorer to connect to an Azure Data Lake.

## Using Storage Explorer to manage Cosmos DB

Using Storage Explorer, you'll learn how to connect to a Cosmos DB and carry out some useful activities like creating and deleting databases, collections, documents, and graphs.

### Connect using  a connection string

There are a few ways of connecting to a Cosmos DB from Storage Explorer.  The primary method is to use a connection string.  A connection string contains all the information needed to find and connect to a specific Cosmos DB.  The connection string has a specific composition, as shown here.

```TXT
AccountEndpoint=https://<YOUR-COSMOS-DB-NAME>.documents.azure.com:443/;AccountKey=<PRIMARY-MASTER-KEY>;
```

In this template, you'd replace <YOUR-COSMOS-DB-NAME> with the name of your Cosmos DB you assigned when you created it.  The <PRIMARY-MASTER-KEY> is a unique key for the Cosmos DB.

There are two ways to obtain the connection string.  

#### Using Azure portal

The first is to use Azure portal to find the Cosmos DB with which you want to connect. Find the **Keys** menu item and make a copy of the Primary Connection String.

#### Using Azure Cloud CLI

The other way is to use the Azure Cloud CLI.  This method gives you the Primary Master Key for the cosmos database.  The command you'd use is:

```BASH
az cosmosdb keys list --name <COSMOS-DB-NAME> \
--resource-group <rgn>[Sandbox resource group]</rgn> --subscription "Concierge Subscription" \
--type keys
```

**NOTE**: replace the <COSMOS-DB-NAME> with the name of the Cosmos DB.

Using the connection string template, you'll add the name of the Cosmos DB along with the Primary Master Key returned from the above command.

Now that you have a connection string, you can use Storage Explorer to connect to your Cosmos DB.  

1. Once you've launched Storage Explorer
1. Open the resource tree and select the branch **Local & Attached**.
1. Right-click on the Cosmos DB Accounts, and select the **Connect to Cosmos DB...** option.
1. When the Cosmos DB wizard launches, paste in the connection string.  You'll see the name of the Cosmos DB appear in the Account label field.
1. A summary of the connection information is displayed before the connection is completed.

### Create a Cosmos DB database

Now that you've connected to your Azure Cosmos DB, you can use Storage Explorer to create any number of cosmos databases.  You can use Storage Explorer to manage their content, added collections, documents, and graphs.

1. To add a database, select the Cosmos DB you want to use. Then right-click on it, and select **Create Database**.
1. Give your database a name.  When created, the database appears beneath the Cosmos DB instance.

### Delete a Cosmos DB database

To remove or delete a database.

1. Right-click on the Cosmos DB database, and select the **Delete Database** option.
1. Once selected, you'll be prompted to confirm that you want to delete the database and its content.  When you select **Yes**, the database and all the content is removed.

### Create a collection in Cosmos DB database

Now that you've got a Cosmos DB database, its time to create a collection.  A database can have as many collections in it as you need.  Each collection name has to be unique.  You can create your collections using Storage Explorer.

1. Each collection needs a unique name.
1. Decide whether this collection has a finite amount of storage space or whether it will grow to match the size of the collection.  A fixed option gives you a maximum collection size of 10 GB.  
1. The last field is Throughput, and you'll accept the default of 400.
1. You'll see each collection added under the cosmos database.  

### Delete a collection from a Cosmos DB database

Deleting a collection removes all entities and data inside it.  So be sure you want to delete the data before you use this option.  To delete a collection:

1. Find the collection in your database.
1. Right-click on the collection and select **Delete Collection** from the context menu.
1. You'll see a warning and final check message asking to confirm you want to delete the collection.  
1. Select **Yes** to delete the collection.

### Create a document in Cosmos DB

The collection can contain any items.  You can use Storage Explorer to manage these, including creating new documents in your collection.

1. Select any collection you created earlier.
1. In the right-hand panel is the collection panel. From here, you can manage the data in your collection.
   ![Screenshot showing the document control panel](../media/5-cosmos-db-collection-create-doc.png)
1. To add a document, select **New Document**.  An empty document is displayed in the window below.
1. Replace the content of the document with this JSON:

   ```JSON
    {
        "id": "66",
        "title": "How to create a new document",
        "rtime": "30 minutes",
        "_etag": "WFFta1FHgQEtttIE1aaa"
    }
   ```

1. Select **Save** when you're ready.

   ![Screenshot showing the document control panel](../media/5-cosmos-db-collection-save-doc.png)
1. The document now appears in the ID panel.  

### Delete a document from a Cosmos DB database collection

To delete a document, select the ID of the document from the list.

Then select the **Delete** option.

![Screenshot showing the document control panel](../media/5-cosmos-db-collection-delete-doc.png)

### Create a Graph database

Cosmos DB supports the storage of graph data.  When creating a graph Cosmos DB, you'll need to enable Gremlin API support.  It's slightly different from creating a standard Cosmos DB.    You'll need to run this **az cosmosdb create**  in your Azure Cloud Shell.

```BASH
az cosmosdb create \
    -n "cosmosGraph" \
    -g <rgn>[Sandbox resource group]</rgn> \
    --capabilities EnableGremlin
```

Now that you've created a Cosmos DB, you'll need to create a Gremlin Graph database.  You'll use this command to do that.

 ```BASH
az cosmosdb gremlin database create \
    -a "cosmosGraph" \
    -g <rgn>[Sandbox resource group]</rgn> \
    -n 'cosmosGraph01'
 ```

You've now created a Cosmos DB Graph database.

### Delete a Graph database

Deleting a database removes all the data contained inside it.

To delete a graph database.

1. Launch Storage Explorer and connect to your Azure subscription.
1. Find the cosmosGraph01 database.
1. Right-click on it and select Delete Database.
1. You'll see a warning and final check message asking to confirm you want to delete the graph database.  
1. Select **Yes** to delete the collection.

## Use Storage Explorer to manage Azure Data Lake

Azure Data Lake is a repository for storing and analyzing large data sets. It supports large data workloads, and is well suited to capture data of any type or size, and at any speed.  It's been tuned to deliver results for the majority of analytics scenarios.   Azure Data Lake supports all the expected enterprise-grade capabilities like security, scalability, reliability, manageability, and availability.

![Image showing how Azure Data Lake data capture and analytics capabilities](../media/4-azure-data-lake-feature-capability.png)

There are two types of Azure Data Lake: Gen1 and Gen 2.  Both types are supported in the Azure portal and Storage Explorer.

### Connect to a Data Lake Storage account

Before you can create a Data Lake Storage account using the Azure Cloud Shell, you'll need to add a preview extension to the CLI.  Use the following command:

```BASH
az extension add --name storage-preview
```

Use of an Azure Data Lake Gen2 Storage account requires a general-purpose v2 Storage account.

1. Make sure your Azure subscription supports a Gen 2 Azure Data Lake.
1. Using an Azure Data Lake can be expensive, so it's a good idea to create a specific resource group for it.  Make sure that the resource group uses the **Storage V2 (general purpose v2)** option. Azure Data Lake resource groups can only exist in the following specific locations:

   - East US 2
   - West US 2
   - North Europe
   - Central US
   - West Europe
   - Australia East

   Lastly, be sure to make sure you enable **Hierarchical namespaces**.

An Azure Data Lake Storage account holds all your data objects like blobs, queues, tables, files, and disks. 

Now that you've created a data lake storage account, you can now connect to it using Storage Explorer.

1. Launch Storage Explorer
1. From the resource tree, expand your subscription. 
1. Select the V2 storage container you created earlier.
1. Right-click on the storage container and select **Connect to Data Lake Storage...** option.
1. Enter the URI for your Data Lake.

   !["Connect to Data Lake Store" dialog box, with the text box for entering the URI](../media/4-connect-data-lake-uri.png)

You've now connected to your data lake.

### Create a container
A container is no different from a folder in your file system. In the same way, you create a folder to hold specific information, you create containers to do the same.  Organizing your data into folders makes managing your Azure Data Lake easier.

To create a container.

Find the Data Lake you created.  It will have a suffix of **(ADLS Gen2)**.
Right-click on the Storage Account and select  **Create Blob container** from the context menu.
An empty container is displayed. Enter the name of the container and press **Enter** to create it.

![Screenshot showing the adding of a new Data Lake container](../media/4-creating-a-filesystem.png)

Bear in mind that all container names have the following constraints.  The full name must be in lowercase, it must start with or end with an alphanumeric, and it can use hyphens.  However, you can't have a double hyphen anywhere in the name.

You can have an unlimited number of containers, each displayed within the Data Lake branch.

### Upload and view blobs

All data stored in an Azure Data Lake is considered blob storage.  There are three supported types: block, append, and page.  The most common type of blob storage is a block.   If for instance, you're managing log files, you'll use an append blob.  For IaaS based VMs, you'd use page blobs.

To upload a file, select an Azure Data Lake container to display the tools ribbon and any content in the display view on the right.

![Screenshot showing the tools ribbon](../media/4-container-directory-menu-ribbon.png)

From this menu, you can upload and download whole directories or individual files.

When you select the upload option, all files are queued and processed in turn.  All results from uploads appear in the **Activities** window.

### Download data (blobs)

To download any file, you need to select the data folder or data file you want to download.  Now select the **Download** option.  Use the file save dialogue, choose the location to save the file.  When you select **Save**, the download starts.
