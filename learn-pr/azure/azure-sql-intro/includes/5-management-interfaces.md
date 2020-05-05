As you deploy, use, and manage Azure SQL resources you will use a variety of interfaces and tools. In this unit, you'll get a survey of what's available, with links to learn more.  

### Azure Portal  

The Azure portal is well integrated for Azure SQL resources including virtual machines, managed instances, and databases.  

The concept of *Azure SQL* is also baked into the portal experience for both managing resources and deploying Azure SQL options.

![Azure SQL deployment options in portal](../media/AzureSQLDeploymentOptions.gif)
  
### SQL Server Management Studio (SSMS)  

[SQL Server Management Studio](https://docs.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15) (SSMS) is the most famous and popular tool for SQL Server in the world. SSMS is integrated to understand how to visualize and work with Azure SQL including SQL Server in Virtual Machines, Managed Instances, or Databases. When necessary, SSMS will only show options that work for a specific Azure service.

### Azure Data Studio (ADS)  

[Azure Data Studio](https://docs.microsoft.com/sql/azure-data-studio/what-is?view=sql-server-ver15) (ADS) is a fairly new open-source, cross-platform tool to query and work with various Azure Data sources including SQL Server and Azure SQL. ADS supports a powerful concept called [notebooks](https://docs.microsoft.com/sql/azure-data-studio/notebooks-guidance?view=sql-server-ver15) which you will use in some of the exercises throughout the learning path.

### APIs  

Since all Azure SQL services are based on the SQL Server engine, Azure SQL supports the [T-SQL language](https://docs.microsoft.com/sql/t-sql/language-reference?view=sql-server-ver15) and [TDS protocol](https://docs.microsoft.com/openspecs/windows_protocols/ms-tds/b46a581a-39de-4745-b076-ec4dbb7d13ec). Therefore, all [drivers](https://docs.microsoft.com/sql/connect/sql-connection-libraries?view=sql-server-ver15) that normally work with SQL Server work with Azure SQL.

In addition, Azure SQL supports specific [REST APIs](https://docs.microsoft.com/rest/api/sql/) for management of Managed Instances and Databases.

### CLIs  

Popular command-line interfaces such as [sqlcmd](https://docs.microsoft.com/sql/tools/sqlcmd-utility?view=sql-server-ver15) and [bcp](https://docs.microsoft.com/sql/tools/bcp-utility?view=sql-server-ver15) are supported with Azure SQL services.

In addition, the [az CLI](https://docs.microsoft.com/cli/azure/?view=azure-cli-latest) and [Azure PowerShell cmdlets](https://docs.microsoft.com/powershell/azure/?view=azps-3.7.0) are supported for specific Azure SQL service scenarios. All of these CLIs are supported across Windows, macOS, and Linux clients. In addition, tools like sqlcmd and az are pre-installed in the [Azure Cloud Shell](https://azure.microsoft.com/features/cloud-shell/).

## Summary

There are several different interfaces you can use to interact with Azure SQL. Which one you choose will depend on a combination of preference and what you're trying to accomplish.  
