In your sports clothing retail company, you needed an easy and quick way to migrate your products database into Azure. You chose Azure SQL Managed Instance because it provides a platform as a service (PaaS) implementation of SQL Server in the cloud. Azure SQL Database also has almost 100 percent compatibility with on-premises versions of SQL Server. You migrated the data, and ensured it was synchronized with the on-premises database so you could reconfigure client applications and the data analysis system.

Before SQL Managed Instance was available, system architects who wanted to migrate a database to Azure had two options:

- You could use Azure SQL Database, which provided a full PaaS solution with the consequent reduction in administrative time. However, this often required significant modification of the database, because Azure SQL Database doesn't support all the features of SQL Server. 
- You could install SQL Server on a virtual machine in Azure. However, this infrastructure as a service (IaaS) solution requires you to run, administer, and update the virtual machine, its operating system, and SQL Server yourself. You could expect to spend more time on administration. 

SQL Managed Instance provides a solution that's a full PaaS but supports almost all the features of SQL Server. This solution gives you the low administrative load you'd expect from Azure SQL Database but without the need to rewrite your database and change your client apps.

For additional reading, you can refer to the following URLs:

- [What is Azure SQL Managed Instance?](/azure/sql-database/sql-database-managed-instance?azure-portal=true)
- [Migrate SQL Server workloads to Azure SQL Database](/training/modules/migrate-sql-workloads-azure-sql-databases/?azure-portal=true)
- [Tutorial: Migrate SQL Server to an Azure SQL Managed Instance online using DMS (classic)](/azure/dms/tutorial-sql-server-managed-instance-online?azure-portal=true)
