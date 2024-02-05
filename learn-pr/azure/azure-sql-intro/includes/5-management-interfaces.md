As you deploy, use, and manage Azure SQL resources, you can use a variety of interfaces and tools. This unit looks at the available tools, their capabilities, and when to use them.

### Azure portal  

The [Azure portal](https://portal.azure.com) provides a broad set of features for Azure SQL resources, including virtual machines, managed instances, and databases. Through the Azure portal, you can deploy resources, administer resources, and even connect to databases and run queries.

:::image type="content" source="../media/5-azure-sql-portal.png" alt-text="Screenshot that shows the Azure SQL deployment options in the Azure portal.":::
  
### SQL Server Management Studio

SQL Server Management Studio (SSMS) is the most popular tool for SQL Server in the world. SSMS is integrated to visualize and work with Azure SQL, including SQL Server in virtual machines, SQL managed instances, and SQL databases. When necessary, SSMS shows only options that work for a specific Azure service.

:::image type="content" source="../media/5-sql-server-management-studio.png" alt-text="Screenshot that shows SQL Server Management Studio (SSMS).":::

### Azure Data Studio

Azure Data Studio is an open-source, cross-platform tool for querying and working with various Azure data sources, including SQL Server and Azure SQL. Azure Data Studio supports a powerful tool called *notebooks* that you'll use in some of the exercises throughout this learning path. Notebooks allow you to mix runnable code cells and formatted text in one place. You can optionally save the results for future reference or analysis.

:::image type="content" source="../media/5-azure-data-studio.png" alt-text="Screenshot that shows Azure Data Studio.":::

### Languages and APIs  

Because all Azure SQL services are based on the SQL Server engine, Azure SQL supports the Transact-SQL (T-SQL) language and the Tabular Data Stream (TDS) protocol. That means all drivers that normally work with SQL Server also work with Azure SQL.

Azure SQL supports REST APIs to manage SQL managed instances and SQL databases.

### Command-line interfaces

Azure SQL supports popular command-line interfaces (CLI) like sqlcmd and bcp.

Also, Azure CLI and Azure PowerShell cmdlets are supported for specific Azure SQL service scenarios. All these CLIs are supported across Windows, macOS, and Linux clients. Tools like sqlcmd and az are pre-installed in Azure Cloud Shell.

:::image type="content" source="../media/5-cloud-shell.png" alt-text="Screenshot that shows the Azure Cloud Shell.":::

## What to use when

There are several interfaces you can use to interact with Azure SQL. Many capabilities are available in all the interfaces. Which one you choose depends on a combination of preference and what you're trying to accomplish. Throughout this learning path, you can use many of the interfaces described here. At the end of this module, there are resources to help you learn more about the ones that interest you.  
