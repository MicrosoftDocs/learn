In this exercise, we'll manage the SQL elastic pool and add an additional databases to the pool for another location.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Adjust elastic pool settings

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Open the SQL elastic pool you created in the previous exercise. You can browse for existing resources by selecting **All resources**.

1. Click on **Configure** in the **Settings** section.

1. Here you can select either a *DTU-based* or *vCore-based* pricing model by selecting the service tier for the elastic pool; select **Basic** and click **Apply**.

1. Within each tier, you can change the number of eDTUs for the pool; change the eDTUs to **200** and click **Apply**.

1. Observe the **Cost summary** on the right, which shows the estimated monthly cost of your elastic pool.

## Adjust per database settings

1. Click on the **Per database settings* tab.

1. Change the max and min eDTUs and click **Apply**.

1. Observe the **Cost summary** on the right, which updates the estimated monthly cost of your elastic pool based on your new settings.

## Create a new database in the pool

1. Go to the  **Overview** section.

1. Click **+ Create database**.

1. Give your new database a meaningful name such as **FitnessLondonDB** and press **Create**.
