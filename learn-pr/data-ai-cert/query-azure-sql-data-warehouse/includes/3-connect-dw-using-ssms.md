There are many applications you can use as a client for the Azure SQL Datawarehouse server. 

- Data engineers often use SQL Server Management Studio (SSMS) to access Microsoft database products including Azure SQL Database, Azure SQL Data Warehouse, and on-premises SQL Server instances. 
- Data analysts usually use Excel or Power BI as their client application to query the database. 
- Developers use Visual Studio to write all kinds of third-party applications to query the database.

Since SMSS is a common tool, let's look at how to use it to query our data warehouse. To connect to our database, we need to create a _connection string_.

## Configuring SMSS to communicate with a database

A database connection string identifies the protocol, URL, port, and security options used to communicate with the database. The client uses this information to establish a network connection to the database. You can click on the **Show database connection** field on the **Overview** screen to get the connection string in a variety of framework formats:

- ADO.NET
- JDBC
- ODBC
- PHP

For example, here's the connection string for ADO.NET.

![Screenshot of Configuring ADO.NET](../media/3-configure-ado-net.png)

Notice that the connection string identifies the protocol as TCP/IP, includes the URL, and uses the port **1433** (the default in this case).

Since TCP:1433 is a well-known and public port, once your ASDW server's name is made public, it may invite DoS (denial-of-service) attacks. To protect the server from such attacks, you can configure the Azure firewall to restrict network access to specific IP addresses.

## Configure the firewall

To configure the firewall rules, navigate back to the **Overview** page 

1. Click the "Server name" link on the ADWS information page. This will navigate to the underlying Azure SQL database.

    ![Screenshot of Selecting Server Name](../media/3-configure-server-name.png)

1. Click the **Show firewall settings** link.

    ![Screenshot of Configuring Firewall](../media/3-configure-firewall.png)

1. From here, you can add a single IP address, an address segment, or a virtual network configration to connect it securely to specific Azure regions or your on-premises networks. 
    - For convenience, the portal lists the IP address of your computer. 
    - You can click the **Add client IP** button in the top menu to add it as a rule, or add a set of known IP addresses/segments through the rules section.

    ![Screenshot of adding IP address to firewall in DB configuration](../media/3-add-ip.png)


## Download SQL Server Management Studio (SSMS)

Once you have the connection string information, you can connect to the database with a client application. We're going to use SQL Server Management Studio. This is a free tool that runs on Windows. If you don't have it installed on your computer, you can use these [instructions](https://docs.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017) to download and install it.

> [!TIP]
> While SMSS is Microsoft's preferred tool, you can also use other 3rd-party tools on other platforms. As long as it can connect to a SQL Server database and perform T-SQL queries, it will likely work for the following steps.

## Connect to the database with SMSS

1. Launch SQL Server Management Studio.

![Screenshot of Starting SSMS](../media/3-start-ssms.png)

1. In the Connect to Server dialog:
    - Fill the server name as **demo-dw-server.database.windows.net**
    - Select the Authentication type as **SQL Server Authentication**
    - Fill the login credentials. If you ever forget the admin credentials, you can get the admin ID from the database overview, as well as reset the password.
    
1. Click the Connect button to establish the network connection.

    ![Screenshot of Connecting to SQL Server using SSMS](../media/3-connect-ssms-sql-server.png)

1. Since this is an Azure SQL Server Database, you will get a prompt to sign into Azure. Go ahead and sign in using the same account you used to create the data warehouse.

    ![Screenshot of Showing New Firewall Rule Dialog in SSMS](../media/3-show-firewall-rule.png)

1. Since the IP address of your computer has already been added to the firewall, your connection should be successful. And, you should see the ASDW server node and its database in the Object Explorer panel of the SSMS.

    ![Screenshot of SMSS Object Explorer expanded to show the database](../media/3-show-explorer-ssms.png)