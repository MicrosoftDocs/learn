In this exercise, we'll manage the SQL elastic pool and add an additional database to the pool for another location.

## Adjust elastic pool settings

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Search for and select the SQL elastic pool you created in the previous exercise. Search for and select **All resources** to browse for your SQL elastic pool.

1. In the left menu pane, under **Settings**, select **Configure**. The **Configure** pane appears.

1. Here, you can select either a *DTU-based* or *vCore-based* pricing model by selecting the service tier for the elastic pool. Under the **Service and compute tier** section, select **Basic** for **Service tier**, then select **Save** in the top menu bar. This will redeploy your elastic pool. Select **Go to resource** when the redeployment completes.

1. Select **Settings**, then select **Configure**. Within each tier, you can change the number of eDTUs for the pool. Change the eDTUs to **200** and observe the **Cost summary** on the right, which shows the estimated monthly cost of your elastic pool.

1. Select **Save** in the top menu bar. This will redeploy your elastic pool. Select **Go to resource** when the redeployment completes.

## Create a new database in the pool

1. In the left menu pane, select **Overview** for your SQL elastic pool.

1. In the top menu bar, select **Create database**. The **Create SQL Database** pane appears.

1. On the **Basics** tab, enter the following value for the setting.

    | Setting | Value |
    |---|---|
    | **Database details** |
    | Database name | Give your new database a meaningful name, such as *fitnesslondondb*. |

1. Select **Review + create**, then select **Create**.

1. Wait for deployment to complete, and then select **Go to resource**. Your new SQL database Getting started pane appears.
