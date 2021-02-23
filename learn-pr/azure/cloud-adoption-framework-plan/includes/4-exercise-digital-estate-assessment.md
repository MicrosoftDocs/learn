In this exercise, we'll demonstrate how Tailwind Traders' used native tools in Azure to evaluate their digital estate. This step-by-step guide includes references that you can recreate as hands-on exercises. For a faster experience skip each exercise and build on the results from Tailwind's digital estate.

## Understand you digital estate

The cloud unlocks a great deal of innovative new potential for your technology portfolio. Your overall strategy will likely include a mixture of workloads that simply need to be migrated to the cloud or slightly modernized. Others that may be better suited more aggressive strategies which leverage cloud native approaches or a significant re-architecture. Even the most cutting edge new applications and innovations will have a dependency on some existing technology. For each of these outcomes, the first step starts with a clear understanding of the assets (applications, data, and VMs) you are responsible for today. Those assets collectively are referred to as your digital estate.

## Tailwind Trader's starting point

It is surprisingly common for organizations to have little more than surface knowledge of their digital estate. Years of technical growth, acquisitions, staffing changes, and changing business priorities leads to large, ambiguous collections of technical assets. Tailwind is no exception.

### What we know about Tailwind's digital estate

- 3 datacenters
    - 1 is owned by the organization
    - 2 are leased through multi-year contracts
- Virtualization is inconsistent
    - Multiple hypervisor vendors has lead to cost and process complexity
- Lack of operating system standardization
    - Mixture of Windows Server 2008 R2, 2012, 2016 and 2019
    - A number of linux OSs and versions are deployed across the environment
    - Most linux OSs are appliance based or are the result of LAMP stack deployments from the dev team
- Operations management is inconsistent
    - Patching is inconsistent
    - Basic data center sprawl has data center resource consumption at 25% over planned targets
    - Back up appliances are past storage capacity. Backups for low priority workloads are local backups only
    - Active monitoring and optimization is limited to mission critical workloads
    - The operations team is over taxed & understaffed
    - The Service Now expert on the team left three years ago, shortly after a vendor completed configuration of the CMDB. Since then, there has been no new discovery or mapping of assets.
- IT is viewed as a cost center
    - The business undervalues the role of IT
    - The high cost of the leased data centers is difficult to justify
    - The business continues to place pressure on IT to reduce cost, after years of budget and staff reductions
- Retail Innovation Team is considered a high value add & source of innovation
    - Each innovation is transitioned to the IT team upon release, adding to the continued cost burdens
- Workloads across the data centers consist of the following:
    - **Retail Innovation:** New innovations that push the boundaries of the retail environment, spanning in-store, online, and throughout the customers' mobile experiences.
    - **Smart storefronts:** Environmental controls, doors, lighting, interactive shelves, in-store displays and advertisements, and over 500 point of sales systems.
    - **Corporate headquarters:** More than 900 employees are hosted in corporate headquarters with technology systems covering best of breed solutions to support processes across real estate, logistics, supply chain, pricing, human resources, employee schedules/tracking, payroll, etc.
    - **End-user workstations:** Mostly desktop-based with a growing percentage of employees opting for mobile, BYOD (bring you own device), in-store kiosks, and virtual desktop solutions.
    - **Central operations:** The IT team provides ongoing technical operations for all IT and retail innovations assets.

### What we don't know

The challenge for Tailwind, is the massive amount of ambiguity just below the surface level information. Years of information silos and no shared platform across technology solutions has resulted in a lot of knowledge gaps. The following are critical questions the team can't answer, yet:

- Servers: How many hypervisors are there across the organization? How many servers or VMs? What resources (cores, memory, & storage) are allocated to each server or VM? Are OSs patched, compliance, and compatible with the target cloud platforms?
- Applications: How many applications are hosted on the servers/VMs? Do those applications actually use the allocation assets? Are those applications self-contained or do they depend on a collection of assets? Is there production traffic to those applications? What is the criticality of each application?
- Data: What data exists across the data estate? How is the data used? Does it support transactional applications? Is the data used for richer analysis? How is the data staged and moved across the environment? Does the data undergo transformation at different points within the environment? Is the data classified based on sensitivity? Is it governed, managed, &/or mastered?
- Business impact: What is the business value of the various workloads? Is there a defined business owner? Are there commitments to operational support? Are there plans to retire any of these workloads? Are there governance, compliance or security constraints on these workloads?

