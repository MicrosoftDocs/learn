Modernizing your data platform has the potential to streamline your database systems and eliminate obstacles to profitability, but it can be a complex process that requires a complete understanding to ensure success.

You've been asked to prepare an initial report for the board that explains why they should finance a data platform modernization project. The board wants to understand the return on investment and efficiencies that could be obtained through this project.

You'll learn what tasks data architects and database administrators must complete during a typical data modernization project.

## What is data platform modernization

As cloud computing continues to expand, organizations are evaluating how it can bring efficiencies, transform their operational practices, and potentially disrupt entire industries through innovative solutions.

At the heart of this transformation is data; it drives business success. To that end, data specialists within IT departments must modernize existing data platform technologies to help businesses realize their transformation goals, while minimizing downtime and data loss.

Data modernization can open up a whole new set of possibilities and opportunities by removing technical barriers that were previously inaccessible due to the inflexibility of most on-premises environments. In some cases, for example, modernizing may involve an organization just upgrading an existing on-premises SQL Server to a newer version.

:::image type="content" border="false" source="../media/2-solution-scenarios-overview.png" alt-text="A diagram of the main solutions and scenarios for data modernization.":::

An increasing number of organizations are choosing to take advantage of the elastic nature and economies of scale that the cloud brings. They can also gain technological benefits through the wider range of technologies available in Azure.

## Why modernize your data platform

Microsoft Azure provides several fully managed SQL-based platforms and services that are cloud-based, secure, and scalable. Their features address the key challenges of cloud storage and provide you with reliable and durable data platform solutions. But there are some other reasons why Azure SQL-based data platform technologies are beneficial:

- **Convenience** - Setting up an Azure SQL data platform can be convenient as it eliminates the need to manage physical hardware. However, there are certain aspects that need to be taken care of such as understanding the latest security best practices and managing operating system and SQL server patches for IaaS (Infrastructure as a Service) offering. In a PaaS (Platform as a Service) offering, all the hardware, software updates, and OS patches are managed for you. You only need to specify a few options, and a running Azure SQL Database can be provisioned within minutes. 

- **Cost** - Microsoft manages the hardware for you, eliminating the need to buy, provide power for, or maintain any system hardware. Azure SQL offers various pricing options that allow you to balance performance and cost, with plans starting at just a few dollars a month. You can use the **Azure Total Cost of Ownership Calculator** to determine the costs associated with the service you want to use.

- **Scale** - Azure provides a scalable infrastructure that can grow or shrink based on your business needs. This means that you can scale up or down your computing resources, storage, and networking capabilities as required.

- **Security** - Azure SQL offers robust security features, as expected from Microsoft. However, ensuring strong security requires shared responsibility between you and Microsoft. Microsoft handles the physical security of the hardware as part of their data center security, but you're responsible for managing data access through permissions.

- **Automated backup and recovery** - This mitigates the risk of losing your data if there's any unforeseen failure or interruption.

- **Encryption capabilities** - Data is automatically encrypted on disk to make it highly secure; you also have encrypting connections to the data.

### Data modernization use cases

Let's go through some examples of data modernization, which include:

- **Migrating to Azure SQL**. This allows organizations to reduce the need for on-premises hardware to support their database operations and can provide significant cost savings and scalability.

- **Adoption of new technologies**. Data modernization can involve the implementation of new technologies such as machine learning, artificial intelligence, and advanced analytics. These technologies can help organizations gain insights from their data and make better-informed decisions.

- **Usage of hybrid features**. For example, the link feature of Azure SQL Managed Instance enables you to replicate your SQL Server databases hosted anywhere to Azure, and switch over to the cloud if there's a disaster or significant business disruption. This allows you to modernize your data estate while still running on-premises.

- **Upgrading to the latest version of SQL Server**. Upgrading to the latest version of SQL Server can provide significant performance improvements and security enhancements. 

- **Consolidation of databases**. Data modernization can also involve the consolidation of databases. This can help organizations reduce complexity and increase efficiency, and provide cost savings by reducing the need for multiple instances of SQL Server.

## Stages of data platform modernization

Data platform modernization is also about designing and implementing a process that ensures that the data platform modernization takes place seamlessly.

This process consists of five main stages:

:::image type="content" border="false" source="../media/2-five-stages-data-modernization.png" alt-text="A diagram of the five stages of data modernization, discover, assess, plan, transform, and validate.":::

- **Discovery** - At this stage, you take an audit of your existing environment to understand the data estate within the business. You also gain insight on and document the type of workloads that your applications and databases deal with. You'll discover how large your workloads are, the frequency that the workloads run, and what they're used for.

- **Assessment** - At this stage, you use the information gained in the discovery phase to do a thorough assessment of the workloads you identified and assess any potential problems or breaking changes that could exist before or after migration. Also, mitigation approaches are defined, and Azure features are evaluated for quick implementation to maximize benefits.

- **Planning** - The planning phase outlines the workloads and the associated databases and applications that will be migrated. The plan will also outline the migration order and the tools that will be used to complete the migration.

- **Transformation and Optimization** - During this phase, transformations are applied to any workloads that require changes to become compatible with the new data platform technology. Workloads are then optimized to take advantage of the new features offered by the new data platform.

- **Testing and Remediation** - At this stage, the migration is completed, including testing to validate that the migration has been successful, and remediate any issues that arise.
