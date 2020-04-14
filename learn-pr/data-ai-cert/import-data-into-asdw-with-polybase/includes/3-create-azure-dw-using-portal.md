First, let's create a blank database named **DemoDW** in Azure SQL Data Warehouse.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, read the instructions to understand how to create a blank data warehouse.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Create a resource** in the upper-left corner of the Azure portal.
1. Select **Databases** > **SQL Data Warehouse**.

    ![Creating a data warehouse](../media/3-create-azure-data-warehouse.png)

1. From the **SQL Data Warehouse** blade, create an Azure Synapse Analytics  with the following settings:

    - Subscription: the name of the subscription you are using in this lab.

    - In **Additional setting** tab, under data source, click **Sample**. Click on the **Basics** tab.

    - Resource group name: **mslearn-demodw**.

    - Database warehouse name: **sampleDataWH**.

    - Server: Create a new server by clicking **Create new** with the following settings and click on **OK**:
        - Server name: **sampledatawhxx**, where **xx** are your initials
        - Server admin login: **dwdbadmin**.
        - Password: **Pa55w.rd**
        - Confirm Password: **Pa55w.rd**
        - Location: choose a **location** near to you.
        - Select the checkbox to Allow Azure services to access server
        - click on **OK**

    - Server: **SQLServicexx**

    - Performance Level: Click **Select performance level** and select **Gen2 DW100C**

1. In the **SQL Data Warehouse*** blade, click **Review + create**.

    ![Database settings for new a data warehouse](../media/3-create-db.png)

1. In the **SQL Data Warehouse*** blade, click **Create**. Provisioning takes a few minutes.

Monitor the deployment process through the notifications icon. You successfully created a data warehouse after it deploys.
