Azure Arc provides a streamlined pathway to migrate SQL Server databases to Azure SQL Managed Instance directly from the Azure portal. When your SQL Server instance is enabled by Azure Arc, you gain access to integrated assessment, target selection, and migration capabilities—all managed through a unified experience.

In our bicycle manufacturing company scenario, the distribution team runs business-critical databases that require minimal downtime during migration. The team wants to use the Azure portal for a simplified migration experience while maintaining control over the migration method.

## Understand how to migrate SQL Server with Azure Arc

When your SQL Server instance is enabled by Azure Arc, the Azure portal becomes your central hub for database migration to SQL Managed Instance. The migration process guides you through four key stages:

1. **Assess source instance** - Evaluate your SQL Server instance to determine migration readiness
2. **Select target** - Choose or create your SQL Managed Instance destination
3. **Migrate data** - Execute the migration using your chosen method
4. **Monitor and cutover** - Track progress and complete the migration

Discovery of SQL Server instances and generation of readiness reports happen automatically every weekend, but you can also trigger assessments manually at any time. The assessment evaluates feature compatibility, identifies potential migration blockers, and provides right-sized recommendations for your target SQL Managed Instance configuration.

Database migration through Azure Arc is available for SQL Server 2012 and later versions, with the specific migration method determining exact version requirements.

## Benefits of Azure Arc for migration

Azure Arc simplifies the migration journey by consolidating the entire process within the Azure portal. Rather than switching between multiple tools and interfaces, you can assess readiness, select or create your target instance, execute the migration, and monitor progress from a single unified experience. The automated assessment capabilities evaluate feature compatibility and identify potential migration blockers, while also providing right-sized recommendations for your target SQL Managed Instance configuration based on your workload characteristics.

Microsoft Copilot is integrated into the Azure portal migration experience to assist you throughout the process. You can interactively chat with Copilot to get help comparing migration methods, understanding assessments, starting migrations, and monitoring progress—making it easier to choose and execute the right approach for your scenario.

Additionally, Azure Arc provides visibility into your overall migration status, showing the number of databases migrated, migrations in progress, and your recommended target configuration. This centralized view helps you track progress across your data estate and ensures nothing is overlooked during large-scale migration projects.

For detailed guidance on migrating SQL Server databases to Azure SQL Managed Instance using Azure Arc, see [Migration to Azure SQL Managed Instance](/sql/sql-server/azure-arc/migrate-to-azure-sql-managed-instance).
