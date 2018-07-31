This section shows you everything you need to create an Azure Cosmos DB account. By the end of this section, you will be able to:

* Name your Azure Cosmos DB account
* Select the appropriate API for your account
* Create the account in the appropriate region
* Learn what settings are required at account creation, and what settings can be modified later

# Motivation

Creating an Azure Cosmos DB is the first step in creating an Azure Cosmos DB database. A single account can contain multiple databases and collections, and acts as the billing entity for the databases it contains.
<!-- TODO: What is Azure Cosmos DB? What is an Azure Cosmos DB account? When do you need more than one account? -->

# Create an Azure Cosmos DB account

1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Click **Create a resource** > **Databases** > **Azure Cosmos DB**.
3. In the **New account** page, enter the settings for the new Azure Cosmos DB account.
 
    Setting|Value|Description
    ---|---|---
    ID|*Enter a unique name*|Enter a unique name to identify this Azure Cosmos DB account. Because *documents.azure.com* is appended to the ID that you provide to create your URI, use a unique but identifiable ID.<br><br>The ID can contain only lowercase letters, numbers, and the hyphen (-) character, and it must contain 3 to 50 characters.
    API|SQL|The API determines the type of account to create. Azure Cosmos DB provides five APIs to suits the needs of your application: SQL (document database), Gremlin (graph database), MongoDB (document database), Azure Table, and Cassandra, each which currently require a separate account. <br><br>Select **SQL** because in this quickstart you are creating a document database that is queryable using SQL syntax and accessible with the SQL API.|
    Subscription|*Your subscription*|Select Azure subscription that you want to use for this Azure Cosmos DB account. 
    Resource Group|Create new<br><br>*Then enter the same unique name as provided above in ID*|Select **Create New**, then enter a new resource-group name for your account. For simplicity, you can use the same name as your ID. 
    Location|*Select the region closest to your users*|Select geographic location in which to host your Azure Cosmos DB account. Use the location that's closest to your users to give them the fastest access to the data.
    Enable geo-redundancy| Leave blank | This creates a replicated version of your database in a second (paired) region. Leave this blank.  
    Pin to dashboard | Select | Select this box so that your new database account is added to your portal dashboard for easy access.

    Then click **Create**.

4. The account creation takes a few minutes. Wait for the portal to display the **Congratulations! Your Azure Cosmos DB account was created** page.

# Summary

You should create your Azure Cosmos DB account in the location closest to your users, and in this case you should use the SQL API as we’ll be storing JSON documents and want to be able to query using the SQL query language. You can configure geo-replication, multi-master write, and virtual network during account creation, or you can easily add them later when you need them, which is what we’ll do.
