In this exercise, we'll manage the SQL elastic pool and add an additional databases to the pool for another location.

## Adjust elastic pool settings

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Search for and select the SQL elastic pool you created in the previous exercise. Search for and select **All resources** to browse for your SQL elastic pool.

1. Click on **Configure** in the **Settings** section.

1. Here you can select either a *DTU-based* or *vCore-based* pricing model by selecting the service tier for the elastic pool; select **Basic** and click **Save**.

1. Within each tier, you can change the number of eDTUs for the pool; change the eDTUs to **200** and click **Save**.

1. Observe the **Cost summary** on the right, which shows the estimated monthly cost of your elastic pool.

## Create a new database in the pool

1. Go to the  **Overview** section.

1. Click **+ Create database**.

1. Give your new database a meaningful name such as **FitnessLondonDB** and press **Review + Create**. 
