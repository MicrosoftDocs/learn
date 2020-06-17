Now that we've covered the major design principles, let's see how easy it is to create a data warehouse in Azure. We'll use some sample data for exploration, but you can start building your own data warehouse by using the principles that are shown in this exercise.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account or if you prefer not to do the exercise in your account, you can read through the instructions to understand the steps that are involved in creating a data warehouse in Azure SQL Data Warehouse.

Complete these steps to create a data warehouse that contains the *AdventureWorksDW* sample data:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the upper-left corner, select **+ Create a resource**.

1. Select **Databases** > **Azure Synapse Analytics (formerly SQL DW)** to start the creation process.
   
   ![Screenshots of creating an Azure data warehouse](../media/6-create-azure-data-warehouse.png)
   
1. From the **Azure Synapse Analytics** blade, create an Azure Synapse Analytics  with the following settings:

    - Subscription: the name of the subscription you are using in this lab

    - In **Additional setting** tab, under data source, click **Sample**. Click on the **Basics** tab

    - Resource group name: **mslearn-demodw**.

    - SQL pool name: **sampleDataWH**.

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

1. In the **Azure Synapse Analytics** blade, click **Review + create**.

    ![Screenshot of the new database server pane](../media/6-create-sql-db.png)

1. In the **Azure Synapse Analytics** blade, click **Create**.


1. Select **Create** to provision the database. Provisioning takes a few minutes.

You can monitor the deployment process through the notification ("bell") icon in the top bar - it will animate while the deployment is occurring. When the data warehouse is deployed, you have successfully created a SQL pool in Azure Synapse Analytics.
