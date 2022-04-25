Firewalls are used to prevent unauthorized users from accessing protected resources. Each Azure SQL Database maps to a public IP address, which is hosted by Microsoft. Each Azure region will have one or more public IP addresses where you can reach your database gateway, which will then take you to your database.

## How firewall works

As shown in the following diagram, connection attempts coming from the internet and Azure must go through the firewall before they reach your server or database.

:::image type="content" source="../media/module-33-security-final-05_2.png" alt-text="Database and server firewall diagram":::

As we can see in the image above, Azure provides built-in firewalls to limit access in order to protect your database and your data. In Azure SQL Database there are two distinct sets of firewall rules: server-level firewall rules and database-level firewall rules.

### Server-level firewall rules

Both server and database level firewalls use IP Address rules instead of SQL Server Logins, and allow all users at the same public IP Address to access the SQL Server. For most companies, this is their outbound IP address.

Server level firewalls are configured to allow users to connect to all databases on the server. Database level firewalls are used to grant or block specific IP Addresses from accessing specific databases.

Server level firewall rules can be configured using the Azure portal or using the `sp_set_firewall_rule` stored procedure from within the *master* database.

 > [!NOTE]
 >The **Allow Azure Services and resources to access this server** server setting counts as a single firewall rule when enabled.

### Database level firewall rules

Database level firewall rules are configured through T-SQL only using the `sp_set_database_firewall_rule` stored procedure from within the user database. 

Upon connection, Azure SQL Database will look first for a server level firewall rule in the *master* database and then a database level firewall rule, if the connection string specifies a database name. If either of these exist, the connection will be completed.

If neither exist and the user is connecting through SQL Server Management Studio or Azure Data Studio, they'll be prompted to create a firewall rule as shown below.

:::image type="content" source="../media/module-33-security-final-15.png" alt-text="New Firewall Rule Screen from SQL Server Management Studio":::

## Virtual network endpoints

Virtual network endpoints allow traffic from a specific Azure Virtual Network. These rules apply at the server level, not just the database level.

Additionally, the service endpoint applies to only one region, which is the underlying endpoint’s region.

An extra concern is that the virtual network that is connecting to the Azure SQL Database must have outbound access to the public IP address for Azure SQL Database, which can be configured using service tags for Azure SQL Database.

## Private link

The Private Link feature allows you to connect to Azure SQL Database and other PaaS offerings using a private endpoint.

A private endpoint allows for a connection to your Azure SQL Database to go entirely over the Azure backbone network and not over the public internet.

This feature provides a private IP address on your Virtual Network. Another feature of private link is that it allows for Azure Express Route connections through that circuit.

Private link offers several benefits including cross-region private connectivity and protection against data leakage by only allowing connections to specific resources.
