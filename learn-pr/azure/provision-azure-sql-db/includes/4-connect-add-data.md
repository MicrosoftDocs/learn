Before you connect the database to your app, you want to verify that you can connect to it, add a basic table, and work with sample data.

We maintain the infrastructure, software updates, and patches for your Azure SQL database. You can treat your Azure SQL database like you would any other SQL Server installation. For example, you can use Visual Studio, SQL Server Management Studio, Azure Data Studio, or other tools to manage your Azure SQL database.

How you access your database and connect it to your app is up to you. To get some experience working with your database, let's connect to it directly from the portal, create a table, and run a few basic CRUD operations. Here, you learn:

- What Cloud Shell is and how to access it from the portal.
- How to access information about your database from the Azure CLI, including connection strings.
- How to connect to your database using `sqlcmd`.
- How to initialize your database with a basic table and some sample data.

## What is Azure Cloud Shell?

Azure Cloud Shell is a browser-based shell experience to manage and develop Azure resources. Think of Cloud Shell as an interactive console that runs in the cloud.

Behind the scenes, Cloud Shell runs on Linux. But, depending on whether you prefer a Linux or Windows environment, you have two experiences from which to choose: Bash and PowerShell.

Cloud Shell is accessible from anywhere. Besides the portal, you can also access Cloud Shell from [shell.azure.com](https://shell.azure.com/), the Azure mobile app, or from Visual Studio Code. 

Cloud Shell includes popular tools and text editors. Here's a brief look at the `az`, `jq`, and `sqlcmd` utilities, which are three tools that you use in this exercise.

- `az` is also known as the Azure CLI. It's the command-line interface for working with Azure resources. You use this interface to get information about your database, including the connection string.
- `jq` is a command-line JSON parser. You pipe output from `az` commands to this tool to extract important fields from JSON output.
- `sqlcmd` enables you to execute statements on SQL Server. You use `sqlcmd` to create an interactive session with your Azure SQL database.

## Get information about your Azure SQL database

Before you connect to your database, it's a good idea to verify that it exists and is online.

Here, you use the `az` utility to list your databases and show some information about the **Logistics** database, including its maximum size and status.

1. Visit [shell.azure.com](https://shell.azure.com/), or from the Azure portal, select the **Cloud shell** button from the global controls of the Azure portal window.

1. If given the option, choose **Bash** for this learning exercise.

1. On the **Getting started** popup, select **No storage account required**. Select your subscription from the **Subscription** drop down. Select **Apply**. The new Cloud Shell terminal loads.

1. The `az` commands you run require the name of your resource group and the name of your Azure SQL logical server. To save keystrokes, run this `azure configure` command to specify them as default values.

    Replace `[server-name]` with the name of the Azure SQL logical server you created and `[resource-group]` with the resource group you used for your server.

    > [!TIP]
    > To paste into a Cloud Shell, use `Ctrl+Shift+V` instead of `Ctrl+V`. Use `Ctrl+C` to clear the current command from the terminal.

    ```azurecli
    az configure --defaults group=[resource-group] sql-server=[server-name]
    ```

    > [!NOTE]
    > Depending on the pane you are on in the Azure portal, your SQL server name is displayed as a Fully qualified domain name (FQDN) (for example, `servername.database.windows.net`) or standalone (`servername`). For this command, you only need the logical name *without* the `.database.windows.net` suffix.

1. Run the following `az sql db list` command to list all databases on your Azure SQL logical server:

    ```azurecli
    az sql db list
    ```

    You get a large block of JSON as output.

1. Because we want to get only the database names, run the command a second time. But this time, pipe the output to `jq` to display only the name fields.

     ```azurecli
    az sql db list | jq '[.[] | {name: .name}]'
    ```

    You should get this output:

    ```json
    [
      {
        "name": "Logistics"
      },
      {
        "name": "master"
      }
    ]
    ```

    `Logistics` is your user database. Like in SQL Server, the `master` system database includes server metadata, such as logins and system configuration settings. 

1. Run the following `az sql db show` command to get details about the `Logistics` database:

    ```azurecli
    az sql db show --name Logistics
    ```

    As before, you see a large block of JSON as output.

1. Run the command a second time. This time pipe the output to `jq` to limit output to only the name, maximum size, and status of the **Logistics** database.

    ```azurecli
    az sql db show --name Logistics | jq '{name: .name, maxSizeBytes: .maxSizeBytes, status: .status}'
    ```

    You see that the database is online and the maximum amount data that the database can store.

    ```json
    {
      "name": "Logistics",
      "maxSizeBytes": 2147483648,
      "status": "Online"
    }
    ```

    If you chose the Azure SQL Database Free offer, the serverless database automatically pauses to conserve your free vCore seconds, so you could see your `Logistics` database with the Paused status after a period of inactivity.

## Connect to your database

A *connection string* contains all the information needed for an application to connect to your database. While you're still in the Cloud Shell, let's start by getting your connection string there.

### Connection string from Cloud Shell

Run the following `az sql db show-connection-string` command to get the connection string to the `Logistics` database in a format that `sqlcmd` can use:

    ```azurecli
    az sql db show-connection-string --client sqlcmd
    ```

    Your output resembles the following example. Copy this output for use in the next step.

    ```output
    "sqlcmd -S tcp:<server-name>.database.windows.net,1433 -d Logistics -U <username> -P <password> -N -l 30"
    ```

### Connection string from the Azure portal

The Azure portal provides connection strings for various data providers for your Azure SQL database easily accessible.

1. In the Azure portal, navigate to your SQL database. 
1. In the service menu of your SQL database, under **Settings**, select **Connection strings**.
1. Choose the data provider and connection method desired.

## Connect to your database with Visual Studio Code

Let's use a graphical tool to connect to your new Azure SQL Database. [Visual Studio Code](https://code.visualstudio.com/docs) is a popular, open-source code editor for Linux, macOS, and Windows. It supports extensions, including the [mssql extension](https://aka.ms/mssql-marketplace). You can use the extension for querying SQL Server, Azure SQL Database, Azure SQL Managed Instance, SQL database in Fabric, and other platforms.

1. Download and install [Visual Studio Code](https://code.visualstudio.com/docs).
1. In Visual Studio Code, open the **Extensions** view by selecting the Extensions icon in the Activity Bar on the side of the window. Search for mssql and select **Install** to add the extension. and the [mssql extension](https://aka.ms/mssql-marketplace) to your local workstation. 

   > [!TIP]
   > For future application project development of your database objects, also use the [SQL Database Projects extension for Visual Studio Code](/azure-data-studio/extensions/sql-database-project-extension). This tool allows you to work with your database in source control, capture existing database schemas, design new objects, and publish to databases.

1. In the extensions list, choose the **SQL Server** extension. 
1. Under **CONNECTIONS**, select **Add Connection**.

   :::image type="content" source="../media/4-vs-code-mssql-extension.png" alt-text="Screenshot of Visual Studio Code, with the mssql extension Add Connection dialogue opened.":::

1. Give your new connection a custom memorable name in **Profile name**.
1. You have multiple ways to provide the connection information:
   - Choose **Parameters** to manually enter the Azure SQL logical server name, database name, user name, and password.
   - Choose **Connection string** to paste in the connection string for your database, then add your user name and password.
   - Choose **Browse Azure** to connect to your Azure subscription in VS Code and select your new Azure SQL Database from a list.

1. For this learning exercise, choose **Browse Azure**. Connect to your Azure subscription from VS Code.
1. Select your **Subscription** from the list. 
1. Select your **Resource Group** from the list. 
1. Select your **Server** and **Database** from the list. 
1. With **Authentication type** set to **SQL Login**, provide the **User name** and **Password** we created in the last module.
1. Select **Connect**.
1. When you connect successfully, the **Add connection** dialogue disappears. It's replaced by your server connection and an object explorer of **Tables**, **Views**, etc.

   :::image type="content" source="../media/4-vs-code-objects.png" alt-text="Screenshot of the VS Code mssql extension with the server connected and database objects displayed.":::

## Query your database with Visual Studio Code

Let's run a series of commands to perform basic CRUD (*Create, Read, Update, Delete*) operations in your Azure SQL Database.

1. Right-click on the server name line under **CONNECTIONS** and select **New Query**.

   :::image type="content" source="../media/4-vs-code-mssql-new-query.png" alt-text="Screenshot of the New Query option under Connections in the mssql extension for Visual Studio Code.":::

1. In the new query window, let's create our first database object by pasting in the following command to create a new table called `Drivers`.

   ```sql
   CREATE TABLE Drivers (DriverID int IDENTITY(1,1), LastName varchar(255), FirstName varchar(255), OriginCity varchar(255));
   GO
   ```

   The table contains four columns: a unique identifier, the driver's last and first name, and the driver's city of origin. 

1. Select the **Execute Query** button to run the T-SQL commands in the query window. 

   > [!TIP]
   > To execute a single T-SQL command among many in a query window, drag and select the desired query, then **Execute**.

   :::image type="content" source="../media/4-vs-code-mssql-execute.png" alt-text="Screenshot of the New Query window with the T-SQL command for the Drivers table. The Execute button is highlighted.":::

   Like almost anything in Visual Studio Code, [keyboard shortcuts can be customized in Visual Studio Code](https://github.com/Microsoft/vscode-mssql/wiki/customize-shortcuts). In Windows, the default keyboard shortcut for **Execute** is `Ctrl + Shift + E`.
   
1. Next, run the following T-SQL statements to verify that the `Drivers` table exists, by querying database metadata:

    ```sql
    SELECT name FROM sys.tables;
    GO
    ```

    In the **Query Results** tab, under **Results**, you should see that `Drivers` exists in the list of tables.

    ```output
    name
    -------
    Drivers
    ```

1. Let's add a row to our table. Run the following T-SQL statements to add a sample row to the table:

    ```sql
    INSERT INTO Drivers (LastName, FirstName, OriginCity) VALUES ('Zirne', 'Laura', 'Springfield');
    GO
    ```

    This output indicates the operation succeeded:

    ```output
    3:14:01 PM
    Started executing query at Line 7
    (1 row affected)
    Total execution time: 00:00:00.044
    ```

1. To see the row we inserted, run the following T-SQL statements to list the `DriverID` and `OriginCity` columns from all rows in the table:

    ```sql
    SELECT DriverID, OriginCity FROM Drivers;
    GO
    ```

    You get one result with the `DriverID` and `OriginCity` for the row you created in the previous step.

    ```output
    DriverID    OriginCity
    ----------- --------------------------
    1           Springfield
    ```

1. Let's update the row and change the `OriginCity`. Run the following T-SQL to change the city of origin from "Springfield" to "Boston" for the driver with a `DriverID` of `1`:

    ```sql
    UPDATE Drivers SET OriginCity='Boston' WHERE DriverID=1;
    GO
    ```

    You should get a message confirming the query execution in the **Query Results** window:

    ```output
    3:14:29 PM
    Started executing query at Line 13
    (1 row affected)
    Total execution time: 00:00:00.031
    ```

1. Run the following T-SQL statements to list the `DriverID` and `OriginCity` columns again:

    ```sql
    SELECT DriverID, OriginCity FROM Drivers;
    GO
    ```

    You should now get the following output. Notice how the `OriginCity` reflects the update to Boston.

    ```output
    DriverID    OriginCity
    ----------- --------------------------
    1           Boston
    ```

1. Finally, let's remove that row by running the following T-SQL statement to delete the record:

    ```sql
    DELETE FROM Drivers WHERE DriverID=1;
    GO
    ```

    ```output
    3:15:00 PM
    Started executing query at Line 16
    (1 row affected)
    Total execution time: 00:00:00.017
    ```

1. Run the following T-SQL statements to verify the `Drivers` table is empty:

    ```sql
    SELECT COUNT(*) FROM Drivers;
    GO
    ```

    You see that the table contains no rows.

    ```output
    -----------
              0
    ```

Now that you have a general idea for working with Azure SQL Database from Cloud Shell and in Visual Studio. You can use the connection string for your favorite SQL management tool, including SQL Server Management Studio, Visual Studio, or custom applications.

Cloud Shell makes it easy to access and work with your Azure resources of any kind. Because Cloud Shell is browser-based, you can access it from Windows, macOS, or Linux; on any system with a web browser.

You gained some hands-on experience running T-SQL commands in Visual Studio Code and practiced your T-SQL skills.

In the next unit, we wrap up this module and describe how to tear down your database.
