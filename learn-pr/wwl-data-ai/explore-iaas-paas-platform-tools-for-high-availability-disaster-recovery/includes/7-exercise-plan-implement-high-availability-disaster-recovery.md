As a DBA within AdventureWorks you need to know how to enable geo-replication for Azure SQL Database, ensure it is working, and know how to manually fail it over to another region using the portal.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Enable geo-replication

1. From the Home screen, select the menu, and select **SQL databases**.

    :::image type="content" source="../media/sql-databases.png" alt-text="Screenshot showing selecting SQL databases.":::

1. Click on the **AdventureWorks** Azure SQL Database.

    :::image type="content" source="../media/adventureworks.png" alt-text="Screenshot showing selecting Adventureworks.":::

1. On the blade for the database, in **Data management**, select **Replicas**.

    :::image type="content" source="../media/geo-replication.png" alt-text="Screenshot showing selecting Geo-Replication.":::

1. Select **Create replica**.

    :::image type="content" source="../media/geo-replication-page.png" alt-text="Screenshot showing selecting Geo-Replication page.":::

1. On the **Create SQL Database - Geo Replica** page and under **Server**, select **Create New**. On the new server pane, enter a unique server name, a valid admin login, and a secure password, and select the region you chose as the target region and then click **OK** to create the server.

1. Back in the Geo-Replica blade, click **Review + Create**, and then click **Create**. The secondary server and the database will now be created. To check the status, look under the bell icon at the top of the portal. If successful, it will progress from Deployment in progress to Deployment succeeded.

1. Now that the Azure SQL Database replica is created, you will perform a failover. Select the Replica page for the secondary server and note that the primary and secondary servers are indicated. Select the **...** menu for the secondary server and click **Forced Failover**.

    :::image type="content" source="../media/geo-replication-failover.png" alt-text="Screenshot showing a Failover operation.":::

1. When prompted, click **Yes**.

1. The status of the primary replica will switch to **Pending** and the secondary, **Failover**. The process will take a few minutes. When complete, the roles will switch with the secondary becoming the new primary and the old primary the secondary.

You have now seen how to enable geo-replication for Azure SQL Database, ensure it is working, and manually fail it over to another region using the portal.

To finish this exercise select **Done** below.
