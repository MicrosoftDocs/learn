A data platform modernization project has five stages that are usually completed in order.

In our global retailer scenario, your board have approved the modernization project and you are beginning to organize staff and other resources. To set up and assign tasks optimally, you need to understand the project phases in depth.

In this unit, you'll explore each of the five stages in more detail.

:::image type="content" border="false" source="../media/2-five-stages-data-modernization.png" alt-text="A diagram of the five stages of data modernization, discover, assess, plan, transform, and validate.":::

## Initiate and discover

Data platform modernization projects are usually initiated to meet business or legal requirements, such as GDPR compliance or improved business benefits. Therefore, it is crucial to account for these needs and obtain support from senior management. The first step is to complete a discovery exercise that includes the following considerations:

- **Evaluate current environment**

    Many IT infrastructures will typically evolve over many years, perhaps even decades. In that time, business and staff can change immensely to the extent that there may no longer be experts in the systems that an organization has. In some rare occasions, organizations may even forget that they still have some systems in existence.

- **Check for dependencies between existing applications and databases**

    You should take time to understand how your applications interact with the databases that exist in your network. Furthermore, you should also understand any inter-database dependencies that may exist so that you can collectively group databases together in logical groupings. By performing this exercise, you will use the logical groupings of databases as a basis for migrating them to Azure as one unit.

- **List the workload types of your systems**

    Listing workload types against identified database servers provides insight into their usage. Workloads can be categorized as analytical (OLAP) or transactional (OLTP) based on whether they are read or write intensive. This helps decide which data platform technology to migrate to. Further categorization may include batch or decision support workloads.

## Assessment

During the assessment stage, the information gathered during the discovery phase is used to conduct a comprehensive evaluation of the identified workloads to establish the following:

- Any potential migration blockers
- Any breaking changes that require post migration fixes
- Azure features that the workloads can use

You establish this by completing a **current workload assessment** and a **workload criteria assessment**:

- **Current workload assessment**

    The identified database servers and applications are categorized and confirmed to establish the following: data volume and expected growth rates, average resource usage, and their criticality to the business. This stage also presents an opportunity to consider combining or decommissioning on-premises databases to reduce the number of databases to migrate, and lower the total cost of ownership.

- **Workload criteria assessment**

    In the workload criteria assessment, you use the findings from the current workload assessment and define the post migration criteria for running the identified workloads.

    Let's say you identified a heavily-used transactional database server during peak hours but with low usage during off-peak hours. In the workload criteria assessment, you define a post-migration criteria, such as migrating to an Azure SQL Database with auto-scaling to handle peak loads.

## Planning

The planning stage of a data platform modernization project involves determining the target platform, migration approach, and mitigation plans for any planned or unplanned interruptions.

Within the planning phase of the Data Platform modernization process, there are seven terms to describe how you can handle application and data transitioning from an existing on-premises environment to a new cloud-based environment (either public or private):

:::image type="icon" source="../media/2-modernization-plan.png" border="false" alt-text="Diagram of the planning phase, showing the seven Rs":::

|#|Phase|Action|Description|
|-|-|-|-|
|**1.** |**Remain**|Do nothing|Continued modernization while considering long-term options for remaining on-premises services.|
|**2.** |**Rehost**|Migrate to IaaS|This approach removes the need for datacenter management and gives a higher **Return on Investment** (ROI) through a lower **Total Cost of Ownership**(TCO).|
|**3.** |**Refactor**|Migration to IaaS or PaaS with minimal application changes|This approach removes the need for datacenter management and gives a higher **Return on Investment** (ROI) through a lower **Total Cost of Ownership**(TCO). It can also  enables a lower management overhead through consolidation of databases.|
|**4.** |**Rearchitect**|Rewriting core aspects of application to use cloud technologies|It enables the use of modern components, reduces code deployment, and facilitates DevOps deployment of infrastructure and services.|
|**5.** |**Rebuild**|Rebuilding the application to use PaaS or serverless technologies|Rebuilding data platforms and applications with newer technologies enables the use of Azure's built-in high availability, increases application portability and scalability, and minimizes potential skill gaps between the technology used and staff supporting/developing the application.|
|**6.** |**Replace**|Replace the application by a newer application or SaaS solution|Consider the replace approach when an application has dependencies on physical devices attached to the server or when it tightly integrates with on-premises infrastructure.|
|**7.** |**Retire**|Decommission applications that are no longer required |The retire approach should be considered when legacy applications and databases are no longer used because there's no business or legal requirement to keep them.|

The graph below shows the amount of effort that each term requires compared to the value that the business gains from the migration.

:::image type="icon" source="../media/2-effort-versus-business-value.png" border="false" alt-text="A graph showing the effort compared to business value.":::

- **Platform target options**

    There are two high-level choices available to you when it comes to choosing the target platform.

    - **Infrastructure as a Service (IaaS)** - In this approach, you will migrate your data to a virtual machine that has SQL Server installed.

    - **Platform as a Service (PaaS)** - In this approach, you will migrate your data to a data platform service that suits your workload. For transactional workloads, that would involve Azure SQL Database or Azure SQL Managed Instance. For Online Analytical Processing (OLAP) type workloads, this would involve Azure Synapse Analytics.

