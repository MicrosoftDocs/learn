Azure SQL auditing tracks database events and writes them to an audit log, but it requires explicit configuration choices before it can satisfy regulatory requirements. Contoso Financial Services must determine which audit action groups meet their compliance finding and how to scope auditing for a high-volume transaction processing database.

| Capability | What it provides |
|------------|------------------|
| Event tracking | Records database operations using SQL Server Extended Events |
| Audit action groups | Preconfigured sets of events like authentication, queries, and schema changes |
| Server and database scope | Flexibility to audit all databases or individual high-priority databases |
| Retention control | Configurable retention periods for compliance (0 = unlimited, or specific days) |

:::image type="content" source="../media/azure-sql-auditing-flow.png" alt-text="Diagram showing the three-stage Azure SQL auditing configuration flow: database scope, audit action groups, and retention settings writing logs to Azure Storage." lightbox="../media/azure-sql-auditing-flow.png":::

## Choose audit action groups for compliance requirements

Audit action groups determine what events Azure SQL auditing captures. The most important groups for financial compliance are BATCH_COMPLETED_GROUP, FAILED_DATABASE_AUTHENTICATION_GROUP, and SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP.

With BATCH_COMPLETED_GROUP enabled, Azure SQL auditing records every T-SQL statement after execution completes. This group provides the most comprehensive audit trail because it captures all query activity, including SELECT statements that read sensitive financial data. With FAILED_DATABASE_AUTHENTICATION_GROUP, the audit log records every failed sign-in attempt, which helps detect brute force attacks and unauthorized access patterns.

For Contoso's regulatory compliance requirement, enabling all three groups—BATCH_COMPLETED_GROUP, SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP, and FAILED_DATABASE_AUTHENTICATION_GROUP—captures all query activity, successful logins, and failed access attempts. This three-group combination is the Microsoft-recommended default and is what the Azure portal configures automatically when auditing is enabled. It satisfies the financial regulator's requirement to prove who accessed the banking database, when they connected, and what queries they executed. Omitting SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP means you can detect denied access but can't prove who successfully logged in—a critical gap for compliance reviews.

Other audit action groups provide more granular control:

- **DATABASE_LOGOUT_GROUP**: Records when users disconnect from the database
- **DATABASE_CHANGE_GROUP**: Tracks database configuration changes like altering compatibility levels
- **SCHEMA_OBJECT_ACCESS_GROUP**: Records access to specific tables and views
- **DATABASE_OBJECT_PERMISSION_CHANGE_GROUP**: Tracks permission changes on database objects
- **DATABASE_PERMISSION_CHANGE_GROUP**: Records changes to database-level permissions

Beyond these built-in groups, you can create custom audit specifications using T-SQL. Custom specifications let you audit specific tables, schemas, or statement types when the built-in groups are too broad or generate excessive log volume.

## Decide between server-level and database-level scope

Azure SQL auditing operates at two different scopes, and the choice affects both performance and log organization. Server-level auditing captures events from all databases on a logical server, while database-level auditing tracks events for a single database only.

The key technical difference lies in how extended event sessions are created. Server-level auditing uses a single extended event session for all databases on the logical server, while database-level auditing creates a separate session for each audited database. This architectural difference has significant performance implications for high-volume Online Transaction Processing (OLTP) environments.

| Aspect | Server-level | Database-level |
|--------|-------------|----------------|
| Scope | All databases on the logical server | Single database only |
| Extended event sessions | Single session for all databases | Per-database session |
| Folder structure (SQL Database) | All logs in main folder | Database-specific folder |
| Performance challenge | Higher in high-volume OLTP | Better for transaction-heavy workloads |
| T-SQL creation | `CREATE SERVER AUDIT` + `CREATE SERVER AUDIT SPECIFICATION` | `CREATE DATABASE AUDIT SPECIFICATION` |

For Contoso's transaction processing database, database-level auditing is the recommended choice. The single extended event session used by server-level auditing can cause performance degradation when handling the high transaction volume typical of financial services workloads. Database-level auditing distributes the auditing overhead across separate sessions, reducing contention.

The folder structure also differs between the two approaches. With server-level auditing in Azure SQL Database, all audit logs are stored in the main database's folder. With database-level auditing, each database gets its own folder, making it easier to organize and retain audit logs according to different compliance requirements.

## Configure retention settings for regulatory requirements

Retention settings control how long audit logs are preserved in storage. The default retention value is RETENTION_DAYS = 0, which means unlimited retention and never automatically deletes audit logs.

You can set retention to any integer value representing days. For Contoso's financial compliance requirement, a typical retention period ranges from 90 to 365 days minimum. Setting RETENTION_DAYS = 90 ensures the audit logs meet the regulator's minimum retention requirement while controlling storage costs.

An important behavior to understand is that retention applies only to logs written after the retention value is set. If you initially configure unlimited retention (zero days) and later change to 90 days, the logs written during the unlimited period are preserved and not automatically deleted. This behavior protects historical audit data from unintended deletion when retention policies change.

When the admin combines SQL auditing with immutable storage (WORM), the SQL retention setting must be longer than the immutable storage lock period. For example, if immutable storage has a 90-day lock period, RETENTION_DAYS must be set to at least 90 days to ensure audit logs remain available for the entire immutability window.

For AI workload queries, the audit logs capture important context. When Contoso's fraud detection AI service connects using a managed identity, the BATCH_COMPLETED_GROUP records every query attributed to the managed identity's principal name. The audit log includes the server name, database name, application name, client IP address, statement text, duration, and success or failure status for each query.
