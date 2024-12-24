With the Azure-SSIS integration runtime installed and SQL Server Data Tools (SSDT) you have the capability to deploy and manage SSIS packages that you create in the cloud. For some packages, you may be able to rebuild them by redeploying them in the Azure-SSIS runtime. However, there may be some SSIS packages that already exist within your environment that may not be compatible.

## Perform assessments of your SSIS packages

When you migrate your database workloads from SQL Server on premises to Azure SQL database services, you may have to migrate SSIS packages as well. The first step required is to evaluate your current SSIS packages to make sure that they are compatible in Azure.

Fortunately, you can use the SQL Server Data Tools (SSDT) to test and debug SSIS packages and identify any compatibility issues with them. 

## Account for SQL Server Agent jobs

Many SSIS packages are scheduled to execute on a recurring basis. To that end, there are job definitions held within the SQL Server Agent that are used to manage the execution of SSIS packages. When you migrate your SSIS packages, you can also migrate the associated jobs within the SQL Server Agent via SQL Server Management Studio (SSMS).

To learn more how to migrate SQL Server Agent jobs associated with SSIS packages, see [Migrate SQL Server Agent jobs to ADF with SSMS](/azure/data-factory/how-to-migrate-ssis-job-ssms).

## Perform a migration of your packages

Before migrating, you must know which Azure SQL database service you are migrating to. This can include migrating to Azure SQL Managed Instance (MI), or Azure SQL Database. Furthermore, when migrating SSIS packages you have to consider the location of the SSIS packages that you are migrating, as this can impact how you migrate the packages, and which tool you will need to use. There are four types of storage including:

-	SSIS Catalog (also known as SSISDB)
-	File System
-	MSDB database in SQL Server
-	SSIS Package store

## Azure Database Migration Service

The Azure Database Migration Service helps you identify compatibility issues that can impact database functionality in your new version of Azure SQL. Azure DMS recommends performance and reliability improvements for your target environment and allows you to move your schema, data, and objects from your source server to your target server.

This tool can be helpful to you in identifying any issues that can affect a migration to an Azure SQL data platform, and with the results you can evaluate your SSIS packages for compatibility. It supports a variety of migration scenarios, including online, offline, and hybrid migrations.

> [!TIP]
> To understand additional features and tools for migrating SQL Server workloads to Azure SQL, see [Migrate SQL Server workloads to Azure SQL](/training/paths/migrate-sql-workloads-azure/).

## Data Migration Assistant

Data Migration Assistant (DMA) is a tool designed to facilitate your transition to an updated data platform. It identifies potential compatibility problems that could affect the functionality of your database on the new version of SQL Server. In addition to suggesting enhancements for performance and reliability in your target environment, DMA also enables the migration of your schema, data, and uncontained objects from your source server to your target server.

> [!NOTE]
> Whenever possible, we recommend that you use the [Azure Database Migration Service](/azure/dms/dms-overview?azure-portal=true) for enhanced overall experience, which is available as [Azure SQL Migration extension for Azure Data Studio](/azure-data-studio/extensions/azure-sql-migration-extension?azure-portal=true), or via [Azure Portal](https://aka.ms/dmsazureportal?azure-portal=true), or through [Azure PowerShell and Azure CLI](/azure/dms/migration-dms-powershell-cli?azure-portal=true).

### Using the Data Migration Assistant

On completion of the installation, the Data Migration Assistant opens. The first step is to configure the type of project that you want to run. There are two choices:

1. **Assessment projects**.

    In this configuration, the Data Migration Assistant will identify any blocking issues or unsupported features that are currently in use with your on-premises SQL Server.

    You can then define setting for your assessment project to check database compatibility or feature parity

    ![Selecting source and target services in the Data Migration Assistant](../media/perform-sql-server-assessment.png)

    Set the source database that you would like to perform the check against, and then start the assessment

    ![Choosing the assessment options in the Data Migration Assistant](../media/add-sources-data-migration-assistant.png)

    and then review the results, either in the tool, or exported into a JSON file for later review

    ![Set the source database in the Data Migration Assistant](../media/feature-assesment-data-migration-assistant.png)


2. **Migration projects**.

    In this configuration, the Data Migration Assistant will migrate the data, schema, or both to the target services defined in the settings.

    ![Migration options in the Data Migration Assistant](../media/perform-migration-data-migration-assistant.png)

### Best practices for running Data Migration Assistant

The following list outlines the best practices that you should consider when working with the Data Migration Assistant:

- Don't install and run the Data Migration Assistant directly on the SQL Server host machine.

- Run assessments on production databases during non-peak times.

- Perform the Compatibility issues and New feature recommendations assessments separately to reduce the assessment duration.

- Migrate a server during non-peak times.

- When migrating a database, provide a single share location accessible by the source server and the target server, and avoid a copy operation if possible. A copy operation may introduce delay based on the size of the backup file. The copy operation also increases the chances that a migration will fail because of an extra step. When a single location is provided, Data Migration Assistant bypasses the copy operation.

- Be sure that to provide the correct permissions to the shared folder to avoid migration failures. The correct permissions are specified in the tool. If a SQL Server instance runs under Network Service credentials, give the correct permissions on the shared folder to the machine account for the SQL Server instance.

- Enable encrypt connection when connecting to the source and target servers. Using SSL encryption increases the security of data transmitted across the networks between Data Migration Assistant and the SQL Server instance, which is beneficial especially when migrating SQL logins. If SSL encryption isn't used and the network is compromised by an attacker, the SQL logins being migrated could get intercepted and/or modified on-the-fly by the attacker.