- **Choosing target platform by features**

    - **Azure SQL Database** - Use if the application surface area is database scoped. SQL Database offers a low maintenance solution that can be a great option for certain workloads.
    
    - **Azure SQL Database Elastic Pools** - Elastic pools allow you to allocate storage and compute resources to a group of databases, rather than having to manage resources for each database individually. Additionally, elastic pools are easier to scale than single databases, where scaling individual databases is no longer needed due to changes made to the elastic pool.

    - **Azure SQL Database serverless** - It is effective for lowering the costs in development and testing environments. The auto-pause delay feature lets you set the inactive period before the database automatically pauses. You can choose between 1 hour and 7 days or disable it. When accessing the database again, it resumes and only incurs storage charges during the pause.

    - **Azure SQL Managed Instance** - Would be appropriate for use if the application surface area is instance scoped and requires features not available in Azure SQL Database such as:

        - SQL Agent
        - MSDTC
        - DQS
        - MDS
        - Database Mail
        - Polybase
        - Support for Linked Servers
        - Supports new Azure cloud services such as Threat Detection

    - **SQL Server on Azure Virtual Machine** - Use if application surface area is instance scoped and requires features not available in Azure SQL Managed Instance, such as SQL Server Reporting Services (SSRS), SQL Server Analysis Services (SSAS), and SQL Server Integration Services (SSIS).

    - **Azure Synapse Analytics** - Use if you have applications that run complex queries across large amount of data that can take advantage of massively parallel processing (MPP) to reduce query processing times.

To view the list of features supported on each PaaS offering for SQL, see [Features comparison: Azure SQL Database and Azure SQL Managed Instance](/azure/azure-sql/database/features-comparison).

- **Choosing target platform by cost**

    - **Azure SQL Database** - The Platform-as-a-Service nature of Azure SQL Database greatly reduces administration and management costs over the more traditional SQL Server on Azure IaaS topology, as most of the required work is completed silently in the background for you by Microsoft. At scale, one can make considerable savings in time and effort.

    - **Azure SQL Database Elastic Pools** - Azure SQL Database Elastic Pools provide significant savings for multiple databases with unpredictable usage demands. Compute resources are shared, avoiding over-provisioning and reducing costs for server maintenance and administration.

    - **Azure SQL Managed Instance** - SQL Managed Instance is offered to those customers who want a fully managed service, where they can easily lift and shift their on-premises environment with minimal configuration changes. The environment offers a minimum of 8 cores and up to 8 TB of storage and sits in an isolated virtual network. This offering is great for customers that want to quickly get to the cloud and want to avoid the overhead of maintaining virtual machines.

    - **SQL Server on Azure Virtual Machine** - Compared to PaaS offerings, SQL Server running on Azure virtual machines come with higher compute, storage, and management costs but provide greater control over the SQL Server and infrastructure.

    - **Azure Synapse Analytics** - Azure Synapse Analytics can reduce your cost by leveraging the MPP architecture to process complex queries in minutes rather than hours.

- **Offline vs. online migrations**

    In the planning stage, you'll want to consider whether you do an offline or an online migration. With offline migrations, application downtime begins at the same time that the migration starts. To limit downtime to the time required to cut over to the new environment when the migration completes, use an online migration. It's recommended to test an offline migration to determine whether the downtime is acceptable; if not, do an online migration. Furthermore, online versus offline options may not be available depending on the Azure platform selected.

## Transform and Optimize

Your assessment and planning would have identified aspects of your applications and database that would require post-migration work that either transforms or optimizes a feature to ensure a successful migration. Transformation typically involves work that requires you to fix or change an aspect of a database. 

Optimization typically involves making a modification to the migrated database to take advantage of a feature, or optimizes its usage within Azure.

For example, a transformation could involve modifying a stored procedure or SQL query that contains syntax not supported in the target database. This would require adjusting the syntax to ensure compatibility with the new database platform, ensuring that the stored procedure or query runs smoothly without any issues in the target environment.

- **Transform**

    To ensure a successful post-migration experience, one or more of the following changes may need to be made to a database.

    - Install pre-migration version upgrades

    - Fix any errors that are identified by the migration assessment tools

    - Implement database schema changes

    - Migrate existing integrated database services into Azure

    - Handling SSIS workloads in the cloud

- **Optimize**

    There may be one or more of the following optimization guidelines you'll want to follow during the migration to ensure that your organization is getting the most out of their investment in Azure.

    - Assess what new features may be available on the target platform

    - Restructure workloads into more cost effective or performance effective sets

    - Choose the highest service level and performance tier during the migration, and scale down after migration is complete

    - Ensure workloads are right-sized

    - Minimize the distance between your BACPAC file and the destination data center

    - Disable auto-statistics during migration

    - Partition tables and indexes

    - Drop indexed views and recreate them once finished

## Migrate, validate, and remediate

This phase involves the migration itself, and importantly the validation steps and remediation steps required to confirm a successful migration. The previous planning, assessment, and transformations stages will have ensured everything is ready to be migrated and functioning correctly once moved to Azure. All that's left to do is prepare the migration tools required, complete the migration, and run post migration functional and performance validations to ensure data consistency with the source database.

### Migration, validation, and remediation considerations

There are a wide range of tools that can be used to do the migration to the selected target platform. These tools will be covered in other modules. In the meantime, it's important to consider the following when completing the migration:

- Understand your workload requirements as a starting point
- Select non-critical workloads or low-priority databases for migration initially
- Run a test migration
- Test database for issues
- Test the plan to mitigate risk associated with downtime and compatibility issues
- Assess migration tools based on disruption to help lower the risk of database downtime
- Continually iterate on your migration process
- Consider the maintenance windows that are available to the application and database targeted for migration
- Take old databases and applications offline
- Test third-party applications
- Create new disaster recovery and maintenance plans
