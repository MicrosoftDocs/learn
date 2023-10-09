This exercise provides an overview of setting up an Azure Cosmos DB account and database. 

In this exercise, you'll:

- Create an Azure Cosmos DB account.
- Create an Azure Cosmos DB database.

## Prerequisites

To perform this exercise, you need:

- An Azure subscription
- A Microsoft account or an Azure Active Directory (Azure AD) account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.

## Create an Azure Cosmos DB account

1. Start a web browser, refer to the [Azure portal](https://portal.azure.com/?azure-portal=true), and sign in to access the Azure subscription you're using for this module.
1. Use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **Azure Cosmos DB**, and in the list of results, select **Azure Cosmos DB**.
1. On the Azure Cosmos DB pane, select **+ Create**.
1. On the **Which API best suits your workload?** pane, select **Azure Cosmos DB for NoSQL** and select **Create**.
1. On the **Basics** tab, configure the following settings:

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you're using in this module. |
   | Resource Group | Create a new resource group named **cosmos-db-RG**. |
   | Account Name | Specify a unique account name. |
   | Location | Select the Azure region closest to the location of your lab environment. |
   | Capacity mode| Select **Provisioned throughput**. |
   | Apply Free Tier Discount | Select **Apply** if that option is available. |

   :::image type="content" source="../media/4-azure-cosmos-db-create-basics.png" alt-text="Screenshot of the Basics tab of the Create Azure Cosmos DB Account pane in the Azure portal.":::

1. Select the **Backup Policy** tab, and then specify the following settings:

   | Setting | Configuration |
   | --- | --- |
   | Backup interval | **24 Hour(s)** |
   | Backup retention | **2 Day(s)** |
   | Backup storage redundancy | **Locally-redundant backup storage** |

   > [!NOTE]
   > These choices don't represent the recommended settings, but are acceptable in a lab environment.

1. Select **Review + create**.
1. On the **Review + create** tab, select **Create**.

   > [!NOTE]
   > Wait for the Azure Cosmos DB provisioning to complete. This might take about three minutes.

1. When the Azure Cosmos DB deployment status indicates success, select **Go to resource**.

## Create an Azure Cosmos DB database

1. On the Azure Cosmos DB pane, in the vertical menu, select **Data Explorer**, select the **New Container** drop-down, and then select **New Database**.
1. On the **New Database** pane, specify the following settings, and then select **OK**.

   | Setting | Configuration |
   | --- | --- |
   | Database id | **iotdb** |
   | Database throughput (autoscale) | **Autoscale** |
   | Database Max RU/s | **4000** |

   :::image type="content" source="../media/4-azure-cosmosdb-create-new-database.png" alt-text="Screenshot of the New Database creation within the Data Explorer pane of an Azure Cosmos DB Account in the Azure portal.":::

1. In the **DATA** section, select the ellipsis icon next to the newly created database **iotdb** and select **New Container**.
1. On the **New Container** pane, specify the following settings, and then select **OK**:

   | Setting | Configuration |
   | --- | --- |
   | Database id | **Use existing - iotdb** |
   | Container id | **iotcollection** |
   | Partition Key | **/pk/timestamp/deviceid** |

1. Keep all the web browser windows open. You'll use them in the next exercise of this module.

## Results

Congratulations! You've completed the first exercise of this module. In this exercise, you created a Cosmos DB account and database.
