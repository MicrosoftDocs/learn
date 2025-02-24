When you create a new server in Azure SQL Database or Azure Synapse Analytics named *mysqlserver*, for example, a server-level firewall blocks all access to the public endpoint for the server (which is accessible at *mysqlserver.database.windows.net*). For simplicity, *SQL Database* is used to refer to both SQL Database and Azure Synapse Analytics. This article does *not* apply to *Azure SQL Managed Instance*. For information about network configuration, see [Connect your application to Azure SQL Managed Instance](/azure/azure-sql/managed-instance/connect-application-instance?view=azuresql).

## How the firewall works

Connection attempts from the internet and Azure must pass through the firewall before they reach your server or database, as the following diagram shows.

:::image type="content" source="../media/azure-sql-database-and-azure-synapse-ip-fiewwall-rules-3e2d7f4e.png" alt-text="Diagram showing an example of how the firewall works.":::


> [!IMPORTANT]
> Azure Synapse only supports server-level IP firewall rules. It doesn't support database-level IP firewall rules.

### Server-level IP firewall rules

These rules enable clients to access your entire server, that is, all the databases managed by the server. The rules are stored in the *master* database. The maximum number of server-level IP firewall rules is limited to 256 for a server. If you have the Allow Azure Services and resources to access this server setting enabled, this counts as a single firewall rule for the server.

You can configure server-level IP firewall rules by using the Azure portal, PowerShell, or Transact-SQL statements.

> [!NOTE]
> The maximum number of server-level IP firewall rules is limited to 256 when configuring using the Azure portal.

 -  To use the portal or PowerShell, you must be the subscription owner or a subscription contributor.
 -  To use Transact-SQL, you must connect to the *master* database as the server-level principal login or as the Microsoft Entra administrator. (A server-level IP firewall rule must first be created by a user who has Azure-level permissions.)

> [!NOTE]
> By default, during creation of a new logical SQL server from the Azure portal, the Allow Azure Services and resources to access this server setting is set to No.

### Database-level IP firewall rules

Database-level IP firewall rules enable clients to access certain (secure) databases. You create the rules for each database (including the *master* database), and they're stored in the individual database.

 -  You can only create and manage database-level IP firewall rules for master and user databases by using Transact-SQL statements and only after you configure the first server-level firewall.
 -  If you specify an IP address range in the database-level IP firewall rule that's outside the range in the server-level IP firewall rule, only those clients that have IP addresses in the database-level range can access the database.
 -  The default value is up to 256 database-level IP firewall rules for a database. For more information about configuring database-level IP firewall rules, see the example later in this article and see [sp\_set\_database\_firewall\_rule (Azure SQL Database)](/sql/relational-databases/system-stored-procedures/sp-set-database-firewall-rule-azure-sql-database).

### Recommendations for how to set firewall rules

We recommend that you use database-level IP firewall rules whenever possible. This practice enhances security and makes your database more portable. Use server-level IP firewall rules for administrators. Also use them when you have many databases that have the same access requirements, and you don't want to configure each database individually.

> [!NOTE]
> For information about portable databases in the context of business continuity, see [Authentication requirements for disaster recovery](/azure/azure-sql/database/active-geo-replication-security-configure?view=azuresql).

## Server-level versus database-level IP firewall rules

*Should users of one database be fully isolated from another database?*

If *yes*, use database-level IP firewall rules to grant access. This method avoids using server-level IP firewall rules, which permit access through the firewall to all databases. That would reduce the depth of your defenses.

*Do users at the IP addresses need access to all databases?*

If *yes*, use server-level IP firewall rules to reduce the number of times that you have to configure IP firewall rules.

*Does the person or team who configures the IP firewall rules only have access through the Azure portal, PowerShell, or the REST API?*

If so, you must use server-level IP firewall rules. Database-level IP firewall rules can only be configured through Transact-SQL.

*Is the person or team who configures the IP firewall rules prohibited from having high-level permission at the database level?*

