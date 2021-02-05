In this module, you learned about Azure SQL, including the deployment options, purchasing models, service tiers, and hardware choices. You now have a better understanding of the options you can and should choose for your applications and data.

## Learn more

To learn more about the history of Azure SQL and the options, models, and management tools, see the following references.

### Video series: Azure SQL for beginners

People learn in different ways. A Channel 9 video series related to this learning path is [available on YouTube](https://aka.ms/azuresql4beginners).

### History of Azure SQL  

You can watch the 2008 [Microsoft Professional Developers Conference](https://www.youtube.com/watch?v=otuf3goxLsg&azure-portal=true) keynote, where Microsoft Chief Software Architect (at the time) Ray Ozzie announced Azure for the first time. If you want to read the original "What to use when," you can find that in the [TechNet archive](https://social.technet.microsoft.com/wiki/contents/articles/1308.select-an-edition-of-sql-server-for-application-development/revision/7.aspx?azure-portal=true). You can also read the [original blog post](https://azure.microsoft.com/blog/microsoft-announces-windows-azure-and-azure-services-platform/?azure-portal=true) about the launch of Windows Azure and SQL Azure.  

### SQL Server on Azure Virtual Machines

To learn more about what you can get from infrastructure as a service (IaaS) services, see [What is IaaS?](https://azure.microsoft.com/overview/what-is-iaas/?azure-portal=true). Here are some considerations specific to optimally deploying and managing SQL Server on Azure Virtual Machines:  

- Install from [Azure gallery images](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#4-configure-sql-server-settings?azure-portal=true) or take advantage of the [resource provider](https://www.aka.ms/sqlvm_rp_documentation?azure-portal=true) (also referred to as the SQL IaaS Extension) for licensing flexibility and to enable automatic backups and updates.
- Consider memory-optimized or storage-optimized virtual machine [sizes](https://azure.microsoft.com/pricing/details/virtual-machines/series/?azure-portal=true) for maximum performance.
- Integrate your Azure virtual machines to on-premises networks by using [Azure Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview#communicate-with-on-premises-resources?azure-portal=true).
- Take advantage of automated backups, backups to Azure Blob storage, and integration with [Azure Backup](https://azure.microsoft.com/blog/azure-backup-for-sql-server-in-azure-virtual-machines-now-generally-available/?azure-portal=true).
- Always On Failover Cluster Instances is supported with [Azure premium file share](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-create-failover-cluster-premium-file-share?azure-portal=true).
- [Always On availability groups](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-availability-group-overview?azure-portal=true) are supported, including Cloud Witness.  

If you're considering SQL Server on Azure Virtual Machines, you should review the [guidance on images](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-overview?azure-portal=true), the [quick checklist](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-performance?azure-portal=true) for getting optimal performance of SQL Server on Azure Virtual Machines, and the guidance for [storage configuration](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-storage-configuration?azure-portal=true).  

If you're specifically considering SQL Server on RHEL Azure VMs, check out the [operations guide](https://azure.microsoft.com/resources/sql-server-on-rhel-azure-vms-operations-guide/?azure-portal=true).  

### Companies that use Azure SQL  

There are many companies that have moved to Azure SQL. You can learn more about the companies mentioned in this module:  

- [Allscripts: SQL Server on Azure Virtual Machines](https://customers.microsoft.com/story/allscripts-partner-professional-services-azure?azure-portal=true)
- [Komatsu: Azure SQL Managed Instance](https://customers.microsoft.com/story/komatsu-australia-manufacturing-azure?azure-portal=true)
- [AccuWeather: Azure SQL Database](https://customers.microsoft.com/story/accuweather-partner-professional-services-azure?azure-portal=true)
- [Paychex: Azure SQL Database elastic pools](https://customers.microsoft.com/story/paychex-azure-sql-database-us?azure-portal=true)

### Platform as a service (PaaS) capabilities

You can read [more about PaaS](https://azure.microsoft.com/overview/what-is-paas/?azure-portal=true).  

Azure SQL Database and SQL Managed Instance are versionless, meaning you get updates as they become available and never have to migrate. You can [view a feed from Microsoft about those updates](https://azure.microsoft.com/updates/?category=databases&azure-portal=true). You also might find the [release notes](https://docs.microsoft.com/azure/sql-database/sql-database-release-notes?tabs=single-database&azure-portal=true) for Azure SQL Database helpful.  

Learn more about pools in Azure SQL:

- [Azure SQL Managed Instance pools](https://docs.microsoft.com/azure/sql-database/sql-database-instance-pools?azure-portal=true)
- [Azure SQL Database elastic pools](https://docs.microsoft.com/azure/sql-database/sql-database-elastic-pool?azure-portal=true)  

If you want to learn more about deployment options and how to choose one, check out these resources:  

- [Blog announcement for Azure SQL](https://techcommunity.microsoft.com/t5/Azure-SQL-Database/Unified-Azure-SQL-experience/ba-p/815368?azure-portal=true) explains Azure SQL and some of the views and experiences available in the Azure portal.
- [Choose the right deployment option in Azure SQL](https://docs.microsoft.com/azure/sql-database/sql-database-paas-vs-sql-server-iaas?azure-portal=true) is a regularly updated article that provides insight into making decisions about Azure SQL options.
- [Choosing your database migration path to Azure](https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf?azure-portal=true) is a white paper about tools for discovering, assessing, planning, and migrating SQL databases to Azure. This learning path refers to it several times, and we recommend that you read it. Chapter 5 includes an in-depth discussion about choosing the right deployment option.  
- [Feature comparison among SQL Database, SQL Managed Instance, and SQL Server](https://docs.microsoft.com/azure/sql-database/sql-database-features?azure-portal=true) can help you learn about the differences among these options.

### Purchasing models and service tiers

You might want to learn more about the differences between [DTU-based](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-dtu?azure-portal=true) and [vCore-based](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-vcore?azure-portal=true) purchasing models. To do that, review the [in-depth comparison of vCores and DTUs](https://docs.microsoft.com/azure/sql-database/sql-database-purchase-models?azure-portal=true). Note that only the vCore model allows you to save money with options like [Azure Hybrid Benefit for SQL Server](https://azure.microsoft.com/pricing/hybrid-benefit/?azure-portal=true) and [reserved capacity](https://docs.microsoft.com/azure/sql-database/sql-database-reserved-capacity?azure-portal=true).  

The [documentation](https://docs.microsoft.com/azure/azure-sql/database/service-tiers-general-purpose-business-critical?azure-portal=true) goes deeper into the details and architectures for the various service tiers.  

### Management interfaces

To learn more about the tools, you can check out the [tools documentation](https://docs.microsoft.com/sql/tools/overview-sql-tools?view=sql-server-ver15&azure-portal=true), which includes information about and guidance on the various options discussed in this module (and more).
