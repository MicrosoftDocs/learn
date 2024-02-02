Azure includes tools to facilitate the disciplines or phases of the migration process: assess workloads, migrate workloads, and release workloads ("cut over"). Those tools start with Azure Migrate, but they also include integrated Microsoft and partner tools.

## Azure Migrate

Azure Migrate provides a unified migration platform: a single portal to start, run, and track your migration to Azure. In the Azure Migrate hub, you can assess and migrate:

- **Servers, databases and web apps**: Assess on-premises servers including web apps and SQL Server instances and migrate them to Azure.
- **Databases**: Assess on-premises SQL Server instances and databases to migrate them to an SQL Server on an Azure VM or an Azure SQL Managed Instance or to an Azure SQL Database.
- **Web applications**: Assess on-premises web applications and migrate them to Azure App Service and Azure Kubernetes Service.
- **Virtual desktops**: Assess your on-premises virtual desktop infrastructure (VDI) and migrate it to Azure Virtual Desktop.
- **Data**: Migrate large amounts of data to Azure quickly and cost-effectively using Azure Data Box products.

## Integrated tools

The Azure Migrate hub includes the following tools. These tools help facilitate the technical aspects of each discipline or phase of the migration.

**Tool** | **Assess and migrate** | **Details**
--- | --- | ---
**Azure Migrate: Discovery and assessment** | Discover and assess servers including SQL and web apps | Discover and assess on-premises servers running on VMware, Hyper-V, and physical servers in preparation for migration to Azure.
**Migration and modernization** | Migrate servers | Migrate VMware VMs, Hyper-V VMs, physical servers, other virtualized servers, and public cloud VMs to Azure.
**Data Migration Assistant** | Assess SQL Server databases for migration to Azure SQL Database, Azure SQL Managed Instance, or Azure VMs running SQL Server. | Data Migration Assistant is a stand-alone tool to assess SQL Servers. It helps pinpoint potential problems blocking migration. It identifies unsupported features, new features that can benefit you after migration, and the right path for database migration.
**Azure Database Migration Service** | Migrate on-premises databases to Azure VMs running SQL Server, Azure SQL Database, or SQL Managed Instances | This tool enables a seamless migration from multiple database sources to Azure data platforms with minimal downtime.
**Movere** | Assess servers | This tool provides data and insights for planning cloud migrations.
**Web app migration assistant** | Assess on-premises web apps and migrate them to Azure. |  Azure App Service Migration Assistant is a standalone tool to assess on-premises websites for migration to Azure App Service. Use Migration Assistant to migrate .NET and PHP web apps to Azure.
**Azure Data Box** | Migrate offline data | Use Azure Data Box products to move large amounts of offline data to Azure.

> [!NOTE]
> If you're in Azure Government, external integrated tools and independent software vendor (ISV) offerings can't send data to Azure Migrate projects. You can use tools independently.

### Discovery and Assessment

Here are more details about what the Discovery and Assessment tool in Azure Migrate does:

- **Azure readiness**: Assesses whether on-premises machines are ready for migration to Azure.
- **Azure sizing**: Estimates the size of Azure VMs or the number of Azure VMware nodes after migration.
- **Azure cost estimation**: Estimates costs for running on-premises servers in Azure.
- **Dependency analysis**: Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

The Discovery and Assessment tool uses a lightweight Azure Migrate appliance that you deploy on-premises. The appliance runs on a VM or physical server. You can install it easily by using a downloaded template.

The appliance discovers on-premises machines. It also continually sends machine metadata and performance data to Azure Migrate. The discovery is agentless. Nothing is installed on discovered machines.

After appliance discovery, you can gather discovered machines into groups and run assessments for each group.

## ISV integration

Azure Migrate also integrates with these ISV offerings:

**ISV**    | **Feature**
--- | ---
Carbonite | Migrate servers.
Cloudamize | Assess servers.
CloudSphere | Assess servers.
Corent Technology | Assess and migrate servers.
Device42 | Assess servers.
Lakeside | Assess VDI.
RackWare | Migrate servers.
Turbonomic | Assess servers.
UnifyCloud | Assess servers and databases.
Zerto | Migrate servers.
