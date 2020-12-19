
Analyzing a migration consideration involves looking at the various options available. The previous article mentioned the hosting services such as IaaS and PaaS. IaaS migration can provide a lift and shift option where you create a virtual machine (VM), configure it with the same software and settings as your on-premises environment, and then host it in Azure. IaaS still requires your organization to manage, patch, update, and secure the software on the VM.

When you have an ASP.NET application that you want to migrate, consider using the PaaS option to achieve the greatest benefit from the automation and scalability on Azure. For the PaaS solution with ASP.NET applications, the discussion turns to using the Azure App Service.

## What is Azure App Service?

The Azure App Service is an HTTP-based service on Azure that you can take advantage of for hosting web applications and REST APIs. This service provides many benefits such as:

- autoscaling to help your app scale to meet demand, based on parameters you specify, then automatically reduce the scale when demand decreases
- high availability to ensure your application remains available in the event of server or data center failures or downtime. Azure makes use of zones, regions, and availability sets to help achieve this.
- support Windows and Linux platforms
- can integrate with automated deployment models using Azure DevOps or GitHub repos

### How does Azure App Service host ASP.NET apps?

The Azure App Service is used to host your ASP.NET application in an App Service plan. The App Service plan will define a set of compute resources for your ASP.NET application. Think of the compute resources as being similar to an on-premises server farm. The compute resources will consist of virtual machines (VMs) that will contain the software necessary to host your application.  This may be a VM running a Window Server product with Internet Information Services (IIS) hosting the app.

:::image type="content" source="../media/web-app-azure.png" alt-text="Seb app architecture hosted on Azure with app plan, DNS, resource group, and databases":::

Other resources will be used for your app as well such as:

- networking resources - to provide access to the web application through the standard port 80 or https port 443. Networking also provides options for DNS and public IP addressing configurations.
- monitoring and logging options for the service
- access control through Azure Active Directory and role-based access control (RBAC)
- other options are available depending on your required configuration for the specific application such as database access and the aforementioned scaling and availability options
- a storage option for various files needed to host the application

## What is Azure SQL Database?

Azure SQL Database is an intelligent, scalable, relational database service built for the cloud. It is a fully managed SQL database that handles patching, upgrading, and backups without user intervention. You can select from two deployment models for your Azure SQL Database, single database or elastic pool.

A single database deployment model is similar to a single, contained data in an on-premises SQL Server database engine. In the Azure SQL Database single deployment model, you get the full managed option mentioned earlier in this section. It is an isolated database for your applications' data needs.

The elastic pool is a collection of single databases that share a set of resources such as memory and CPU. The single databases that are part of the elastic pool can be moved out of the pool if necessary and other single databases can be moved into the pool.

There are various service tiers and compute sizes that will help customize the Azure SQL Database deployment to your specific application needs. For example, you can start with a single small database to meet your existing needs and helps keep costs low. As your application needs grow, you can upgrade the service tier to provide dynamic scalability options to help meet demand on the application and data access. The dynamic scaling allows you to bring on resources to handle the scale when needed, and then reduce the scale when demands drop off, helping to keep costs lower.

### Compare Azure SQL DB with SQL Server

Comparing an on-premises SQL Server database engine with Azure SQL Server can help highlight some of the benefits of using Azure.

#### On-premises SQL

- require your IT department to acquire the server hardware
- install the operating system
- install the database engine
- manage patches
- configure firewall security
- manage database access
- manage database backup
- manage disaster recovery
- and when the compute resources are not enough to meet demand, you perform all the above again for new hardware

#### Azure SQL Database

- Create an instance on Azure using your chosen deployment model
- migrate your data to the new instance
- configure the application access
- configure scalability options if needed
- enjoy the benefits of a managed environment

### Hybrid data scenarios

Azure Hybrid Benefit is a model that helps reduce your licensing costs for running your SQL workloads in the cloud. You take advantage of this benefit by using your existing on-premises Software Assurance-enabled licenses for Windows Server and SQL Server on the Azure platform.

An example of a SQL Server Enterprise savings is demonstrated in this graph.

:::image type="content" source="../media/azure-sql-hybrid-savings.png" alt-text="SQL hybrid savings graph showing enterprise at $3.97 per hour and hybrid at $0.598 per hour":::

## What are Migration Assistance Tools?

The set of migration assistance tools that Microsoft makes available, are designed to help you assess your existing environment, highlight issues you may face during the migration, and to aid in the actual process of bringing your application and data to the cloud.

### What is Azure Migrate?

