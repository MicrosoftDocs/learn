In this module, you learned about Azure SQL, including the deployment options, purchasing models, service tiers, and hardware choices. You now have a better understanding of what options you can and should choose for your applications and data.

## Learn more

To learn more about the history, options, models, and management tools for Azure SQL, visit the references below.

### History of Azure SQL  

You can watch the 2008 [Microsoft Professional Developers Conference](https://www.youtube.com/watch?v=otuf3goxLsg) keynote, where Microsoft's Chief Software Architect (at the time) Ray Ozzie announced Azure for the first time. If you want to read the original "What to use when", you can find that [here](https://social.technet.microsoft.com/wiki/contents/articles/1308.select-an-edition-of-sql-server-for-application-development/revision/7.aspx). You can also read the [original blog post](https://azure.microsoft.com/en-us/blog/microsoft-announces-windows-azure-and-azure-services-platform/) from the launch of Windows Azure and SQL Azure.  

### SQL Server on Azure virtual machines

Learn more about what you can get from [Infrastructure as a Service (IaaS)](https://azure.microsoft.com/overview/what-is-iaas/) services. There are some considerations specific to optimally deploying and managing SQL Server on Azure Virtual Machines, including:  

- Install from [Azure gallery images](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#4-configure-sql-server-settings) or take advantage of the [Resource Provider](https://www.aka.ms/sqlvm_rp_documentation) for licensing flexibility and to enable automatic backups and updates.
- Consider the Memory or Storage optimized Virtual Machine [sizes](https://azure.microsoft.com/pricing/details/virtual-machines/series/) for maximum performance requirements.
- Integrate your Azure Virtual Machines to on-premises networks using [Azure Virtual Networks](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview#communicate-with-on-premises-resources).
- Take advantage of Automated Backups, Backups to Azure Blog Storage, and integration with [Azure Backup](https://azure.microsoft.com/blog/azure-backup-for-sql-server-in-azure-virtual-machines-now-generally-available/).
- Always On Failover Cluster Instance is supported with [Azure Premium File Share](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-create-failover-cluster-premium-file-share).
- [Always On Availability Groups](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-availability-group-overview) are supported including a Cloud Witness.  

If you're considering SQL Server on Azure Virtual Machines, you'll want to review the [guidance on images to choose from](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-overview), the [quick checklist](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-performance) to obtain optimal performance of SQL Server on Azure VMs, and the guidance for [storage configuration](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-storage-configuration).  

If you're specifically looking at SQL Server on RHEL Azure VMs, there's a full operations guide available [here](https://azure.microsoft.com/resources/sql-server-on-rhel-azure-vms-operations-guide/
).  

### Customers using Azure SQL  

There are many customers that have moved to Azure SQL. You can dive deeper into the customers mentioned in this module:  

- [Allscripts - SQL Server on Azure virtual machines](https://customers.microsoft.com/story/allscripts-partner-professional-services-azure)
- [Komatsu - Azure SQL Managed Instance](https://customers.microsoft.com/story/komatsu-australia-manufacturing-azure)
- [AccuWeather - Azure SQL Database](https://customers.microsoft.com/story/accuweather-partner-professional-services-azure)
- [Paychex - Azure SQL Database Elastic Pools](https://customers.microsoft.com/story/paychex-azure-sql-database-us)

### Platform as a Service (PaaS) capabilities

You can read more about PaaS [here](https://azure.microsoft.com/overview/what-is-paas/).  

Azure SQL Database and Managed Instance are versionless, meaning you get updates as they become available and never have to migrate. To see a feed from Microsoft regarding those updates, [refer here](https://azure.microsoft.com/updates/?category=databases). Another helpful resources are the [Release Notes](https://docs.microsoft.com/azure/sql-database/sql-database-release-notes?tabs=single-database) for Azure SQL Database.  

Learn more about pools in Azure SQL:

- [Azure SQL Managed Instance Pools](https://docs.microsoft.com/azure/sql-database/sql-database-instance-pools)
- [Azure SQL Database Elastic Pools](https://docs.microsoft.com/azure/sql-database/sql-database-elastic-pool)  

If you want to dive deeper into the deployment options and how to choose, check out the following resources:  

- [Blog announcement for Azure SQL](https://techcommunity.microsoft.com/t5/Azure-SQL-Database/Unified-Azure-SQL-experience/ba-p/815368), which explains and walks through Azure SQL and some of the resulting views and experiences available in the Azure portal.
- [Choose the right deployment option in Azure SQL](https://docs.microsoft.com/azure/sql-database/sql-database-paas-vs-sql-server-iaas) is a page in the documentation regularly updated to help provide insight into making the decisions between the Azure SQL options.
- [Choosing your database migration path to Azure](https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf) is a white paper that talks about tools for discovering, assessing, planning, and migrating SQL databases to Azure. This workshop will refer to it several times, and it's a highly recommended read. Chapter 5 deeply discusses choosing the right deployment option.  
- [Feature comparison between SQL database, SQL managed instance, and SQL Server](https://docs.microsoft.com/azure/sql-database/sql-database-features)

### Purchasing models and service tiers

You may want to dive to the differences between the [DTU-based](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-dtu
) and [vCore-based](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-vcore) purchasing models. To do that, review the [comparison vCores and DTUs in-depth here](https://docs.microsoft.com/azure/sql-database/sql-database-purchase-models
). Note that only the vCore model allows you to opt in for cost saving opportunities like [Azure Hybrid Benefit for SQL Server](https://azure.microsoft.com/pricing/hybrid-benefit/) and/or [Reserved capacity](https://docs.microsoft.com/azure/sql-database/sql-database-reserved-capacity).  

The [documentation](https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-general-purpose-business-critical) goes deeper into the details and architectures for the various service tiers.  

### Management interfaces

To learn more about some of the tools, you can leverage the [Tools documentation](https://docs.microsoft.com/en-us/sql/tools/overview-sql-tools?view=sql-server-ver15) which includes information and guidance on the various options discussed in this module (and more).  