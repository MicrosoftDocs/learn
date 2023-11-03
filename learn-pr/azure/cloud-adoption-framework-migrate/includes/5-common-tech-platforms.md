During any organization's migration, you need to be prepared for various technology platforms. Most migrations start with Windows and SQL Server assets, but most datacenters in operation today also have several non-Windows-based platforms.

This unit outlines Microsoft's unified migration approach. This approach ensures that all workloads have a clear path to cloud migration, regardless of the underlying technology platform.

## Unified migration focus

Most migration teams are aware of the capabilities of Azure Migrate and the Azure Migrate hub to facilitate migration of Windows and SQL Server assets. But before you begin a migration, it's important to familiarize yourself with the other technology platforms that can use the same migration factory approach or the same migration process.

The following diagram and table outline several scenarios that follow the same iterative Migrate methodology for migration and modernization. The summary at the end of this module includes links for continued learning on each of these technology platforms.

:::image type="content" source="../media/one-migrate.png" alt-text="Diagram that shows the variety of technology platforms supported in the migration process." border="false":::

*Figure 1: Technology platforms that the Migrate methodology supports.*

| Virtual machines | Applications | Data | Hybrid | Technology platforms | Additional scenarios
|---|---|---|---|---|---|
| Servers running Windows Server | ASP.NET | SQL Server | Azure Stack | SAP (classic and HANA) | Secure workloads |
| Linux servers | Java  | Open-source systems (OSS) databases | VMware | Kubernetes | Multitenant environments |
| Virtual desktops | PHP | Analytics |  | Mainframes | NetApp |

## Preparing for common tech platforms

Each technology platform might have subtle differences in how the migration should be executed. Later in this module, you can bookmark the links in the summary for a reference on those considerations. For now, this unit can help you understand the ways a technology platform might affect your migration at a high level.

Here are a few examples to illustrate the impact:

- **Assess workloads**: During assessment of the workloads in each wave, the architects are looking primarily for Azure compatibility and dependencies between assets. However, they should also look for compatibility with modernization and optimization opportunities.

  In the Tailwind Traders story, the team evaluates each of its databases for compatibility with Azure SQL Database to minimize the amount of infrastructure dedicated to data hosting. The OSS databases provide several potential modernizations, thanks to the various database formats that Azure SQL Database supports.

- **Deploy workloads**: During migration, or deployment as it's also known, the team primarily uses the Azure Migrate tool to migrate the assets such as VMs, applications, and data to Azure. Some technology platforms might require complimentary tooling.

  When the Tailwind Traders team migrates its SAP platform, it adds **SAP Database Migration Option (DMO)** to its migration toolbox to ensure a smooth migration to SAP HANA in Azure.

- **Release workloads**: After each technology platform and workload is migrated to Azure, the team will need to test, optimize, and release production traffic to its newly migrated workloads. Some platforms might require a bit of diversity in the monitoring tools to help the team gain clarity and get visibility into workload operations.

  When the Tailwind Traders team migrates its virtual desktops, it's likely to use an Azure Migrate partner solution, like Lakeside Software. Using such a partner solution helps provide a great user experience by tracking performance and identifying other workloads for migration.

## Preparing for diverse tech platforms in your sprint plan

The same methodology applies to each of these technology platforms. During initial cloud-adoption planning, little effort is applied to prepare for these differences. The individual technology platforms typically don't materially affect that level of planning.

However, there are subtle differences in the underlying tasks required to be successful with some of these platforms. Those differences are addressed in the following critical planning activities, which aid in sprint planning:

- **Priority alignment**: The overall cloud-adoption plan outlines the sequence of workloads to be migrated based on the business impact, but the priority must also consider the team's ability to execute.

  Before migration teams begin any sprint, they should evaluate the technology platforms required to migrate each workload. When possible, they should rearrange migration priorities to group workload waves based on the technology platform. For example: migrate Windows and SQL Server instances in sprints 1-3, then migrate Linux servers and OSS data in sprints 4-6.

  > [!IMPORTANT]
  > Realigning priorities in this way is not always applicable. There might be situations that require a mixture of Windows and OSS assets to migrate a workload. In those situations, it's best to keep the workload contained as a single deliverable. You might want to move more complex workloads to a later sprint to ensure that the team has time to develop the required skills.

- **Modernization review**: If your migration groups all three task areas (assess, deploy, and release) into a single migration team and single migration sprint, then you should include a modernization review into each sprint plan.

  In this type of review, the team evaluates the assets to be migrated with a focus on modernization to platform as a service (PaaS) options. For example, should SQL Server or OSS databases be converted to Azure SQL Database to minimize dependence on infrastructure? Should the application be moved from an infrastructure as a service (IaaS) server to a web app or container instance? Each decision shapes how you engage each of the common technology platforms.