Azure Migrate is a free service, provided by Microsoft, that discovers, assesses, and migrates on-premises systems to Azure. The service helps with performance-based sizing calculations (virtual machine sizing, compute/storage) for the machines that you'll migrate and estimate the ongoing cost of running these machines in Azure. Azure Migrate can assess both Hyper-V and VMware-based virtual machines, and physical servers. Azure Migrate also supports the visualization of dependencies for those machines. It helps you create groups of machines that can be assessed together and ultimately migrated to Azure at the same time. Understanding the dependencies gives you confidence that nothing will be left behind.

### What is the Azure Migration Assistant?

The Azure Migration Assistant is a tool that you can use to perform the migration of your ASP.NET application to the cloud.  It works alongside the App Service Migration Assistant, which is designed to simplify your migration to the cloud using a free, simple, and fast solution to migrate ASP.NET applications from on-premises to the cloud. With these tools, you can:

- Assess whether your app is a good candidate for migration by running a scan of its public URL.
- Download the Migration Assistant to begin your migration.
- Use the tool to run readiness checks and general assessment of your app’s configuration settings, then migrate your app or site to Azure App Service via the tool.

### What is the Data Migration Assistant?

The Data Migration Assistant helps you upgrade to a modern data platform by detecting compatibility issues that can impact database functionality in your new version of SQL Server or Azure SQL Database. The assistant recommends performance and reliability improvements for your target environment and allows you to move your schema, data, and uncontained objects from your source server to your target server.

Key features are:

- Assess on-premises SQL Server instance(s) to detect issues with a migration resulting from compatibility issues or feature support
- Discover new features in Azure SQL Database that you can take advantage of
- Migrate on-premises SQL Server instances to the cloud
- Assess on-premises SQL Server Integration Services (SSIS) package(s) migrating to Azure SQL Database

## Evaluate your existing environment

A critical step in the migration process is evaluation of your existing environment. This will help to ensure a smooth transition for your migration scenario and may also help identify potential issues that may before, during, and after the migration.

### Inventory existing environment

Taking an inventory of you existing environment helps to identify the servers, applications, and services that are in scope for the migration. Utilize your IT and business teams that work with those services to help provide guidance, feedback, and support for the migration.

You will also want to produce a full inventory and dependency map of servers and services that are in scope for migration. The inventory and map determine how those services communicate with each other. They can help define the online environment needs to ensure a successful migration.

### Identify required app changes

Changes will likely be required to the application to make it work correctly after the migration. For example, your ASP.NET application is accessing a database. The database connection string will likely need to be changed. A benefit to using Azure is the ability to store your database connection string as a secret in the Azure Key Vault.  This protects the authentication parameters in the connection string by "hiding" the connection string behind a secret in the key vault.  You then configure your app to use that secret, rather than the connection string directly.

## Estimate costs

A key consideration for any migration scenario is cost. How much will it cost your organization to host the application on Azure.  You will be moving from a cost model that is different than a typical on-premises environment.  In the Azure environment, you will be billed on a monthly basis for various consumption costs related to compute, storage, and access costs.

The next article will discuss the Azure Cost Estimator, which you can use to help evaluate your estimated spend.

## Evaluate security considerations

Security is, and should be, a top priority in any migration scenario. You may be worried about hosting data in an online world or wonder if your employees will still be able to use their current credentials for accessing the applications. Perhaps you are also concerned about security of data from the perspective of compliance with industry standards. Understanding the options available in Azure can help to address these concerns.

### Evaluate security requirements for your app

In an ASP.NET application scenario, where the app needs to access a data store, you need to consider how to secure the database while still allowing access to the web front-end. Azure provides virtual networks to help in this regard. Azure virtual networks can help you:

- Build a hybrid infrastructure that you control
- Bring your own IP addresses and DNS servers
- Secure your connections with an IPsec VPN or ExpressRoute
- Get granular control over traffic between subnets
- Create sophisticated network topologies using virtual appliances
- Get an isolated and highly secure environment for your applications

You may also access applications running on-premises using Active Directory for authentication and identity management. Azure AD Connect enables you to integrate your on-premises directories with Azure Active Directory. This means employees will not be required to have multiple sets of credentials for authentication.

Similar to taking an inventory of your on-premises environment for apps and hardware, you should also map out your existing security requirements and implementation so you can perform a proper security assessment for the migration scenario. You want to ensure that the security needs of your organization will still be possible in a cloud-hosted environment.

## Explore DevOps pipelines for a migration scenario

Many organizations are adopting DevOps practices for more agile development and faster deployments. One of the key areas that make this possible in a cloud environment is the native integration between the tools that you developers use.  Visual Studio, GitHub, and App Service integration enables your developers to build and ship changes faster. For ASP.NET applications, remote and live-site debugging provide greater benefit to developers for diagnosing issues in your production environment. You will explore DevOps pipelines in a later module.