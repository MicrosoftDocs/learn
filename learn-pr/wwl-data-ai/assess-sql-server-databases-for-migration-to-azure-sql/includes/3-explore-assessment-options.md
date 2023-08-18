
When it comes to migrating a database to a new platform or version, it’s important to assess the database beforehand to identify any potential issues that could affect the migration process. 

Tools such as **Azure migration extension for Azure Data Studio**, **Azure Migrate**, and **Data Migration Assistant (DMA)** can help you in this process.

## Azure migration extension for Azure Data Studio

The [Azure SQL Migration extension for Azure Data Studio](https://learn.microsoft.com/sql/azure-data-studio/extensions/azure-sql-migration-extension) helps in assessing your migration readiness, providing appropriate SKU recommendations for Azure resources, and facilitating the migration of your SQL Server database to Azure and is ideal for small to medium-sized databases. It's powered by the latest version of Data Migration Services, and also provides an advanced assessment feature that evaluates SQL Server databases that are ready for migration to Azure SQL.

Additionally, the migration extension is a lightweight tool that provides support for both online and offline migration modes, enabling you to migrate from SQL Server to Azure SQL Managed Instance, Azure SQL Database, or SQL Server on Azure Virtual Machine. However, please note that for SQL Server to Azure SQL Database migration, only the offline migration mode is currently available.

> [!NOTE]
> To a list of the features supported by the extension, see [Azure SQL migration extension for Azure Data Studio](https://learn.microsoft.com/sql/azure-data-studio/extensions/azure-sql-migration-extension)

## Azure Migrate

Azure Migrate is a comprehensive migration service that supports a wide range of migration scenarios, including SQL Server migration. Azure Migrate provides a suite of tools designed for assessment and migration of on-premises servers, infrastructure, applications, and data at scale, with the purpose of migrating them to Azure. 

These tools include *Azure Migrate: Discovery and assessment*, which evaluates your existing environment, and *Migration and modernization*, which facilitates the actual migration and modernization process. Moreover, Azure Migrate seamlessly integrates with several Azure services, tools, and independent software vendor (ISV) offerings, ensuring a flexible and efficient migration experience tailored to your specific requirements.

Azure Migrate is suitable for larger-scale migrations and scenarios.

> [!NOTE]
> To see a list of integrated tools supported by Azure Migrate, see [Integrated tools](https://learn.microsoft.com/azure/migrate/migrate-services-overview#integrated-tools)

## Data Migration Assistant (DMA)

The Database Migration Assistant (DMA) is a standalone application that helps migrating or upgrading SQL Server databases. It automates the process of checking for compatibility issues and offers recommendations. DMA connects to the source and target servers, identifying breaking changes, deprecated features, and assessing new features for improved performance. It supports both on-premises SQL Server host migrations and migrations to Azure SQL.

:::image type="content" border="false" source="../media/2-data-migration-assistant-start.png" alt-text="Screenshot of the Data Migration Assistant start page.":::

Although DMA supports Azure SQL Managed Instance and SQL Server on Azure Virtual Machines as target options, it's best suited for organizations migrating their databases to Azure SQL Database or SQL Server.

To learn more about Data Migration Assistant, see [Best practices for running Data Migration Assistant](https://learn.microsoft.com/sql/dma/dma-bestpractices)

Regardless of the tool chosen, it's important to evaluate the specific requirements and goals of your migration project. Selecting the appropriate tool based on your scenario helps ensure a successful and efficient SQL Server migration to Azure.