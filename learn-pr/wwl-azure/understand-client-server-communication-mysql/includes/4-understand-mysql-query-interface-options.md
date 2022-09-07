The third element to the application layer is the query interface. When you're developing a database interface, and debugging it, you'll need a client query interface. These tools allow you to execute a SQL query and examine the results. They include features that help you write better SQL. Popular graphical interfaces include:

- **MySQL Workbench**. Available in three editions - Community, Standard and Enterprise. The Community edition is free to install, whereas Standard and Enterprise require licenses.
- **dbForge Studio**. Includes a rich user interface for developing and debugging SQL queries for MySQL and MariaDB databases. dbForgeStudio for MySQL is a paid-for tool.
- **MySQL for Visual Studio**. This add-on for Microsoft Visual Studio allows developers to connect to MySQL servers and work with MySQL databases within Visual Studio. There's limited functionality, however.

There are other query interface tools available, and your choice will depend on your specific needs.

## MySQL Workbench

MySQL Workbench is an open-source developer environment that allows you to connect to an Azure Database for MySQL single or flexible server. Using MySQL Workbench, you can query a database or find information about the server. MySQL Workbench can be [downloaded](https://dev.mysql.com/downloads/workbench/) and installed without a license.

To access a MySQL database on Azure Database for MySQL, you'll need an administrator username and password. To connect to a database:

1. Open MySQL Workbench, from the top ribbon menu select **Database**.
1. Select **Manage Connections** and the **Manage Server Connections** dialog box is displayed.
1. In **Connection Name**, enter a name for the connection.
1. In **Hostname**, enter the full name of the server as it is displayed in the Azure portal's Overview page for the server, eg mysqlserver-29.mysql.database.azure.com.
1. In **Port**, leave the default 3306.
1. In **Username**, enter an administrator account username.
1. Select **Store in Vault** and enter the administrator password then select **OK**. The password will be stored so you don't have to enter it each time.
1. Select **Test Connection** to ensure you can connect successfully.
    :::image type="content" source="../media/mysql-workbench-connect.png" alt-text="Screenshot showing the MySQL Workbench Connect to Database dialog box." lightbox="../media/mysql-workbench-connect.png":::

You've now created a connection to the server. If you want to connect to the same database each time, in **Default Schema** enter the name of the database.

> [!NOTE]
> In the MySQL world, schema means the structure of the database and is often used to refer to the database. In the SQL Server world, schema means a collection of database objects within the database. MySQL does not implement schemas in the same way as SQL Server.

MySQL Workbench has four main areas:

1. **Navigator**. This has two tabs - Administration and Schemas.
    1. **Administration** displays information such as the server status and client connections, and a performance dashboard. The Schemas tab shows information about databases. Note that MySQL refers to databases as schemas.
    1. **Information** has two tabs - Object info and Session. Object info displays information about the selected object. Session displays information about the session.
1. **Query tabs**. The main area in the center allows you to enter statements and queries. Dashboard and other information is displayed in this central area. The results of a query or statement appear in the query tab. The results area also has further options: Result Grid, Form Editor, Field Types, Query stats, and Execution Plan.
1. **Output**. Underneath the query tabs is the Output area, which displays information messages and error codes.
1. **SQL Additions**. This has two tabs - Context Help and Snippets. Context Help displays help topics from the "Jump to" dropdown box at the top. The Snippets area allows you to store code snippets, allowing you to keep the Query tab clear of unnecessary code.
    :::image type="content" source="../media/mysql-workbench.png" alt-text="Screenshot showing the MySQL Workbench four main areas - Navigator, Query tabs, Output, and SQL Additions." lightbox="../media/mysql-workbench.png":::

From the top View menu, select Panels to display which panels you want to display at any one time. Alternatively, the top right icons allow you to select and deselect which panels are visible.

Select the cog icon to display or edit Workbench Preferences including setting defaults for commonly used names and data types.
:::image type="content" source="../media/cog-icon.png" alt-text="Screenshot that shows the MySQL Workbench cog icon." lightbox="../media/cog-icon.png":::

## dbForge Studio for MySQL

dbForge Studio for MySQL is a third-party licensed full-featured IDE. To get started, [download and install dbForge for MySQL](https://www.devart.com/dbforge/mysql/studio/).

To connect to your MySQL server:

1. In dbForge for MySQL, select **Database** from the top menu.
1. Select **New Connection** and then provide the full server name, username, and password.
1. Select **Test Connection** to check the connection works.

You can migrate MySQL databases to Azure, backup and restore databases, as well as create and debug queries. dbForge for MySQL also has advanced administration abilities, such as the ability to compare and synchronize data and schemas.

## MySQL for Visual Studio

MySQL for Visual Studio is a third-party add-on for Microsoft Visual Studio. It can be downloaded from [MySQL Installer](https://dev.mysql.com/downloads/installer/). Both MySQL for Visual Studio 1.2.10 and Connector/NET are required.

> [!NOTE]
> There are two download options, the larger download includes all mySQL products, including the mySQL server. Choose the **web** option, which only downloads selected products:

- MySQL Servers (from 5.6 onwards)
- Applications
  - MySQL Workbench
  - MySQL for Visual Studio
  - MySQL Shell
  - MySQL Router
- MySQL Connectors
  - Connector ODBC
  - Connector C++
  - Connector J
  - Connector NET
  - Connector Python
- Documentation
  - Documentation, samples, and examples for versions 5.6, 5.7 or 8.0.

Select **MySQL for Visual Studio** and **MySQL Connectors - Connector/Net**. The **MySQL installer** installs the selected products.

To connect to a MySQL database from Visual Studio, from the top menu select **Tools**, then **Connect to Database**, under **Data source** select **MySQL Database**. Enter the full **server name**, for example mysqlserver-29.mysql.database.azure.com, then the username and password. You can optionally save the password. Select **Test Connection** to check the connection works.

> [!NOTE]
> The first time you connect to a MySQL database after installing MySQL for Visual Studio you'll have to restart Visual Studio.

If the Server Explorer panel isn't visible, from the top menu select **View**, then **Server Explorer**. Under **Data Connections**, your MySQL database is displayed. Expand the selection to see Tables, Views, Stored Procedures, Functions, and UDFs. Double-click an object to display details. Right-click to display a context-sensitive menu. You can then display objects, run queries, and create objects.
