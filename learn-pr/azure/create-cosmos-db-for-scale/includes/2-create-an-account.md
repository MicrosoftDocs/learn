## Motivation

Your company has chosen Azure Cosmos DB to meet the demands of their expanding customer and product base. You have been tasked with creating the database.

The firststep is to create an Azure Cosmos DB account. 

## What is an Azure Cosmos DB account?

Azure Cosmos DB account is an Azure resource that acts as an organizational entity for your databases, and connects your usage to your Azure subscription for billing purposes.

Each Azure Cosmos DB account is associated with one of the several data models Azure Cosmos DB supports, and you can create as many accounts as you need. 

SQL API is the prefered data model if you are creating a new application. If you're working with graphs or tables, or migrating your MongoDB or Cassandra data to Azure, create additional accounts and select relevant data models.

When creating an account, choose an ID that is meaningful to you; it is how you identify your account. Further, create the account in the Azure region that's closest to your users to minimize latency between the datacenter and your users.

You can optionally set up virtual networks and geo-redundancy during account creation, but this can also be done later. In this module we will not enable those settings.

## Creating an Azure Cosmos DB account in the portal

<!--TODO: Update portal link with one that routes to free Learning acct-->
1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Click **Create a resource** > **Databases** > **Azure Cosmos DB**.
   
   ![The Azure portal Databases pane](../media/1-introduction/create-nosql-db-databases-json-tutorial-1.png)

3. In the **New account** page, enter the settings for the new Azure Cosmos DB account.
 
    Setting|Value|Description
    ---|---|---
    ID|*Enter a unique name*|Enter a unique name to identify this Azure Cosmos DB account. Because *documents.azure.com* is appended to the ID that you provide to create your URI, use a unique but identifiable ID.<br><br>The ID can contain only lowercase letters, numbers, and the hyphen (-) character, and it must contain 3 to 50 characters.
    API|SQL|The API determines the type of account to create. Azure Cosmos DB provides five APIs to suit the needs of your application: SQL (document database), Gremlin (graph database), MongoDB (document database), Azure Table, and Cassandra, each which currently require a separate account. <br><br>Select **SQL** because in this module you are creating a document database that is queryable using SQL syntax and accessible with the SQL API.|
    Subscription|*Your subscription*|Select Azure subscription that you want to use for this Azure Cosmos DB account. 
    Resource Group|Create new<br><br>*Then enter the same unique name as provided above in ID*|Select **Create New**, then enter a new resource-group name for your account. For simplicity, you can use the same name as your ID. 
    Location|*Select the region closest to your users*|Select geographic location in which to host your Azure Cosmos DB account. Use the location that's closest to your users to give them the fastest access to the data.
    Enable geo-redundancy| Leave blank | This creates a replicated version of your database in a second (paired) region. Leave this blank for now as the database can be replicated later. 
    Virtual networks|Disabled|Leave virtual networks disabled for now, they can be enabled later. 

4. Click **Create**.

    ![The new account page for Azure Cosmos DB](../media/1-introduction/azure-cosmos-db-create-new-account.png)

5. The account creation takes a few minutes; wait for the portal to display the notification that the deployment succeeded, and click the notification. 

    ![Notification alert](../media/1-introduction/azure-cosmos-db-notification.png)

6. In the notification window, click **Go to resource**.

    ![Go to resource](../media/1-introduction/azure-cosmos-db-go-to-resource.png)

7. The portal displays the **Congratulations! Your Azure Cosmos DB account was created** page.

    ![The Azure portal Notifications pane](../media/1-introduction/azure-cosmos-db-account-created.png)

## Summary

You have created an Azure Cosmos DB account which is the first step in creating an Azure Cosmos database. You selected appropriate settings for your data types and set the account location to minimize latency for your users.