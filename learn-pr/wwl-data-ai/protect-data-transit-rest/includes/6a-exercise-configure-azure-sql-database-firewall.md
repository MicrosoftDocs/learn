You've been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database. You will learn how to configure authentication and authorization to the Azure SQL database.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Configure a server-based firewall rule using the Azure portal

1. In the search bar at the top of the Azure portal, type **SQL servers**.

    :::image type="content" source="../media/dp-3300-module-33-lab-01.png" alt-text="Screenshot showing the SQL servers in the search results.":::

1. The SQL servers icon will appear. Select **SQL servers**, and then select the server name that starts with **azuresql-lab**.

    :::image type="content" source="../media/dp-3300-module-33-lab-02.png" alt-text="SQL Server Detail Page.":::

1. In the detail screen for your SQL server, move your mouse to right of the server name and select the **Copy to clipboard** button as shown below.

    :::image type="content" source="../media/dp-3300-module-33-lab-03.png" alt-text="dp300-lab-adw page.":::

1. Select **Show Firewall Setting** above the server name that you copied to clipboard. Select **+ Add client IP** as highlighted below and then select **Save**.

     :::image type="content" source="../media/dp-3300-module-33-lab-04.png" alt-text="Insert Text.":::

    These settings will allow you to connect to your Azure SQL Database server using SQL Server Management Studio or any other client tools. Make note of your **client IP address**, you will use it later in this exercise.

## Connect to a SQL Server and create a database in Azure

1. Open SQL Server Management Studio by navigating to **Microsoft SQL Server Tools 18** > **SQL Server Management Studio** from the Start menu. Paste in the name of your Azure SQL database server and sign in with these credentials:

    - Server admin login: **labadmin**
    - Password: **Azur3Pa$$**

    :::image type="content" source="../media/dp-3300-module-33-lab-05.png" alt-text="Connect to Server.":::

    Select **Connect**.

1. In Object Explorer expand the server node, and right click on **Databases**, then select **Import Data-tier Application**.

    :::image type="content" source="../media/dp-3300-module-33-lab-06.png" alt-text="Import Date-tier Application.":::

1. On the first screen in the **Import Data Tier Application** dialog select **Next**.

    :::image type="content" source="../media/dp-3300-module-33-lab-07.png" alt-text="Import Date-tier Application Introduction.":::

1. In the Import Settings screen, select Browse and navigate to **D:\Labfiles\Secure Environment** folder and select the **AdventureWorks.bacpac** file and select **Open**. Then in the Import Data-tier application screen, select **Next**.

    :::image type="content" source="../media/dp-3300-module-33-lab-08.png" alt-text="AdventureWorks bacpac file.":::

    :::image type="content" source="../media/dp-3300-module-33-lab-09.png" alt-text="Import Settings.":::

1. On the Database Settings screen, change **Edition of Azure SQL Database** to **General Purpose**. Change the **Service Objective** to **GP_Gen5_2** and then select **Next**.

    :::image type="content" source="../media/dp-3300-module-33-lab-10.png" alt-text="Database Settings.":::

1. On the **Summary** screen select **Finish**. When your import completes you will see the results below.

    :::image type="content" source="../media/dp-3300-module-33-lab-11.png" alt-text="Results.":::

## Create a firewall rule using SQL statements

> [!NOTE]
> If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Secure Environment\exercise_steps.sql** file.

1. In the **Object Explorer**, right-click on the AdventureWorks database you just imported.
1. Select **New Query**.

    :::image type="content" source="../media/dp-3300-module-33-lab-12.png" alt-text="Object Explorer.":::

1. Execute the following T-SQL query by pasting the text into your query window and selecting **Execute** or pressing F5.

    ```sql
    EXECUTE sp_set_database_firewall_rule @name = N'ContosoFirewallRule',
    @start_ip_address = 'n.n.n.n', @end_ip_address = 'n.n.n.n'
    ```

    Replace both occurrences of **n.n.n.n** with your client IP address copied earlier. You can return to the firewall settings in the Azure portal to copy your client IP address again if you need to.

1. Next you will create a user contained in the AdventureWorks database. Select **New Query** and execute the following T-SQL. Ensure that you are using the AdventureWorks database. If you see master in the highlighted box below, you can pull down and switch to AdventureWorks.

    :::image type="content" source="../media/dp-3300-module-33-lab-13.png" alt-text="Create User.":::

    Enter this command to create a user contained within the AdventureWorks database. You will sign in using the username and password in the next step.

    ```sql
    CREATE USER containeddemo WITH PASSWORD = 'P@ssw0rd!'
    ```

1. Select **Execute** to run this command.

1. Navigate to Object Explorer in SSMS and select **Connect** and then **Database Engine**.

    :::image type="content" source="../media/dp-3300-module-33-lab-14.png" alt-text="Object Explorer > Database Engine.":::

1. Attempt to connect with the credentials you created in step 4.

    - Login: **containeddemo**
    - Password: <strong>P@ssw0rd!</strong>

    :::image type="content" source="../media/dp-3300-module-33-lab-15.png" alt-text="Connect to Server Error.":::

    This error occurred because the connection attempted to sign in to the master database and not AdventureWorks where the user was created.

1. Change the connection context by selecting **OK** to exit the error message and then selecting **Options** in the Connect to Server dialog box as shown below.

    :::image type="content" source="../media/dp-3300-module-33-lab-16.png" alt-text="Select Options.":::

1. On the connection options tab, in the **Connect to database** field type **AdventureWorks** and then select **Connect**. Don't try to use the autopopulated dropdown list.

    :::image type="content" source="../media/dp-3300-module-33-lab-17.png" alt-text="Connection Properties.":::

    This connection bypasses the master database and logs you directly into AdventureWorks, which is the only database to which the newly created user has access.

    :::image type="content" source="../media/dp-3300-module-33-lab-18.png" alt-text="Screenshot showing connecting to the AdventureWorks database.":::

1. Expand the Databases for the **containeddemo** connection, then right-click on **AdventureWorks** and select **New Query**.

    :::image type="content" source="../media/dp-3300-module-33-lab-19.png" alt-text="Screenshot showing selecting a New Query.":::

1. In the new query window, type this command:

    ```sql
    SELECT SUSER_NAME();
    ```

    Then select **Execute**.

    :::image type="content" source="../media/dp-3300-module-33-lab-20.png" alt-text="Screenshot showing the results of running the query.":::

The results show the logged in user, containeddemo.

In this exercise you've seen how to add a client IP address to enable SSMS to connect to a database in Azure. You did this in the Azure portal, and you created a firewall rule using T-SQL.

To finish this exercise select **Done** below.
