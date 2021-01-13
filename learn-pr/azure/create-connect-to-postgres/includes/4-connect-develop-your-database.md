PostgreSQL has many tools to help developers connect to and query their database.

The psql client is a popular choice for connecting to PostgreSQL servers. You can connect to your server by using psql with Azure Cloud Shell. You can also use psql on your local environment if you have it available.

pgAdmin is a popular open-source administration and management tool for PostgreSQL that can be run as a web or desktop application. It has a graphical administration interface, a SQL query tool, a debugger, and more. Using pgAdmin to connect to the server simplifies the creation, maintenance, and use of database objects.

For the exercises in this module, we’ll be using psql with Azure Cloud Shell because it's quick to get started.

### Connect to your database

If your client computer has PostgreSQL installed, you can use a local instance of psql, or the Azure Cloud Console, to connect to an Azure PostgreSQL server. To connect, you’ll need your:

* Server name
* Sign-in credentials

You can get this information from the Azure portal after deployment, and also change your password if you've forgotten it. In the next exercise, there's a connection script provided for you.

After you're connected, you can create, query, and update your tables with SQL statements. Detailed instructions about how to connect and query with your programming language of choice are available in Unit 9 - Summary.

## Azure Firewall

The Azure Database for PostgreSQL server firewall prevents all access to your database server. Users must specify which computers have permission to access the server. The firewall can be configured in the Azure portal or with the Azure CLI. The firewall configuration allows you to specify a range of IP addresses that are permitted to connect to the server, and Azure can detect and suggest your own IP.

   :::image type="content" source="../media/5b-firewall.png" alt-text="Azure Database for PostgreSQL - Create Firewall Rule":::

As you already created an Azure Database for PostgreSQL instance in the previous exercise, next we'll configure the firewall. We'll allow access for our Cloud Shell development environment. Later, our .NET server will use the same access to query the database.

In the next unit, we'll start developing our database using Azure Cloud Shell.
