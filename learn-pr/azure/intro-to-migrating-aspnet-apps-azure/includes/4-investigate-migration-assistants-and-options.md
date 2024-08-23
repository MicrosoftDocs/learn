Analyzing a migration consideration involves a review of all the various available options. In a previous unit, we mentioned hosting services such as IaaS and PaaS. IaaS migration can provide a lift-and-shift option where you create a VM, configure it with the same software and settings as your on-premises environment, and then host it in Azure. IaaS still requires your organization to manage, patch, update, and help secure the software on the VM.

When you have an ASP.NET application that you want to migrate, consider using the PaaS option to achieve the greatest benefit from the automation and scalability on Azure. For the PaaS solution with ASP.NET applications, the discussion turns to using Azure App Service.

## What is Azure App Service?

Azure App Service is an HTTP-based service on Azure that you can use to host web applications and REST APIs. This service provides benefits such as:

- Autoscaling to help your app scale to meet demand, based on the parameters you specify, and then automatically reducing the scale when demand decreases.

- High availability to help ensure that your application remains available in case of server or datacenter failures or downtime. Azure makes use of zones, regions, and availability sets to help achieve this.

- Support on the Windows and Linux platforms.

- Integration with automated deployment models using Azure DevOps or GitHub repos.

### How does Azure App Service host ASP.NET apps?

You can use Azure App Service to host your ASP.NET application in an App Service plan. The App Service plan will define a set of compute resources for your ASP.NET application. Think of the compute resources as being similar to an on-premises server farm. The compute resources will consist of VMs that contain the software that's necessary to host your application. This might be a VM running a Windows Server product with IIS hosting the app.

:::image type="content" source="../media/4-web-app-azure.png" alt-text="Diagram of web app architecture hosted on Azure with app plan, DNS, resource group, and databases.":::

The app will use other resources as well, such as:

- Networking resources to provide access to the web application through the standard port 80 or HTTPS port 443. Networking also provides options for DNS and public IP addressing configurations.
- Monitoring and logging options for the service.
- Access control through Microsoft Entra ID and role-based access control (RBAC).
- Other options that are available, depending on your required configuration for the specific application such as database access and the scaling and availability options.
- A storage option for various files needed to host the application.

## What is Azure SQL Database?

Azure SQL Database is an intelligent, scalable, relational database service built for the cloud. It's a fully managed SQL database service that manages patching, upgrading, and backups without user intervention. You can select from two deployment models for your Azure SQL database: a single database or an elastic pool.

### Single database model

A single database deployment model is similar to a single, contained database in an on-premises SQL Server database engine. In the Azure SQL Database single deployment model, you get the full managed option mentioned earlier in this unit. It's an isolated database for your applications' data needs.

### Elastic pool model

The elastic pool is a collection of single databases that share a set of resources, such as memory and CPU. If necessary, you can move single databases out of the elastic pool and move other single databases into the pool.

There are various service tiers and compute sizes that help customize the Azure SQL Database deployment to your specific application needs. For example, you can start with a single small database to meet your existing needs and help keep costs low. As your application needs grow, you can upgrade the service tier to provide dynamic scalability options to help meet demand on the application and data access. The dynamic scaling allows you to bring on resources to manage the scale when needed and then reduce the scale when demands drop off, which helps keep costs lower.

### Compare Azure SQL Database with SQL Server

Comparing an on-premises SQL Server database engine with Azure SQL Database can help highlight the benefits of using Azure.

With an on-premises SQL Server database engine, you:

- Require your IT department to acquire the server hardware.

- Install the operating system.

- Install the database engine.

- Manage patches.

- Configure firewall security.

- Manage database access.

- Manage database backup.

- Manage disaster recovery.

- Perform all the preceding tasks again for new hardware when the compute resources are not enough to meet demand.

When you use Azure SQL Database, you:

- Create a database instance on Azure using your chosen deployment model.

- Migrate your data to the new instance.

- Configure the application access.

- Configure scalability options if needed.

- Enjoy the benefits of a managed environment.

### Hybrid data scenarios

Azure Hybrid Benefit is a model that helps reduce your licensing costs for running your SQL workloads in the cloud. You can take advantage of this benefit by using your existing on-premises Software Assurance-enabled licenses for Windows Server and SQL Server on the Azure platform.

This graph demonstrates an example of a SQL Server Enterprise savings.

:::image type="content" source="../media/4-azure-sql-hybrid-savings.png" alt-text="Graph of SQL hybrid savings, depicting enterprise at $3.97 per hour and hybrid at $0.598 per hour. This represents an 85% savings.":::

## What are migration assistance tools?

Microsoft provides a set of migration assistance tools that help you assess your existing environment, highlight issues you might face during the migration, and aid in the actual process of bringing your application and data to the cloud.

### What is Azure Migrate?