## Evaluate the digital estate

The following process will help clear the ambiguity and aid in building a comprehensive plan for migration based on existing data.

Start by identifying your on-premises infrastructure, applications, and dependencies. This helps you to identify workloads for migration to Azure, and to gather optimized cost projections. The Server Assessment tool helps you to identify the workloads you have in use, dependencies between workloads, and workload optimization.

> [!NOTE]
> There are different roles in the development of an adoption plan. The remainder of this section outlines the technical steps to collect data about the digital estate. If your role is more of a project management or project planning role, skip to the end to see how a sample [data output can shape the plan using information from the Tailwind Traders environment](#output-of-the-exercise).

### Before your start

- Review the support and deployment requirements for agent-based dependency analysis for:
    - [VMware VMs](https://docs.microsoft.com/azure/migrate/migrate-support-matrix-vmware?azure-portal=true#dependency-analysis-requirements-agent-based)
    - [Physical servers](https://docs.microsoft.com/azure/migrate/migrate-support-matrix-physical?azure-portal=true#agent-based-dependency-analysis-requirements)
    - [Hyper-V VMs](https://docs.microsoft.com/azure/migrate/migrate-support-matrix-hyper-v?azure-portal=true#agent-based-dependency-analysis-requirements).
- Make sure you:
    - Have an Azure Migrate project. If you don't, [create](https://docs.microsoft.com/azure/migrate/create-manage-projects?azure-portal=true) one now.
    - Check that you've [added](https://docs.microsoft.com/azure/migrate/how-to-assess?azure-portal=true) the Azure Migrate:Server Assessment tool to the project.
    - Set up an [Azure Migrate appliance](https://docs.microsoft.com/azure/migrate/migrate-appliance?azure-portal=true) to discover on-premises machines, applications, and data using an agentless appliance. The appliance discovers on-premises machines, and sends metadata and performance data to Azure Migrate:Server Assessment. Set up an appliance for:
        - [VMware](https://docs.microsoft.com/azure/migrate/how-to-set-up-appliance-vmware?azure-portal=true) VMs.
        - [Hyper-V](https://docs.microsoft.com/azure/migrate/how-to-set-up-appliance-hyper-v?azure-portal=true) VMs.
        - [Physical servers](https://docs.microsoft.com/azure/migrate/how-to-set-up-appliance-physical?azure-portal=true).
- Next, you'll use the Azure Migrate: Discovery and Assessment tool discovers and assesses on-premises VMware VMs, Hyper-V VMs, VMs hosted on other public clouds and physical servers for migration to Azure. The discovery and assessment tool will pull data from the Azure Migrate appliance, which will help you complete the following:
    - Azure readiness: Assesses whether on-premises machines are ready for migration to Azure.
    - Azure sizing: Estimates the size of Azure VMs or number of Azure VMware nodes after migration.
    - Azure cost estimation: Estimates costs for running on-premises servers in Azure.
    - Dependency analysis: Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

### Workloads in use

Azure Migrate uses a lightweight Azure Migrate appliance to perform agentless discovery of on-premises VMware VMs, Hyper-V VMs, other virtualized machines, and physical servers. Continuous discovery collects machine configuration information, and performance metadata, as well as application data. Here's what the appliance collects from on-premises machines: 

- Machine, disk, and NIC metadata.

- Installed applications, roles, and features.

- Performance data, including CPU and memory utilization, disk IOPS, and throughput.

After collecting data, you can export the application inventory list to find apps, and SQL Server instances running on your machines. You can use the Azure Migrate: Database Assessment tool to understand SQL Server readiness.

:::image type="content" source="../media/concepts-migration-planning/application-inventory-portal.png" alt-text="Application inventory on Portal" border="false":::

:::image type="content" source="../media/concepts-migration-planning/application-inventory-export.png" alt-text="Application inventory export" border="false":::

Along with data discovered with the Server Assessment tool, you can use your Configuration Management Database (CMDB) data to build a view of your server and database estate, and to understand how your servers are distributed across business units, application owners, geographies, etc. This helps decide which workloads to prioritize for migration. 

### Dependencies between workloads

After server discovery, you can [analyze dependencies](https://docs.microsoft.com/azure/migrate/concepts-dependency-visualization?azure-portal=true), to visualize and identify cross-server dependencies, and optimization strategies for moving interdependent servers to Azure. The visualization helps to understand whether certain machines are in use, or if they can be decommissioned, instead of being migrated.  Analyzing dependencies helps ensure that nothing is left behind, and to  surprise outages during migration. With your application inventory and dependency analysis done, you can create high-confidence groups of servers, and start assessing them.

:::image type="content" source="../media/concepts-migration-planning/expand-client-group.png" alt-text="Dependency mapping" border="false":::

### Optimization and sizing

Azure provides flexibility to resize your cloud capacity over time, and migration provides an opportunity for you to optimize the CPU and memory resources allocated to your servers. Creating an assessment on servers you've identity helps you to understand your workload performance history. This is crucial for right sizing Azure VM SKUs, and disk recommendations in Azure.

### Readiness/suitability analysis

You can export the assessment report, and filter on these categories to understand Azure readiness:

- **Ready for Azure**: Machines can be migrated as-is to Azure, without any changes. 
- **Conditionally ready for Azure**: Machines can be migrated to Azure, but need minor changes, in accordance with the remediation guidance provided in the assessment.
- **Not ready for Azure**: Machines can't be migrated to Azure as-is. Issues must be fixed in accordance with remediation guidance, before migration. 
- **Readiness unknown**: Azure Migrate can't determine machine readiness, because of insufficient metadata.

Using database assessments, you can assess the readiness of your SQL Server data estate for migration to Azure SQL Database, or Azure SQL Managed Instances. The assessment shows migration readiness status percentage for each of your SQL server instances. In addition, for each instance you can see the recommended target in Azure, potential migration blockers, a count of breaking changes, readiness for Azure SQL DB or Azure SQL VM, and a compatibility level. You can dig deeper to understand the impact of migration blockers, and recommendations for fixing them.

:::image type="content" source="../media/concepts-migration-planning/database-assessment-portal.png" alt-text="Database assessments" border="false":::

### Sizing Recommendations

After a machine is marked as ready for Azure, Server Assessment makes sizing recommendations that identify the Azure VM SKU and disk type for your machines. You can get sizing recommendations based on performance history (to optimize resources as you migrate), or based on on-premise machine settings, without performance history. In a database assessment, you can see recommendations for the database SKU, pricing tier, and compute level.  

### Get compute costs

Performance-based sizing option in Azure Migrate assessments helps you to right-size VMs, and should be used as a best practice for optimizing workloads in Azure. In addition to right-sizing, there are a few other options to help save Azure costs: 

- **Reserved Instances**: With [reserved instances(RI)](https://azure.microsoft.com/pricing/reserved-vm-instances/?azure-portal=true), you can significantly reduce costs compared to [pay-as-you-go pricing](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/?azure-portal=true).
- **Azure Hybrid Benefit**: With [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/?azure-portal=true), you can bring on-premises Windows Server licenses with active Software Assurance, or Linux subscriptions, to Azure, and combine with reserved instances options.
- **Enterprise Agreement**: Azure [Enterprise Agreements (EA)](https://docs.microsoft.com/azure/cost-management-billing/manage/ea-portal-agreements?azure-portal=true) can offer savings for Azure subscriptions and services.
- **Offers**: There are multiple [Azure Offers](https://azure.microsoft.com/support/legal/offer-details/?azure-portal=true). For example, [Pay-As-You-Go Dev/Test](https://azure.microsoft.com/pricing/dev-test/?azure-portal=true), or [Enterprise Dev/Test offer](https://azure.microsoft.com/offers/ms-azr-0148p/?azure-portal=true), to provide lower rates for dev/test VMs
- **VM uptime**: You can review days per month and hours per day in which Azure VMs run. Shutting off machines when they're not in use can reduce your costs   (not applicable for RIs).
- **Target region**: You can create assessments in different regions, to figure out whether migrating to a specific region might be more cost effective. 

### Visualize data

You can view Server Assessment reports (with Azure readiness information, and monthly cost distribution) in the portal. You can also export assessment, and enrich your migration plan with additional visualizations. You can create multiple assessments, with different combinations of properties, and choose the set of properties that work best for your business.  

:::image type="content" source="../media/concepts-migration-planning/assessment-summary.png" alt-text="Assessments overview" border="false":::

### Evaluate gaps/blockers

As you figure out the apps and workloads you want to migrate, identify downtime constraints for them, and look for any operational dependencies between your apps and the underlying infrastructure. This analysis helps you to plan migrations that meet your recovery time objective (RTO), and ensure minimal to zero data loss. Before you migrate, we recommend that you review and mitigate any compatibility issues, or unsupported features, that may block server/SQL database migration. The Azure Migrate Server Assessment report, and Azure Migrate Database Assessment, can help with this. 

### Prioritize workloads

After you've collected information about your inventory, you can identify which apps and workloads to migrate first. Develop an “apply and learn” approach to migrate apps in a systematic and controllable way, so that you can iron out any flaws before starting a full-scale migration.

To prioritize migration order, you can use strategic factors such as complexity, time-to-migrate, business urgency, production/non-production considerations, compliance, security requirements, application knowledge, etc. 

A few recommendations:

- **Prioritize quick wins**: Use the assessment reports to identify low-hanging fruit, including servers and databases that are fully ready, and require minimal effort to migrate to Azure. The table summarizes a few ways to do this.

    **State** | **Action**
    --- | ---
    **Azure ready VMs** | Export the assessment report, and filter all machines with state *Ready for Azure*. This might be the first group of machines that you lift and shift to Azure, using the [Azure Migrate: Server Migration](https://docs.microsoft.com/azure/migrate/migrate-services-overview?azure-portal=true#azure-migrate-server-migration-tool) tool.
    **End-of-support operating systems** | Export the assessment report, and filter all machines running Windows Server 2008 R2/Windows Server 2008. These operating systems are at the end of support, and only Azure provides a free three years of security updates when you migrate them to Azure. If you combine Azure Hybrid Benefit, and use RIs, the savings could be much higher.
    **SQL Server migration** | Use the database assessment recommendations to migrate databases that are ready for Azure SQL Database, using the Azure Migrate: Database Migration tool. Migrate the databases ready for Azure SQL VM using the Azure Migrate: Server Migration tool.
    **End-of-support software** | Export your application inventory, and filter for any software/extensions that might be reaching end-of-support. Prioritize these applications for migration.
    **Under-provisioned machines** | Export the assessment report, and filter for machines with low CPU utilization (%) and memory utilization (%).  Migrate to a right-sized Azure VM, and save on costs for underutilized resources.
    **Over-provisioned machines** | Export the assessment report and filter for machines with high CPU utilization (%) and memory utilization (%).  Solve capacity constraints, prevent overstrained machines from breaking, and increase performance by migrating these machines to Azure. In Azure, use autoscaling capabilities to meet demand. Analyze assessment reports to investigate storage constraints. Analyze disk IOPS and throughput, and the recommended disk type.

- **Start small, then go big**: Start by moving apps and workloads that  present minimal risk and complexity, to build confidence in your migration strategy. Analyze Azure Migrate assessment recommendations together with your CMDB repository, to find and migrate dev/test workloads that might be candidates for pilot migrations. Feedback and learnings from pilot migrations can be helpful as you begin migrating production workloads.  
- **Comply**: Azure maintains the largest compliance portfolio in the industry, in terms of breadth and depth of offerings. Use compliance requirements to prioritize migrations, so that apps and workloads comply with your national, regional, and industry-specific standards and laws. This is especially true for organizations that deal with business-critical process, hold sensitive information, or are in heavily regulated industries. In these types of organizations, standards and regulations abound, and might change often, being difficult to keep up with.  

## Finalize the migration plan

Before finalizing your migration plan, make sure you consider and mitigate other potential blockers, as follows: 

- **Network requirements**: Evaluate network bandwidth and latency constraints, which might cause unforeseen delays and disruptions to migration replication speed.
- **Testing/post-migration tweaks**: Allow a time buffer to conduct performance and user acceptance testing for migrated apps, or to configure/tweak apps post-migration, such as updating database connection strings, configuring web servers, performing cut-overs/cleanup etc.
- **Permissions**: Review recommended Azure permissions, and server/database access roles and permissions needed for migration.
- **Training**: Prepare your organization for the digital transformation. A solid training foundation is important for successful organizational change. Check out free training on [Microsoft Learn](https://docs.microsoft.com/learn/azure/?ocid=CM_Discovery_Checklist_PDF&azure-portal=true), including courses on Azure fundamentals, solution architectures, and security. Encourage your team to explore [Azure certifications](https://www.microsoft.com/learning/certification-overview.aspx?ocid=CM_Discovery_Checklist_PDF&azure-portal=true).  
- **Implementation support**: Get support for your implementation if you need it. Many organizations opt for outside help to support their cloud migration. To move to Azure quickly and confidently with personalized assistance, consider an [Azure Expert Managed Service Provider](https://www.microsoft.com/solution-providers/search?cacheId=9c2fed4f-f9e2-42fb-8966-4c565f08f11e&ocid=CM_Discovery_Checklist_PDF&azure-portal=true), or [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/?ocid=CM_Discovery_Checklist_PDF&azure-portal=true).  

Create an effective cloud migration plan that includes detailed information about the apps you want to migrate, app/database availability, downtime constraints, and migration milestones. The plan considers how long the data copy will take, and include a realistic buffer for post-migration testing, and cut-over activities.

A post-migration testing plan should include functional, integration, security, and performance testing and use cases, to ensure that migrated apps work as expected, and that all database objects, and data relationships, are transferred successfully to the cloud.  

Build a migration roadmap, and declare a maintenance window to migrate your apps and databases with minimal to zero downtime, and limit the potential operational and business impact during migration.  

### Test Migration

We recommend that you run a test migration in Azure Migrate, before starting a full-scale migration. A test migration helps you to estimate the time involved, and tweak your migration plan. It provides an opportunity to discover any potential issues, and fix them before the full migration.

## Output of the exercise

When this exercise was complete for Tailwind Trader, a total of 3,500 VMs, 1,200 applications, and 300 databases had been identified in the total digital estate. Of those, over 80% are hosted in the leased data centers & must be moved to more modern cloud solutions in less than 24 months.

The migration tooling used to collect this data is capable of migrating all of the identified assets. However, such a migration could place a great deal of stain on your organizations change management capacity. In particular, thoroughly testing over 1,200 applications and validating 300 databases could be a strain on the organization, especially if migration processes and cloud tools are new to the team.

To improve your odds of success, plan a series of subsequent waves of migrations. Identify a small set of prioritized workloads to migrate, test, and release to production in a two week sprint. Follow that with subsequent migration waves until all workloads are migrated. Overtime, you will see a steady increase in the number of workloads that the team can migrate in each sprint, increasing the size of your migration waves.

As a first wave, the following workloads were identified by Tailwind Traders due to the low impact on the business & limited technical complexity:

- **Retail Innovation:**
    - Mobile coupon, an application consisting of a small website and a single independent database running on 3 servers.
- **Smart storefronts:**
    - Video shelf, a video distribution system that pushes video down to a tracked set of displays in a small number of pilot stores. This system uses 20 servers to manage and distribute video.
    - Remote store POS, instances of the POS systems used by remote locations that aren't able to connect to the organizations MPLS for high-speed transactions. This system uses 15 servers.
- **Corporate headquarters:**
    - Employee scheduling app, is a simple app for managing and displaying employee schedules. This system only uses 2 servers, but must connect back to central ERP and HR systems for personally identifiable information.
- **End-user workstations:**
    - Virtual desktops require a 30 server solution to support as many as 500 desktops. Current business demands would suggest a 3x growth of demand, if it were available.
- **Central operations:** 
    - Current backup solution limitations inject a great deal of risk into technology operations. A new solution is required to future proof the organization's operations.

This is a very small subset of the overall digital estate, but it creates a set of measurable and actionable workloads that can be migrated, tested, and deployed to production. This first iteration will build skills for the team & prepare them for larger migration efforts.

In the next unit, we will convert this data into an actionable plan to guide migration and innovation efforts.
