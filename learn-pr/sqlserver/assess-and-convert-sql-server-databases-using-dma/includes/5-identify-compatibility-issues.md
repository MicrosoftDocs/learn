Suppose you are a database administrator for a law firm and you have identified the SQL Server instances within your organization that require upgrading. You want to check that the databases will continue to function after the migration is complete. Your CTO is creating a report detailing the return on investment (ROI) that will be gained by moving the databases to SQL Server 2017. She has asked you to provide details of the features in SQL Server 2017 that will realize benefits to the users, so that she can reassure the partners in the firm that their investment is worthwhile.

You quickly realize that it would take you too long to manually check each database for compatibility issues and, because a few of the databases are moving to Azure SQL Databases, you must ensure that all functionality continues to be supported after the migration, whether the target is an on-premise SQL Server or an instance of Azure SQL Database. You have decided that the **Microsoft Data Migration Assistant (DMA)** will fulfill these requirements and automate much of the process.

## Identifying compatibility issues

The Microsoft Data Migration Assistant compares the SQL Server version on your source database with the your intended upgrade version, and identifies breaking changes, behavior changes, and deprecated features. The DMA enables you check against an upgrade version without having to have that version installed anywhere. Therefore, if you are running a feasibility study to see the impact of upgrading, you can choose your target version, and run the assessment against an existing database, all without having any initial setup or licensing cost.

On-premise source versions from SQL Server 2005 are supported. You can select a target type of Azure SQL Database, SQL Server, and SQL Server on Azure Virtual Machine. The option you choose for the target type may determine the version of the target you can select. If your source is an on-premise SQL Server instance, you can compare against SQL Server 2012 through SQL Server 2017, including SQL Server 2017 on Linux. However, if you select Azure SQL Database or SQL Server on Azure Virtual Machine, this only compares against the current Azure version that is available.

You can choose to run the assessment on one or more databases and on one or more instances. If the target is Azure SQL Database, you can run the compatibility check with the performance recommendations and the SQL Server feature parity check, or you can run each assessment individually. The size of each selected database affects the time it takes to run the assessment.

It is best practice to run assessments on a development or test version of the database, prior to running the check on the production database and, when you do need to run the assessment in production, ensure you do this at the time of lowest activity so as not to impact the users.

![Data Migration Assistant assessment](../media/5-dma-assess.png "Data Migration Assistant assessment")

By default, the Data Migration Assistant saves each assessment project and you can reopen the assessment to view the results, or run it again if you have made changes since the last check. DMA saves the credentials so you don't need to reconfigure the set-up. You can also delete any assessments that you no longer need.

## Discovering feature recommendations

The **New features' recommendation** assessment can be run alongside the **Compatibility issues** assessment, or on its own. The assessment evaluates three key areas:

- Performance
- Security
- Storage

![Data Migration Assistant assessment](../media/5-dma-report-options.png "Data Migration Assistant assessment")

Migrating your database to a newer version of SQL Server does not necessarily guarantee improved performance. Changes to the query engine may mean source queries no longer run optimally on the target if no changes are made to the database during or after migration. Existing indexes may no longer be sufficient, and new index enhancements that can bring faster results to large datasets are especially important for analyzing corporate data in real time. If, for example, you were upgrading a database from SQL Server 2008 R2 to SQL Server 2017, DMA would assess your indexes, and may recommend dropping an existing clustered index, and replacing it with a clustered columnstore index for even faster data retrieval. With the growth in data captured and stored by modern business, leveraging as much speed as possible from a database often becomes an essential aspect of the migration process.

The security assessment identifies areas in your database that would benefit from new features to ensure tighter controls over sensitive data. Recommendations are categorized as High, Medium, and Low Value. For example, if you were upgrading customer contact details from a SQL Server 2008 R2 database to SQL Server 2017, DMA might recommend you use **Always Encrypted (AE)**, or **Dynamic Data Masking (DDM)** to secure sensitive data such as personal details. The Data Migration Assistant includes full instructions for using each feature that it recommends.

