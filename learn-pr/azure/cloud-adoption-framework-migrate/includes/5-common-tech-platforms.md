During migration of any organization, you will need to be prepared for various technology platforms. Most migrations start with Windows and SQL server assets. But there are few datacenters in operation today that don't also have several non-windows based platforms. This unit will outline Microsoft's unified migration approach, which ensures that all workloads have a clear path to cloud migration, regardless of the underlying technology platform.

## Unified migration focus

Most migration teams are aware of the capabilities of Azure Migrate and the Azure Migrate Hub to facilitate migration of Windows and SQL Server assets. But before beginning a migration, it is important to familiarize yourself with the other technology platforms that can be completed using the same migration factory approach or the same migration process.

The following diagram and table outline several scenarios that follow the same iterative Migrate methodology for migration and modernization. The summary to this learn module, will include links for continued learning on each of these different technology platforms.

:::image type="content" source="../media/one-migrate.png" alt-text="Variety of technology platforms supported in the migration process" border="false":::

| | | | |
|---------|---------|---------|---------|
| **Virtual machines** | Windows servers | Linux servers | Virtual desktops |
| **Applications** | ASP.NET | Java | PHP |
| **Data** | SQL Server | Open source systems (OSS) databases | Analytics |
| **Hybrid** | Azure Stack | VMware | Containers |
| **Additional scenarios** | Secure workloads | Mainframes | NetApp and SAP HANA |

## Preparing for common tech platforms

Each technology platform may have subtle differences in how the migration should be executed. Bookmark the links in the summary unit of this learn module for a reference on those considerations. For now, understand the ways a technology platform could impact your migration at a high level. The following are a few examples to illustrate the impact.

**Assess workloads:** During assessment of the workloads in each wave, the architects are looking primarily for Azure compatibility and dependencies between assets. But, they should also be looking for compatibility with modernization and optimization opportunities.

In the Tailwind Traders story, the team will be evaluating each of their databases for compatibility with Azure SQL to minimize the amount of infrastructure dedicated to data hosting. The OSS databases will provide several potential modernizations, thanks to the various database formats supported by Azure SQL.

**Migrate workloads** During migration, the team will primarily use the Azure Migrate tool to migrate the assets (VMs, Apps, and Data) to Azure. But, some technology platforms may require complimentary tooling.

When the Tailwind Traders team migrates their SAP platform, they will add **SAP Database Migration Option (DMO)** to their migration toolbox to ensure a smooth migration to SAP/Hana in Azure.

**Release workloads**  Once each technology platform and workload is migrated to Azure, the team will need to test, optimize, and release production traffic to their newly migrated workloads. Some platforms may require a bit of diversity in the monitoring tools required to gain necessary clarity and get visibility into workload operations.

When the Tailwind Traders team migrates their virtual desktops, they'll likely use one of the Azure Migrate partner solutions, like Lakeside Software, to help provide a great user experience by tracking performance and identifying additional workloads for migration.

## Preparing for diverse technology platforms in your sprint plan

The same methodology applies to each of these technology platforms. During initial cloud adoption planning, little effort is applied to prepare for these differences. That level of planning is typically not materially impacted by the individual technology platforms.

However, there are subtle differences to the underlying tasks required to be successful with some of these platforms. Those subtle differences are addressed in the critical planning activities describe below, which will aid in sprint planning.

**Priority alignment:** The overall cloud adoption plan will outline the sequence of workloads to be migrated based on the business impact. But, priority must also consider the team's ability to execute. Before beginning any sprint, the migration team(s) should evaluate the technology platforms required to migrate each workload. When possible, rearrange migration priorities to group workload waves based on the technology platform. For example, Migrate windows and SQL servers in sprint 1-3. Then migrate Linux servers and OSS data in sprints 4-6.  

> [!CAUTION]
> Realigning priorities in this way is not always applicable. There may be situations that require a mixture of Windows and OSS assets to migrate a given workload. In those situations, it is best to keep the workload contained as a single deliverable. But you may wish to move more complex workloads to a later sprint, to ensure the team has time to develop the required skills.

**Modernization review:** If your migration groups all three task areas (Assess, Migrate, and Release) into a single migration team and single migration sprint, then you will want to include a modernization review into each sprint plan. In this type of review, the team will evaluate the assets to be migrated with a focus on modernization to Platform as a Service (PaaS) based options. For example, Should SQL Servers or OSS databases be converted to Azure SQL Database to minimize dependence on infrastructure? Should the application be moved from an Infrastructure as a Service (IaaS) server to a web app or container instance? Each will shape how you engage each of the common technology platforms.
