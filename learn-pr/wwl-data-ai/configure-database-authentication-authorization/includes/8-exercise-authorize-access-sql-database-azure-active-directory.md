You've been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database. You'll learn how to configure authentication and authorization to the Azure SQL database.

## Authorize Access to Azure SQL Database with Azure Active Directory

1. When the VM lab environment opens use the password on the **Resources** tab for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the **Password** field.

1. In the Azure Portal navigate to your Azure SQL Database server dp300-lab-xx and click on **Not Configured** next to **Active Directory Admin**.

    :::image type="content" source="../media/dp-3300-module-33-lab-20.png" alt-text="Active Directory Admin":::

1. On the next screen, click **Set admin**.

    :::image type="content" source="../media/dp-3300-module-33-lab-21.png" alt-text="Set admin":::

1. In the **Set admin** screen, search for your username.

    When you have found it, click on it to highlight the username, and then click **Select**. You will be returned to the above Active Directory Admin screen. Click save to complete the process. This will make your username the Azure Active Directory admin for the server as shown below.

    :::image type="content" source="../media/dp-3300-module-33-lab-22.png" alt-text="Active Directory admin":::

1. Open SQL Server Management Studio and click **Connect** > **Database Engine**. In the server name enter the name of your server. Change the authentication type to **Azure Active Directory Universal with MFA**.

:::image type="content" source="../media/dp-3300-module-33-lab-23.png" alt-text="Connect to server":::

You will be prompted to enter your Azure Active Directory password, and then logged in to your database.

## Manage access to database objects

In this task you will manage access to the database and its objects. The first thing you will do is create two users in the AdventureWorks database.

1. Open a new query window and copy and paste the below T-SQL into it. Execute the query to create the two users.

    ```sql
    CREATE USER [DP300User1] WITH PASSWORD = 'Azur3Pa$$'
    GO
    CREATE USER [DP300User2] WITH PASSWORD = 'Azur3Pa$$'
    GO
    ```

    You will note these users are created in the scope of the database. So if you were to try to login with one of these users, you would need to specify the AdventureWorks database in your connection string.

    Next you will create a custom role and add the users to it.

1. Execute the following T-SQL in the same query window as in step 1.

    ```sql
    CREATE ROLE [SalesReader]
    GO
    ALTER ROLE [SalesReader] ADD MEMBER [DP300User1]
    GO
    ALTER ROLE [SalesReader] ADD MEMBER [DP300User2]
    GO
    ```

    Next you will grant permissions to the role. In this case you are assigning SELECT and EXECUTE on the Sales schema.

1. Execute the below T-SQL to grant the permissions to the role.

    ```sql
    GRANT SELECT, EXECUTE ON SCHEMA::Sales TO [SalesReader]
    GO
    ```

    Next you will create a new stored procedure in the Sales schema. You will note this procedure access a table in the Product schema.

1. Execute the below T-SQL in your query window.

    ```sql
    CREATE OR ALTER PROCEDURE Sales.DemoProc
    AS
    SELECT P.Name, Sum(SOD.LineTotal) as TotalSales ,SOH.OrderDate
    FROM Production.Product P
    INNER JOIN Sales.SalesOrderDetail SOD on SOD.ProductID = P.ProductID
    INNER JOIN Sales.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID
    GROUP BY P.Name, SOH.OrderDate
    ORDER BY TotalSales DESC
    GO
    ```

    Next you will use the EXECUTE AS USER syntax to test out the security you just created. This allows the database engine to execute a query in the context of your user.

1. Execute the following query in your query window.

    ```sql
    EXECUTE AS USER = 'DP300User1'
    SELECT P.Name, Sum(SOD.LineTotal) as TotalSales ,SOH.OrderDate
    FROM Production.Product P
    INNER JOIN Sales.SalesOrderDetail SOD on SOD.ProductID = P.ProductID
    INNER JOIN Sales.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID
    GROUP BY P.Name, SOH.OrderDate
    ORDER BY TotalSales DESC
    ```

    This query will fail with an error message saying the SELECT permission was denied on the Production.Product table. The role that user DP300User1 is a member of has SELECT permission in the Sales schema, but not in the Production schema. However, if you execute the stored procedure in that same context, the query will complete.

1. Execute the following T-SQL.

    ```sql
    EXECUTE AS USER = 'DP300User1'
    EXECUTE Sales.DemoProc
    ```

This happens because stored procedures take advantage a feature called ownership chaining to provide data access to users who do not have direct permissions to access database objects. For all objects that have the same owner, the database engine only checks the EXECUTE permission on the procedure and not the underlying objects.
