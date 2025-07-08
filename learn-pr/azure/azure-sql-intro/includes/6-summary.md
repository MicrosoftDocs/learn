In this module, you learned about the three products in the Azure SQL family, including deployment options, purchasing models, service tiers, and features. You now have a better understanding of the options you can and should choose for your applications and data when using Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure VMs. 

> [!NOTE]
> - If you're ready to get started, [try Azure SQL Database free of charge](/azure/azure-sql/database/free-offer) for the life of your subscription, or [try Azure SQL Managed Instance free of charge](/azure/azure-sql/managed-instance/free-offer) for 12 months. 

## Learn more

To learn more about Azure SQL products and their options, models, and management tools, check out the following references.

### Video series: Azure SQL for beginners

People learn in different ways. A video series related to this learning path is [available on Azure shows](https://learn.microsoft.com/shows/browse?terms=azure%20sql).

### Platform as a service (PaaS) capabilities

You can read [more about PaaS](https://azure.microsoft.com/overview/what-is-paas/?azure-portal=true).  

You can [view a feed from Microsoft about Azure platform updates](https://azure.microsoft.com/updates/?category=databases&azure-portal=true). 

To learn more about each PaaS product, check out the following links:
- [Azure SQL Database](/azure/azure-sql/database/)
- [Azure SQL Managed Instance](/azure/azure-sql/managed-instance)

Follow the latest feature announcements and news at: 
- [What's New in Azure SQL Database?](/azure/azure-sql/database/doc-changes-updates-release-notes-whats-new) 
- [What's New in Azure SQL Managed Instance?](/azure/azure-sql/managed-instance/doc-changes-updates-release-notes-whats-new)


[Feature comparison between SQL Database and SQL Managed Instance](/azure/azure-sql/database/features-comparison) is a great resource to help you understand the differences between the products.

### SQL Server on Azure VMs

To learn more about what you can get from IaaS services, check out [What is IaaS?](https://azure.microsoft.com/resources/cloud-computing-dictionary/what-is-iaas/). 

If you're considering SQL Server on Azure VMs, review the: 
- [Documentation](/azure/azure-sql/virtual-machines/)
- [What's new](/azure/azure-sql/virtual-machines/windows/doc-changes-updates-release-notes-whats-new)
- [Best practices checklist](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-checklist) for getting optimal performance of SQL Server on Azure Virtual Machines. 

If you're specifically considering SQL Server on Linux on Azure VMs, review [SQL Server on Linux](/sql/linux/sql-server-linux-overview). There are multiple quickstarts available for Linux distributions, for example: [Quickstart: Install SQL Server and create a database on Red Hat](/sql/linux/quickstart-install-connect-red-hat).

Here are some considerations specific to optimally deploying and managing SQL Server on Azure VMs:  

- Install from [Azure gallery images](/azure/virtual-machines/shared-image-galleries) or take advantage of the benefits provided by the [SQL IaaS Agent extension](/azure/azure-sql/virtual-machines/windows/sql-server-iaas-agent-extension-automate-management), such as licensing flexibility, automatic backups, and updates.
- Integrate your Azure VMs to on-premises networks by using [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview#communicate-with-on-premises-resources?azure-portal=true).
- Always On failover cluster instances are supported with a number of [different storage options](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-overview). 
- [Always On availability groups](/azure/azure-sql/virtual-machines/windows/availability-group-overview) are supported, including Cloud Witness.  




## Saving on costs

You can save on costs with the [Azure Hybrid Benefit](/azure/azure-sql/azure-hybrid-benefit) available for Azure SQL Database, Azure SQL Managed Instance, and [SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/licensing-model-azure-hybrid-benefit-ahb-change#azure-hybrid-benefit). 

You can also use [Azure Reservations](/azure/azure-sql/database/reservations-discount-overview) to save on compute costs for Azure SQL Database and Azure SQL Managed Instance. Azure Reservations are a billing discount that you can use to save money by committing to use compute resources at a discounted rate for a period of time.

## Management interfaces

To learn more about tools, you can check out the [SQL tools documentation](/sql/tools/overview-sql-tools), which includes information about and guidance on the various options discussed in this module.

For more on how to connect to the Database Engine in various products and services, from various tools or providers, read [Connect to the Database Engine](/sql/sql-server/connect-to-database-engine).

To get started with migrating your data estate to Azure, review [Migration overview](/data-migration/sql-server/overview). 
