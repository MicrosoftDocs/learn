### What is the Azure migration framework?

Before you can start migrating Tailwind Traders' on-premises workloads to Azure, you should consider creating a migration plan. This plan should help you to identify the workloads that you want to migrate. The plan should also help you identify and select the appropriate service or tools to use during the migration.

Ideally, your plan should also include details about how to optimize the migrated services. The Azure migration framework can help you work through your plan and the migration it addresses.

The Azure migration framework consists of four stages:

- Assess

- Migrate

- Optimize

- Monitor

### Assess your on-premises environment

The best place to start is with an assessment of Tailwind Traders' current on-premises environment. During the assessment, you should:

- Identify apps, and their related servers, services, and data, that is within scope for migration.

- Start to involve stakeholders, such as the IT department and relevant business groups.

- Create a full inventory and a dependency map of servers, services, and apps that you're selecting for migration.

- Estimate cost savings by using the Azure Total Cost of Ownership Calculator.

- Identify appropriate tools and services you can use to perform the assessment, migration, optimization, and monitoring stages.

Strategies for migration to the cloud fall into four broad patterns: rehost, refactor, rearchitect, or rebuild. The strategy you adopt depends on your business drivers and migration goals. You might even adopt multiple patterns. For example, you might choose to rehost simple apps or apps that aren't critical to your business, but rearchitect apps that are more complex and business critical.

The following table describes the four patterns.

 

| **Pattern**| **Definition**| **When to use** |
| - | - | - |
| Rehost| Often referred to as a lift and shift migration, this option doesn't require code changes, and allows you to migrate your existing workloads to Azure quickly. Each workload is migrated as is, without the risk and cost associated with code changes.| When you need to move workloads quickly to the cloud, when you want to move a workload without modifying it, when your apps are designed so that they can take advantage of Azure IaaS scalability after migration, and when workloads are important to your business, but you don't need immediate changes to app capabilities. |
| Refactor| Often referred to as repackaging, refactoring requires minimal changes to apps so they can connect to Azure platform as a service (PaaS) and use cloud offerings. For example, you could migrate existing apps to Azure App Service or Azure Kubernetes Service (AKS). Alternatively, you could refactor relational and non-relational databases into options such as Azure SQL Database Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB, but only if your app can easily be repackaged to work in Azure.| If you want to apply innovative DevOps practices provided by Azure, or if you're thinking about DevOps using a container strategy for workloads. For refactoring, you need to think about the portability of your existing code base and available development skills. |
| Rearchitect| Rearchitecting for migration focuses on modifying and extending app functionality and the code base to optimize the app architecture for cloud scalability. For example, you could break down a monolithic application into a group of microservices that work together and scale easily. Alternatively, you could rearchitect relational and nonrelational databases to a fully managed database solution such as Azure SQL Database Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB.| When your apps need major revisions to incorporate new capabilities, or to work effectively on a cloud platform. When you want to use existing application investments, meet scalability requirements, apply innovative DevOps practices, and minimize use of VMs. |
| Rebuild| Rebuild takes things a step further by completely rebuilding an app using Azure cloud technologies. For example, you could build green-field apps with cloud-native technologies such as Azure Functions, Azure AI, Azure SQL Database Managed Instance, and Azure Cosmos DB.| When you want rapid development, and existing apps have limited functionality and lifespan. When you're ready to expedite business innovation by using Azure DevOps practices. When are building new applications using cloud-native technologies, like Azure Blockchain. When you are rebuilding legacy apps as no code or low apps in the cloud. |


Choosing which strategy to use depends on what you’re trying to accomplish.

### Migrate your workloads

After you complete the assessment, you can begin the process of migrating your targeted apps and their related services and data. The migration stage typically consists of the following elements:

**Deploy cloud infrastructure targets**: Before you can migrate Tailwind Traders' workloads, you'll need to create the required cloud infrastructure targets. Depending on the tools you use to perform the migration, you might need to create the required Azure resources before you begin the migration. Some tools, such as Azure Migrate and Azure Database Migration Service, can create the target Azure resources for you.

**Migrate workloads**: It's a good idea to pilot your workload migration, and to choose a non-critical app for the pilot. This approach enables you to:

- Become familiar with tools

- Gain experience with processes and procedures

- Reduce risk when migrating large or complex workloads

Depending on the workload you plan to migrate, the steps used to perform the migration will vary.

**Decommission on-premises infrastructure**: After you’re satisfied that your source apps and databases are migrated successfully, you must decommission those source workloads. Consider retaining the source workload backups and archived data. This data might prove useful as it provides a historical archive. You can store these backups and archives in Azure Blob storage.

 

### Optimize the migrated workloads

During the optimization stage, you should:

- Analyze the costs of the workload migration

- Identify ways to reduce costs

- Seek to improve workload performance

To analyze costs, you can use Cost Management in the Azure portal. Select the Azure resource group in which you're interested (the one which contains the migrated workloads), and then, in the navigation pane, select **Costs analysis** in the **Cost Management** section. The following screenshot shows the cost analysis for the last billable period for a resource group called ContosoResourceGroup. The results display the costs according to service name, region, and resource, although you can customize the results to your needs.

 

:::image type="content" source="../media/cost-analysis.png" alt-text="Cost analysis example with estimated costs.":::



To help to reduce costs, select the **Advisor recommendations** link in the navigation pane. Recommendations, if there are any, are displayed on the details pane.

 

### Monitor your workloads

You can use Azure Monitor to capture health and performance information from your Azure VMs. However, you must first install a Log Analytics agent on target VMs. After you've installed the agent, you can then set up alerting and reporting.

>[!TIP]
>You can install the agent on machines running either Windows or Linux.

You can set up alerts based on a range of data sources, such as:

- Specific metric values like CPU usage

- Specific text in log files

- Health metrics

- An Autoscale metric