If so, use server-level IP firewall rules. You need at least *CONTROL DATABASE* permission at the database level to configure database-level IP firewall rules through Transact-SQL.

*Does the person or team who configures or audits the IP firewall rules centrally manage IP firewall rules for many (perhaps hundreds) of databases?*

In this scenario, best practices are determined by your needs and environment. Server-level IP firewall rules might be easier to configure, but scripting can configure rules at the database-level. And even if you use server-level IP firewall rules, you might need to audit database-level IP firewall rules to see if users with *CONTROL* permission on the database create database-level IP firewall rules.

*Can I use a mix of server-level and database-level IP firewall rules?*

Yes. Some users, such as administrators, might need server-level IP firewall rules. Other users, such as users of a database application, might need database-level IP firewall rules.

### Connections from the internet

When a computer tries to connect to your server from the internet, the firewall first checks the originating IP address of the request against the database-level IP firewall rules for the database that the connection requests.

 -  If the address is within a range that's specified in the database-level IP firewall rules, the connection is granted to the database that contains the rule.
 -  If the address isn't within a range in the database-level IP firewall rules, the firewall checks the server-level IP firewall rules. If the address is within a range that's in the server-level IP firewall rules, the connection is granted. Server-level IP firewall rules apply to all databases managed by the server.
 -  If the address isn't within a range that's in any of the database-level or server-level IP firewall rules, the connection request fails.

> [!NOTE]
> To access Azure SQL Database from your local computer, ensure that the firewall on your network and local computer allow outgoing communication on TCP port 1433.

### Connections from inside Azure

To allow applications hosted inside Azure to connect to your SQL server, Azure connections must be enabled. To enable Azure connections, there must be a firewall rule with starting and ending IP addresses set to 0.0.0.0. This recommended rule is only applicable to Azure SQL Database.

When an application from Azure tries to connect to the server, the firewall checks that Azure connections are allowed by verifying this firewall rule exists. This can be turned on directly from the Azure portal pane by switching the Allow Azure Services and resources to access this server to ON in the Firewalls and virtual networks settings. Switching the setting to ON creates an inbound firewall rule for IP 0.0.0.0 - 0.0.0.0 named AllowAllWindowsAzureIps. The rule can be viewed in your master database [sys.firewall\_rules](/sql/relational-databases/system-catalog-views/sys-firewall-rules-azure-sql-database) view. Use PowerShell or the Azure CLI to create a firewall rule with start and end IP addresses set to 0.0.0.0 if you're not using the portal.

> [!IMPORTANT]
> This option configures the firewall to allow all connections from Azure, including connections from the subscriptions of other customers. If you select this option, make sure that your login and user permissions limit access to authorized users only.

## Permissions

