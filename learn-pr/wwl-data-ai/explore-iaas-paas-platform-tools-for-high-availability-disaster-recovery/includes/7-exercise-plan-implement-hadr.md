As a DBA within AdventureWorks you need to know how to enable geo-replication for Azure SQL Database, ensure it is working, and know how to manually fail it over to another region using the portal.

## Enable geo-replication

1. When the VM lab environment opens select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the password field.

1. From the Home screen, select the menu, and select **SQL databases**.

    :::image type="content" source="../media/sql-databases.png" alt-text="SQL databases":::

1. Click on the **adventureworks** Azure SQL Database.

    :::image type="content" source="../media/adventureworks.png" alt-text="Adventureworks":::

1. On the blade for the database, select **Geo-Replication**.

    :::image type="content" source="../media/geo-replication.png" alt-text="Geo-Replication":::

    > [!NOTE]
    > The region where the database is currently configured is shown in a blue hexagon with a white checkmark. You will see that geo-replication is not configured.
    > :::image type="content" source="../media/primary-region.png" alt-text="Region not configured":::

1. At the bottom of the blade, select one of the **Target regions**. All available regions will have a hexagon with a green outline.

1. In this example, **West US 2** was selected as can be seen on the **Create secondary**
blade.

    :::image type="content" source="../media/create-secondary.png" alt-text="Create secondary":::

1. Select **Target server**.

1. On the **New server** blade, enter a **Server name** of **azuresqlgeo[uniqueguid]**, a **Server admin login** of **azuresqladmin**. Enter and confirm a secure **Password**. Click **Select** when done.

1. Click **OK** on the **Create secondary** blade. The secondary server and the database will now be created. To check the status, select the **Notifications** icon at the top of the portal. If successful, it will progress from **Deployment in progress** to **Deployment succeeded**.

    > [!NOTE]
    > You will also notice that in the status column of the table, the status will go from Initializing, to a seeding percentage complete, to Readable when the replication in synchronized.
    > :::image type="content" source="../media/replica-status.png" alt-text="Replica status":::

1. Now that the Azure SQL Database is configured with geo-replication, you will perform a failover. Select your secondary server, and, on the blade, click **Forced Failover**.
1. When prompted, click **Yes**.
1. The status of the primary replica will switch to **Pending** and the secondary, **Failover**. The process will take a few minutes. When complete, the roles will switch with the secondary becoming the new primary and the old primary the secondary.
