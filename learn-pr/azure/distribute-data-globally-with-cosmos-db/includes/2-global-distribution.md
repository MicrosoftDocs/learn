Providing your customers the fastest access to the products on your online clothing site is paramount to your customers, and your businesses success. By decreasing the distance data has to travel to your users, you can deliver more content faster. If your data is stored in Azure Cosmos DB, replicating your site's data to multiple regions around the world is a point and click operation.

In this unit, you'll learn the benefits of global distribution and a natively multi-mastered database service, and then replicate your account into three other regions.

## Global distribution basics

Global distribution enables you to replicate data from one region into multiple Azure regions. You can add or remove regions in which your database is replicated at any time. Azure Cosmos DB ensures that when you add another region, your data is available for operations within 30 minutes, assuming your data is 100 TBs or less.

There are two common scenarios for replicating data in two or more regions:

- Delivering low-latency data access to end users no matter where they're located around the globe
- Adding regional resiliency for Business Continuity and Disaster Recovery (BCDR)

To deliver low-latency access to customers, we recommend you replicate the data to regions closest to where your users are. For your online clothing company, you have customers in Los Angeles, New York, and Tokyo. Look at the [Azure regions](https://azure.microsoft.com/global-infrastructure/regions/) page, and determine the closest regions to those sets of customers. Those regions are the locations you'll replicate users to.

To provide a BCDR solution, it's recommended to add regions based on the region pairs described in the [Business continuity and disaster recovery (BCDR): Azure Paired Regions](/azure/best-practices-availability-paired-regions) article.

When a database is replicated, the throughput and storage are replicated equally. For example, your original database has 10 GB of storage and throughput of 1,000 RU/s. If you replicated that to three other regions, each region would have 10 GB of data and 1,000 RU/s of throughput. Because the storage and throughput is replicated in each region, the cost of replicating to a region is the same as the original region. So, replicating to three other regions would cost about four times the original non-replicated database.

## Creating an Azure Cosmos DB account in the portal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

    > [!IMPORTANT]
    > Sign in to the Azure portal and the sandbox with the same account.
    >
    > Sign in to the Azure portal using the link above to ensure you're connected to the sandbox, which provides access to a Concierge Subscription.

1. Select **Create a resource**.

   :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-create-resource-2022.png" alt-text="Screenshot that shows selecting the Create a resource icon in the Azure portal.":::

1. Select **Databases**, and then **Create** under **Azure Cosmos DB**.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-create-cosmos-db-resource.png" alt-text="Screenshot that shows the Create a resource page with the Databases category selected and Create selected under Azure Cosmos DB.":::

1. On the **Select API option** page, select the **Create** button for **Core (SQL) - Recommended**.

    The API determines the type of account to create. Azure Cosmos DB provides five APIs to suit the needs of your application: Core (SQL), Gremlin (graph database), Azure Cosmos DB for MongoDB (document database), Azure Table, and Cassandra, each of which currently requires a separate account.

    You're selecting Core (SQL) because in this module you're creating a document database that is queryable using SQL syntax and accessible with the SQL API.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-select-api.png" alt-text="Screenshot that shows the Core (SQL) API selected from the Select API option page.":::

1. On the **Create Azure Cosmos DB Account - Core (SQL)** page **Basics** tab, enter the settings for the new Azure Cosmos DB account, including the location.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-create-account-basics.png" alt-text="Screenshot that shows the settings entered on the Create Azure Cosmos DB Account Basics tab.":::

    <!-- Resource selection -->  
    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    > [!NOTE]
    > Some regions might not be available due to high demand. In these cases, select your next closest region.

    Setting|Value|Description
    ---|---|---
    Subscription|*Concierge Subscription*|Select your Concierge Subscription. If you don't see the Concierge Subscription listed, you have multiple tenants enabled on your subscription, and you need to change tenants. To do so, login again using the following portal link: [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
    Resource Group|Use existing<br><br><rgn>[sandbox resource group name]</rgn>|Select the drop-down for **Resource Group**, and then enter <rgn>[sandbox resource group name]</rgn> in the **Select existing** text box.
    Account Name|*Enter a unique name*|Enter a unique name to identify this Azure Cosmos DB account. Because *documents.azure.com* is appended to the ID that you provide to create your URI, use a unique but identifiable ID.<br><br>The ID can contain only lowercase letters, numbers, and the hyphen (-) character, and it must contain 3 to 31 characters.
    Location|*Select the region closest to you*|Select the region closest to you from the list of regions above.

1. Select **Next: Global Distribution**. On the Global Distribution tab, enter the following settings, and then select **Review + Create**.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-create-account-global-distribution.png" alt-text="Screenshot that shows the settings selected on the Create Azure Cosmos DB Account Global Distribution tab.":::

    Setting|Value|Description
    ---|---|---
    Geo-Redundancy| Disable | This setting creates a replicated version of your database in a second (paired) region. Leave this setting disabled for now, as you'll replicate the database later.
    Multi-region Writes | Enable | This setting enables you to write to multiple regions at the same time. This setting can only be configured during account creation.

1. After the settings validate, select **Create** to create the account.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-review-account-creation.png" alt-text="Screenshot that shows the Review + create tab with the Create button selected.":::

1. The account creation takes a few minutes. Wait for the portal to display that the deployment succeeded, and then select **Go to resource**.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-deployment-success.png" alt-text="Screenshot that shows a successful Azure Cosmos DB deployment message with the Go to resource button selected.":::

1. The portal displays the **Congratulations! Your Azure Cosmos DB account was created** page.

    :::image type="content" source="../media/2-global-distribution/2-azure-cosmos-db-account-created.png" alt-text="Screenshot that shows the Quick start page with an account created message.":::

## Replicate data in multiple regions

Let's now replicate your database closest to your global users in Los Angeles, New York, and Tokyo.

1. On the left-hand menu, click **Replicate data globally** from the menu.

1. In the **Replicate data globally** page, select the West Central US, East US, and Japan East regions, and then click **Save**.

    If you don't see the map in the Azure portal, minimize the menus of the left side of the screen to display it.

    The page will display an **Updating** message while the data is written to the new regions. Data in the new regions will be available within 30 minutes.

    :::image type="content" source="../media/2-global-distribution/2-global-replication-new-region.gif" alt-text="Screenshot GIF that shows the regions being selected for data replication.":::

## Summary

In this unit, you replicated your database to the regions of the world in which your users are most concentrated, providing them lower-latency access to the data on your site.
