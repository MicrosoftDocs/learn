Firewalls are essential for blocking unauthorized access to protected resources. Each Azure SQL Database is assigned a public IP address managed by Microsoft. In each Azure region, there are one or more public IP addresses that serve as entry points to your database gateway, which then directs you to your database.

## How firewall works

Any connection attempts from the internet or Azure must pass through the firewall before reaching your server or database.

:::image type="content" source="../media/3-firewall.png" alt-text="Diagram of the database and server firewall architecture for Azure SQL Database.":::

Azure provides built-in firewalls to limit access and safeguard your database and data. In Azure SQL Database, there are two types of firewall rules: server-level IP firewall rules and database-level IP firewall rules.

### Server-level IP firewall rules

Both server-level and database-level firewalls in Azure SQL Database use IP address rules instead of SQL Server logins. This approach allows all users from the same public IP address, typically the company's outbound IP address, to access the SQL Server.

Server-level firewall rules permit users to connect to all databases on the server, while database-level firewall rules are used to grant or block specific IP addresses from accessing individual databases.

You can configure server-level firewall rules using the Azure portal or by executing the [`sp_set_firewall_rule`](/sql/relational-databases/system-stored-procedures/sp-set-database-firewall-rule-azure-sql-database?azure-portal=true) stored procedure within the master database. This flexibility ensures that you can manage access efficiently and securely.

 > [!NOTE]
 >The **Allow Azure Services and resources to access this server** server setting counts as a single firewall rule when enabled.

### Database-level IP firewall rules

Database-level IP firewall rules allow clients to access specific databases by creating rules for each database, including the master database. These rules are managed using Transact-SQL statements after configuring the first server-level firewall. You need to use the [`sp_set_database_firewall_rule`](/sql/relational-databases/system-stored-procedures/sp-set-database-firewall-rule-azure-sql-database?azure-portal=true) stored procedure from within the database.

When connecting to a database with database-level firewall rules enabled, Azure SQL Database first checks for a database-level firewall rule matching the database name in the connection string. If no such rule exists, it then checks the server-level IP firewall rules, which apply to all databases on the server. If either rule is found, the connection is completed.

If neither exist and the user is connecting through SQL Server Management Studio or Azure Data Studio, they'll be prompted to create a firewall rule as shown below.

:::image type="content" source="../media/4-firewall-rule.png" alt-text="Screenshot of the New Firewall Rule dialog in SQL Server Management Studio.":::

## Virtual network endpoints

Virtual network endpoints allow traffic from a specific Azure Virtual Network. These rules apply at the server level, not just the database level.

Additionally, the service endpoint applies to only one region, which is the underlying endpoint’s region.

An extra concern is that the virtual network that is connecting to the Azure SQL Database must have outbound access to the public IP address for Azure SQL Database, which can be configured using service tags for Azure SQL Database.

To address this concern, ensure that the virtual network connecting to the Azure SQL Database has outbound access to the public IP address for Azure SQL Database. Additionally, you can use network security groups (NSGs) to define and control the outbound traffic rules, ensuring that only the necessary traffic is allowed to reach the Azure SQL Database. 

## Private link

The Private Link feature allows you to connect to Azure SQL Database and other PaaS offerings using a private endpoint.

A private endpoint allows for a connection to your Azure SQL Database to go entirely over the Azure backbone network and not over the public internet.

This feature provides a private IP address on your Virtual Network. Another feature of private link is that it allows for Azure Express Route connections through that circuit.

Private link offers several benefits including cross-region private connectivity and protection against data leakage by only allowing connections to specific resources.
