With the Azure-SSIS integration runtime installed and SQL Server Data Tools (SSDT) you have the capability to deploy and manage SSIS packages that you create in the cloud. For some packages, you may be able to rebuild them by redeploying them in the Azure-SSIS runtime. However, there may be some SSIS packages that already exist within your environment that may not be compatible.

## Perform assessments of your SSIS packages

When you migrate your database workloads from SQL Server on premises to Azure SQL database services, you may have to migrate SSIS packages as well. The first step required is to evaluate your current SSIS packages to make sure that they're compatible in Azure.

SQL Server Data Tools (SSDT) includes a built-in Azure assessment feature through its Azure-Enabled Project capability. After Azure-enabling your SSIS project, you can assess a single package or all packages in the project in Solution Explorer to surface potential cloud compatibility issues before migration.

The assessment report lists potential cloud compatibility issues, each with a detailed description and recommendation, including:

- **Migration blockers**: compatibility issues that would prevent your packages from running on Azure-SSIS IR.
- **Informative issues**: additional information that you should be aware of, such as partially supported or deprecated features used in the source packages.

You can export the assessment report as a CSV file to share with teammates who need to address specific issues before migration.

## Account for SQL Server Agent jobs

Many SSIS packages are scheduled to execute on a recurring basis. To that end, there are job definitions held within the SQL Server Agent that are used to manage the execution of SSIS packages. When you migrate your SSIS packages, you can also migrate the associated jobs within the SQL Server Agent via SQL Server Management Studio (SSMS) by using the **SSIS Job Migration Wizard**. The wizard supports only packages that are stored in the file system.

To learn more how to migrate SQL Server Agent jobs associated with SSIS packages, see [Migrate SQL Server Agent jobs to ADF with SSMS](/azure/data-factory/how-to-migrate-ssis-job-ssms).

## Perform a migration of your packages

Before migrating, you must know which Azure SQL database service you're migrating to. This can include migrating to Azure SQL Managed Instance (MI), or Azure SQL Database. Furthermore, when migrating SSIS packages you have to consider the location of the SSIS packages that you're migrating, as this can impact how you migrate the packages, and which tool you need to use. There are four types of storage:

-	SSIS Catalog (also known as SSISDB)
-	File System
-	MSDB database in SQL Server
-	SSIS Package store

## Migration tools by storage type

The tool you use to migrate SSIS packages depends on where the packages are stored:

| Package storage type | How to migrate the packages |
| --- | --- |
| SSIS Catalog (SSISDB) | Redeploy the projects with SSDT or SSMS to an SSISDB hosted by Azure SQL Database or Azure SQL Managed Instance. |
| File System | Redeploy the packages to file shares or Azure Files with `dtinstall`, `dtutil`, or a manual copy, or keep them in the file system and access them through a virtual network or a self-hosted integration runtime. |
| MSDB database in SQL Server | Export the packages to the file system, file shares, or Azure Files with SSMS or `dtutil`. |
| SSIS Package store | Export the packages to an Azure-SSIS IR package store with SSMS or `dtutil`, or redeploy them with `dtinstall`, `dtutil`, or a manual copy. |

Azure Database Migration Service doesn't migrate a source SSISDB to Azure SQL Database. Instead, redeploy your SSIS projects and packages by using the Integration Services Deployment Wizard, which you can launch from SSMS. The deployment process validates the packages to make sure that they can run on the Azure-SSIS IR. You can also use SSIS DevOps Tools to do batch package redeployment.

> [!NOTE]
> Data Migration Assistant (DMA), which could assess SSIS packages in batches, is retired as of July 16, 2025. For more information, see [Data Migration Assistant overview](/sql/dma/dma-overview).

> [!TIP]
> To understand additional features and tools for migrating SQL Server workloads to Azure SQL, see [Migrate SQL Server workloads to Azure SQL](/training/paths/migrate-sql-workloads-azure/).



