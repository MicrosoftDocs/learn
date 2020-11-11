
For organizations such as Contoso, which are considering moving their on-premises resources to Azure, one of the first and most important steps in migration is planning. In a migration project, the majority of work is usually done in the preplanning phases.

These phases involve a very thorough assessment of:

- The business model.
- The current processing and systems.
- How the business process will resemble in Azure when the migration is completed.

The following table identifies various items that you should consider, and corresponding strategies you should take when defining and determining an overall migration strategy.

|Consideration|Details|
|----------------|------------------------------------------------------------|
|Business drivers|IT Leadership must work closely with business partners to understand what they want to achieve with the migration. The business drivers should focus on addressing business growth, limiting risks, and specifying the extent of the migration.|
|Migration goals|The goals are used to determine the best migration method.|
|Solution design|After identifying your goals and requirements, you design and review a deployment solution, and identify the migration process, including the Azure services that you will use for the migration.|

## Choose a migration strategy

Cloud migration strategies fall under four broad categories:

- Rehost
- Refactor
- Rearchitect
- Rebuild

The strategy you adopt depends on your business drivers and migration goals. You might even adopt multiple patterns. For example, Contoso might choose to rehost simple apps or apps that aren't critical to their business, but rearchitect apps that are more complex and business-critical. The following table describes these patterns.

|Pattern |Definition|When to use|
|---------------|------------------------------------------------------------|------------------------------------------------------------|
|**Rehost**|Often referred to as a *lift-and-shift* migration. This option doesn't require code changes, and allows you to migrate your existing apps to Azure quickly. Each app is migrated as is to reap the benefits of the cloud without the risk and cost associated with code changes.|When you need to move apps quickly to the cloud. When you want to move an app without modifying it. When your apps are designed so they can utilize Azure IaaS scalability after migration. When apps are important to your business, but you don't need immediate changes to the app capabilities.|
|**Refactor**|Often referred to as *repackaging*, refactoring requires minimal changes to apps so they can connect to Azure platform as a service (PaaS) and use cloud offerings. For example, you could migrate existing apps to Azure App Service or Azure Kubernetes Service (AKS). Alternatively, you could refactor relational and nonrelational databases into options such as Azure SQL Database Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB. If your app can easily be repackaged to work in Azure.|If you want to apply innovative DevOps practices provided by Azure, or you're thinking about DevOps using a container strategy for workloads. For refactoring, you need to think about the portability of your existing code base and available development skills.|
|**Rearchitect**|Rearchitecting for migration focuses on modifying and extending app functionality and the code base to optimize the app architecture for cloud scalability. For example, you could break down a monolithic application into a group of microservices that work together and scale easily. Alternatively, you could rearchitect relational and nonrelational databases to a fully managed database solution, such as Azure SQL Database Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB.|When your apps need major revisions to incorporate new capabilities, or to work effectively on a cloud platform. When you want to use existing application investments, meet scalability requirements, apply innovative DevOps practices, and minimize use of virtual machines (VMs).|
|**Rebuild** |Rebuild takes things a step further by rebuilding an app from scratch using Azure cloud technologies. For example, you could build green-field apps with cloud-native technologies such as Azure Functions, Azure AI, Azure SQL Database Managed Instance, and Azure Cosmos DB.|When you want rapid development, and existing apps have limited functionality and lifespan. When you're ready to expedite business innovation (including DevOps practices provided by Azure). When you want to build new applications using cloud-native technologies. When you want to utilize advancements in AI, Blockchain, and Internet of Things (IoT).|

## Migration tools

After a strategy has been selected, Contoso must choose the appropriate migration tool or tools. The following table describes some of the different migration tools that are available for Contoso to use, depending on the migration scenario.

|Tool|Migration scenario|
|----------------------------------|------------------------------------------------------------|
|Azure Migrate: Server Assessment|Performs an assessment for physical servers and on-premises virtual machines running in Hyper-V and VMware environments as preparation for migration to Azure.|
|Azure Migrate: Server Migration|Performs migration for physical Windows servers  and on-premises VMs running in Hyper-V and VMware environments, and other public cloud VMs.|
|Azure Migrate: Database Assessment|Performs an assessment of on-premises Microsoft SQL Server databases as preparation for migration to Azure SQL Database, an Azure SQL Database managed instance, Database managed instance, or Azure VMs running SQL Server.|
|Azure Migrate: Database Migration|Performs an assessment as preparation for migration to Azure VMs running SQL Server, Azure SQL Database, or Azure SQL Database–managed instances.|
|Azure Migrate: Web App Assessment|Performs an assessment of on-premises web apps and migrates them to Azure.|
|Azure Migrate: Data Box|Performs a move of large amounts of offline data to Azure by using Azure Data Box.|
