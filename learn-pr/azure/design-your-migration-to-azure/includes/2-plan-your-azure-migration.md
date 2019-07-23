Your first task is to plan your company's migration to Azure. You need to put together a plan that you can then present to your leadership team to get their support and approval.

In this unit, you'll cover some of the considerations and methods you can use to plan for your migration to Azure. Every situation is different, but by following some principles, you can achieve your goals in the best possible way in the shortest amount of time.

## Plan your migration to Azure

You can use a framework of **Assess**, **Migrate**, **Optimize**, and **Monitor** as a path for migration. Each stage focuses on a particular aspect of ensuring a migration is successful.

![Stages of migration, Assess, Migrate, Optimize, and Monitor](../media/2-planning-process.png)

Let's take a look at what's involved at each phase.

![Assess stage](../media/2-assess.png)

### Discovery and evaluation

Start will a full assessment of your current environment. Identify which servers, applications, and services are in the scope for migration. By identifying the services and systems that may be migrated, you can bring in the IT and business teams that work with these services. Bring these teams in early in the process, to ensure they can provide guidance, feedback, and support for the migration.

Now you can produce a full inventory and dependency map to determine how in scope servers and services communicate. A modern business could have hundreds of applications spread across the estate. Each application needs to be fully investigated before any work takes place.

For each application, there are various options for the migration process. These could be one of the following:

- **Rehost**: Recreate your existing infrastructure in Azure, choosing this approach will have the least impact as it needs minimal changes.
- **Refactor**: Take the opportunity to take advantage of Azure as a PaaS, reducing the time to release software, and reduce the ongoing maintenance costs. Small enhancements to run more efficiently in the cloud can have large impacts on performance.
- **Rearchitect**: You may be forced to rearchitect some systems to enable them to be migrated. Other apps could be changed to become cloud native, or take advantage of new approaches to software, such as containers or microservices.
- **Rebuild**: You may need to rebuild software if the cost to rearchitect is more than starting again from scratch.
- **Replace**: While you're reviewing your estate, there are chances that third-party applications could completely replace your companies bespoke apps. Evaluate software-as-a-service options that can be used to replace the existing application.

Review each application and which of these options is the best fit.

### Involve key stakeholders

Applications are used by specific sections of the business and include application owners and superusers, who have a wealth of experience to call on. Involving these people in the planning stage will increase the chance of a successful migration These resources can offer guidance in areas where the knowledge of the person running the project may have gaps. Often each area of the business will appoint business owners to manage specific sections.

### Estimate cost savings

Part of the business's plan to migrate to Azure could be to reduce costs, as moving to the cloud offers cost savings over running your own on-premises estate. Once the initial scoping exercise has been completed, use the Azure Total Cost of Ownership (TCO) Calculator to estimate the real work costs to support the project and the company's longer term financial goals.

### Identify tools

There are several tools and services available to help you plan and complete the four phases of migration. In some migrations, you may only need to use one or two of the tools.

