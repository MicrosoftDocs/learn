You've been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database. You'll learn how to configure authentication and authorization to the Azure SQL database.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Authorize access to Azure SQL Database with Azure Active Directory

1. On the Azure portal home page select **All resources**.

    :::image type="content" source="../media/azure-portal-select-resources.png" alt-text="Screenshot of the Azure portal home page, selecting All resources":::

1. Select the Azure SQL Database server **azuresql-lab-xxxxxx**, where **xxxxxx** is a random string, and select **Not Configured** next to **Active Directory Admin**.

    :::image type="content" source="../media/select-not-configured.png" alt-text="Screenshot selecting Not Configured.":::

1. On the next screen, select **Set admin**.

    :::image type="content" source="../media/active-directory-admin-not-set.png" alt-text="Screenshot selecting Set admin.":::

1. In the **Set admin** screen, search for the Azure username you logged into the Azure portal with.

    When you have found it, select the username, and then select the **Select** button. You will be returned to the above **Active Directory Admin** screen.

1. Select **Save** to complete the process. This will make your username the Azure Active Directory admin for the server as shown below.

    :::image type="content" source="../media/active-directory-admin-set.png" alt-text="Screenshot of the Active Directory admin page":::

1. On the left select **Overview**, then copy the **Server name**.

    :::image type="content" source="../media/copying-server-name.png" alt-text="Screenshot showing where to copy the server name from.":::

1. Open SQL Server Management Studio and select **Connect** > **Database Engine**. In the **Server name** paste the name of your server. Change the authentication type to **Azure Active Directory Universal with MFA**.

    :::image type="content" source="../media/connect-server-dialog.png" alt-text="Screenshot of the Connect to server dialog.":::

    In the **User name** select the Azure **Username** from the **Resources** tab.

1. Select **Connect**.

> [!NOTE]
> When you first try to sign in to an Azure SQL database your client IP address needs to be added to the firewall. SQL Server Management Studio can do this for you. Use the Azure Portal **password** from the **Resources** tab, then select **Sign in**, choose your Azure credentials and then select **OK**.
> :::image type="content" source="../media/new-firewall-rule.png" alt-text="Screenshot of adding the client IP address.":::

## Manage access to database objects

In this task you will manage access to the database and its objects. The first thing you will do is create two users in the AdventureWorks database.

> [!NOTE]
> If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Secure Environment\exercise_steps.sql** file.

1. Use the **Object Explorer** and expand **Databases**.
1. Right-click on **AdventureWorksLT**, and select **New Query**.

    :::image type="content" source="../media/new-query-menu.png" alt-text="Screenshot of the new query menu option.":::

1.  In the new query window and copy and paste the below T-SQL into it. Execute the query to create the two users.

    ```sql

    CREATE USER [DP300User1] WITH PASSWORD = 'Azur3Pa$$';
    GO

    CREATE USER [DP300User2] WITH PASSWORD = 'Azur3Pa$$';
    GO
    ```

    Note these users are created in the scope of the AdventureWorksLT database. Next you will create a custom role and add the users to it.

1. Execute the following T-SQL in the same query window as in step 1.

    ```sql
    CREATE ROLE [SalesReader];
    GO

    ALTER ROLE [SalesReader] ADD MEMBER [DP300User1];
    GO

    ALTER ROLE [SalesReader] ADD MEMBER [DP300User2];
    GO
    ```

    Next create a new stored procedure in the **SalesLT** schema.

1. Execute the below T-SQL in your query window.

    ```sql
    CREATE OR ALTER PROCEDURE SalesLT.DemoProc
    AS
    SELECT P.Name, Sum(SOD.LineTotal) as TotalSales ,SOH.OrderDate
    FROM SalesLT.Product P
    INNER JOIN SalesLT.SalesOrderDetail SOD on SOD.ProductID = P.ProductID
    INNER JOIN SalesLT.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID
    GROUP BY P.Name, SOH.OrderDate
    ORDER BY TotalSales DESC
    GO
    ```

    Next use the **EXECUTE AS USER** syntax to test out the security. This allows the database engine to execute a query in the context of your user.

1. Execute the following T-SQL.

    ```sql
    EXECUTE AS USER = 'DP300User1'
    EXECUTE SalesLT.DemoProc
    ```

    This will fail with the message:

    :::image type="content" source="../media/sql-statement-error.png" alt-text="Screenshot of the error message, The EXECUTE permission was denied on the object DemoProc.":::

1. Next grant permissions to the role to allow it to execute the store procedure. Execute the below T-SQL.

    ```sql
    REVERT;
    GRANT EXECUTE ON SCHEMA::SalesLT TO [SalesReader];
    GO
    ```

    The first command reverts the execution context back to the database owner.

1. Rerun the previous T-SQL.

    ```sql
    EXECUTE AS USER = 'DP300User1'
    EXECUTE SalesLT.DemoProc
    ```

    :::image type="content" source="../media/sql-statement-suceeds.png" alt-text="Screenshot showing the returned rows of data from the stored procedure.":::

In this exercise you've seen how you can use Azure Active Directory to grant Azure credentials  access to a SQL Server hosted in Azure. You've also used T-SQL statement to create new database users and granted them permissions to run stored procedures.

To finish this exercise select **Done** below.
