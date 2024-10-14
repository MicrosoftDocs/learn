Now that you've decided to migrate to a PaaS database solution, you need to determine which cloud-native Azure Database product is best for your Oracle databases. Azure supports a wide variety of database technologies. Microsoft provides [guides for migrating many database technologies to Azure](/data-migration/), including Oracle.

## Decide on a database technology

After some initial research into the options, you've narrowed down your options to two choices: [migration to Azure Database for PostgreSQL](/azure/postgresql/migrate/how-to-migrate-from-oracle) or migration to Azure SQL. You consult your team on the features, system components, and capabilities of both Azure SQL and Azure Database for PostgreSQL to find the best fit. Although both options have well-documented migration processes, provide managed infrastructure, and remove the need for Oracle licensing requirements, there are important differences that affect your decision.

At a high level, the key advantages of Azure Database for PostgreSQL are the open-source nature of the core PostgreSQL technology, along with a closer similarity between Oracle PL/SQL and PostgreSQL PL/pgSQL query languages that can make schema translation easier.

By contrast, Azure SQL offers near-limitless storage capacity and responsive serverless compute for high-performance transactional applications. It also uses the Transact-SQL (T-SQL) query language that many developers and IT departments have deep and long-standing experience with.

After you've reviewed the relative differences between the two options, your organization decides that internally developed applications will move toward using Azure SQL technologies for its database storage services. Your team also wants to take advantage of the integrated Azure [monitoring and tuning tools](/azure/azure-sql/database/monitor-tune-overview), such as [Intelligent Insights](/azure/azure-sql/database/intelligent-insights-overview), [database watcher](/azure/azure-sql/database-watcher-overview), [SQL Insights](/azure/azure-sql/database/sql-insights-overview), and [Microsoft Defender for Azure SQL](/azure/defender-for-cloud/defender-for-sql-introduction). Now you'll choose between [Azure SQL Database and Azure SQL Managed Instance](/azure/azure-sql/database/features-comparison). You decide in favor of Azure SQL Managed Instance, because your organization has expertise with on-premises SQL Server.

## Perform database discovery and assessment

Now that you've determined the database PaaS technology, it's up to your database administrator and development teams to perform a discovery and assessment process. These tasks help you understand what development and IT tasks are required to [migrate your Oracle database to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide).

The first thing to determine is the amount of resources that your Oracle database uses. This step helps you initially configure your Azure SQL managed instance. Follow the guidance in [Migrating Oracle Databases to SQL Server](/sql/ssma/oracle/migrating-oracle-databases-to-sql-server-oracletosql) to help you gather the necessary information, which may include using the [Oracle Automatic Workload Repository (AWR)](https://docs.oracle.com/iaas/operations-insights/doc/analyze-automatic-workload-repository-awr-performance-data.html) tool to help collect peak CPU, memory, and IO performance data about your Oracle databases. Use the information you get from this process to rightsize the Azure SQL resources you need to provision.

With resource usage assessed, you next determine how you'll convert and migrate your databases. The key tool you use throughout the Oracle-to-Azure-SQL migration process is the [SQL Server Migration Assistant (SSMA) for Oracle](/sql/ssma/oracle/sql-server-migration-assistant-for-oracle-oracletosql). SSMA helps automate many migration tasks, including migration assessment, schema and SQL syntax conversion, data migration, and migration testing.

During the assessment phase, you connect SSMA to your existing on-premises Oracle database servers. SSMA examines the databases you want to migrate and provides an [assessment report](/sql/ssma/oracle/assessing-oracle-schemas-for-conversion-oracletosql) that contains the following information:

- Schema and objects using features that may require modification or may not be directly supported in Azure SQL.

- Potential data issues, including data type compatibility and constraints.

- Code compatibility issues between Oracle and Azure SQL, such as syntax differences, reserved keywords, and unsupported features.

- Recommendations and workarounds for specific issues.

- Summary conversion statistics, including overall complexity of the migration process, number of objects to be converted, the number of lines of code, and the estimated effort required for the migration.

Based on this information, you can plan the schedule and developer resource allocation for the database migration process.

## Audit your application code

In addition to the database conversion, your development team needs to identify what work is needed for your application code to support the new database service. At the basic level, this involves updating your application code to [communicate with your new Azure SQL Managed Instance](/azure/azure-sql/database/connect-query-java) service. The team also needs to conduct a thorough code audit to identify any potential Oracle-specific features or functionality that should be updated for Azure SQL compatibility.

You'll use the [Microsoft Data Access Migration Toolkit](/sql/dma/dma-assess-app-data-layer#assess-an-application-with-data-access-migration-toolkit) to help with this process. The toolkit, which is an extension for Visual Studio Code, scans your application source code and identifies potential database usage issues or invalid query syntax that must be resolved before the application can correctly use the new database service. After this review process is complete, you can create an estimate of how many dev resources you need and how long it will take to perform required code updates.

## Assess your application hosting needs

To minimize complexity during your initial migration, you've chosen to rehost your Java applications on Azure VMs. You can use the [Azure Migrate: Discovery and assessment tool](/azure/migrate/concepts-assessment-calculation) to determine:

- How suitable your existing on-premises servers are for migration to Azure.
- The size and number of VMs you need to deploy on Azure.
- The costs for running these VMs on Azure.
- Any additional cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

For details on how best to set up and use assessment information, consult the [Azure Migrate documentation](/azure/migrate/best-practices-assessment).
