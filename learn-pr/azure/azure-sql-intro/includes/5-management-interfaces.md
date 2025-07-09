As you deploy, use, and manage Azure SQL resources, you can use a variety of interfaces and tools. This unit looks at the available tools, their capabilities, and when to use them.

## Azure portal  

The [Azure portal](https://portal.azure.com) provides a broad set of features for Azure SQL resources, including virtual machines, managed instances, and databases. Through the Azure portal, you can deploy and administer resources, and, with Azure SQL Database, even connect to databases and run queries.

:::image type="content" source="../media/5-azure-sql-portal.png" alt-text="Screenshot that shows the Azure SQL deployment options in the Azure portal.":::
  
## SQL Server Management Studio

SQL Server Management Studio (SSMS) is the most popular tool for SQL Server in the world. SSMS is integrated to visualize and work with all three Azure SQL products. When necessary, SSMS shows only options that work for a specific Azure service.

:::image type="content" source="../media/5-sql-server-management-studio.png" alt-text="Screenshot that shows SQL Server Management Studio (SSMS).":::

## Languages and APIs  

Because all Azure SQL services are based on the SQL Database Engine, all support the Transact-SQL (T-SQL) language and the Tabular Data Stream (TDS) protocol. That means all drivers that normally work with SQL Server also work with Azure SQL Database and Azure SQL Managed Instance. Note that Microsoft retired the SQL Native Client (SNAC), for all new development you should use the [modern data providers](/sql/connect/sql-connection-libraries). 

Like all Azure products, REST APIs are available to manage all Azure SQL products.

## Command-line interfaces

Command-line interfaces (CLI) like sqlcmd and bcp can connect to all Azure SQL products.

Also, Azure CLI and Azure PowerShell cmdlets are supported for specific Azure SQL service scenarios. All these CLIs are supported across Windows, macOS, and Linux clients. Tools like sqlcmd and az are preinstalled in Azure Cloud Shell.

:::image type="content" source="../media/5-cloud-shell.png" alt-text="Screenshot that shows the Azure Cloud Shell.":::

## What to use when

There are several interfaces you can use to interact with Azure SQL. Many capabilities are available in all the interfaces. Which one you choose depends on a combination of preference, and what you're trying to accomplish. Throughout this learning path, you can use many of the interfaces described here. At the end of this module, there are resources to help you learn more about the ones that interest you.  
