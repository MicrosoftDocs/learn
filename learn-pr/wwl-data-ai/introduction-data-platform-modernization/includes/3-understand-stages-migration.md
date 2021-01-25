A data platform modernization project has five stages that are usually completed in order.

In your global retailer, your board have approved the modernization project and you are beginning to organize staff and other resources. To set up and assign tasks optimally, you need to understand the project phases in depth.

In this unit, you'll explore each of the five stages in more detail.

:::image type="content" border="false" source="../media/2-five-stages-data-modernization.png" alt-text="A diagram of the five stages of data modernization, discover, assess, plan, transform, and validate.":::

## Initiate and discover

Initiation of a data platform modernization project typically is driven by a wider business or legal requirement. For example, ensuring that an organization uses a technology that is GDPR-compliant, or has a feature that brings about an improved business benefit. That's why it's important that projects account for these types of need to obtain project support from senior management in the business. Assuming this, the first step of the project is to complete a discovery exercise that consists of the following considerations:

- **Taking stock of the current environment**

    Many IT infrastructures will typically evolve over many years, perhaps even decades. In that time, business and staff can change immensely to the extent that there may no longer be experts in the systems that an organization has. Indeed on rare occasions, organizations may even forget that they still have some systems in existence.

- **Check for dependencies between existing Applications and Databases**

    You should take time to understand how your applications interact with the databases that exist in your network. Furthermore, you should also understand any inter-database dependencies that may exist so that you can collectively group databases together in logical groupings. By performing this exercise, you will use the logical groupings of databases as a basis for migrating them to Azure as one unit.

- **List the workload types of your systems**

    Listing the workload types against the database servers that you've identified will help you understand how the server is used. Traditionally workloads can be either identified as analytical (also known as OLAP) or transactional (also known as OLTP). Such categorization denotes if the servers do read or write intensive operations, and to that end can help you formulate a decision as to which data platform technology to migrate to. You may also want to go further and categorize servers into those that do Batch workloads or those that perform Decision Support workloads.

## Assessment

The assessment stage takes the information that has been gained from the discovery phase and your team does a thorough assessment of the workloads you've identified to establish the following:

- Any potential migration blockers
- Any breaking changes that require post migration fixes
- Azure features that the workloads can use

You establish this by completing a Current Workload Assessment and a Workload Criteria Assessment

- **Current Workload Assessment**

    With the list of categorized database servers and applications that have been identified in the discovery phase, your assessment should confirm what databases exist on each server, establish the data volumes and expected growth rates of each database, and document the average resource usage of each database. In addition, you should understand the criticality of the applications and databases to the business. For example, is it a database that cannot afford any downtime, or is important in facilitating revenue for the business. At this stage, there is also an opportunity to consider if you should combine or decommission any on-premises databases before doing a cloud migration. This can reduce the number of databases to migrate, and reduce the total cost of ownership.

- **Workload Criteria Assessment**

    In the Workload Criteria Assessment, you use the findings from the Current Workload Assessment and define the post migration criteria for running the identified workloads.

## Planning

The planning stage of a data platform modernization project is used to determine the target platform, and whether the data migration involves a one time sync or a continuous flow of data. You'll also build in any rollback or mitigation plans required if there should be any planned or unplanned interruptions or issues.

- **Platform target options**

    There are two high-level choices available to you when it comes to choosing the target platform.

    - **Infrastructure as a Service (IaaS)** - In this approach, you will migrate your data to a virtual machine that has SQL Server installed.

    - **Platform as a Service (PaaS)** - In this approach, you will migrate your data to a data platform service that suits your workload. For transactional workloads, that would involve Azure SQL Database or Cosmos DB. For Online Analytical Processing (OLAP) type workloads, this would involve Azure SQL Data Warehouse.

