Your company has chosen Azure Cosmos DB to meet the demands of its expanding customer and product base. You've been tasked with creating the database.

The first step is to create an Azure Cosmos DB account.

## What is an Azure Cosmos DB account?

An Azure Cosmos DB account is an Azure resource that acts as the organizational entity for your databases. The account connects your database usage to your Azure subscription for billing purposes.

Each Azure Cosmos DB account is associated with one of several data models Azure Cosmos DB supports. You can create as many accounts as you need.

SQL API is the preferred data model if you're creating a new application. If you're working with graphs or tables, or if you're migrating your MongoDB or Cassandra data to Azure, create additional accounts and select relevant data models.

When you create an account, choose an ID that is meaningful to you. The account ID is how you identify your account. Create the account in the Azure region that's closest to your users to minimize latency between the datacenter and your users.

You can optionally set up virtual networks and geo-redundancy during account creation, but you also can configure those options later. In this module, we won't enable those settings.

## Create an Azure Cosmos DB account in the portal

In this exercise, create an Azure Cosmos DB account in the Azure portal.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), sign in using the same account you used to activate the sandbox.

    > [!IMPORTANT]
    > Sign in to the Azure portal by using the link provided in this step. The link gives you access to a Concierge subscription to use to complete the exercises. The Concierge subscription is active in the Azure portal while you have an active sandbox.

1. In the Azure portal, in **Azure services**, select **Create a resource**:

   :::image type="content" source="../media/portal-create-resource.png" alt-text="Screenshot that shows Create a resource on the Azure portal home page.":::

1. In the resource menu, select **Databases**. In **Azure Cosmos DB**, select **Create**.

      :::image type="content" source="../media/create-a-resource-azure-cosmos-db.png" alt-text="Screenshot that shows how to search for and create a database in the Azure portal.":::

    > [!NOTE]
    > If you don't see **Azure Cosmos DB** in the list of databases, you can use the search box to find it.

1. In **Select API option**, in the **Core (SQL) - Recommended** box, select **Create**.

    :::image type="content" source="../media/create-database-core-sql.png" alt-text="Screenshot that shows the Core S Q L database option in the Azure portal.":::

1. In **Create Azure Cosmos DB Account - Core (SQL)**, select the **Basics** tab, and then enter the following values for each setting:

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | **Concierge Subscription** | Select the Concierge subscription. If you don't see the Concierge subscription listed, you have multiple tenants enabled on your subscription, and you need to change tenants. To do so, sign in again using the following portal link: [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). |
    | Resource Group | **<rgn>[sandbox resource group name]</rgn>** | Select the dropdown to select the existing resource group in the Concierge subscription. |
    | **Instance Details** |
    | Account Name | *Enter a unique name* | Enter a unique but identifiable account name. You'll use this name to complete the exercises later in this module. *documents.azure.com* is appended to the account name to create your URI.<br /><br />This name must be 3 to 31 characters long. Characters must be lowercase letters, numbers, and the hyphen (-) character. |
    | Location | *Select the region closest to you from the list at the bottom of this table* | Select the location where the database should be located. |
    | Capacity mode | **Provisioned throughput** | This value is the default, and there's no need to change it. |
    | Apply Free Tier Discount | **Do Not Apply** | The free tier isn't necessary for this module. |
    | Limit total account throughput | *Leave unchecked* | Not required for this exercise. |

    [!INCLUDE[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    :::image type="content" source="../media/azure-cosmos-db-create.png" alt-text="Screenshot that shows options to create an Azure Cosmos DB account in the Azure portal.":::

1. Select **Next: Global Distribution**.

1. On the **Global Distribution** tab, enter the following values for each setting:

    | Setting | Value | Description |
    |---|---|---|
    | **Global Distribution** |
    | Geo-Redundancy | *Disable* | This setting creates a replicated version of your database in a second (paired) region. For this exercise, be sure that **Disable** is selected. |
    | Multi-region Writes | *Disable* | This setting enables you to write to multiple regions at the same time. For this exercise, be sure that **Disable** is selected. |

    :::image type="content" source="../media/global-distribution-options.png" alt-text="Screenshot that shows selecting Disable for the options under Global Distribution.":::

1. Select **Review + create**.

1. When your settings are validated, select **Create** to create your Cosmos DB account.

1. This operation takes several minutes to finish. Wait for the deployment to finish before continuing with this exercise.

   You can also select the notification icon to view deployment progress:

   :::image type="content" source="../media/notification-azure-portal.png" alt-text="Screenshot that shows the notification icon in the Azure portal, with an alert.":::

1. When deployment is finished, select **Go to resource**.

   :::image type="content" source="../media/azure-cosmos-db-go-to-resource.png" alt-text="Screenshot that shows the Go to resource button when the Azure Cosmos DB resource is ready.":::

    The **Quick start** pane for your Azure Cosmos DB account appears.

   :::image type="content" source="../media/azure-cosmos-db-account-created.png" alt-text="Screenshot that shows the Quick start pane when the Azure Cosmos DB account is created.":::

You've created an Azure Cosmos DB account, the first step in creating an Azure Cosmos DB database. You selected appropriate settings for your data types, and you set the account location to minimize latency for your users.
