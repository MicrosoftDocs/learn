# Title

Migrate your relational data to Azure SQL Database

## Role(s)

- Solution Architect
- Administrator
- Data Engineer

## Level

- Beginner

## Product(s)

- Azure SQL Database

## Prerequisites

- Basic familiarity with relational data
- Basic familiarity with SQL Server
- Basic familiarity with Azure SQL Database

## Summary

Plan and implement the migration of relational data from SQL Server to Azure SQL Database. Select the appropriate migration strategy for your database, and use Azure tools to asses and migrate your data. Perform an assessment using the Data Migration Assistant and migrate a database to Azure SQL.

## Learning objectives

1. Select the proper migration strategy for your relational data stored in SQL Server.
1. Perform a migration from SQL Server to a single Azure SQL Database using the migration with downtime process.

## Chunk your content into subtasks

Identify the subtasks of *Migrate your relational data to Azure SQL Database*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe the elements of the migration process. | ...plan a migration... | Knowledge check | Select the proper migration strategy for your relational data stored in SQL Server. | Yes |
| Choose when to use migration with downtime. | ...select the proper migration strategy and tools... | Knowledge check | Select the proper migration strategy for your relational data stored in SQL Server. | Yes |
| Choose when to use transactional replication. | ...select the proper migration strategy and tools... | Knowledge check | Select the proper migration strategy for your relational data stored in SQL Server. | Yes |
| Migrate a database with downtime. | You will be migrating these databases to Azure SQL Database... | Exercise | Perform a migration from SQL Server to a single Azure SQL Database using the migration with downtime process. | Yes, possibly multiple |

## Outline the units

1. **Introduction**

    Your organization is moving out of your on-premises data center, and has several databases running on SQL Server. You will be migrating these databases to Azure SQL Database for the reduced costs and operational resources required for these systems. You need to plan a migration for these databases to Azure SQL Database, and need to select the proper migration strategy and tools to use to perform this migration. You need to decide whether to use migration with downtime or transactional replication to migrate your data.

1. **Exercise - Environment setup**

    Exercise unit to kick off the setup of the systems needed for the exercise. This should be a single command to deploy a template for a SQL Server on a Windows VM, with a sample database configured.

1. **Migration process overview**

    List the content that will enable the learner to *Describe the elements of the migration process*:

    - Pre-migration
        - Discover: Inventory database assets, and application stack discovery.
        - Assess: Assess workloads and fix recommendations.
        - Convert: Convert the source schema to work in the target environment. This is only relevant for heterogeneous migrations.
    - Migration
        - Migrate schema, data, and objects: Migrate the source schema, and then migrate the source data to the target.
        - Sync data: Sync your target schema and data with the source. This is only relevant for minimal-downtime migrations.
        - Cutover: Cut over from the source to the target environment. This is only relevant for minimal-downtime migrations.
    - Post-migration
        - Remediate applications: Iteratively make any necessary changes to your applications.
        - Perform Tests: Iteratively run functional and performance tests.
        - Optimize: Based on the tests you performed, address any performance issues, and then retest to confirm the performance improvements.

    Migration details

    - What is included and what is not included in the migration process
    - Tools and services that are used
        - Data Migration Assistant
        - Azure Database Migration Service

    **Knowledge check**

    What types of questions will test *learning objective*?

    - Why is the post-migration stage an important part of a successful migration plan?

1. **Exercise - Assess database with the Data Migration Assistant**

    Perform an assessment to ensure the source database is compatible with Azure SQL Database. Steps to follow should reference https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-azure-sql#assess-your-on-premises-database.

    1. Download and install the [Data Migration Assistant](https://www.microsoft.com/download/details.aspx?id=53595)
    1. Create an assessment
    1. Review assessment results
    1. Prepare any necessary fixes as TSQL scripts

1. **Migration with downtime**

    List the content that will enable the learner to *Choose when to use migration with downtime*:

    - Overview of the migration process
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Selecting downtime tolerance
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Migration with transactional replication**

    List the content that will enable the learner to *Choose when to use transactional replication*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Exercise - Migrate a database with downtime**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    *Add your summary [(Guidance)](id-guidance-module-summary-unit.md)*

## Notes

Much of the detail in unit 3 is based on the graphic from https://datamigration.microsoft.com/, click on *Migration overview* at the top of the page.

The following template has examples of setting up several of the resources necessary for this exercise, though shouldn't be used on as it's currently presented. We may need to use the SQL2014SP2/WS2012R2 marketplace image to ensure that the deployment happens in a timely manner. This took about 8 minutes in a trial run in my own subscription.

https://github.com/Azure/azure-quickstart-templates/tree/master/101-azure-database-migration-service

Content is based on the [SQL Server database migration to Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-single-database-migrate) article.

Steps for creating a migration assessment can be found [here](https://docs.microsoft.com/en-us/sql/dma/dma-assesssqlonprem?view=sql-server-ver15).

[Tutorial: Migrate SQL Server to a single database or pooled database in Azure SQL Database *offline* using DMS](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-azure-sql)

[Tutorial: Migrate SQL Server to a single database or pooled database in Azure SQL Database *online* using DMS](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-azure-sql-online)