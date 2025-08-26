When it comes to migrating a database to a new platform or version, it's important to assess the database beforehand to identify any potential issues that could affect the migration process. 

Tools such as **Azure migration extension for Azure Data Studio** and **Azure Migrate** can help you in this process.

> [!NOTE]
> For comprehensive migrations, we recommend that you use the [Azure Database Migration Service](/azure/dms/dms-overview) for large migrations and enhanced overall experience. When it comes to migrating a database to a new platform or version, it's important to assess the database beforehand to identify any potential issues that could affect the migration process. 

Tools such as **Azure migration extension for Azure Data Studio**, and **Azure Migrate** can help you in this process.

## Azure migration extension for Azure Data Studio

The [Azure SQL Migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension) helps in assessing your migration readiness, providing appropriate SKU recommendations for Azure resources, and facilitating the migration of your SQL Server database to Azure and is ideal for small to medium-sized databases. It's powered by the latest version of [Azure Database Migration Service](/azure/dms/dms-overview), and also provides an advanced assessment feature that evaluates SQL Server databases that are ready for migration to Azure SQL.

Additionally, the migration extension is a lightweight tool that provides support for both online and offline migration modes, enabling you to migrate from SQL Server to Azure SQL Managed Instance, Azure SQL Database, or SQL Server on Azure Virtual Machine. However, please note that for SQL Server to Azure SQL Database migration, only the offline migration mode is currently available.

> [!NOTE]
> To a list of the features supported by the extension, see [Azure SQL migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension)

## Azure Migrate

Azure Migrate is a comprehensive migration service that supports a wide range of migration scenarios, including SQL Server migration. Azure Migrate provides a suite of tools designed for assessment and migration of on-premises servers, infrastructure, applications, and data at scale, with the purpose of migrating them to Azure. 

These tools include *Azure Migrate: Discovery and assessment*, which evaluates your existing environment, and *Migration and modernization*, which facilitates the actual migration and modernization process. Moreover, Azure Migrate seamlessly integrates with several Azure services, tools, and independent software vendor (ISV) offerings, ensuring a flexible and efficient migration experience tailored to your specific requirements.

Azure Migrate is suitable for larger-scale migrations and scenarios.

> [!NOTE]
> To see a list of integrated tools supported by Azure Migrate, see [Integrated tools](/azure/migrate/migrate-services-overview#integrated-tools)

Regardless of the tool chosen, it's important to evaluate the specific requirements and goals of your migration project. Selecting the appropriate tool based on your scenario helps ensure a successful and efficient SQL Server migration to Azure.
