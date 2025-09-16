
Azure Migrate offers tools to assess your current on-premises workloads, providing insights for migration planning. Also, you can perform an agentless environment discovery or use agents to conduct a dependency analysis. This helps identify the dependencies between different components in your environment. 

## What is Azure Migrate?

Azure Migrate simplifies the process of migrating, modernizing, and optimizing your Azure environment by offering a wide range of comprehensive services. It covers all pre-migration steps, including discovery, assessments, and right-sizing of on-premises resources for infrastructure, data, and applications. Additionally, Azure Migrate allows integration with third-party tools, expanding its capabilities to support a wide range of use-cases.

Azure Migrate supports discovery and assessment of different SQL Server deployments, such as SQL Server Always On Failover Cluster Instances (FCI) and Always On Availability Groups (AG).

There are several tools available in Azure Migrate, such as **Azure Migrate: Discovery and Assessment and Migration and Modernization**, which can be integrated with other Azure services, independent software vendor (ISV) offerings, and support the assessment, migration, and modernization of servers, databases, web apps, and virtual desktops. 

For example, if you're assessing the entire SQL Server data estate at scale on VMware, you can use Azure Migrate to get Azure SQL deployment recommendations, target sizing, and monthly estimates.

:::image type="content" source="../media/2-azure-migrate.png" alt-text="Screenshot of the Azure portal's Azure Migrate Overview Get Started screen." lightbox="../media/2-azure-migrate.png":::

During the discovery phase, Azure Migrate can also be used to scan the network and identify all SQL Server instances and features used within your organization.

## Assessment tools

The Azure Migrate hub for assessment includes these tools:

### Azure Migrate: Discovery and assessment

There are three assessment types that you can create using the **Azure Migrate: Discovery and assessment** tool.

- **SQL Server discovery and assessment** 

    It supports SQL Server deployments running in VMware, Microsoft Hyper-V, and physical environments, in addition to IaaS services of other public clouds. It provides an agentless discovery, cost estimation and optimal Azure SQL configuration. It does require an Azure Migrate appliance that you deploy on-premises. This tool is suitable for workloads where you need to assess the readiness of both virtual machines and physical servers, not limited to just SQL Servers.
         
    :::image type="content" source="../media/5-azure-migrate-2.png" alt-text="Screenshot of the Azure Migrate: Discovery and assessment tool in Azure Migrate dashboard." lightbox="../media/5-azure-migrate-2.png":::

    During the discovery phase, **SQL Server discovery and assessment** can also be used to scan the network and identify all SQL Server instances and features used within your organization. This may provide valuable insights into your existing SQL Server environment, enabling you to assess the readiness and scope of your migration project.

- **Business case**

    This assessment type helps you to develop a comprehensive business case to assess the return on investment for migrating servers, SQL Server deployments, and ASP.NET web apps to Azure. You can also eliminate uncertainty and gain insights on Total Cost of Ownership (TCO), resource utilization, and quick wins for migration and modernization.

- **Optimize costs**

    This assessment type uses agentless discovery, Azure readiness checks, and dependency analysis for efficient on-premises mapping and identification of resources ready for migration. It uses insights to estimate the cost of migrating your resources to Azure.

## Exercise: Create and configure Azure Migrate assessment

To run this exercise, ensure you follow these steps before proceeding:

> [!NOTE]
> To complete this exercise, you need access to an Azure subscription to create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.
>
> If you choose to perform this exercise in this module, be aware that you might incur costs in your Azure Subscription.

### Prerequisites

- SQL Server 2022 with the latest [**AdventureWorks**](/sql/samples/adventureworks-install-configure) database. 
- Once the database has been restored, run the following commands to create additional objects for the assessment:
    
    ```sql
    -- Create LogDB database
    CREATE DATABASE LogDB;
    GO
    
    USE LogDB;
    GO
    
    -- Create Logs table
    CREATE TABLE Logs (
        DataCreated DATETIME2 DEFAULT GETDATE(),
        UserID INT,
        ActionID INT
    );
    GO
       
    -- Now modify AdventureWorks database
    USE [AdventureWorks];
    GO    

    ALTER TABLE [Person].[Person] ADD [Next] VARCHAR(5);
    
    CREATE PROCEDURE [HumanResources].[usp_legacyIntegration]
    AS
    SELECT DataCreated, UserID, ActionID 
    FROM LogDB..Logs
    ```

- A SQL Server user with read access to the source database.

### Task 1: Create an Azure Migrate project

1. In the Azure portal, search for *Azure Migrate*.
2. In **Services**, select **Azure Migrate**.
4. In the **Migration goals** section, select **Servers, databases and web apps**, and then select **+ Create project**.
5. In the **Create project** page, select the Azure subscription, and the resource group.
6. In **Project Details**, specify the **Project** and the **Geography** in which you want to create the project.
7. Select **Create**.

### Task 2: Configure SQL Server discovery and assessment

1. In your Azure Migrate project, go to **Servers, databases and web apps**.
2. Select **Discover** under **Azure Migrate: Discovery and assessment**.
3. In **Discover machines**, select **Yes, with VMware vSphere hypervisor** or **Physical or other (AWS, GCP, Xen, etc.)** based on your environment.
4. Download and set up the Azure Migrate appliance following the provided instructions.
5. After the appliance is configured, it will automatically discover your SQL Server instances and databases.

### Task 3: Review assessment results in Azure Migrate

1. Once discovery is complete, go to **Servers, databases and web apps** in your Azure Migrate project.
2. Under **Azure SQL**, you'll see the discovered SQL Server instances and databases.

    :::image type="content" border="false" source="../media/5-azure-migrate-assess.png" alt-text="Screenshot of the Azure Migrate: Database Assessment results after discovery is complete."::: 

3. Select **Assessed databases** to review the assessment results and Azure SQL deployment recommendations.

    :::image type="content" border="false" source="../media/5-azure-migrate-assess-2.png" alt-text="Screenshot of the assessed databases page showing Azure SQL recommendations."::: 

Note that Azure Migrate provides comprehensive assessment results including readiness status, recommended Azure SQL deployment options, and cost estimates. Take a moment to review the assessment results and the different columns in the assessment report. 