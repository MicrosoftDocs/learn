Azure includes tools to facilitate the disciplines or phases of the migration process: assess workloads, migrate workloads, and release workloads ("cut over"). Those tools start with Azure Migrate, but they also include integrated Microsoft and partner tools.

## Azure Migrate

Azure Migrate provides a unified migration platform: a single portal to start, run, and track your migration to Azure. In the Azure Migrate hub, you can assess and migrate:

- **Servers:** Assess on-premises servers or virtual machines (VMs) running on other clouds and migrate them to Azure Virtual Machines or Azure VMware Solution
- **Databases:** Assess on-premises databases and migrate them to Azure SQL Database or Azure SQL Managed Instance
- **Web applications:** Assess on-premises web applications and migrate them to Azure App Service by using App Service Migration Assistant
- **Virtual desktops:** Assess your on-premises virtual desktop infrastructure (VDI) and migrate it to Azure Virtual Desktop
- **Data:** Migrate large amounts of data to Azure quickly and cost-effectively by using Azure Data Box products

## Integrated tools

The Azure Migrate hub includes the following tools. These tools help facilitate the technical aspects of each discipline or phase of the migration.

| **Tool** | **Assess or migrate** | **Details** |
|--|--|--|
| **Azure Migrate: Discovery and Assessment** | Assess servers | Discover and assess on-premises VMware VMs, Hyper-V VMs, and physical servers in preparation for migration to Azure. You can also use this tool to assess servers from other cloud platforms with a view to migrate to Azure. |
| **Azure Migrate: Server Migration** | Migrate servers | Migrate VMware VMs, Hyper-V VMs, physical servers, other virtualized machines, and public cloud VMs to Azure. |
| **Data Migration Assistant** | Assess SQL Server databases for migration to SQL Database, SQL Managed Instance, or Azure VMs running SQL Server | Data Migration Assistant helps pinpoint potential problems that block migration. It identifies unsupported features, new features that can benefit you after migration, and the right path for database migration. |
| **Azure Database Migration Service** | Migrate on-premises databases to SQL Database, SQL Managed Instance, or Azure VMs running SQL Server | This tool enables a seamless migration from multiple database sources to Azure data platforms with minimal downtime. |
| **Movere** | Assess servers | This tool helps to provide data and insights needed to plan cloud migrations. |
| **Azure App Service Migration Assistant** | Assess on-premises web apps and migrate them to Azure | Use this tool to assess on-premises websites for migration to Azure App Service. Use App Service Migration Assistant to migrate .NET and PHP web apps to Azure. |
| **Azure Data Box** | Migrate offline data | Use Azure Data Box products to move large amounts of offline data to Azure. |

> [!NOTE]
> If you're in Azure Government, external integrated tools and independent software vendor (ISV) offerings can't send data to Azure Migrate projects. You can use tools independently.

### Discovery and Assessment

Here are more details about what the Discovery and Assessment tool in Azure Migrate does:

- **Azure readiness:** Assesses whether on-premises machines are ready for migration to Azure
- **Azure sizing:** Estimates the size of Azure VMs or the number of Azure VMware nodes after migration
- **Azure cost estimation:** Estimates costs for running on-premises servers in Azure
- **Dependency analysis:** Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure

Discovery and Assessment uses a lightweight Azure Migrate appliance that you deploy on-premises. The appliance runs on a VM or physical server. You can install it easily by using a downloaded template.

The appliance discovers on-premises machines. It also continually sends machine metadata and performance data to Azure Migrate. The discovery is agentless. Nothing is installed on discovered machines.

After appliance discovery, you can gather discovered machines into groups and run assessments for each group.

### Server Migration

<!-- docutune:ignore "Server Migration" -->

The Server Migration tool in Azure Migrate helps you migrate to Azure:

| Migrate | Details |
|--|--|
| On-premises VMware VMs | Migrate VMs to Azure by using agentless or agent-based migration. For agentless migration, Server Migration uses the same appliance that the Discovery and Assessment tool uses for discovery and assessment of VMware VMs. For agent-based migration, Server Migration uses a replication appliance. |
| On-premises Hyper-V VMs | Migrate VMs running on Hyper-V hosts to Azure by using the Hyper-V replication provider. |
| Physical servers and VMs (in public or private clouds) | You can migrate physical machines to Azure. You can also migrate other virtualized machines, and VMs from other public clouds, by treating them as physical servers for the purpose of migration. Server Migration uses a replication appliance for the migration. |

## ISV integration

Azure Migrate also integrates with these ISV offerings:

| ISV | Feature |
|--|--|
| Carbonite | Migrate servers |
| Cloudamize | Assess servers |
| Corent Technology | Assess and migrate servers |
| Device42 | Assess servers |
| Lakeside | Assess VDI |
| RackWare | Migrate servers |
| Turbonomic | Assess servers |
| UnifyCloud | Assess servers and databases |


