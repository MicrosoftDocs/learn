In this exercise, you'll see how to create logins, users, and admins, as well as how to grant Azure AD users access to the database like normal users in SQL Server.

1. Open SSMS and connect to your Azure SQL Database server, if you are not already.

1. Once you've configured and connected to your databases, your next step might be to add other users and grant access. As in SQL Server, you can add new logins and users.

    In SSMS, right-click on your database **server** and create a new query. Run the following.

    ```sql
    -- Create a new SQL login and give them a password
    CREATE LOGIN ApplicationUser WITH PASSWORD = 'YourStrongPassword1';
    ```

    > [!TIP]
    > For most queries in Azure SQL Database, you must right-click on the **database** within your Azure SQL Database logical server. In SQL Server and Azure SQL managed instance, you can query at the server level and use `USE DatabaseName`, but in Azure SQL Database, you must query the database directly, the `USE` statement is not supported. There are a few exceptions to querying Azure SQL Database, and one is logins. You must connect to the **master** database to create and alter logins.

    Now you have a login at the server-level. The next step is to create a user in the AdventureWorks database and give them read/write access (if needed). Right-click on your AdventureWorks **database** and create a new query. Run the following.  

    ```sql
    -- Create a new SQL user from that login
    CREATE USER ApplicationUser FOR LOGIN ApplicationUser;

    -- Until you run the following two lines, ApplicationUser has no access to read or write data
    ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
    ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
    ```

    This user will be able to log in to only the AdventureWorks database, not the entire server.

    The best practice is to create non-admin accounts at the database level, unless they need to be able to execute administrator tasks.  

1. In SQL Server, you may be familiar with the concept of a contained database user. This means that a user has access to only specific database(s), but does not have a login to the server. In Azure SQL Database, you can create contained database users with SQL authentication or Azure AD authentication. You must be in the context of the user database you want to create user access in (as opposed to being in master). In SSMS, right-click on your **database** and create a new query. Run the following.

    ```sql
    CREATE USER MyDatabaseUser WITH PASSWORD = 'C0mpl3xPa55word!'
    ```

1. Select **Connect** > **Database Engine** and configure the main page so you are connecting to your Azure SQL Database logical server with Login `MyDatabaseUser` and Password `C0mpl3xPa55word!`.  

1. You must also set the database name, which you can do by going to **Options** > **Additional Connection Parameters**, where you can enter `Initial Catalog=AdventureWorks`. You must do this manually, because *MyDatabaseUser* doesn't have access to scan the server to select a database.  

1. Select **Connect** and confirm you're able to access the database.  

1. As a clean-up step, right-click on the connection from *MyDatabaseUser* and select **Disconnect**.  

## Grant other users access (Azure AD)  

Azure AD authentication is a little different. From the documentation, "*Azure Active Directory authentication requires that database users are created as contained. A contained database user maps to an identity in the Azure AD directory associated with the database and has no login in the master database. The Azure AD identity can either be for an individual user or a group*."  

Additionally, the Azure portal can only be used to create administrators, and Azure RBAC roles don't propagate to Azure SQL Database logical servers, Azure SQL Databases, or Azure SQL Managed Instances. Additional server/database permissions must be granted using T-SQL.  

If you want to create a user that can authenticate at the database level using Azure AD authentication, you can use new T-SQL such as `CREATE USER [anna@contoso.com] FROM EXTERNAL PROVIDER`.  
