This exercise provides an overview of setting up an Azure Cosmos DB account and database. 

In this exercise, you'll:

- Create an Azure Cosmos DB account.
- Create an Azure Cosmos DB database.

## Prerequisites

To perform this exercise, you need:

- An Azure subscription
- A Microsoft account or an Azure Active Directory (Azure AD) account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.

## Create an Azure Cosmos DB account

1. Start a web browser, refer to the [Azure portal](https://portal.azure.com/?azure-portal=true), and sign in to access the Azure subscription you'll be using in this module.
1. Use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **Azure Cosmos DB**, and in the list of results, select **Azure Cosmos DB**.
1. On the **Azure Cosmos DB** blade, select **+ Create**.
1. On the **Which API best suits your workload?** blade, select **Core (SQL) - Recommended** and select **Create**.
1. On the **Basics** tab of the **Create Azure Cosmos DB Account - Core (SQL)** blade, configure the following settings, and then select **Next: Global Distribution**.

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you'll be using in this module. |
   | Resource Group | Create a new resource group named **cosmos-db-RG**. |
   | Account Name | Specify a unique account name. |
   | Location | Select the Azure region closest to the location of your lab environment. |
   | Capacity mode| Select **Provisioned throughput**. |
   | Apply Free Tier Discount | Select **Apply** if that option is available. |

   :::image type="content" source="../media/4-azure-cosmos-db-create-basics.png" alt-text="Screenshot of the Basics tab of the Create Azure Cosmos DB Account blade in the Azure portal.":::

1. On the **Global Distribution** tab of the **Create Azure Cosmos DB Account - Core (SQL)** blade, accept the default settings, and then select **Next: Networking**.
1. On the **Networking** tab of the **Create Azure Cosmos DB Account - Core (SQL)** blade, accept the default settings, and then select **Next: Backup Policy**.
1. On the **Backup Policy** tab of the **Create Azure Cosmos DB Account - Core (SQL)** blade, specify the following settings (leave others with their default values), and then select **Next: Encryption**:

   | Setting | Configuration |
   | --- | --- |
   | Backup interval | **24 Hour(s)** |
   | Backup retention | **2 Day(s)** |
   | Backup storage redundancy | **Locally-redundant backup storage** |
   
   > [!NOTE]
   > These choices don't represent the recommended settings, but are acceptable in a lab environment.

1. On the **Encryption** tab of the **Create Azure Cosmos DB Account - Core (SQL)** blade, accept the default settings, and then select **Review + create**.
1. On the **Review + create** tab of the **Create Azure Cosmos DB Account - Core (SQL)** blade, select **Create**.

   > [!NOTE]
   > Wait for the Azure Cosmos DB provisioning to complete. This might take about three minutes.

1. Within the browser window displaying the Azure portal with the Azure Function app provisioning status blade, select **Go to resource**.

## Create an Azure Cosmos DB database

1. On the Azure Cosmos DB blade, in the vertical menu, select **Data Explorer**, and then in the **Common Tasks** section, select **New Database**.
1. On the **New Database** blade, specify the following settings (leave others with their defaults), and then select **OK**.

   | Setting | Configuration |
   | --- | --- |
   | Database id | **iotdb** |
   | Database throughput (autoscale) | **Autoscale** |
   | Database Max RU/s | **4000** |

   :::image type="content" source="../media/4-azure-cosmos-db-new-database.png" alt-text="Screenshot of the New Database blade within the Data Explorer blade of an Azure Cosmos DB Account in the Azure portal.":::

1. On the Azure Cosmos DB blade, in the vertical menu, select **Data Explorer**, then in the **DATA** section, select the ellipsis icon next to the newly created database **iotdb** and select **New Container**.
1. On the **New Container** blade, specify the following settings (leave others with their default values) and select **OK**:

   | Setting | Configuration |
   | --- | --- |
   | Database id | **Use existing - iotdb** |
   | Container id | **iotcollection** |
   | Partition Key | **/pk/timestamp/deviceid** |

1. Keep all the web browser windows open. You'll use them in the next exercise of this module.

## Results

Congratulations! You've completed the first exercise of this module. In this exercise, you created a Cosmos DB account and database.
