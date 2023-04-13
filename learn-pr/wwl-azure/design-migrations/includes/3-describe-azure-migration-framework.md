Before you can start migrating Tailwind Traders on-premises workloads to Azure, you should consider creating a migration plan. The plan should identify the workloads to migrate, and the appropriate service or tools to use during the migration. Ideally, your plan should also include details about how to optimize the migrated services.

The Azure migration framework can help you develop your plan and work through your migration. The framework consists of four stages: _Assess_, _Migrate_, _Optimize_, and _Monitor_.

### Stage 1: Assess your on-premises environment

In the first stage, you assess the current on-premises environment:
- Identify your apps, and their related servers, services, and data, that's within scope for migration
- Start to involve stakeholders, such as the IT department and relevant business groups
- Create a full inventory and dependency map of your servers, services, and apps that you're planning to migrate
- Estimate your cost savings by using the Azure Total Cost of Ownership Calculator (TCO)
- Identify appropriate tools and services you can use to perform the four stages

#### Migration strategy patterns

There are four broad strategy patterns for migrating workloads to the cloud: rehost, refactor, rearchitect, and rebuild. The strategy you adopt depends on your business drivers and migration goals. You might consider adopting multiple patterns. You could choose to rehost simple apps or apps that aren't critical to your business, but rearchitect apps that are more complex and business critical.

- **Rehost**: Rehost is often referred to as a _lift and shift migration_. This strategy doesn't require code changes, and allows you to migrate your existing workloads to Azure quickly. Each workload is migrated as is, without the risk and cost associated with code changes. 

- **Refactor**: Refactor is often referred to as _repackaging_. Refactoring requires minimal changes to apps so they can connect to Azure platform as a service (PaaS) and use cloud offerings. You can migrate existing apps to Azure App Service or Azure Kubernetes Service (AKS). Or, you could refactor relational and non-relational databases into other options. Refactor into Azure SQL Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB (if your app can easily be repackaged to work in Azure). 

- **Rearchitect**: Rearchitecting for migration focuses on modifying and extending app functionality and the code base to optimize the app architecture for cloud scalability. You can break down a monolithic application into a group of microservices that work together and scale easily. Or, you could rearchitect relational and non-relational databases to a fully managed database solution. Rearchitect to Azure SQL Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB. 

- **Rebuild**: Rebuild takes things a step further by completely rebuilding an app by using Azure cloud technologies. You can build green-field apps with cloud-native technologies such as Azure Functions, Azure AI, Azure SQL Managed Instance, and Azure Cosmos DB.

The following table lists scenarios for working with the four patterns.

| Rehost | Refactor | Rearchitect | Rebuild |
| --- | --- | --- | --- |
| _Move workloads quickly to the cloud_ <br><br> _Move a workload without modifying it_ <br><br> _For apps designed to take advantage of Azure IaaS scalability after migration_ <br><br> _When workloads are important to your business, but you don't need immediate changes to app capabilities_ | _Apply innovative DevOps practices provided by Azure_ <br><br> _Implement a DevOps container strategy for workloads_ <br><br> _Support portability of your existing code base and available development skills_ | _Your apps need major revisions to incorporate new capabilities_ <br><br> _Your apps need major revisions to work effectively on a cloud platform_ <br><br> _Use existing application investments_ <br><br> _Meet scalability requirements_ <br><br> _Apply innovative DevOps practices_ <br><br> _Minimize use of virtual machines_ | _Rapid development_ <br><br> _Support existing apps with limited functionality and lifespan_ <br><br> _Expedite business innovation by using DevOps practices_ <br><br> _Rebuild with new cloud-native technologies like Azure Blockchain_ <br><br> _Rebuild legacy applications as "no code apps" or "low apps" in the cloud_ |

### Stage 2: Migrate your workloads

After you complete the assessment, you can begin the process of migrating your targeted apps and their related services and data. The migration stage typically consists of the following efforts:

- **Deploy cloud infrastructure targets**. Before you can migrate Tailwind Traders workloads, you need to create the required cloud infrastructure targets. Depending on the tools you use to perform the migration, you might need to create the required Azure resources before you begin the migration. Some tools, such as Azure Migrate and Azure Database Migration Service can create the target Azure resources for you.

- **Migrate workloads**. It's a good idea to pilot your workload migration, and to choose a non-critical app for the pilot. This approach enables you to become familiar with tools, gain experience with processes and procedures, and reduce risk when migrating large or complex workloads.

- **Decommission on-premises infrastructure**: After you're satisfied that your source apps and databases are migrated successfully, you need to decommission the source workloads. Consider retaining the source workload backups and archived data. This data might prove useful as it provides a historical archive. You can store these backups and archives in Azure Blob Storage.

### Stage 3: Optimize your migrated workloads

For the optimization stage, there are three main efforts to focus on for your planning:
- Analyze migration costs for your workloads
- Review recommendations for reducing your costs
- Identify options for improving your workload performance

You can use Microsoft Cost Management (formerly known as Azure Cost Management and Billing) in the Azure portal to analyze your workload costs. This tool is available for the Azure resource group that contains your migrated workloads. You'll find the tool in the **Costs analysis** > **Cost Management** section. The following screenshot shows cost analysis for the last billable period for the `ContosoResourceGroup` resource group. The results display the costs according to service name, region, and resource. You can customize the display results to meet your needs.

:::image type="content" source="../media/cost-analysis.png" alt-text="Screenshot that shows a cost analysis example with estimated costs in the Azure portal.":::

To help reduce your costs, you can use the Azure Advisor features by choosing **Advisor recommendations**. After you analyze your current costs and review the recommendations, you can determine your options for improving your workload performance.

### Stage 4: Monitor your workloads

You can use Azure Monitor to capture health and performance information from your Azure virtual machines. Install the Azure Monitor Logs (formerly known as Log Analytics) agent on target virtual machines, and then set up alerting and reporting.

> [!Note]
> You can install the Azure Monitor Logs agent on machines running Windows or Linux.

You can set up alerts based on a range of data sources:
- Specific metric values like CPU usage
- Specific text in log files
- Health metrics
- Autoscale metrics