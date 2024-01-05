
When migrating databases to any of the Azure SQL offerings, it’s important to assess your databases for potential migration blockers and breaking changes that may require post-migration fixes. 

Several migration tools provide the database assessment feature, which involves validating the code and schema of the source database to ensure compliance with the requirements of the target platform. This validation helps detect any inconsistencies, errors, or deprecated features that need to be addressed before the migration, ensuring a smooth and error-free transition.

## Identify compatibility issues

Migration tools can identify breaking changes, behavior changes, and deprecated features. You can use these tools to check against a migration target without having to have that target installed anywhere. This allows you to quickly assess a database to see the impact of migrating without any initial setup or licensing cost.

An example of an incompatibility that may prevent migration to Azure SQL Database is the use of cross-database queries. Cross-database queries aren't supported in Azure SQL Database. Migration tools such as the **Azure SQL migration extension for Azure Data Studio** can help you identify this and other compatibility issues and blockers that may prevent a migration.

You can run the assessment on one or more databases and on one or more instances. The size of each selected database affects the time it takes to run the assessment.

It’s best practice to run assessments on a development or test version of the database. After assessments are complete, you may decide to run the same checks on the production database. When it's time to run the assessment in production, ensure it's done at the time of lowest activity so as not to impact users.

### Assessment rules

Different migration tools perform comprehensive assessments on the source SQL Server instance, and run several rules to identify any critical issues that need to be resolved prior to migrating your SQL Server database to Azure SQL. 

Understanding the assessment rules used in the migration process is important because it allows you to identify and address potential issues or challenges before migrating your SQL Server database to Azure SQL Database. By familiarizing yourself with these rules, you gain valuable insights into the specific requirements for a successful migration.

For example, one of the rules in the assessment guidelines for migrating your SQL Server database to Azure SQL Database is the ***LinkedServer*** rule. This rule checks for the presence of linked servers, which aren't supported in Azure SQL Database. By reviewing this rule, you can identify any linked server dependencies and plan for alternative approaches or modifications in your application to ensure a successful transition to Azure SQL Database.

To learn more about the rules used to assess the feasibility of migrating your SQL Server database to Azure SQL Database or Azure SQL Managed Instance, refer to the following links: [Assessment rules for SQL Server to Azure SQL Database migration](https://learn.microsoft.com/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-assessment-rules) and [Assessment rules for SQL Server to Azure SQL Managed Instance migration](https://learn.microsoft.com/azure/azure-sql/migration-guides/managed-instance/sql-server-to-sql-managed-instance-assessment-rules).

## Other supported scenarios

There are several other scenarios where using an assessment tool may be worthwhile. For example:

- **Upgrading to a new version:** If you're upgrading your databases to a newer version of SQL Server, you may want to use a migration tool to assess compatibility and identify any deprecated features or breaking changes that could impact your workloads.

- **Consolidating databases:** If you're consolidating multiple databases into a single database or instance, it's possible to use a migration tool to assess compatibility and identify any issues that may prevent a successful consolidation. For example, suppose you're managing several SQL Server databases that are spread across multiple instances or servers. To simplify management and reduce costs, you may want to consolidate these databases into a single instance or server.

- **Discovering new features:** For example, before you migrate or upgrade with the help of the Data Migration Assistant (DMA), the database can take advantage of new features available in the target SQL Server platform. DMA provides feature recommendations that are categorized into the following areas: performance, security, and storage.



