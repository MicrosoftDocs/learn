There are many tools to help developers connect and query with Azure Database for PostgreSQL. 

The psql client is a popular choice for connecting to PostgreSQL servers. You can connect to your server by using psql with Azure Cloud Shell. You can also use psql on your local environment if you have it available.

pgAdmin is a popular open-source administration and management tool for PostgreSQL that can be run as a web or desktop application. Its features include a graphical administration interface, an SQL query tool, a debugger, and more. Using pgAdmin to connect to the server simplifies the creation, maintenance, and use of database objects.

The Azure Databases extension for Visual Studio Code is currently in preview, so we won’t use it in the exercises. However, the extension allows developers to browse and query PostgreSQL servers both locally and in the cloud, all from within Visual Studio Code.

For the exercises in this module, we’ll be using psql with Azure Cloud Shell because it's quick to get started.

## Azure Firewall

The Azure Database for PostgreSQL server firewall prevents all access to your database server. Users must specify which computers have permission to access the server. The firewall can be configured in the Azure portal or with the Azure CLI. The firewall configuration allows you to specify a range of IP addresses that are permitted to connect to the server, and Azure can detect and suggest your own IP.

   :::image type="content" source="../media/5b-firewall.png" alt-text="Azure Database for PostgreSQL - Create Firewall Rule":::

For our payment app, we'll configure the firewall to allow access from our Cloud Shell development environment. Later, we'll add firewall permission for our .NET server.

### Connecting to your database

If your client computer has PostgreSQL installed, you can use a local instance of psql, or the Azure Cloud Console to connect to an Azure PostgreSQL server. To connect, you’ll need:

* Server name
* Login credentials

You can get this information from the Azure portal after deployment.

Once you're connected, you can create, query, and update your tables with SQL statements.  Detailed instructions on how to connect and query with your programming language of choice are available in Unit 7 - Summary.

In the next unit, we'll start developing our database using Azure Cloud Shell.