Azure Migrate is a free service provided by Microsoft that discovers, assesses, and migrates on-premises systems to Azure. The service helps with performance-based sizing calculations (VM sizing and compute/storage) for the machines that you'll migrate and estimates the ongoing cost of running these machines in Azure. Azure Migrate can assess both Hyper-V and VMware-based VMs, and also assesses physical servers. Azure Migrate also supports the visualization of dependencies for those machines. It helps you create groups of machines that can be assessed together and ultimately migrated to Azure at the same time. Understanding the dependencies gives you confidence that nothing will be left behind.

### What is the Azure Migration Assistant?

The Azure Migration Assistant is a tool you can use to perform the migration of your ASP.NET application to the cloud. It works alongside the App Service Migration Assistant, which is designed to simplify your migration to the cloud by using a free, simple, and fast solution to migrate ASP.NET applications from on-premises to the cloud. With these tools, you can:

- Assess whether your app is a good candidate for migration by running a scan of its public URL.

- Download the Migration Assistant to begin your migration.

- Use the tool to run readiness checks and a general assessment of your app's configuration settings, then migrate your app or site to Azure App Service.

### What is the Data Migration Assistant?

The Data Migration Assistant helps you upgrade to a modern data platform by detecting compatibility issues that can impact database functionality in your new version of SQL Server or Azure SQL Database. The assistant recommends performance and reliability improvements for your target environment and allows you to move your schema, data, and uncontained objects from your source server to your target server.

Key features are:

- Assessing on-premises SQL Server instances to detect issues with a migration that resulted from compatibility issues or a lack of feature support

- Discovering new features in Azure SQL Database of which you can take advantage

- Migrating on-premises SQL Server instances to the cloud

- Assessing on-premises SQL Server Integration Services packages migrating to Azure SQL Database

## Evaluate your existing environment

A critical step in the migration process is evaluating your existing environment. This helps ensure a smooth transition for your migration scenario, and might also help identify potential issues before, during, and after the migration.

### Inventory the existing environment

Taking an inventory of your existing environment helps to identify the servers, applications, and services that are in scope for the migration. Use your IT and business teams that work with those services to help provide guidance, feedback, and support for the migration.

You'll also want to produce a full inventory and dependency map of servers and services that are in scope for migration. The inventory and map determine how those services communicate with each other. They can help define the online environment needs to ensure a successful migration.

### Identify required app changes

Your application will likely require changes to make it work correctly after the migration. For example, your ASP.NET application is accessing a database. The database connection string will likely need a change. A benefit to using Azure is the ability to store your database connection string as a secret in the Azure Key Vault. This protects the authentication parameters in the connection string by "hiding" the connection string behind a secret in the key vault. You can then configure your app to use that secret rather than the connection string directly.

## Estimate costs

A key consideration for any migration scenario is the cost your organization will incur to host the application on Azure. You'll be moving from a cost model that's different from a typical on-premises environment. In the Azure environment, you'll be billed monthly for various consumption costs related to compute, storage, and access costs.

The previous unit discussed the Azure Pricing Calculator, which you can use to help evaluate your estimated spend.

## Evaluate security considerations

Security is, and should be, a top priority in any migration scenario. You might worry about hosting data in an online world, or wonder if your employees will still be able to use their current credentials to access the applications. You're also concerned about security of data from the perspective of compliance with industry standards. Understanding the options available in Azure can help to address these concerns.

### Evaluate security requirements for your app

In an ASP.NET application scenario where the app needs to access a data store, you need to consider how to secure the database while still allowing access to the web frontend. Azure provides virtual networks to help in this regard. Azure virtual networks can help you:

- Build a hybrid infrastructure that you control.

- Bring your own IP addresses and DNS servers.

- Secure your connections with an IPsec virtual private network (VPN) or Azure ExpressRoute.

- Get granular control over traffic between subnets.

- Create sophisticated network topologies using virtual appliances.

- Get an isolated and highly secure environment for your applications.

You might also access applications running on-premises using Active Directory for authentication and identity management. Microsoft Entra Connect enables you to integrate your on-premises directories with Microsoft Entra ID. This means that employees won't be required to have multiple sets of credentials for authentication.

Similar to taking an inventory of your on-premises environment for apps and hardware, you should also map out your existing security requirements and implementation so that you can perform a proper security assessment for the migration scenario. You want to ensure that a cloud-hosted environment will still meet your organization's security needs.

## Explore Azure Pipelines for a migration scenario

Many organizations are adopting DevOps practices for more agile development and faster deployments. One of the key areas that makes this possible in a cloud environment is the native integration between the tools that developers use. Microsoft Visual Studio, GitHub, and App Service integration allow your developers to build and ship changes faster. For ASP.NET applications, remote and live-site debugging provide greater benefit to developers for diagnosing issues in your production environment.
