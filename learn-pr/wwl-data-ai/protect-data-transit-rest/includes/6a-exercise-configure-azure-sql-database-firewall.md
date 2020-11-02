You've been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database. You will learn how to configure authentication and authorization to the Azure SQL database.

## Configure a server-based firewall rule using the Azure Portal

1. When the VM lab environment opens use the password on the **Resources** tab for the Student account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the **Password** field.

1. In the search bar at the top of the Azure portal, type **SQL servers**.

    :::image type="content" source="../media/dp-3300-module-33-lab-01.png" alt-text="Screenshot showing the SQL servers in the search results.":::

1. The SQL servers icon will appear. Select **SQL servers**, and then select the server name.

    :::image type="content" source="../media/dp-3300-module-33-lab-02.png" alt-text="SQL Server Detail Page.":::

1. In the detail screen for your SQL server, move your mouse to right of the server name and select the **Copy to clipboard** button as shown below.

    :::image type="content" source="../media/dp-3300-module-33-lab-03.png" alt-text="dp300-lab-adw page.":::

1. Select **Show Firewall Setting** above the server name that you copied to clipboard. Select **+ Add client IP** as highlighted below and then select **Save**.

     :::image type="content" source="../media/dp-3300-module-33-lab-04.png" alt-text="Insert Text.":::

    This will allow you to connect to your Azure SQL Database server using SQL Server Management Studio or any other client tools. Make note of your **client IP address**, you will use it later in this task.

1. Open SQL Server Management Studio on the lab VM by navigating to **Microsoft SQL Server Tools 18** > **SQL Server Management Studio** from the Start menu. Paste in the name of your Azure SQL database server and login with the credentials you created in Lab 2:

    - Server admin login: **labadmin**
    - Password: **Azur3Pa$$**

    :::image type="content" source="../media/dp-3300-module-33-lab-05.png" alt-text="Connect to Server.":::

    Select **Connect**.

1. In Object Explorer expand the server node, and right click on databases. Select **Import Data-tier Application**.

    :::image type="content" source="../media/dp-3300-module-33-lab-06.png" alt-text="Import Date-tier Application.":::

1. On the first screen in the **Import Data Tier Application** dialog select **Next**.

    :::image type="content" source="../media/dp-3300-module-33-lab-07.png" alt-text="Import Date-tier Application Introduction.":::

1. In the Import Settings screen, select Browse and navigate to D:\Labfiles\Secure Environment folder and select the **AdventureWorks.bacpac** file and select **Open**. Then in the Import Data-tier application screen select **Next**.

    :::image type="content" source="../media/dp-3300-module-33-lab-08.png" alt-text="AdventureWorks bacpac file.":::

    :::image type="content" source="../media/dp-3300-module-33-lab-09.png" alt-text="Import Settings.":::

1. On the Database Settings screen, change **Edition of Azure SQL Database** to **General Purpose**. Change the **Service Objective** to **GP_Gen5_2** and then select **Next**.

    :::image type="content" source="../media/dp-3300-module-33-lab-10.png" alt-text="Database Settings.":::

1. Select **Next** and then on the **Summary** screen select **Finish**. When your import completes you will see the results below .

    :::image type="content" source="../media/dp-3300-module-33-lab-11.png" alt-text="Results.":::

1. In **Object Explorer** right-click on AdventureWorks and then select **New Query**.

    :::image type="content" source="../media/dp-3300-module-33-lab-12.png" alt-text="Object Explorer.":::

1. Execute the following T-SQL query by pasting the text into your query window and selecting **Execute** or pressing F5.

    ```sql
    EXECUTE sp_set_database_firewall_rule @name = N'ContosoFirewallRule',
    @start_ip_address = 'n.n.n.n', @end_ip_address = 'n.n.n.n'
    ```

    Replace n.n.n.n with your client IP address from Step 8. Next you will create a contained user in the AdventureWorks database. Select **New Query** and execute the following T-SQL. Ensure that you are using the AdventureWorks database. If you see master in the highlighted box below, you can pull down and switch to AdventureWorks.

    :::image type="content" source="../media/dp-3300-module-33-lab-13.png" alt-text="Create User.":::

1. Select **Execute** to run this command. This command creates a contained user within the AdventureWorks database. You will login using the username and password in the next step.

    ```sql
    CREATE USER containeddemo WITH PASSWORD = 'P@ssw0rd!'
    ```

1. Navigate to Object Explorer in SSMS and select **Connect** and then **Database Engine**.

    :::image type="content" source="../media/dp-3300-module-33-lab-14.png" alt-text="Object Explorer > Database Engine.":::

1. Attempt to connect with the credentials you created in step 13. You will see the following error.

    :::image type="content" source="../media/dp-3300-module-33-lab-15.png" alt-text="Connect to Server Error.":::

    This error occurred because the connection attempted to login to the master database and not AdventureWorks where the user was created.

1. Change the connection context by selecting **OK** to exit the error message and then selecting **Options** in the Connect to Server dialog box as shown below.

    :::image type="content" source="../media/dp-3300-module-33-lab-16.png" alt-text="Select Options.":::

1. On the connection options tab, type the database name **AdventureWorks** and then select **Connect**.

    :::image type="content" source="../media/dp-3300-module-33-lab-17.png" alt-text="Connection Properties.":::

    This connection bypasses the master database and logs you directly into AdventureWorks, which is the only database to which the newly created user has access.

    :::image type="content" source="../media/dp-3300-module-33-lab-18.png" alt-text="dp300-lab-adw Database.":::