Storage recommendations are also categorized into High, Medium, and Low Value areas. For example, DMA might suggest you take advantage of using a stretch database to reduce storage costs, and provide a recommendation on how to achieve this. If there are any issues within the database, such as a CHECK constraint that is not compatible with stretch technology, DMA would highlight this.

## SQL Server feature parity

If you run your assessment against a target Azure SQL Database or SQL Server 2017 for Linux, the Data Migration Assistant creates a list of unsupported, and partially-supported features. The Azure and Linux versions of SQL Server offer reduced functionality, so it is essential that you perform a full test prior to migration, otherwise this could result in a broken database.

Features you currently depend on in an on-premise version may not be available. DMA highlights unsupported features by the components installed on your source instance to the target. For example, at the time of release, Master Data Services (MDS), SQL Server Analysis Services (SSAS), and SQL Server Reporting Services (SSRS) were not supported on Azure SQL or SQL Server for Linux, so any interaction with these services would need to be removed, or redeveloped elsewhere. Support for SQL Server features on Azure SQL and SQL Server for Linux databases will be increasingly enabled over time.

Partially-supported features are those in Azure SQL Database or SQL Server 2017 for Linux that don't have the same depth of functionality as the on-premise Windows versions. The Data Migration Assistant automatically finds feature discrepancies enabling you to plan around any potential issues.

## Export assessment report

The Data Migration Assistant saves your assessment projects until you delete them, so you can view these at a later date. You can also export the results to a CSV or JSON file, so that you have a detailed list of fixes. This is useful for sharing with other database administrators and developers, and once you have a finalized list, you can then plan your upgrades and allocate resource for performing the upgrade operation.

## Steps to identify compatibility issues

When using the Data Migration Assistant to identify Compatibility issues, there are three keys phases.

### 1. Run the compatibility assessment

1. In DMA, start by selecting **Assessment**, and provide a name for the project.
1. Then choose **SQL Server** as the **Source server type** and **Target server type**.
1. Then select the target server SQL Server version; this is the SQL Server version you will be assessing for compatibility.
1. During an assessment, **Compatibility Issues** is selected by default; you can also add the **New features' recommendation** option, and the **Check feature parity** option if your target is Azure SQL Database or SQL Server 2017 for Linux.
1. The next step is to select the source server instances, and connection credentials.
1. You can now select **Start Assessment**, and when the assessment is complete, the results are displayed in the **Review results** tab.

### 2. Review the assessment results

1. In the results, there will be a tab for each tested version. For example, if SQL Server 2017 is a target, there will be a  **Compatibility 140** tab.
1. For each compatibility tab, there may be a **Behavior changes** note, listing issues for review.
1. There may also be an **Impact** section, with **Recommendation** notes, highlighting any **Impacted objects** list; you can click through the object list to see more details.

### 3. Export the assessment results

1. To export the assessment, select **Export report**, and you can then choose the format to use for the export, such as **CSV**.
1. The exported report can then be viewed in Excel, or other tools, to get detailed information on issues and recommendations.

## Summary

The Microsoft Data Migration Assistant automates the process of finding compatibility issues between different versions of SQL Server prior to upgrading a database. The assistant can check one or more databases, on one or more servers at a time, and you don't need to have the target version installed. Assessment reports are saved so that you can view the results at a later date, or re-run the assessment without having to re-enter any credentials or select databases.

The Data Migration Assistant compares your database to the target version to recommend new features you can benefit from. In the rush to move from one version to another, it is easy to put emphasis on ensuring the database is functional, overlooking new features that enhance the performance or security of the migrated database.

You can also export the assessment results to Excel or JSON, giving you a detailed list of issues to fix prior to upgrade. This list provides a clear development plan to upgrade your databases, and you'll know all about compatibility problems and unsupported features in advance.