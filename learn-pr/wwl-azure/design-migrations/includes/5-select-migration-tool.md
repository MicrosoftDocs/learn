After you've assessed Tailwind Traders' on-premises workloads, you should begin to consider how to migrate those workloads to Azure. You can use several tools in Azure Migrate to migrate your workloads, depending on your needs.

### Describe Azure Migrate

Azure Migrate is a set of features located in a centralized hub that you can use to assess and migrate different workloads to Azure. You can use Azure Migrate to perform the migration of workloads, including apps and VMs. Workloads that can be migrated to Microsoft Azure include on-premises servers, infrastructure, applications, and data.

Azure Migrate components include:

- Unified migration platform: A single portal where you can perform migration to Azure and track the migration status.

- Assessment and migration tools: Azure migration tools consist of multiple assessment and migration tools, including Azure Migrate: Server Assessment and Azure Migrate: Server Migration and other independent software vendor (ISV) tools.

- Assessment and migration of different workloads: There are several different workloads that you can migrate with Azure Migrate hub, including:

	- Servers: On-premises servers are assessed and migrated to Azure VMs.

	- Databases: On-premises databases are assessed and migrated to Azure SQL Database or to an Azure SQL Database–managed instance.

	- Web applications: On-premises web applications are assessed and migrated Azure App Service by using the Azure App Service Migration Assistant.

	- Virtual desktops: On-premises virtual desktop infrastructure (VDI) is assessed and migrated to Azure Virtual Desktop.

	- Data: Large volumes of data are migrated to Azure by using Azure Data Box products.

The following table describes the different migration tools you can use, depending on the migration scenario.

| **Tool**| **Migration scenario** |
| - | - |
| Azure Migrate: Server Assessment| Performs an assessment for physical servers and on-premises VMs running in Hyper-V and VMware environments as preparation for migrating to Azure. |
| Azure Migrate: Server Migration| Performs migration for physical servers and on-premises VMs running in Hyper-V, VMware environments, and other public cloud VMs. |
| Azure Migrate: Database Assessment| Performs an assessment of on-premises Microsoft SQL Server databases as preparation for migration to Azure SQL Database, an Azure SQL Database–managed instance, Database–managed instance, or Azure VMs running SQL Server. |
| Azure Migrate: Database Migration| Performs an assessment as preparation for migration to Azure VMs running SQL Server, Azure SQL Database, or Azure SQL Database–managed instances. |
| Azure Migrate: Web App Assessment| Performs an assessment of on-premises web apps and migrates them to Azure. Uses the Azure App Service Migration Assistant to perform assessment and migration. |
| Azure Migrate: Data Box| Performs a move of large amounts of offline data to Azure by using Azure Data Box. |


### What can you do with Azure Migrate?

Azure Migrate can help with several migration scenarios. The one that you select depends on what you’re trying to achieve. The six major migration scenarios are:

- Windows Server workloads

- SQL Server workloads

- Linux workloads

- Windows apps, Java apps and PHP apps

- SAP HANA

- Specialized compute

### Migrate web apps to Azure

Azure Migrate uses the Azure App Service Migration Assistant to assess and migrate your web apps. The Azure App Service Migration Assistant enables you to assess and migrate your on-premises Windows ASP.NET web apps to Azure. By using this assistant, you can:

- Determine whether your app is a suitable migration candidate.

- Run readiness checks to perform a general assessment of the app's configuration settings.

- Migrate the app to the Azure App Service.

The Migration Assistant uses an agent that you install locally, and then use to perform a detailed analysis of your apps. You can then use the tool to migrate those apps to Azure. After the initial assessment of your app is complete, you’re guided through the migration process using a graphical wizard-driven interface.

After moving the app to Azure, you may also consider migrating any connected databases.

>[!IMPORTANT]
> The Migration Assistant migrates your web application and its associated configurations, but does not migrate any backend databases connected to the app. You can use the SQL Migration Tool to complete the migration of your database.

 

### Migrate VMs with Azure Migrate

After you've selected the appropriate server workloads, you're ready to begin the migration. There are four main technical implementation steps involved in moving a server workload to an Azure VM workload using Azure Migrate. These are:

1. Prepare Azure for the Azure Migrate: Server Migration tool.

2. Prepare the on-premises VMs for migration.

3. Replicate the on-premises VMs.

4. Migrate the VMs.

:::image type="content" source="../media/discover-assess.png" alt-text="Discover, analyze dependencies, and assess.":::


### Describe Azure Resource Mover

Azure Resource Mover is a tool that helps move your Azure resources between subscriptions, resource groups, and regions. The tool can be used:

- Before you migrate, to organize your resources.

- After you migrate, to optimize your resource organization. 

:::image type="content" source="../media/resource-mover.png" alt-text="Moving resources as part of the migration plan.":::


Resource Mover provides:

- A single location for moving resources.

- Simplicity and speed in moving resources.

- A consistent interface and procedure for moving different types of Azure resources.

- A way to identify dependencies across resources that you want to move.

- Automatic clean-up of resources in the source region.

- The ability to test a move operation before you commit it.

Consider using Azure Resource Mover when, after migration to Azure, and you need to move any of your recently migrated resources across subscriptions, regions or resource groups.