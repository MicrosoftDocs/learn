Your first task is to plan your company's migration to Azure. You need to put together a plan to present to your leadership team, to get their support and approval.

In this unit, you'll cover some considerations and methods that you can use to plan your migration to Azure. Every situation is different, but by following some principles, you can achieve your goals in the best possible way and in the shortest amount of time.

## Azure migration framework

You can use a framework of Assess, Migrate, Optimize, and Monitor as a path for migration. Each stage focuses on a particular aspect of ensuring the success of a migration.

![Stages of migration, Assess, Migrate, Optimize, and Monitor](../media/2-planning-process.png)

Let's look at what's involved at each stage.

![Assess stage](../media/2-assess.png)

### Discovery and evaluation

Start with a full assessment of your current environment. Identify the servers, applications, and services that are in scope for migration. You can then bring in the IT and business teams that work with those services. By bringing these teams in as early as possible in the process, you ensure that they can provide guidance, feedback, and support for the migration.

Next, produce a full inventory and dependency map of servers and services that are in scope for migration. The inventory and map determine how those services communicate with each other. A modern business might have hundreds of applications spread across the estate. Each application must be fully investigated before any work takes place.

For each application, there are multiple migration options:

- **Rehost**: Recreate your existing infrastructure in Azure. Choosing this approach has the least impact because it requires minimal changes. It typically involves moving virtual machines from your data center to virtual machines on Azure.
- **Refactor**: Move services running on virtual machines to platform-as-a-service (PaaS) services. This approach can reduce operational requirements, improve release agility, and keep your costs low. Small enhancements to run more efficiently in the cloud can have large impacts on performance.
- **Rearchitect**: You might be forced to rearchitect some systems so that they can be migrated. Other apps could be changed to become cloud native, or to take advantage of new approaches to software, such as containers or microservices.
- **Rebuild**: You might need to rebuild software if the cost to rearchitect it is more than that of starting from scratch.
- **Replace**: While you're reviewing your estate, it's possible you'll find that third-party applications could completely replace your custom applications. Evaluate software-as-a-service (SaaS) options that can be used to replace existing applications.

Review each application to determine which option is the best fit.

### Involve key stakeholders

Applications are used by specific sections of the business. The owners and superusers of applications have a wealth of experience to call on. Involving these people in the planning stage increases the chance of a successful migration. These resources can offer guidance in areas where the person running the migration project might have knowledge gaps. Often, each area of the business will appoint business owners to manage specific sections.

### Estimate cost savings

Part of the business's plan to migrate to Azure could be to reduce costs, because moving to the cloud offers cost savings over running your own on-premises estate. After you complete the initial scoping exercise, use the Azure Total Cost of Ownership (TCO) Calculator to estimate the real costs of supporting the project in light of the company's longer-term financial goals.

### Identify tools

Several tools and services are available to help you plan and complete the four stages of migration. In some migrations, you may only need to use one or two of these tools.

