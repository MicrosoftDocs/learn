In this exercise, we will create a free Azure Cosmos DB, and enable Azure Synapse Link on the Azure Cosmos DB account.

> [!NOTE]
> Today, once youe enable Synapse Link on an Azure Cosmos DB account, the feature cannot be disabled. Enabling Synapse Link on an account has no billing implications until containers are created with the analytical store enabled.

## Open an Azure Cosmos DB

You need an Azure Cosmos DB to complete this exercise.

1. To create and use a free Cosmos DB for this exercise, select https://azure.microsoft.com/try/cosmosdb/.

1. In the SQL box, select **Create**. If prompted, to login, select the login icon.

1. On the sesulting screen, select **Open in the Azure portal**. The **Quick start** pane for your Azure Cosmos DB account appears.

## Enable Synapse Link for Cosmos DB SQL account

To enable Azure Synapse Link on a previously created Azure Cosmos DB SQL (Core) API:

1. If it isn't already open, sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and select your Azure Cosmos DB account.

1.	In the resource menu, select **Data Explorer**. The **Data Explorer** pane for your Azure Cosmos DB account appears. 
 
    :::image type="content" source="../media/enable-azure-synpase-link-sql-api.png" alt-text="Screenshot highlighting enable Azure Synapse Link for CosmosDB in the Azure portal" lightbox="../media/enable-azure-synpase-link-sql-api.png":::

1.	In the command bar, select **Enable Azure Synapse Link**. A confirmation dialog appears. 
 
     :::image type="content" source="../media/enable-azure-synpase-link-cosmos-db.png" alt-text="Screenshot of confirmation dialog to enable Azure Synapse Link" ::: 

1.	Select **Enable Azure Synapse Link** to permanently enable *Azure Synapse Link* service for this account.

    It may take a few minutes for the Azure Synapse Link to be enabled on the account.

1. To verify that the Azure Synapse Link feature is enabled, in the Azure Cosmos DB Account menu, under **Settings**, select **Features**.
 
    :::image type="content" source="../media/enable-azure-synpase-link-sql-api.png" alt-text="Screenshot highlighting Features and Status for enabling Azure Synapse Link":::

1.	Verify that the Azure Synapse Link feature shows with a Status of **On**. If status is still *Pending*, in the command bar, select **Refresh**, until this pane indicates that Azure Synapse Link has been enabled for your Azure Cosmos DB account.

## Enabling Synapse Link on Azure Cosmos DB API for MongoDB account

We will now use an alternative and equally effective manner for enabling the Synapse Link on your previously provisioned Azure Cosmos DB API for MongoDB account. You will need to create an Azure Cosmos DB API for MongoDB account.

1. If you are using the free Cosmos DB, use the instructions on [Try Azure Cosmos DB for free](https://portal.azure.com) to delete your existing  database and create a new one. 
 
1. On the **Try Azure Cosmos DB for free** select **Create** for Mongo DB.

    :::image type="content" source="../media/enable-azure-synpase-link-mongodb.png" alt-text="Screenshot showing the option to create a MongoDB":::

1.	When your database has been created, select **Open in the Azure portal** to open your **Azure Cosmos DB API for MongoDB account** in Azure portal.
 
    :::image type="content" source="../media/enable-azure-synpase-link-feature-mongodb.png" alt-text="Screenshot highlighting Features and Status for Azure Synapse Link":::

1. In the resource menut, select **Features** and then in the results, select **Azure Synapse Link**. A dialog box opens, prompting you to confirm your selection.
 
    :::image type="content" source="../media/enable-azure-synpase-link.png" alt-text="Screenshot showing the Enable dialog":::

1.	Select **Enable**. Imay take a few minutes for the feature to be enabled. You can verify that your Azure Cosmos DB API for MongoDB account has been enabled for with the Synapse Link feature in the same manner we did for the Azure Cosmos DB Core (SQL) API account previously. 
