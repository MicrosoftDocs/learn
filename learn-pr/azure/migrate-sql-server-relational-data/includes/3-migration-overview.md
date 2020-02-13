Migrating your company's social media database is a multi-step process. The workflow begins with a **pre-migration** phase, in which you'll determine which databases need to be migrated and look for any compatibility issues between your existing database and Azure SQL Database. 

After you have resolved any incompatibility issues, you are ready for the **migration** stage. First, you'll migrate the schema to the Azure SQL Database service. Once that has been done, you'll be ready to migrate the data itself using the Azure Data Migration Service.

The last step in your workflow will be the **post-migration** phase. During this phase, you'll do any required testing, then update applications, reports, and other tools that will need to use the new database for their data.

![Migration Workflow](../media/3-01-azure-sql-migration-sql-db.png)

## Pre-migration

The pre-migration phase begins with **discovery**, or taking inventory of your existing databases and the tools and applications that rely on them. For this simple exercise we are concerned only with a single social database, however in practice this can be a much more complex step. You will need to identify everything that uses your existing database. Applications, SQL Server Report Services reports, Power BI reports, and export jobs written in PowerShell are all examples of things you will need to take note of so you can update them after the migration to point to the new Azure SQL Database.

The second step in the pre-migration phase is the **assessment**. During the assessment, you will examine the database for any incompatibilities between it and the Azure SQL platform. Because this can be a difficult task to perform manually, Microsoft has provided The Azure Data Migration Assistant. You can use the Data Migration Assistant to automatically examine your source database for any compatibility issues with Azure SQL.

The Data Migration Assistant will provide a report you can use as a guide to updating your database. As you make changes, you can rerun the Data Migration Assistant to keep track of your progress as well as uncover any new issues that may arise as you make changes. The assessment phase is covered in steps 1 and 2 of the above workflow.

The final stage in the pre-migration is **convert**. In the convert phase, you'll make any changes for compatibility recommended to you by the Data Migration Assistant. After making the changes, you'll create the SQL scripts for deploying to the Azure SQL Server. The Data Migration Assistant can be of help to you here as well. It will generate all of the SQL scripts needed to deploy your schema to the target Azure SQL Server.

## Migration

The migration phase involves migrating two elements: **schema** and **data**. In the convert phase of pre-migration, the Data Migration Assistant tool generated all of the code. The Data Migration Assistant can execute these scripts for you, or you can save these scripts and execute them on your own using a tool such as SQL Server Management Studio, Azure Data Studio, or the sqlcmd utility. The schema migration can be found in step 4 in the graphic at the top of this article.

Once your database schema has been migrated, you are ready to migrate your data (steps 3 and 5). For this step, we will use the Azure Data Migration Service to move our data up to the Azure SQL Database service.

The Data Migration Service can be run in two modes, online and offline. When running in online mode, there are two additional steps. The first is **sync**, in which any changes made to the data in the source system after the migration are brought into the target database. The other is the **cutover** step, in which the source database is taken offline and the new Azure SQL database is now available.

## Post-migration

The post-migration phase is a multi-step process that consists of several steps. First, you'll need to remediate any applications, updating any affected by the database changes. For example, you may need to update the connection strings to point to the new Azure SQL database.

In addition, there should be thorough and complete testing. Validation testing will ensure your application did not break due to changes at the database level. Tests should be constructed to return data from both the source and target and compare them to ensure queries are returning from the Azure SQL database as they would with the original source database. Next, performance tests should be created that will validate that your application returns data in the times required by your organization and allow you to do further optimizations if necessary.

The post-migration phase is critical as it ensures your data is both accurate and complete. In addition, it will alert you to any performance issues that may arise with the workload in the new environment.

## The Azure Data Migration Tools

The core of data migration in Azure is the **Azure Data Migration Service**. It is the Data Migration Service that allows you to move bulk amounts of data in a timely fashion. As part of the Data Migration Service, Microsoft provides the Data Migration Assistant. Just as its name implies, the Data Migration Assistant *assists* the service by preparing the target database.

## Azure Data Migration Assistant

The Azure Data Migration Assistant is a client-side tool that you can install on a Windows compatible workstation or server. It has two major functions in the migration of our companies social database to the Azure SQL Database platform.

![Fixed Issues](../media/4-09-fixed-issues.png)

First, it assesses your existing database and identifies any incompatibilities between your existing database and the Azure SQL platform. It then generates a report of the things you will need to fix before you will be able to migrate. As you make changes, you can rerun the Data Migration Assistant to generate an updated report of changes that remain to be made. This allows you to not only track your progress, but catch any new issues that may have been inadvertently introduced during your coding phase.

Once the Data Migration Assistant completes the assessment and you have made any changes, you will then need to migrate the database schema to Azure SQL. The Data Migration Assistant can aid with this as well. It will generate the required SQL, then give you the option of running it or saving the code so you can execute it yourself later.

Using the Data Migration Assistant is not a requirement to use the Azure Data Migration Service. You have the option of coding your new database in the Azure SQL Database service manually without trying to convert an existing database.

As an example, let's say you are creating a staging database in Azure SQL Database that will later feed data into an Azure SQL Data Warehouse. The staging database will be sourced from multiple systems, but it will only be migrating small portions of the source data. In this situation, you may be better off manually crafting the new database directly on the Azure SQL Database service rather than trying to automate the job.

## Azure Data Migration Service

Once you have migrated your database schema using the Data Migration Assistant or created a target database manually, you are ready to move your data. To do that, you'll be using the Azure Data Migration Service.

The Azure Data Migration Service is a fully managed Azure service that provides automated, seamless data migrations from multiple sources into the Azure data platforms.

![Migration Workflow](../media/3-03-adms.png)

The Data Migration Service runs on the Azure platform, as opposed to being a client application like the Data Migration Assistant. It is capable of moving large amounts of data quickly and is not dependent upon installation of a client application. The Data Migration Service can operate in two modes, offline and online.

In offline mode, your source database is put in "offline" mode, in that no more changes may be made to it. Data is migrated, then your various applications can begin using the new Azure SQL Database.

In online mode, your source database may remain in use while the bulk of the data is migrated. At the end of the migration, you will then take the source system offline momentarily while any final changes to the source are synced to the new Azure SQL Database. At this point, your applications can cut over to use the new Azure SQL Database.
