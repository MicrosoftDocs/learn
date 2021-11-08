Historically, software vendors who build software for SQL Server have certified their software to run on a specific version of the database engine. For example, SharePoint 2016 was only certified to run on SQL Server 2014. This process, called compatibility certification, allows for an application to run on the latest release of SQL Server, while maintaining its vendor supported compatibility level.

SQL Server compatibility level has always been a database level setting. Setting compatibility level to a specific version allows for specific T-SQL keywords to be used as it also determines certain query optimizer behaviors. For example, if you had a database at a specific compatibility level and migrated it to SQL Server 2019, the execution plan shapes and query syntax should remain the same as they did originally before the migration, if it is a supported release.

The database engine version for Azure SQL Database and Azure SQL Database Managed Instance are not comparable with SQL Server internal build numbers, but they do refer to the same compatibility level.

You can check the compatibility level of your databases by executing the query as shown below:

```sql
SELECT name, compatibility_level FROM sys.databases;
```

## Support Policy for SQL Server

Microsoft has a generous support policy for SQL Server. Releases are supported for five years in primary support, and then five additional years in extended support. During the first five years, Microsoft updates all releases with enhanced capabilities, closes feature gaps, and addresses performance, functional, and security bugs. After a release moves into extended support, Microsoft will only address security bugs.

There are many benefits to running on the latest release of SQL Server, including enhancements in the following categories:

* Performance
* Security
* Availability
* Query functionality

These benefits are further improved by the one to two-year release cadence of SQL Server, and the nature of the Azure SQL Database services, which means it never needs to be patched or upgraded where new features are added and fixes are applied automatically.

Microsoft has recommended that application vendors certify applications at a specific compatibility level, instead of for a particular software version. This approach will help customers to take advantage of newer releases of SQL Server but maintain vendor support for applications. 

Microsoft includes query plan shape protection, which means your query execution plans and their performance should be nearly the same (on similar hardware). This feature removes one of the main risks of upgrading SQL Server: optimizer changes that causes degradation in query performance. Microsoft still recommends upgrading to a newer compatibility level when possible but will support databases on older compatibility levels as long as the release of SQL Server that you are running on is a supported release of SQL Server.

Learn more about the [compatibility levels supported](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level).