| Service/Tool | Phase | Use |
|------|-------|-------|
| [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-overview)                   | Assess   | If you're using VMWare vCenter Server (version greater than 5.5) running Windows or Linux on the VMs |
| [Service Map](https://docs.microsoft.com/azure/azure-monitor/insights/service-map)           | Assess   | Maps communication between application components on Windows or Linux. Helps you identify dependencies when scoping what to migrate |
| [Azure TCO Calculator](https://azure.microsoft.com/pricing/tco/calculator)                   | Assess   | Estimate your monthly running costs in Azure |
| [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) | Migrate  | Move VMs from on-premise to Azure |
| [Azure Database Migration Service](https://docs.microsoft.com/azure/dms/dms-overview)        | Migrate  | Uses the Data Migration Assistant and the Azure portal to manage the whole process of moving database workloads to Azure |
| [Azure Data Box](https://docs.microsoft.com/azure/databox-family/)                           | Migrate  | Efficiently move large datasets either offline or online data to Azure |
| [Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-overview)                  | Migrate  | Assess SQL databases for compatibility, then used to perform the migration of schema and data |
| [Data Migration Tool](https://docs.microsoft.com/azure/cosmos-db/import-data)                | Migrate  | Migrate existing databases to Azure Cosmos DB |
| [Azure Cost Management](https://docs.microsoft.com/azure/cost-management/)                   | Optimize | Monitor, control, and optimize ongoing Azure costs |
| [Azure Advisor](https://azure.microsoft.com/services/advisor/)                               | Optimize | Optimize your Azure resources for high availability, performance, and cost |
| [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/)                             | Monitor  | Monitor your entire estates performance, including app  health via enhanced telemetry, and set up notifications |
| [Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/)                       | Monitor  | Intelligent security analytics for your applications |

![Migrate stage](../media/2-migrate.png)

### Deploy target cloud infrastructure

You will need to create the destination systems and services on Azure to migrate to. The scope for your migration has been defined as your company's current VMware machines and existing relational databases. In this scenario, you don't need to pre-create the resources in Azure. The two tools you'll use to do the migration **Azure Site Recovery** and the **Azure Database Migration Service** will create the required Azure resources for you.

In other situations, you may need to set up resources in Azure to have them available as a migration destination.

### Migrate workloads

It's often best to start with a small migration, as opposed to migrating a large, business-critical workload. This allows you to increase familiarity with the tools, processes, and procedures for migration. It can reduce the risk of issues when you migrate larger workloads. As you become more comfortable with the migration process, you can continue to larger and more business-critical workloads.

<!-- Each tool will guide you through the migration, and the steps to complete them are covered in future units. At a high level these steps are:

1. Prepare the source (vCenter Server) and target (Azure) environments.
1. Set up and start the replication between the two.
1. Test that the replication has worked.
1. Failover from the source servers to Azure.

For the Database migrations, the high-level steps are:

1. Assess your on-premises databases.
1. Migrate the schemas.
1. Create and run an Azure Database Migration Service project to move the data.
1. Monitor the migration. -->

### Decommission on-premises infrastructure

Decommission all your on-premise systems once all the migrated workloads have been tested and validated to have been successfully migrated to Azure. Even after decommissioning the systems, it can be beneficial to retain backups and archive data from the migrated systems. This provides you a historical archive of data in the event they are needed. This data could be stored on-premises, or in a cloud storage service, such as Azure blob storage.

![Optimize stage](../media/2-optimize.png)

With your services migrated, it's important to optimize them to ensure they are running as efficiently as possible from a cost and performance standpoint. 

### Analyze running costs

Using **Azure Cost Management** you can start analyzing your Azure costs at any level your choose. For example, by choosing subscriptions in the portal, you can see a breakdown of all the resources for that subscription. Or you could view a resource group, and again see all the costs associated with all the resources in just the selected group.

![Screenshot of the cost analysis section of the Azure portal, showing a resource group](../media/2-cost-analysis.png)

### Review opportunities to improve

Azure Cost Management shows you cost reduction advice from Azure Advisor. The advice includes suggestions like reducing the performance of underutilized VMs, making use of additional discounts, or reserving resources instead of paying as-you-go.

![Monitor stage](../media/2-monitor.png)

### Integrate health and performance monitoring

**Azure Monitor** can capture health and performance information from Azure VMs by installing a Log Analytics agent. The agent can be installed on machines running either Windows or Linux. With the agents installed on your VMs, you can set up alerting and reporting.

You can set up alerts based on a range of data sources, from specific metric values like CPU usage, specific text in log files, health metrics, or an autoscale metric.

### Set up data protection, backup, and disaster recovery

Once everything is up and running, and being monitored, Azure has a good set of tools to protect those workloads. From replicating the infrastructure to handle disaster recovery, to having VMs located around the world to improve performance.
