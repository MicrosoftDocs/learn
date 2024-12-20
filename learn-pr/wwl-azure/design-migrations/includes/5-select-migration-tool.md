After you assess Tailwind Traders on-premises workloads, you can begin to consider how to migrate those workloads to Azure. There are several tools in Azure Migrate for migrating your workloads, depending on your specific requirements. In this unit, we take a closer look at Azure Migrate and also explore Azure Resource Mover.

## Azure Migrate 

As we reviewed in the previous unit, Azure Migrate is a set of features located in a centralized hub that you can use to assess and migrate different workloads to Azure. You can use Azure Migrate to perform the migration of workloads, including applications and virtual machines. Workloads that can be migrated to Microsoft Azure include on-premises servers, infrastructure, applications, and data.

:::image type="content" source="../media/discover-assess.png" alt-text="Screenshot that shows Azure Migrate: Discovery and assessment tools." border="false":::

### Things to know about Azure Migrate 

Azure Migrate includes the following components to support the migration process:

- **Unified migration platform**: Azure Migrate provides a single portal where you can perform migration to Azure and track the migration status.

- **Assessment and migration tools**: Azure Migrate supplies several assessment and migration tools, including Server Assessment, Server Migration, and other independent software vendor (ISV) tools.

- **Assessment and migration features for different workloads**: Azure Migrate hub supports several different workloads for migration:
   - Servers: On-premises servers are assessed and migrated to Azure virtual machines. Migration is available for both Linux and Windows servers. 
   - Databases: On-premises databases are assessed and migrated to Azure SQL Database or to an Azure SQL Managed Instance.
   - Web applications: On-premises web applications are assessed and migrated to Azure App Service by using Azure App Service Migration Assistant.
   - Virtual desktops: On-premises virtual desktop infrastructure (VDI) is assessed and migrated to Azure Virtual Desktop.
   - Data: Large volumes of data are migrated to Azure by using Azure Data Box products.

- **Azure Migrate hub tools**: The Azure Migrate hub provides access to many migration tools.

   | Tool | Usage |
   | --- | --- |
   | Azure Migrate: Discovery and assessment: Server Assessment | Discover and assess servers including SQL and web apps |
   | Azure Migrate: Server Migration | Migrate servers |
   | App Service Migration Assistant  | Migrate .NET web apps from Windows OS to App Service |
   | SQL Server Data Migration Assistant (DMA) | Assess SQL Server databases for migration to Azure SQL Database, Azure SQL Managed Instance, or Azure virtual machines running SQL Server |
   | Azure Database Migration Service | Migrate on-premises databases to Azure virtual machines running SQL Server, Azure SQL Database, or SQL Managed Instances |
   | Web app migration assistant | Assess on-premises web apps and migrate them to Azure |
   | Azure Data Box | Migrate offline data |

## Azure Resource Mover

Azure Resource Mover is a tool that helps move your Azure resources between subscriptions, resource groups, and regions. Azure Resource Mover provides the following advantages:

- A single location for moving resources.
- Simplicity and speed in moving resources.
- A consistent interface and procedure for moving different types of Azure resources.
- A way to identify dependencies across resources that you want to move.
- Automatic clean-up of resources in the source region.
- The ability to test a move operation before you commit it.

### Things to consider when migrating with Azure Resource Mover

You can use Azure Resource Mover in two ways:

- **Before you migrate**, to organize your resources.

- **After you migrate**, to optimize your resource organization. 

> [!Tip]
> After you migrate your workloads to Azure, consider using Azure Resource Mover to move any of your recently migrated resources across subscriptions, regions or resource groups.