| Service or tool | Stage | Use |
|------|-------|-------|
| [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-overview)                   | Assess and migrate   | Perform assessment and migration of VMware VMs, Hyper-V VMs, cloud VMs, and physical servers, as well as databases, data, virtual desktop infrastructure, and web applications, to Azure. |
| [Service Map](https://docs.microsoft.com/azure/azure-monitor/insights/service-map)           | Assess   | Maps communication between application components on Windows or Linux. Helps you identify dependencies when scoping what to migrate. |
| [Azure TCO Calculator](https://azure.microsoft.com/pricing/tco/calculator)                   | Assess   | Estimates your monthly running costs in Azure versus on-premises. |
| [Azure Database Migration Service](https://docs.microsoft.com/azure/dms/dms-overview)        | Migrate  | Uses the Data Migration Assistant and the Azure portal to migrate database workloads to Azure. |
| [Data Migration Tool](https://docs.microsoft.com/azure/cosmos-db/import-data)                | Migrate  | Migrates existing databases to Azure Cosmos DB. |
| [Azure Cost Management](https://docs.microsoft.com/azure/cost-management/)                   | Optimize | Helps you monitor, control, and optimize ongoing Azure costs. |
| [Azure Advisor](https://azure.microsoft.com/services/advisor/)                               | Optimize | Helps optimize your Azure resources for high availability, performance, and cost. |
| [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/)                             | Monitor  | Enables you to monitor your entire estate's performance. Includes application-health monitoring via enhanced telemetry, and setting up notifications. |
| [Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/)                       | Monitor  | Provides intelligent security analytics for your applications. |

![Migrate stage](../media/2-migrate.png)

### Deploy cloud infrastructure targets

You'll need destination systems and services on Azure to migrate to. The scope of your migration has been defined as your company's current VMware machines and existing relational databases. In this scenario, you don't need to create the resources in Azure beforehand. The two tools you'll use to do the migration, Azure Migrate and the Azure Database Migration Service, will create the required Azure resources for you.

In other situations, you may need to set up resources in Azure to have them available as a migration destination.

### Migrate workloads

It's often best to start with a small migration instead of migrating a large, business-critical workload. This approach lets you become familiar with the tools, processes, and procedures for migration. It can reduce the risk of issues when you migrate larger workloads. As you become more comfortable with the migration process, you can progress to larger and more business-critical workloads.

Each tool will guide you through the migration. The steps to complete them are covered in later units. At a high level, the steps are:

1. Prepare the source (vCenter Server) and target (Azure) environments.
1. Set up and start the replication between the two.
1. Test that the replication has worked.
1. Fail over from the source servers to Azure.

For the database migrations, the high-level steps are:

1. Assess your on-premises databases.
1. Migrate the schemas.
1. Create and run an Azure Database Migration Service project to move the data.
1. Monitor the migration.

### Decommission on-premises infrastructure

After all migrated workloads have been tested and verified as successfully migrated to Azure, you can decommission all your on-premises systems. Even after you decommission them, it can be useful to keep backups and archive data from the migrated systems. This practice gives you a historical archive of data in case it's needed. This data could be stored on-premises, or in a cloud-storage service such as Azure Blob storage.

![Optimize stage](../media/2-optimize.png)

After your services are migrated, it's important to optimize them to ensure that they're running as efficiently as possible from a cost and performance standpoint.

### Analyze running costs

Use Azure Cost Management to start analyzing your Azure costs at different management scopes. For example, by choosing a subscription in the portal, you can see a breakdown of all the resources for that subscription. Or, you could view a resource group to see all the costs associated with all the resources in just the selected group:

![Screenshot of the cost analysis section of the Azure portal, showing a resource group](../media/2-cost-analysis.png)

### Review opportunities to improve

Azure Cost Management shows you cost-reduction advice from Azure Advisor. The advice includes suggestions like reducing the performance of underused VMs, making use of additional discounts, or reserving resources instead of paying as you go. Azure Advisor also shows you recommendations for network security, high availability, and performance. Review the recommendations that Advisor presents to further optimize your environment.

![Monitor stage](../media/2-monitor.png)

### Integrate health and performance monitoring

Azure Monitor can capture health and performance information from Azure VMs if you install a Log Analytics agent. You can install the agent on machines running either Windows or Linux, and you can then set up alerting and reporting.

You can set up alerts based on a range of data sources, such as:

- Specific metric values like CPU usage.
- Specific text in log files.
- Health metrics.
- An Autoscale metric.

It's also important to have event logging and visibility into security events across your enterprise. Azure Sentinel provides security information and event-management (SIEM) capabilities, along with artificial intelligence to help you protect against, detect, and respond to security events. This information helps security operations (SecOps) teams triage critical alerts and prioritize work effectively.

The remainder of this module will focus on the Assess and Migrate stages. You'll find additional resources to help you with the Optimize and Monitor stages in the **Learn more** section at the end of this module.
