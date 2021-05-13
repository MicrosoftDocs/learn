Data platform modernization can streamline your database systems and remove barriers to profitability but it is complex and must be understood fully to be successful.

In you global retailer, you've been asked to prepare a initial report for the board that will explain why they should finance a data platform modernization project. The board want to understand the return on investment and efficiencies that such a project might realize.

Here, you'll learn what tasks system architects and database administrators must complete during a typical modernization project.

## What is data platform modernization?

With the growth of cloud computing, and as IT hardware comes to end of life within a business, many organizations take stock and look at how the cloud can help bring new efficiencies, transform their working practices, and in some cases disrupt entire industries with new business models.

At the heart of this transformation is data; it drives business success. To that end, database administrators or data engineers within IT departments must modernize existing data platform technologies to help businesses realize their transformation goals, while minimizing downtime and data loss.

Data platform modernization focuses on selecting and migrating to the right data platform technology. In some cases, the modernization may involve an organization just upgrading an existing on-premises SQL Server to a newer version. More and more, organizations are choosing to take advantage of the elastic nature and economies of scale that the cloud brings. They can also gain technological benefits through the wider range of technologies available in Azure.

Data platform modernization is also more than that, it's also about designing and implementing a process that ensures that the data platform modernization takes place almost seamlessly. The process consists of five stages:

:::image type="content" border="false" source="../media/2-five-stages-data-modernization.png" alt-text="A diagram of the five stages of data modernization, discover, assess, plan, transform, and validate.":::

- **Initiate and Discovery** - At this stage, you take an audit of your existing environment to understand the data estate within the business. You also gain insight on and document the type of workloads that your applications and databases deal with. You'll discover how large your workloads are, the frequency that the workloads run, and what they're used for.

- **Assessment** - At this stage, you use the information gained in the discovery phase to do a thorough assessment of the workloads you identified and assess any potential problems or breaking changes that could exist pre or post migration. You'll also define your approach to mitigation that will be used to deal with them. You'll also assess what Azure features can be quickly implemented to maximize the benefits of the data platform modernization project.

- **Planning** - The planning phase outlines the workloads and the associated databases and applications that will be migrated. It will also specify the order in which they are migrated and what tools will be used to complete the migration.

- **Transformation and Optimization** - In this phase, any workload that requires any changes to become compatible with the new data platform technology are dealt with by using transformations. Workloads are then optimized to make use of the new features of the new data platform.

- **Testing and Remediation** - At this stage, the migration is completed, including testing to validate that the migration has been successful, and remediate any issues that arise.

## Why modernize your data platform

Microsoft Azure provides a number of fully managed SQL based data platform technologies and services that are cloud-based, secure, and scalable. Their features address the key challenges of cloud storage and provide you with reliable and durable data platform solutions. But there are some other reasons why Azure SQL based data platform technologies are beneficial:

- **Convenience** - Setting up SQL based data platform technologies is convenient. You don't have to manage the physical hardware. You'll need to understand the latest security best practices and may need to manage the operating system and SQL Server patches on a routine basis in some situations.  In other situations we manage all the hardware, software updates, and OS patches for you. All you specify is the name of your database and a few options. You'll have a running SQL database in minutes. You can also bring up and tear down Azure SQL Database instances at your convenience. Azure SQL Database comes up fast and is easy to configure. You can focus less on configuring software and more on making your applications great.

- **Cost** - Because Microsoft manages hardware for you, there's no system hardware for you to buy, provide power for, or otherwise maintain. The Azure SQL based data platform has several pricing options. These pricing options enable you to balance performance versus cost so you can start for just a few dollars a month. In fact, the Total Cost of Ownership can be calculated using the online calculator Azure Total Cost of Ownership Calculator to help you establish the costs of the service you wish to use.

- **Scale** - With Azure based data platform technologies, you can adjust the performance and size on the fly when your needs change. This is difficult when running on-premises SQL Server where you have to predict the size and scale in advance of reaching them.

- **Security** - Azure SQL based data platform technologies come with the range of security features that you've come to expect from Microsoft. But there's also a shared responsibility with you and Microsoft to ensure that security is as strong as it can be. For example, you don't have to worry about the physical security of the hardware, Microsoft deals with this as part of its data center security. You would be concerned with an individuals access to the data through permissions.

- **Automated backup and recovery** - This mitigates the risk of losing your data if there's any unforeseen failure or interruption.

- **Encryption capabilities** - Data is automatically encrypted on disk to make it highly secure; you also have encrypting connections to the data.

## The 7 R considerations to migration

Within the planning phase of the Data Platform modernization process, there are seven terms to describe how you can handle application and data transitioning from an existing on-premises environment to a new cloud-based environment (either public or private).

:::image type="icon" source="../media/2-modernization-plan.png" border="false" alt-text="Diagram of the planning phase, showing the seven Rs":::

These terms can be used to help formulate the strategy that an organization would want to take when undertaking a data platform modernization project. As the table below shows, the strategy can range from doing nothing at all to a complete replacement of a Data Platform solution and application.

|#|Phase|Description|Benefit|
|-|-|-|-|
|1. |Remain|Do nothing|With this option modernization of the rest of the platform continues while long-term options for the services that are remaining on-premises are considered.|
|2. |Rehost|Optimize the data center and migrate to IaaS|This approach removes the need for datacenter management and gives a Higher **R**eturn **O**n **I**nvestment (**ROI**) through a lower **T**otal **C**ost of **O**wnership (**TCO**) due to consumption of IaaS compute.|
|3. |Refactor|Migration to IaaS or PaaS with minimal application changes|This approach removes the need for datacenter management and gives a Higher **R**eturn **O**n **I**nvestment (ROI) through a lower **T**otal **C**ost of **O**wnership (TCO) due to consumption of IaaS compute. It also  enables a lower management overhead through consolidation of databases|
|4. |Rearchitect|redevelopment of the application to make use of cloud technologies|It allows the system to make use of the latest components and reduce the amount of code required to deploy an application. It also provides the opportunity to allow the use of DevOps deployment of infrastructure and Services.|
|5. |Rebuild|rebuilding the application to use PaaS or serverless technologies|Rebuilding data platforms and applications using newer technologies allows the use of the built-in Azure High availability and Increases the portability and scalability of the application. It also reduces the likelihood of a skills gap between the technologies used and the staff supporting/ developing the application.|
|6. |Replace|Change the application to a newer application or SaaS solution|The replace approach should be considered when an application requires physical devices attached to the server or it integrates tightly with on-premises infrastructure.|
|7. |Retire|Decommission applications that are no longer required |The retire approach should be considered when legacy applications and databases are no longer used because there's no business or legal requirement to keep them.|

The graph below shows the amount of effort that each term requires compared to the value that the business gains from the migration.

:::image type="icon" source="../media/2-effort-versus-business-value.png" border="false" alt-text="A graph showing the effort compared to business value.":::