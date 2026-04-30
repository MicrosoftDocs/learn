With the Azure-SSIS integration runtime installed and SQL Server Data Tools (SSDT) you have the capability to deploy and manage SSIS packages that you create in the cloud. For some packages, you may be able to rebuild them by redeploying them in the Azure-SSIS runtime. However, there may be some SSIS packages that already exist within your environment that may not be compatible.

## Perform assessments of your SSIS packages

When you migrate your database workloads from SQL Server on premises to Azure SQL database services, you may have to migrate SSIS packages as well. The first step required is to evaluate your current SSIS packages to make sure that they're compatible in Azure.

SQL Server Data Tools (SSDT) includes a built-in Azure assessment feature through its Azure-Enabled Project capability. After Azure-enabling your SSIS project, you can right-click any package or the entire project in Solution Explorer and select **Assess SSIS Packages for Azure** to surface potential cloud compatibility issues before migration.

The assessment report categorizes findings into two types:

- **Migration blockers**: compatibility issues that would prevent your packages from running on Azure-SSIS IR. SSDT provides guidance to help you resolve each issue.
- **Informative issues**: partially supported or deprecated features used in the source packages. SSDT provides recommendations and alternative approaches available in Azure.

You can export the assessment report as a CSV file to share with teammates who need to address specific issues before migration. 

## Account for SQL Server Agent jobs

Many SSIS packages are scheduled to execute on a recurring basis. To that end, there are job definitions held within the SQL Server Agent that are used to manage the execution of SSIS packages. When you migrate your SSIS packages, you can also migrate the associated jobs within the SQL Server Agent via SQL Server Management Studio (SSMS).

To learn more how to migrate SQL Server Agent jobs associated with SSIS packages, see [Migrate SQL Server Agent jobs to ADF with SSMS](/azure/data-factory/how-to-migrate-ssis-job-ssms).

## Perform a migration of your packages

Before migrating, you must know which Azure SQL database service you're migrating to. This can include migrating to Azure SQL Managed Instance (MI), or Azure SQL Database. Furthermore, when migrating SSIS packages you have to consider the location of the SSIS packages that you're migrating, as this can impact how you migrate the packages, and which tool you'll need to use. There are four types of storage including:

-	SSIS Catalog (also known as SSISDB)
-	File System
-	MSDB database in SQL Server
-	SSIS Package store

## Azure Database Migration Service

The Azure Database Migration Service helps you identify compatibility issues that can impact database functionality in your new version of Azure SQL. Azure DMS recommends performance and reliability improvements for your target environment and allows you to move your schema, data, and objects from your source server to your target server.

This tool can be helpful to you in identifying any issues that can affect a migration to an Azure SQL data platform, and with the results you can evaluate your SSIS packages for compatibility. It supports a variety of migration scenarios, including online, offline, and hybrid migrations.

> [!TIP]
> To understand additional features and tools for migrating SQL Server workloads to Azure SQL, see [Migrate SQL Server workloads to Azure SQL](/training/paths/migrate-sql-workloads-azure/).



