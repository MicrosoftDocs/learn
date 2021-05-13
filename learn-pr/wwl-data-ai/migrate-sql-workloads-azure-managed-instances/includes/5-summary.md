In your sports clothing retail company, you needed an easy and quick way to migrate your products database into Azure. You chose Azure SQL Database Managed Instance because it provides a platform as a service (PaaS) implementation of SQL Server in the cloud. Azure SQL Database also has almost 100 percent compatibility with on-premises versions of SQL Server. You migrated the data, and ensured it was synchronized with the on-premises database so you could reconfigure client applications and the data analysis system.

Before Managed Instance was available, system architects who wanted to migrate a database to Azure had two options:

- You could use Azure SQL Database, which provided a full PaaS solution with the consequent reduction in administrative time. However, this often required significant modification of the database, because Azure SQL Database doesn't support all the features of SQL Server. 
- You could install SQL Server on a virtual machine in Azure. However, this infrastructure as a service (IaaS) solution requires you to run, administer, and update the virtual machine, its operating system, and SQL Server yourself. You could expect to spend more time on administration. 

Azure SQL Database Managed Instance provides a new solution that's a full PaaS but supports almost all the features of SQL Server. This solution gives you the low administrative load you'd expect from Azure SQL Database but without the need to rewrite your database and change your client apps.

## Learn more

- [What is Azure SQL Database Managed Instance?](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance)
- [SQL Server instance migration to Azure SQL Database Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-migrate)
- [Tutorial: Migrate SQL Server to an Azure SQL Database Managed Instance offline using DMS](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-managed-instance?toc=/azure/sql-database/toc.json)
- [Differences between Compatibility Level 140 and Level 150](https://docs.microsoft.com/sql/t-sql/statements/alter-database-transact-sql-compatibility-level?view=sql-server-2017#differences-between-compatibility-level-140-and-level-150)
- [Pvk2Pfx](https://docs.microsoft.com/windows-hardware/drivers/devtest/pvk2pfx)