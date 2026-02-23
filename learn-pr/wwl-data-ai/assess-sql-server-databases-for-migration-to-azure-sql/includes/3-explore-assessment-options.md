When it comes to migrating a database to a new platform or version, it's important to assess the database beforehand to identify any potential issues that could affect the migration process. 

Microsoft provides several tools to help you assess SQL Server databases for migration to Azure, including **SQL Server enabled by Azure Arc**, **Azure Migrate**, and **Azure Database Migration Service**.

> [!NOTE]
> For comprehensive migrations, we recommend that you use the [Azure Database Migration Service](/azure/dms/dms-overview) for large migrations and enhanced overall experience.

## SQL Server enabled by Azure Arc

[SQL Server enabled by Azure Arc](/sql/sql-server/azure-arc/overview) provides an integrated assessment experience directly in the Azure portal. This feature automatically produces assessments for migration to Azure, simplifying the discovery process and readiness evaluation.

Key benefits include:

- **Automatic assessment**: Once your SQL Server instances are connected to Azure Arc, assessments are automatically generated
- **No additional tools required**: Assessment results are available directly in the Azure portal
- **Integrated experience**: View migration readiness, compatibility issues, and recommendations in one place
- **Continuous monitoring**: Assessments can be refreshed to track changes in your environment

To use SQL Server enabled by Azure Arc for assessment:

1. [Automatically connect SQL Server machines to Azure Arc](/sql/sql-server/azure-arc/automatically-connect)
2. Verify your Azure Extension for SQL Server version is 1.1.2594.118 or later
3. Navigate to your SQL Server enabled by Azure Arc resource in the Azure portal
4. Under **Migration**, select **Assessments** to view results

For more information, see [Assess instances for migration with SQL Server enabled by Azure Arc](/sql/sql-server/azure-arc/migration-assessment).

## Azure Migrate

Azure Migrate is a comprehensive migration service that supports a wide range of migration scenarios, including SQL Server migration. Azure Migrate provides a suite of tools designed for assessment and migration of on-premises servers, infrastructure, applications, and data at scale, with the purpose of migrating them to Azure. 

These tools include *Azure Migrate: Discovery and assessment*, which evaluates your existing environment, and *Migration and modernization*, which facilitates the actual migration and modernization process. Moreover, Azure Migrate seamlessly integrates with several Azure services, tools, and independent software vendor (ISV) offerings, ensuring a flexible and efficient migration experience tailored to your specific requirements.

Azure Migrate is suitable for larger-scale migrations and scenarios where you need to assess entire data estates across VMware, Hyper-V, and physical environments.

> [!NOTE]
> To see a list of integrated tools supported by Azure Migrate, see [Integrated tools](/azure/migrate/migrate-services-overview#integrated-tools)

## Azure Database Migration Service

[Azure Database Migration Service](/azure/dms/dms-overview) provides assessment and migration capabilities through the Azure portal, PowerShell, and Azure CLI. This service enables:

- **Portal-based assessments**: Assess database readiness directly in the Azure portal
- **SKU recommendations**: Get right-sized Azure SQL configuration recommendations
- **Automation support**: Use PowerShell and Azure CLI for assessment at scale
- **Integrated migration**: Seamlessly transition from assessment to migration

The service is accessible via:
- [Azure portal](https://portal.azure.com/#create/Microsoft.AzureDMS)
- PowerShell ([Az.DataMigration module](/powershell/module/az.datamigration))
- Azure CLI ([az datamigration](/cli/azure/datamigration))

Regardless of the tool chosen, it's important to evaluate the specific requirements and goals of your migration project. Selecting the appropriate tool based on your scenario helps ensure a successful and efficient SQL Server migration to Azure.
