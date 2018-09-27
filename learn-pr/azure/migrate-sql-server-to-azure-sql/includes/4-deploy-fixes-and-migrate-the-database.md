You have assessed your on-premises database to check its compatibility and feature parity against the Azure SQL database. Because the customer base for your online bicycle retail business is limited to one geographical location, you can afford to take your database offline during an off-peak time, for example, the early morning hours.

The best approach for database migration in this scenario is to use the Data Migration Assistant, which provides a wizard to guide you through migration steps. In this unit, we'll discuss how the Data Migration Assistant carries out the actual migration.

## Migrate the Database Using Data Migration Assistant

When using the Data Migration Assistant to migrate your database, choose a time frame when there is a zero or minimum transactional activity on your database.

Before starting with the migration process, fix any errors identified during the assessment stage. The assessment report details the fixes that must be made before proceeding with the actual migration.

To reduce the total time taken for a migration, you can change the performance level of the target Azure SQL Database for the period of migration. You can increase the performance to a higher level, such as P15, to reduce the downtime caused by migration. However, to reduce costs, ensure that you return the performance level to its previous value after the migration.

The actual migration process involves the following steps:

1. Creating an empty Azure SQL Database.

1. Creating a new migration project.

1. Defining the source and target servers and databases.

1. Selecting the objects to migrate. You don't need to migrate all the objects, however, ensure that you do not leave any dependent objects. For example, if a SQL view accesses a table, and you're migrating the view, ensure that you also migrate the table.

1. Deploying the schema. This migrates the structure of the database, but not the data.

1. Migrating the data. This migrates the contents of the tables in the database and is the most time-consuming step.
