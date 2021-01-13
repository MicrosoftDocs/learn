In this exercise, you'll create logins, users, and admins, and you'll grant Azure Active Directory (Azure AD) users access to the database, as you would for normal users in SQL Server.

1. Open SQL Server Management Studio (SSMS), and connect to your Azure SQL Database server, if you aren't already connected.

1. After you've configured and connected to your database, your next step might be to add other users and grant them access. As in SQL Server, you can add new logins and users.

    In SSMS, right-click your *database server* and then create a new query by running the following command:

    ```sql
    -- Create a new SQL login and give them a password
    CREATE LOGIN ApplicationUser WITH PASSWORD = 'YourStrongPassword1';
    ```

    > [!TIP]
    > For most queries in Azure SQL Database, you must right-click the *database* within your Azure SQL Database logical server. In SQL Server and your Azure SQL managed instance, you can query at the server level and use `USE DatabaseName` but, in your Azure SQL Database instance, you must query the database directly. This is because the `USE` statement is not supported. There are a few exceptions to querying your Azure SQL Database instance, and one is logins. You must connect to the *master* database to create and alter logins.

    Now you have a login at the server level. The next step is to create users in the AdventureWorks database and give them read/write access, if necessary. Right-click your AdventureWorks *database* and create a new query by running the following command:  

    ```sql
    -- Create a new SQL user from that login
    CREATE USER ApplicationUser FOR LOGIN ApplicationUser;

    -- Until you run the following two lines, ApplicationUser has no access to read or write data
    ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
    ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
    ```

    Users will be able to log in only to the AdventureWorks database, not the entire server.

    The best practice is to create non-admin accounts at the database level, unless the users need to be able to execute administrator tasks.  

1. In SQL Server, you might be familiar with the concept of a contained database user. This means that a user has access only to specific databases and doesn't have a login to the server. In your Azure SQL Database instance, you can create contained database users with SQL authentication or Azure AD authentication. You must be in the context of the user database that you want to create user access to (as opposed to being in master). In SSMS, right-click your *database*, and then create a new query by running the following command:

    ```sql
    CREATE USER MyDatabaseUser WITH PASSWORD = 'C0mpl3xPa55word!'
    ```

1. Select **Connect** > **Database Engine**, and then configure the main page so that you're connecting to your Azure SQL Database logical server. For **Login**, enter **MyDatabaseUser**, and for **Password**, enter **C0mpl3xPa55word!**.  

1. You must also set the database name, which you can do by going to **Options** > **Additional Connection Parameters**, where you can enter `Initial Catalog=AdventureWorks`. You must do this manually, because *MyDatabaseUser* doesn't have access to scan the server to select a database.  

1. Select **Connect**, and then confirm that you're able to access the database.  

1. As a clean-up step, right-click the connection from *MyDatabaseUser*, and then select **Disconnect**.  

## Grant access to other Azure AD users  

Azure AD authentication is a little different. From the documentation:

"*Azure Active Directory authentication requires that database users are created as contained. A contained database user maps to an identity in the Azure AD directory associated with the database and has no login in the master database. The Azure AD identity can either be for an individual user or a group*."  

Additionally, the Azure portal can be used only to create administrators, and Azure role-based access control roles don't propagate to Azure SQL Database logical servers, Azure SQL Database instances, or Azure SQL managed instances. You must grant additional server and database permissions by using Transact-SQL (T-SQL).  

If you want to create a user that can authenticate at the database level by using Azure AD authentication, you can use a new T-SQL command such as `CREATE USER [anna@contoso.com] FROM EXTERNAL PROVIDER`.  
