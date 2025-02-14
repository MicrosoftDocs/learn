With your discovery and assessment process complete, you begin the process of converting and migrating your Oracle database to your Azure SQL managed instance.

## Create an Azure SQL managed instance

Before starting the process of converting and migrating your database, you create the database server on Azure.

- [Create a resource group.](/azure/azure-resource-manager/management/manage-resource-groups-portal) Azure resource groups are region-specific containers for storing and organizing resources. Before creating your Azure SQL managed instance, the application VMs, or other assets, you create a resource group where they will live.

- [Create your Azure SQL managed instance.](/azure/azure-sql/managed-instance/instance-create-quickstart) To select the appropriate initial scale and capacity of the instance, you use the resource usage data from SSMA assessment report or the Oracle AWR data you generated during the assessment phase.

Now that your SQL managed instance is in place, you can create the blank target databases to migrate to.

## Convert the schema

We discussed the SSMA tool during the earlier assessment and planning phase, and now you use it to help [convert the Oracle DB schema into SQL Database format](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide#convert-the-schema). To do this, you perform the following steps:

1.  Connect to your source and target databases. SSMA must connect to both your existing Oracle database and your newly created Azure SQL managed instance.

1.  Automatically convert the schema. Use the SSMA Convert Schema tool to convert the Oracle schema objects.

1.  Remediate any remaining schema issues. Not all schema objects will automatically convert. Your schema remediation exercise will update the new SQL schema to fix any remaining issues. SSMA lists errors or warnings related to the schema conversion and provides recommendations for fixes and workarounds.

## Perform the data migration

When your database team has finished applying fixes to your converted schema conversion files, you're ready to [perform the migration](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide#migrate). Again, you use SSMA during this process to perform the following actions:

1.  Publish your new schema. You deploy the fixed schema to your Azure SQL managed instance.

1.  Configure data mapping. Before migrating, you ensure that SSMA is configured to properly map all of your Oracle database objects to the correct target objects in the SQL database.

1.  Perform data migration. The configured SSMA makes a complete copy of the database contents to the SQL managed instance.

After the initial data migration is complete, you periodically sync the data with the production version until you've completed deploying and testing your application code updates and are ready to cut over to the Azure-hosted copy of the application.

If your workload requires near-zero downtime, consider an online migration using [change data capture (CDC)](/sql/relational-databases/track-changes/about-change-data-capture-sql-server).
