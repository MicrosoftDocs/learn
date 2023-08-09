
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

### **Data Migration Assistant (DMA)** 

We'll learn more about DMA in the next unit. However, it's important to note that DMA is used when running a **Database (only)** assessment in Azure Migrate. For migrations to Azure SQL, DMA also checks feature parity to uncover partially or unsupported features in Azure. To take full advantage of the features offered by Azure Migrate, you have to install and create an assessment project using DMA, and then upload the assessment report to Azure Migrate.

:::image type="content" source="../media/5-azure-migrate-dma.png" alt-text="Screenshot showing how to upload a Data Migration Assistant assessment to Azure Migrate." lightbox="../media/5-azure-migrate-dma.png":::

## Exercise: Assess a database and sync results in Azure Migrate

To run this exercise, ensure you follow these steps before proceeding:

> [!NOTE]
> To complete this exercise, you need access to an Azure subscription to create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.
>
> If you choose to perform this exercise in this module, be aware that you might incur costs in your Azure Subscription.

### Prerequisites

- SQL Server 2022 with the latest [**AdventureWorks**](/sql/samples/adventureworks-install-configure) database. 
- Once the database has been restored, run the following command:
    
    ```sql
    ALTER TABLE [Person].[Person] ADD [Next] VARCHAR(5);
    ```

- A SQL Server user with read access to the source database.

### Task 1: Create an Azure Migrate project

1. In the Azure portal, search for *Azure Migrate*.
2. In **Services**, select **Azure Migrate**.
4. In the **Migration goals** section, select **Servers, databases and web apps**, and then select **+ Create project**.
5. In the **Create project** page, select the Azure subscription, and the resource group.
6. In **Project Details**, specify the **Project** and the **Geography** in which you want to create the project.
7. Select **Create**.

### Task 2: Assess a database using DMA

1. Download and install the latest version of DMA from the [**Microsoft Download Center**](https://www.microsoft.com/download/details.aspx?id=53595), and then run the **DataMigrationAssistant.msi** file.
1. Launch **Microsoft Data Migration Assistant**, select **+ New** and provide the following information:

    - **Project type -** Assessment
    - **Project name -** <*provide a name of your preference*>
    - **Assessment type -** Database Engine
    - **Source server type -** SQL Server 
    - **Target server type -** Azure SQL Database. This is the target server you'll assess for compatibility.
1. Select **Create**
1. On the assessment page, select **Check feature parity**. Select **Next**.
1. On the **Connect to a server** sidebar, provide the connection details about your source server. Select **Connect**.
1. On the **Add sources** sidebar, select the database for assessment. Select **Add**.
1. Select **Start Assessment**, and once the assessment is finished, you can view the results in the **Review results** tab.

:::image type="content" border="false" source="../media/6-dma-assessment-page.png" alt-text="Screenshot of the review results tab after running an assessment in Data Migration Assistant.":::

### Task 3: Upload assessment report to Azure Migrate

1. On the assessment results page in DMA, select **Upload to Azure Migrate**.
1. On the **Connect to Azure** side bar, select **Connect**. Follow the steps to sign in to your Azure account.
1. In the **Upload to Azure Migrate** side bar, select your subscription followed by the **Azure Migrate Project** created in the first task of this exercise.
1. Select **Upload**.

### Task 4: Review results in Azure Migrate

1. On the **Databases (only)** section in Azure Migrate, select **Refresh**. This makes sure the dashboard is updated accordingly.

    :::image type="content" border="false" source="../media/5-azure-migrate-assess.png" alt-text="Screenshot of the Azure Migrate: Database Assessment results after the assessment report was uploaded."::: 

    >[!NOTE]
    >The assessment results that we uploaded from DMA in the previous task are now being presented.
1. Select **Assessed databases** and review the results.

    :::image type="content" border="false" source="../media/5-azure-migrate-assess-2.png" alt-text="Screenshot of the assessed databases page results after the assessment report was uploaded."::: 

Note that the report is now available on Azure Migrate, and different teams can reference it. Take a moment to review the assessment results, and the columns in the assessment report. 