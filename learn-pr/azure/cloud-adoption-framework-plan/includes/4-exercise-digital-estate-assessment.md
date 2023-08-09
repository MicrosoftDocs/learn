In this exercise, we'll demonstrate how Tailwind Traders used native tools in Azure to evaluate its digital estate. This step-by-step guide includes references that you can re-create as hands-on exercises. For a faster experience, skip each exercise and build on the results from Tailwind Traders' digital estate.

## Understand your digital estate

The cloud unlocks a great deal of innovative potential for your technology portfolio. Your overall strategy will likely include a mixture of workloads that simply need to be migrated to the cloud or slightly modernized. Other workloads might be better suited to more aggressive strategies that use cloud native approaches or a significant re-architecture. Even the most cutting-edge new applications and innovations will have a dependency on some existing technology. For each of these outcomes, the first step starts with a clear understanding of the assets (applications, data, and VMs) you are responsible for today. Those assets collectively are referred to as your *digital estate*.

## Tailwind Traders' starting point

It's surprisingly common for an organization to have little more than surface knowledge of its digital estate. Years of technical growth, acquisitions, staffing changes, and changing business priorities can all lead to large, ambiguous collections of technical assets. Tailwind Traders is no exception.

### Tailwind Traders' digital estate

Here's a list of what we know about the company's digital estate:

- Three datacenters:
  - One is owned by the organization.
  - Two are leased through multiyear contracts.
- Virtualization is inconsistent:
  - Multiple hypervisor vendors have led to cost and process complexity.
- Lack of operating system standardization:
  - Mixture of Windows Server 2008 R2, Windows Server 2012, Windows Server 2016 and Windows Server 2019
  - A number of Linux operating systems and versions are deployed across the environment.
  - Most Linux instances are appliance-based or are the result of LAMP stack deployments from the dev team.
- Operations management is inconsistent:
  - Patching is inconsistent.
  - Basic datacenter sprawl has datacenter resource consumption at 25 percent over planned targets.
  - Backup appliance has exceeded its storage capacity. Backups for low-priority workloads are local backups only.
  - Active monitoring and optimization are limited to mission critical workloads.
  - The operations team is over-taxed and understaffed.
  - The service now expert on the team left three years ago, shortly after a vendor completed configuration of the configuration management database (CMDB). Since then, there has been no new discovery or mapping of assets.
- IT is viewed as a cost center:
  - The business undervalues the role of IT.
  - The high cost of the leased datacenters is difficult to justify.
  - The business continues to place pressure on IT to reduce cost, after years of budget and staff reductions.
- The retail innovation team is considered to add a lot of value and be a source of innovation:
  - Each innovation is transitioned to the IT team upon release, adding to the continued cost burdens.
- Workloads across the datacenters consist of the following:
  - **Retail innovation:** New innovations that push the boundaries of the retail environment, spanning in-store, online, and throughout the customers' mobile experiences.
  - **Smart storefronts:** Environmental controls, doors, lighting, interactive shelves, in-store displays and advertisements, and over 500 point-of-sales systems.
  - **Corporate headquarters:** More than 900 employees are hosted in corporate headquarters. They use technology systems that cover best-of-breed solutions to support processes across numerous areas. These include real estate, logistics, supply chain, pricing, human resources, employee schedules/tracking, and payroll.
  - **End-user workstations:** Mostly desktop-based with a growing percentage of employees opting for mobile, BYOD (bring your own device), in-store kiosks, and virtual desktop solutions.
  - **Central operations:** The IT team provides ongoing technical operations for all IT and retail innovations assets.

### What we don't know

The challenge for Tailwind Traders is the significant ambiguity just below the surface level information. Years of information silos and no shared platform across technology solutions have resulted in a lot of knowledge gaps. The following are critical questions the team can't answer yet:

