The [SQL Database Projects extension](/azure-data-studio/extensions/sql-database-project-extension?azure-portal=true) is a developer tool that can be installed in both Azure Data Studio and Visual Studio Code. This extension is designed to facilitate the development and management of SQL databases in a project-based environment. It's compatible with several SQL platforms, including SQL Server, Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse SQL.

Database schemas can be created or changed, and the changes are saved in a *.dacpac* file format. You can publish the SQL Database project either using the SQL Database Projects extension or by publishing the *.dacpac* with the command line interface [SqlPackage](/sql/tools/sqlpackage/sqlpackage-publish?azure-portal=true).

With the SQL Database Projects extension you can either create a new empty project or create a new project from a connected database. You can then add, modify, or remove objects such as tables, views, stored procedures, functions, and custom scripts.

## Install the Database Projects extension

The SQL Database Project extension can be installed in both Azure Data Studio and Visual Studio Code.

### Install the Database Projects in Visual Studio Code

The SQL Database Projects extension is installed as part of the [mssql extension](/sql/tools/visual-studio-code/sql-server-develop-use-vscode?azure-portal=true). The mssql extension for Visual Studio Code enables you to connect to a SQL Server, query databases with T-SQL, and view the results.

:::image type="content" source="../media/3-sql-database-projects-extension.png" alt-text="Screenshot showing the SQL Database Projects extension installed.":::

It's a prerequisite that you have the latest [.NET SDK](https://dotnet.microsoft.com/download/dotnet?azure-portal=true) installed. If not, you'll be prompted to install it. 

### Install the Database Projects in Azure Data Studio

Installing the Database Projects extension in Azure Data Studio follows a similar process to installing it in Visual Studio Code.

1. In Azure Data Studio, select either the **Extensions** icon or **View** -> **Extensions** to open the *Extensions manager*.
1. Search for **SQL Database Projects**.
1. Select **Install**.

## Import and modify a schema

Now that you installed the SQL Database Projects extension, you're ready to create a Database project. In this example, we connect to an existing Azure SQL Database.

### Create a database project

The database project is the starting point to designing, developing, and managing your database schema. It provides a structured environment where you can define tables, views, stored procedures, and other database objects. 

1. In Visual Studio Code left menu, select **Database projects** and then **Create new**.
1. Select **Azure SQL Database starting from an empty project** under **Select Database Project Type**.
1. Select or enter a name for your project under **Project name**.
1. Select or browse to a folder on your local machine where the project will be saved under **Location**.
1. When prompted, select **Yes** for SDK-style project. The Data Project is created.

### Add a connection

Before you can start working with your database in Visual Studio Code, you need to establish a connection to your Azure SQL Database. This connection allows you to interact with your database directly from the IDE, enabling you to run queries, manage database objects, and perform other database-related tasks. Follow the steps to add a connection to your Azure SQL Database.

1. From the left menu, select **SQL Server**.
1. Select **Add connection**.
1. Enter the name of the SQL Server under **Server name**. You can copy and paste the server name from the Azure portal.
1. Enter the *database name*.
1. Select the authentication type, user name, and password.
1. Enter a name for the connection profile under **Profile name**. This step is optional.
1. The database connection appears under the **Connections** node.

### Create a new SQL Database project from an existing database

Creating a new SQL Database project from an existing database allows you to import your current database schema into a structured project format. Follow these steps to create a new SQL Database project from an existing database.

1. Right-click the database and select **Create Project From Database**.
1. Select your database under **Select database**.
1. Select your project under **Enter project name**.
1. Browse to your folder under **Select location or create project**.
1. Select **Schema/Object Type** under **Select folder structure**.
1. Select **No (default)** under **Include permissions in project**.
1. Select **Yes (recommended)** under **SDK-style project (Preview)**.
1. When prompted, select **Yes** to trust the authors of the files.
1. Expand the database objects tree to see the tables and other objects.
1. To modify the schema, select an object.
1. Select **File > Save**, then close the tab.

### Deploy the schema changes

To deploy the changes to your Azure SQL Database after modifying your database schema (such as adding new tables, update existing columns, or create new stored procedures), perform the following steps.

1. In the activity bar, select **Database Projects**.
1. Select **Build** by right-clicking your project.
1. Then select **Publish** by right-clicking your project.
1. Select **Publish to an existing Azure SQL logical server** under **Select where to publish the project to**.
1. Select **Don't use profile** under **Select publish profile to load**.
1. Select your database under **Choose a connection profile from the list below**.
1. Select **Publish** under **Choose action**.
1. Refresh the database view to verify that the schema modifications have been made.

:::image type="content" source="../media/3-publish-database.png" alt-text="Screenshot showing how to publish to an existing Azure SQL logical server.":::

## Azure Data Studio

The features for database projects in [Azure Data Studio](/azure-data-studio/download-azure-data-studio?azure-portal=true) are consistent with the features in other environments, such as Visual Studio Code. However, the user interface in Azure Data Studio is different, offering a unique layout and navigation experience. Despite these differences, you can still perform all the same tasks, such as creating, managing, and deploying database projects, with the same level of efficiency and effectiveness.

### Create a database project

To create a database project in Azure Data Studio, follow these steps.

1. In Azure Data Studio, select **Database projects** and then **Create new**.
1. Select **Azure SQL Database**, and enter a name for your project.
1. In **Location**, browse to a folder on your local machine where the project is saved.
1. Keep the selection for **SDK-style project (Preview)**.
1. Select **Create** to create the project. When prompted, select **Yes** if you trust the authors of the files in this folder.

Now that you created a SQL project, you can edit a table in the table designer. After making your changes, you can build and publish the project using a process similar to the process in Visual Studio Code.

For more information about working with SQL Database Projects in Azure Data Studio, see [Getting started with the SQL Database Projects extension](/azure-data-studio/extensions/sql-database-project-extension-getting-started?azure-portal=true).