To be able to create and manage IP firewall rules for the Azure SQL Server, you will need to either be:

 -  in the [SQL Server Contributor](/azure/role-based-access-control/built-in-roles#sql-server-contributor) role
 -  in the [SQL Security Manager](/azure/role-based-access-control/built-in-roles#sql-security-manager) role
 -  the owner of the resource that contains the Azure SQL Server

## Create and manage IP firewall rules

You create the first server-level firewall setting by using the [Azure portal](https://portal.azure.com/) or programmatically by using [Azure PowerShell](/powershell/module/az.sql), [Azure CLI](/cli/azure/sql/server/firewall-rule), or an Azure [REST API](/rest/api/sql/firewall-rules/create-or-update). You create and manage additional server-level IP firewall rules by using these methods or Transact-SQL.

> [!IMPORTANT]
> Database-level IP firewall rules can only be created and managed by using Transact-SQL.

To improve performance, server-level IP firewall rules are temporarily cached at the database level. To refresh the cache, see [DBCC FLUSHAUTHCACHE](/sql/t-sql/database-console-commands/dbcc-flushauthcache-transact-sql).

> [!TIP]
> You can use [Database Auditing](/azure/azure-sql/database/auditing-overview?view=azuresql) to audit server-level and database-level firewall changes.

### Use the Azure portal to manage server-level IP firewall rules

To set a server-level IP firewall rule in the Azure portal, go to the overview page for your database or your server.

> [!TIP]
> For a tutorial, see [Create a database using the Azure portal](/azure/azure-sql/database/single-database-create-quickstart?view=azuresql).

#### From the database overview page

1.  To set a server-level IP firewall rule from the database overview page, select Set server firewall on the toolbar, as the following image shows.
    
    :::image type="content" source="../media/sql-database-firewall-settings-dd46ab44.png" alt-text="Screenshot showing an example of the sql database firewall settings toolbar.":::
    
    
    The Networking page for the server opens.
2.  Add a rule in the Firewall rules section to add the IP address of the computer that you're using, and then select Save. A server-level IP firewall rule is created for your current IP address.
    
    :::image type="content" source="../media/virtual-networking-settings-c0e3ccd3.png" alt-text="Screenshot showing an example of the sql database firewall settings toolbar.":::
    

#### From the server overview page

The overview page for your server opens. It shows the fully qualified server name (such as *mynewserver20170403.database.windows.net*) and provides options for further configuration.

1.  To set a server-level rule from this page, select Networking from the Settings menu on the left side.
2.  Add a rule in the Firewall rules section to add the IP address of the computer that you're using, and then select Save. A server-level IP firewall rule is created for your current IP address.

### Use Transact-SQL to manage IP firewall rules

Expand table

| **Catalog view or stored procedure**                                                                                                                                      | **Level** | **Description**                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------------------------------------------------------- |
| [sys.firewall\_rules](/sql/relational-databases/system-catalog-views/sys-firewall-rules-azure-sql-database)                                    | Server    | Displays the current server-level IP firewall rules     |
| [sp\_set\_firewall\_rule](/sql/relational-databases/system-stored-procedures/sp-set-firewall-rule-azure-sql-database)                          | Server    | Creates or updates server-level IP firewall rules       |
| [sp\_delete\_firewall\_rule](/sql/relational-databases/system-stored-procedures/sp-delete-firewall-rule-azure-sql-database)                    | Server    | Removes server-level IP firewall rules                  |
| [sys.database\_firewall\_rules](/sql/relational-databases/system-catalog-views/sys-database-firewall-rules-azure-sql-database)                 | Database  | Displays the current database-level IP firewall rules   |
| [sp\_set\_database\_firewall\_rule](/sql/relational-databases/system-stored-procedures/sp-set-database-firewall-rule-azure-sql-database)       | Database  | Creates or updates the database-level IP firewall rules |
| [sp\_delete\_database\_firewall\_rule](/sql/relational-databases/system-stored-procedures/sp-delete-database-firewall-rule-azure-sql-database) | Databases | Removes database-level IP firewall rules                |

The following example reviews the existing rules, enables a range of IP addresses on the server *Contoso*, and deletes an IP firewall rule:

SQL

```
SELECT * FROM sys.firewall_rules ORDER BY name;

```

Next, add a server-level IP firewall rule.

SQL

```
SELECT * FROM sys.firewall_rules ORDER BY name;

```

EXECUTE sp\_set\_firewall\_rule @name = N'ContosoFirewallRule',<br>@start\_ip\_address = '192.168.1.1', @end\_ip\_address = '192.168.1.10'

To delete a server-level IP firewall rule, execute the *sp\_delete\_firewall\_rule* stored procedure. The following example deletes the rule *ContosoFirewallRule*:

SQL

```
EXECUTE sp_delete_firewall_rule @name = N'ContosoFirewallRule'

```

### Use PowerShell to manage server-level IP firewall rules

> [!NOTE]
> This example uses the Azure Az PowerShell module, which is the recommended PowerShell module for interacting with Azure. To get started with the Az PowerShell module, see [Install Azure PowerShell](/powershell/azure/install-az-ps). To learn how to migrate to the Az PowerShell module, see [Migrate Azure PowerShell from AzureRM to Az](/powershell/azure/migrate-from-azurerm-to-az).

> [!IMPORTANT]
> The PowerShell Azure Resource Manager (AzureRM) module was deprecated on February 29, 2024. All future development should use the Az.Sql module. Users are advised to migrate from AzureRM to the Az PowerShell module to ensure continued support and updates. The AzureRM module is no longer maintained or supported. The arguments for the commands in the Az PowerShell module and in the AzureRM modules are substantially identical. For more about their compatibility, see [Introducing the new Az PowerShell module](/powershell/azure/new-azureps-module-az).

Expand table

| **Cmdlet**                                                                                                            | **Level** | **Description**                                                  |
| --------------------------------------------------------------------------------------------------------------------- | --------- | ---------------------------------------------------------------- |
| [Get-AzSqlServerFirewallRule](/powershell/module/az.sql/get-azsqlserverfirewallrule)       | Server    | Returns the current server-level firewall rules                  |
| [New-AzSqlServerFirewallRule](/powershell/module/az.sql/new-azsqlserverfirewallrule)       | Server    | Creates a new server-level firewall rule                         |
| [Set-AzSqlServerFirewallRule](/powershell/module/az.sql/set-azsqlserverfirewallrule)       | Server    | Updates the properties of an existing server-level firewall rule |
| [Remove-AzSqlServerFirewallRule](/powershell/module/az.sql/remove-azsqlserverfirewallrule) | Server    | Removes server-level firewall rules                              |

The following example uses PowerShell to set a server-level IP firewall rule:

PowerShell

```
New-AzSqlServerFirewallRule -ResourceGroupName "myResourceGroup" `-ServerName $servername `-FirewallRuleName "ContosoIPRange" -StartIpAddress "192.168.1.0" -EndIpAddress "192.168.1.255"

```

> [!TIP]
> For $servername specify the server name and not the fully qualified DNS name e.g. specify mysqldbserver instead of mysqldbserver.database.windows.net. For PowerShell examples in the context of a quickstart, see [Create DB - PowerShell](/azure/azure-sql/database/powershell-script-content-guide?view=azuresql) and [Create a single database and configure a server-level IP firewall rule using PowerShell](/azure/azure-sql/database/scripts/create-and-configure-database-powershell?view=azuresql).

### Use CLI to manage server-level IP firewall rules

Expand table

| **Cmdlet**                                                                                                                              | **Level** | **Description**                         |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------- | --------------------------------------- |
| [az sql server firewall-rule create](/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-create) | Server    | Creates a server IP firewall rule       |
| [az sql server firewall-rule list](/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-list)     | Server    | Lists the IP firewall rules on a server |
| [az sql server firewall-rule show](/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-show)     | Server    | Shows the detail of an IP firewall rule |
| az sql server firewall-rule update                                                                                                      | Server    | Updates an IP firewall rule             |
| [az sql server firewall-rule delete](/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-delete) | Server    | Deletes an IP firewall rule             |

The following example uses CLI to set a server-level IP firewall rule:

Azure CLI

```

 
az sql server firewall-rule create --resource-group myResourceGroup --server $servername \-n ContosoIPRange --start-ip-address 192.168.1.0 --end-ip-address 192.168.1.255">">
 

```

> [!TIP]
> For $servername, specify the server name and not the fully qualified DNS name. For example, use mysqldbserver instead of mysqldbserver.database.windows.net. For a CLI example in the context of a quickstart, see [Create DB - Azure CLI](/azure/azure-sql/database/az-cli-script-samples-content-guide?view=azuresql) and [Create a single database and configure a server-level IP firewall rule using the Azure CLI](/azure/azure-sql/database/scripts/create-and-configure-database-cli?view=azuresql). For Azure Synapse Analytics, refer to the following examples:

Expand table

| **Cmdlet**                                                                                                                                                   | **Level** | **Description**                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- | ---------------------------------------------------------------------------- |
| [az synapse workspace firewall-rule create](/cli/azure/synapse/workspace/firewall-rule#az-synapse-workspace-firewall-rule-create) | Server    | Create a firewall rule                                                       |
| [az synapse workspace firewall-rule delete](/cli/azure/synapse/workspace/firewall-rule#az-synapse-workspace-firewall-rule-delete) | Server    | Delete a firewall rule                                                       |
| [az synapse workspace firewall-rule list](/cli/azure/synapse/workspace/firewall-rule#az-synapse-workspace-firewall-rule-list)     | Server    | List all firewall rules                                                      |
| [az synapse workspace firewall-rule show](/cli/azure/synapse/workspace/firewall-rule#az-synapse-workspace-firewall-rule-show)     | Server    | Get a firewall rule                                                          |
| [az synapse workspace firewall-rule update](/cli/azure/synapse/workspace/firewall-rule#az-synapse-workspace-firewall-rule-update) | Server    | Update a firewall rule                                                       |
| az synapse workspace firewall-rule wait                                                                                                                      | Server    | Place the CLI in a waiting state until a condition of a firewall rule is met |

The following example uses CLI to set a server-level IP firewall rule in Azure Synapse:

Azure CLI

```
az synapse workspace firewall-rule create --name AllowAllWindowsAzureIps --workspace-name $workspacename --resource-group $resourcegroupname --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

```

### Use a REST API to manage server-level IP firewall rules

Expand table

| **API**                                                                                                     | **Level** | **Description**                                     |
| ----------------------------------------------------------------------------------------------------------- | --------- | --------------------------------------------------- |
| [List firewall rules](/rest/api/sql/firewall-rules/list-by-server)               | Server    | Displays the current server-level IP firewall rules |
| [Create or update firewall rules](/rest/api/sql/firewall-rules/create-or-update) | Server    | Creates or updates server-level IP firewall rules   |
| [Delete firewall rules](/rest/api/sql/firewall-rules/delete)                     | Server    | Removes server-level IP firewall rules              |
| [Get firewall rules](/rest/api/sql/firewall-rules/get)                           | Server    | Gets server-level IP firewall rules                 |

## Troubleshoot the database firewall

Consider the following points when access to Azure SQL Database doesn't behave as you expect.

 -  Local firewall configuration: Before your computer can access Azure SQL Database, you may need to create a firewall exception on your computer for TCP port 1433. To make connections inside the Azure cloud boundary, you may have to open additional ports. For more information, see the "SQL Database: Outside vs inside" section of [Ports beyond 1433 for ADO.NET 4.5 and Azure SQL Database](/azure/azure-sql/database/adonet-v12-develop-direct-route-ports?view=azuresql).
 -  Network address translation: Because of network address translation (NAT), the IP address that's used by your computer to connect to Azure SQL Database may be different than the IP address in your computer's IP configuration settings. To view the IP address that your computer is using to connect to Azure:
    
    
    1.  Sign in to the portal.
    2.  Go to the Configure tab on the server that hosts your database.
    3.  The Current Client IP Address is displayed in the Allowed IP Addresses section. Select Add for Allowed IP Addresses to allow this computer to access the server.
 -  Changes to the allow list haven't taken effect yet: There may be up to a five-minute delay for changes to the Azure SQL Database firewall configuration to take effect.
 -  The login isn't authorized, or an incorrect password was used: If a login doesn't have permissions on the server or the password is incorrect, the connection to the server is denied. Creating a firewall setting only gives clients an *opportunity* to try to connect to your server. The client must still provide the necessary security credentials. For more information about preparing logins, see [Controlling and granting database access](/azure/azure-sql/database/logins-create-manage?view=azuresql).
 -  Dynamic IP address: If you have an internet connection that uses dynamic IP addressing and you have trouble getting through the firewall, try one of the following solutions:
    
    
     -  Ask your internet service provider for the IP address range that's assigned to your client computers that access the server. Add that IP address range as an IP firewall rule.
     -  Get static IP addressing instead for your client computers. Add the IP addresses as IP firewall rules.