- **Choosing target platform by features**

    - **Azure SQL Database** - Azure SQL Database would be appropriate for use if the application surface area is database scoped. If the application uses some SQL features listed below in managed instance, then Azure SQL Database may not be appropriate as not all are yet available.

    - **Azure SQL Database Elastic Pools** - Azure SQL Database would be appropriate for use if the application surface area is database scoped. If the application uses some SQL features listed below in managed instances, then Azure SQL Database may not be appropriate as not all are yet available.

    - **Azure SQL Database managed instance** - Would be appropriate for use if the application surface area is instance scoped and requires features not available in Azure SQL Database such as:

        - SQL Agent
        - MSDTC
        - DQS
        - MDS
        - Database Mail
        - Filestream
        - Filetable
        - Polybase
        - Support for Linked Servers
        - Supports new Azure cloud services such as Threat Detection

    - **SQL Server on Azure VMs** - Use if application surface area is instance scoped and requires features not available in Azure SQL Database managed instance.   Additionally, supports local instances of:

        - SSRS
        - SSAS
        - SSIS

    - **Azure SQL Data Warehouse** - Use if you have applications that run complex queries across petabytes of data that can leverage massively parallel processing (MPP) to reduce query processing times from hours to minutes.

- **Choosing target platform by cost**

    - **Azure SQL Database** - The Platform-as-a-Service nature of Azure SQL Database greatly reduces administration and management costs over the more traditional SQL Server on Azure IaaS topology, as most of the required work is completed silently in the background for you by Microsoft Operations. This is evident at scale where considerable savings in time and effort can be made.

    - **Azure SQL Database Elastic Pools** - Azure SQL Database Elastic Pools can offer considerable savings if used by multiple databases that have varying and unpredictable usage demands. The sharing of compute resources amongst all databases in the pool means that customers are not required to over-provision resources for all databases to meet their infrequent spikes in usage. Further savings are made on lowered server maintenance and administrative costs as most of the required work is completed silently in the background by Microsoft Operations.

    - **Azure SQL Database managed instance** - Managed instances are offered to those customers who want a fully managed service offering, where they can easily lift and shift their on-premises environment with minimal configuration changes. The environment offers a minimum of 8 cores and up to 8 TB of storage and sits in an isolated virtual network. This offering is great for customers that want to quickly get to the cloud and want to avoid the overhead of virtual machines.

    - **SQL Server on Azure VMs** - VMs impose higher compute, storage, and management costs over the Azure SQL Database offerings but grants greater control across the SQL Server and infrastructure.

    - **Azure SQL Data Warehouse** - Azure SQL Data Warehouse can reduce your cost by leveraging the MPP architecture to process complex queries in minutes rather than hours.

- **Offline versus online migrations**

    In the planning stage, you'll want to consider whether you do an offline or an online migration. With offline migrations, application downtime begins at the same time that the migration starts. To limit downtime to the time required to cut over to the new environment when the migration completes, use an online migration. It's recommended to test an offline migration to determine whether the downtime is acceptable; if not, do an online migration. Furthermore, online versus offline options may not be available depending on the Azure Service offering.

## Transform and Optimize

Your assessment and planning would have identified aspects of your applications and database that would require post migration work that either transforms or optimizes a feature to ensure a successful migration. Transformation typically involves work that requires you to fix or change an aspect of a database. Optimization typically involves making a modification to the migrated database to take advantage of a feature, or optimizes its usage within Azure.

- **Transform**

    There may be one or more of the following changes that need to be made to a database to ensure that it works successfully post migration.

    - Install pre-migration version upgrades

    - Fix any errors that are identified by the migration assessment tools

    - Implement database schema changes

    - Migrate existing integrated database services into Azure

    - Handling SSIS workloads in the cloud

- **Optimize**

    There may be one or more of the following optimization guidelines you'll want to follow during the migration to ensure that your organization is getting the most out of their investment in Azure.

    - Assess what new features may be available on the target platform

    - Re-structure workloads into more cost effective or performance effective sets

    - Choose the highest service level and performance tier during the migration

    - Ensure workloads are right-sized

    - Minimize the distance between your BACPAC file and the destination data center

    - Disable auto-statistics during migration

    - Partition tables and indexes

    - Drop indexed views and recreate them once finished

## Migrate, validate, and remediate

This phase involves the migration itself, and importantly the validation steps and remediation steps required to confirm a successful migration. The previous planning, assessment, and transformations stages will have ensured everything is ready to be migrated and functioning correctly once moved to Azure. All that's left to do is prepare the migration tools required, complete the migration, and run post migration functional and performance validations.

### Migration, validation, and remediation considerations

There are a wide range of tools that can be used to do the migration to the selected target platform. These tools will be covered in later modules. But you should consider the following when completing the migration.

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