- **Servers:** How many hypervisors are there across the organization? How many servers or VMs? What resources (cores, memory, and storage) are allocated to each server or VM? Are operating systems patched, in compliance, and compatible with the target cloud platforms?
- **Applications:** How many applications are hosted on the servers/VMs? Do those applications actually use the allocation assets? Are those applications self-contained or do they depend on a collection of assets? Is there production traffic to those applications? What is the criticality of each application?
- **Data:** What data exists across the data estate? How is the data used? Does it support transactional applications? Is the data used for richer analysis? How is the data staged and moved across the environment? Does the data undergo transformation at different points within the environment? Is the data classified based on sensitivity? Is it governed, managed, or mastered?
- **Business impact:** What's the business value of the various workloads? Is there a defined business owner? Are there commitments to operational support? Are there plans to retire any of these workloads? Are there governance, compliance, or security constraints on these workloads?

## Evaluate the digital estate

The following process will help clear the ambiguity and aid in building a comprehensive plan for migration based on existing data.

Start by identifying your on-premises infrastructure, applications, and dependencies. This helps you to identify workloads for migration to Azure and to gather optimized cost projections. Use the server assessment tool in Azure Migrate to identify the workloads you have in use, dependencies between workloads, and workload optimization.

> [!NOTE]
> There are different roles in the development of an adoption plan. The remainder of this section outlines the technical steps to collect data about the digital estate. If your role is more of a project management or project planning role, skip to the end to see how a sample [data output can shape the plan by using information from the Tailwind Traders environment](#output-of-the-exercise).

### Before you start

- Review the support and deployment requirements for agent-based dependency analysis for:

  - [VMware VMs](/azure/migrate/migrate-support-matrix-vmware?azure-portal=true#dependency-analysis-requirements-agent-based)
  - [Physical servers](/azure/migrate/migrate-support-matrix-physical?azure-portal=true#agent-based-dependency-analysis-requirements)
  - [Hyper-V VMs](/azure/migrate/migrate-support-matrix-hyper-v?azure-portal=true#agent-based-dependency-analysis-requirements)
- Make sure you:
  - Have an Azure Migrate project. If you don't, [create](/azure/migrate/create-manage-projects?azure-portal=true) one now.
  - Check that you've [added](/azure/migrate/how-to-assess?azure-portal=true) the server assessment tool to the project.
  - Set up an [Azure Migrate appliance](/azure/migrate/migrate-appliance?azure-portal=true) to discover on-premises machines, applications, and data by using an agentless appliance. The appliance discovers on-premises machines, and sends metadata and performance data to the server assessment tool. Set up an appliance for:
    - [VMware](/azure/migrate/how-to-set-up-appliance-vmware?azure-portal=true) VMs
    - [Hyper-V](/azure/migrate/how-to-set-up-appliance-hyper-v?azure-portal=true) VMs
    - [Physical servers](/azure/migrate/how-to-set-up-appliance-physical?azure-portal=true)
- Next, you'll use the discovery and assessment tool in Azure Migrate to discover and assess the following for migration to Azure: on-premises VMware VMs, Hyper-V VMs, VMs hosted on other public clouds, and physical servers. The discovery and assessment tool pulls data from the Azure Migrate appliance, which will help you complete the following:
  - **Azure readiness:** Assesses whether on-premises machines are ready for migration to Azure.
  - **Azure sizing:** Estimates the size of Azure VMs or number of Azure VMware nodes after migration.
  - **Azure cost estimation:** Estimates costs for running on-premises servers in Azure.
  - **Dependency analysis:** Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

### Workloads in use

Azure Migrate uses a lightweight Azure Migrate appliance to perform agentless discovery of on-premises VMware VMs, Hyper-V VMs, other virtualized machines, and physical servers. Continuous discovery collects machine configuration information, and performance metadata, as well as application data. Here's what the appliance collects from on-premises machines:

- Machine, disk, and NIC metadata.

- Installed applications, roles, and features.

- Performance data, including CPU and memory utilization, disk IOPS, and throughput.

After collecting data, you can export the application inventory list to find applications and SQL Server instances running on your machines. You can use the database assessment tool in Azure Migrate to understand SQL Server readiness.

:::image type="content" source="../media/concepts-migration-planning/application-inventory-portal.png" alt-text="Screenshot that shows the application inventory on the portal." border="false":::

:::image type="content" source="../media/concepts-migration-planning/application-inventory-export.png" alt-text="Screenshot that shows the application inventory export." border="false":::

<!-- docutune:ignore "Server Assessment" -->

Along with data discovered via the server assessment tool, you can use your CMDB data to build a view of your server and database estate. This helps you understand how your servers are distributed across business units, application owners, and geographies. You can then decide which workloads to prioritize for migration.

### Dependencies between workloads

After server discovery, you can [analyze dependencies](/azure/migrate/concepts-dependency-visualization?azure-portal=true) to visualize and identify cross-server dependencies and understand optimization strategies for moving interdependent servers to Azure. The visualization helps to understand whether certain machines are in use, or if they can be decommissioned instead of being migrated. Analyzing dependencies helps ensure that nothing is left behind, and helps avoid surprise outages during migration. With your application inventory and dependency analysis done, you can create high-confidence groups of servers and start assessing them.

:::image type="content" source="../media/concepts-migration-planning/expand-client-group.png" alt-text="Diagram that shows dependency mapping." border="false":::

### Optimization and sizing

Azure provides flexibility to resize your cloud capacity over time, and migration provides an opportunity for you to optimize the CPU and memory resources allocated to your servers. Creating an assessment on servers you've identified helps you to understand your workload performance history. This is crucial for right-sizing Azure VM SKUs and disk recommendations in Azure.

### Readiness and suitability analysis

You can export the assessment report and filter on these categories to understand Azure readiness:

- **Ready for Azure:** Machines can be migrated as-is to Azure, without any changes.
- **Conditionally ready for Azure:** Machines can be migrated to Azure, but need minor changes in accordance with the remediation guidance provided in the assessment.
- **Not ready for Azure:** Machines can't be migrated to Azure as-is. Issues must be fixed in accordance with remediation guidance before migration.
- **Readiness unknown:** Azure Migrate can't determine machine readiness, because of insufficient metadata.

Using database assessments, you can assess the readiness of your SQL Server data estate for migration to Azure SQL Database, or Azure SQL Managed Instance. The assessment shows the migration readiness status percentage for each of your SQL Server instances. In addition, for each instance you can see the recommended target in Azure, potential migration blockers, a count of breaking changes, readiness for Azure SQL Database or an Azure SQL Database VM, and a compatibility level. You can dig deeper to understand the impact of migration blockers, and get recommendations for fixing them.

:::image type="content" source="../media/concepts-migration-planning/database-assessment-portal.png" alt-text="Screenshot that shows database assessments." border="false":::

### Sizing recommendations

After a machine is marked as ready for Azure, the server assessment tool makes sizing recommendations that identify the Azure VM SKU and disk type for your machines. You can get sizing recommendations based on performance history (to optimize resources as you migrate), or based on on-premises machine settings without performance history. In a database assessment, you can see recommendations for the database SKU, pricing tier, and compute level.

### Get compute costs

The performance-based sizing option in Azure Migrate assessments helps you to right-size VMs, and should be used as a best practice for optimizing workloads in Azure. In addition to right-sizing, there are a few other options to help save Azure costs:

- **Reserved Instances:** With [Reserved Instances](https://azure.microsoft.com/pricing/reserved-vm-instances/?azure-portal=true), you can significantly reduce costs compared to [pay-as-you-go pricing](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/?azure-portal=true).
- **Azure Hybrid Benefit:** With [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/?azure-portal=true), you can bring on-premises Windows Server licenses with active Software Assurance, or Linux subscriptions, to Azure. You can combine this with Reserved Instances options.
- **Enterprise Agreement:** Azure [Enterprise Agreements (EA)](/azure/cost-management-billing/manage/ea-portal-agreements?azure-portal=true) can offer savings for Azure subscriptions and services.
- **Offers:** There are multiple [Azure offers](https://azure.microsoft.com/support/legal/offer-details/?azure-portal=true). For example, [Pay-As-You-Go Dev/Test](https://azure.microsoft.com/pricing/dev-test/?azure-portal=true), or [Enterprise Dev/Test offer](https://azure.microsoft.com/offers/ms-azr-0148p/?azure-portal=true), provide lower rates for dev/test VMs.
- **VM uptime:** You can review days per month and hours per day in which Azure VMs run. Shutting off machines when they're not in use can reduce your costs.
- **Target region:** You can create assessments in different regions, to determine whether migrating to a specific region might be more cost effective.

### Visualize data

You can view server assessment reports (with Azure readiness information and monthly cost distribution) in the portal. You can also export assessments and enrich your migration plan with additional visualizations. You can create multiple assessments with different combinations of properties, and choose the set of properties that works best for your business.

:::image type="content" source="../media/concepts-migration-planning/assessment-summary.png" alt-text="Screenshot that shows the assessments overview." border="false":::

### Evaluate gaps and blockers

As you determine the applications and workloads you want to migrate, you'll identify downtime constraints for them and look for any operational dependencies between your applications and the underlying infrastructure. This analysis helps you to plan migrations that meet your recovery time objective (RTO) and ensure minimal to zero data loss. Before you migrate, review and mitigate any compatibility issues or unsupported features that might block the migration. The server assessment report and the database assessment tool are particularly helpful with this.

### Prioritize workloads

After you've collected information about your inventory, you can identify which applications and workloads to migrate first. Develop an "apply and learn" approach to migrate apps in a systematic and controllable way, so that you can iron out any flaws before starting a full-scale migration.

To prioritize migration order, consider factors such as complexity, time-to-migrate, business urgency, production considerations, compliance, security requirements, and application knowledge.

Here are a few recommendations:

- **Prioritize quick wins:** Use the assessment reports to identify low-hanging fruit, including servers and databases that are fully ready and require minimal effort to migrate to Azure. The following table summarizes a few ways to do this.

    **State** | **Action**
    --- | ---
    **Azure-ready VMs** | Export the assessment report and filter all machines with state *Ready for Azure*. This might be the first group of machines that you move to Azure by using the [Azure Migrate: Server Migration](/azure/migrate/migrate-services-overview?azure-portal=true#azure-migrate-server-migration-tool) tool.
    **End-of-support operating systems** | Export the assessment report and filter all machines running Windows Server 2008 R2 or Windows Server 2008. These operating systems are at the end of support, and only Azure provides a free three years of security updates when you migrate them to Azure.
    **SQL Server migration** | Use the database assessment recommendations to migrate databases that are ready for Azure SQL Database. Migrate the databases ready for Azure SQL Database VM.
    **End-of-support software** | Export your application inventory and filter for any software or extensions that might be reaching end-of-support. Prioritize these applications for migration.
    **Under-provisioned machines** | Export the assessment report and filter for machines with low CPU utilization and memory utilization (measured as percentages). Migrate to a right-sized Azure VM and save on costs for underutilized resources.
    **Over-provisioned machines** | Export the assessment report and filter for machines with high CPU utilization and memory utilization. Solve capacity constraints, prevent overstrained machines from breaking, and increase performance by migrating these machines to Azure. In Azure, use autoscaling capabilities to meet demand. Analyze assessment reports to investigate storage constraints. Analyze disk IOPS and throughput, and the recommended disk type.

- **Start small, then go big:** Start by moving applications and workloads that present minimal risk and complexity to build confidence in your migration strategy. Analyze Azure Migrate assessment recommendations and your CMDB repository to find and migrate dev/test workloads that might be candidates for pilot migrations. Feedback and learnings from pilot migrations can be helpful as you begin migrating production workloads.

- **Comply:** Azure maintains the largest compliance portfolio in the industry in terms of breadth and depth of offerings. Use compliance requirements to prioritize migrations so that applications and workloads comply with your national/regional and industry-specific standards and laws. This is especially true for organizations that deal with business-critical processes, hold sensitive information, or are in heavily regulated industries. In these types of organizations, standards and regulations abound, might change often, and can be difficult to keep up with.

## Finalize the migration plan

Before finalizing your migration plan, make sure you consider and mitigate other potential blockers, as follows:

- **Network requirements:** Evaluate network bandwidth and latency constraints, which might cause unforeseen delays and disruptions to migration replication speed.
- **Testing/post-migration tweaks:** Allow a time buffer to conduct performance and user acceptance testing for migrated applications, or to configure and tweak applications post-migration. For example, you might need to update database connection strings, configure web servers, or perform cut-overs or cleanup.
- **Permissions:** Review recommended Azure permissions and server and database access roles and permissions needed for migration.
- **Training:** Prepare your organization for the digital transformation. A solid training foundation is important for successful organizational change. Check out free training on [Microsoft Learn](/training/azure/?azure-portal=true&ocid=CM_Discovery_Checklist_PDF), including courses on Azure fundamentals, solution architectures, and security. Encourage your team to explore [Azure certifications](/certifications/?azure-portal=true&ocid=CM_Discovery_Checklist_PDF).
- **Implementation support:** Get support for your implementation if you need it. Many organizations opt for outside help to support cloud migration. To move to Azure quickly and confidently with personalized assistance, consider an [Azure Expert Managed Service Provider](https://www.microsoft.com/solution-providers/search?cacheId=9c2fed4f-f9e2-42fb-8966-4c565f08f11e&ocid=CM_Discovery_Checklist_PDF&azure-portal=true), or [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/?ocid=CM_Discovery_Checklist_PDF&azure-portal=true).

Create an effective cloud migration plan that includes detailed information about the applications you want to migrate, application and database availability, downtime constraints, and migration milestones. The plan considers how long the data copy will take and includes a realistic buffer for post-migration testing and cut-over activities.

A post-migration testing plan should include functional, integration, security, and performance testing and use cases. This helps you ensure that migrated applications work as expected, and that all database objects and data relationships are transferred successfully to the cloud.

Build a migration roadmap. Declare a maintenance window to migrate your applications and databases with minimal to zero downtime, and to limit the potential operational and business impact during migration.

### Test migration

We recommend that you run a test migration in Azure Migrate before starting a full-scale migration. A test migration helps you to estimate the time involved and tweak your migration plan. It provides an opportunity to discover any potential issues and fix them before the full migration.

## Output of the exercise

For Tailwind Traders, a total of 3,500 VMs, 1,200 applications, and 300 databases had been identified in the total digital estate. Of those, over 80 percent are hosted in the leased datacenters and must be moved to cloud solutions in less than 24 months.

The migration tooling used to collect this data is capable of migrating all of the identified assets. However, such a migration can place a great deal of strain on the change-management capacity of your organization. In particular, thoroughly testing over 1,200 applications and validating 300 databases can strain an organization, especially if migration processes and cloud tools are new to the team.

To improve your odds of success, plan a series of subsequent waves of migrations. Identify a small set of prioritized workloads to migrate, test, and release to production in a two-week sprint. Follow that with subsequent migration waves until all workloads are migrated. Over time, you will see a steady increase in the number of workloads that the team can migrate in each sprint, increasing the size of your migration waves.

As a first wave, the following workloads were identified by Tailwind Traders due to the low impact on the business and limited technical complexity:

- **Retail innovation:**
  - Mobile coupon, an application consisting of a small website and a single independent database running on 3 servers.
- **Smart storefronts:**
  - Video shelf, a video distribution system that pushes video down to a tracked set of displays in a small number of pilot stores. This system uses 20 servers to manage and distribute video.
  - Remote store POS, instances of the POS systems used by remote locations that aren't able to connect to the organization's MPLS for high-speed transactions. This system uses 15 servers.
- **Corporate headquarters:**
  - Employee scheduling application, a simple application for managing and displaying employee schedules. This system only uses two servers, but must connect back to central ERP and HR systems for customer content.
- **End-user workstations:**
  - Virtual desktops require a 30-server solution to support as many as 500 desktops. Current business demands would suggest a 3x growth of demand, if it were available.
- **Central operations:**
  - Current backup solution limitations inject a great deal of risk into technology operations. A new solution is required to future-proof the organization's operations.

This is a very small subset of the overall digital estate, but it creates a set of measurable and actionable workloads that can be migrated, tested, and deployed to production. This first iteration will build skills for the team and prepare them for larger migration efforts.

In the next unit, we will convert this data into an actionable plan to guide migration and innovation efforts.
