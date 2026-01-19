Azure Arc provides a streamlined pathway to migrate SQL Server databases to Azure SQL Managed Instance directly from the Azure portal. When your SQL Server instance is enabled by Azure Arc, you gain access to integrated assessment, target selection, and migration capabilities—all managed through a unified experience.

In our bicycle manufacturing company scenario, the distribution team runs business-critical databases that require minimal downtime during migration. The team wants to use the Azure portal for a simplified migration experience while maintaining control over the migration method.

## Understand how to migrate SQL Server with Azure Arc

When your SQL Server instance is enabled by Azure Arc, the Azure portal becomes your central hub for database migration to SQL Managed Instance. The migration process guides you through four key stages:

1. **Assess source instance** - Evaluate your SQL Server instance to determine migration readiness
2. **Select target** - Choose or create your SQL Managed Instance destination
3. **Migrate data** - Execute the migration using your chosen method
4. **Monitor and cutover** - Track progress and complete the migration

Discovery of SQL Server instances and generation of readiness reports happen automatically every weekend, but you can also trigger assessments manually at any time. The assessment evaluates feature compatibility, identifies potential migration blockers, and provides right-sized recommendations for your target SQL Managed Instance configuration.

Database migration through Azure Arc is available for SQL Server 2012 and later versions, with the specific migration method determining exact version requirements.

## Integrated migration methods

Azure Arc integrates two migration methods directly into the portal experience, each suited to different business requirements.

### Managed Instance link

The Managed Instance link uses distributed availability group technology to replicate data in near real-time from SQL Server to SQL Managed Instance. This approach offers several advantages:

- **Near real-time replication** - Data changes are continuously replicated, providing the fastest available synchronization
- **Read-only access during migration** - Query your data on the target instance while migration is in progress, allowing you to validate data or offload read workloads
- **Minimum downtime** - Cutover is measured in seconds, making the only true online migration option for both General Purpose and Business Critical service tiers
- **Unlimited replication duration** - Keep the link active for weeks or months until you're ready to cut over
- **Reverse migration capability** - For SQL Server 2022 and later, you can migrate back from SQL Managed Instance to SQL Server if needed

The Managed Instance link supports SQL Server 2016 and later running on Windows Server 2016 and later. It's available for Enterprise, Standard, and Developer editions. This method is recommended for business-critical workloads that can't tolerate extended downtime.

> [!NOTE]
> Microsoft Copilot is integrated into the migration experience to assist you throughout the process. Copilot can help you compare migration methods, understand assessments, and guide you through migration decisions.

### Log Replay Service (LRS)

Log Replay Service uses log shipping technology to continuously restore backups from an intermediary Azure Blob Storage account to SQL Managed Instance. Key characteristics include:

- **Broad compatibility** - Supports all SQL Server editions from version 2012 and later on Windows Server 2012 and later
- **Simpler initial setup** - Works with a public endpoint by default, requiring minimal network configuration
- **Backup-based approach** - Upload full, differential, and transaction log backups to Azure Blob Storage for automatic restoration

LRS migrations have a maximum duration of 30 days, after which the job automatically stops. The database remains in a restoring state until cutover completes, meaning it's not accessible for read workloads during migration. Cutover time depends on restoring the final backup file, which can take longer for large databases.

For migrations to the Business Critical service tier, LRS requires extra time after cutover to seed data to secondary replicas, potentially adding hours of downtime for large databases.

## Choosing between migration methods

The choice between Managed Instance link and LRS depends on your specific requirements:

| Consideration | Managed Instance link | Log Replay Service |
| --- | --- | --- |
| **Minimum downtime required** | Best choice - cutover in seconds | Longer cutover, especially for Business Critical tier |
| **Need to read data during migration** | Supported | Not available - database is in restoring state |
| **SQL Server version** | 2016 and later | 2012 and later |
| **SQL Server edition** | Enterprise, Standard, Developer | All editions |
| **Network configuration** | Requires VPN or private endpoint setup | Works with public endpoint by default |
| **Migration duration** | Unlimited | Maximum 30 days |
| **Reverse migration needed** | Supported (depends on SQL MI update policy) | Not supported |

For most business-critical workloads targeting either General Purpose or Business Critical SQL Managed Instance, the Managed Instance link provides the best migration experience with minimal downtime.

LRS is well-suited for general purpose workloads where some planned downtime is acceptable, or when migrating from older SQL Server versions or editions not supported by the Managed Instance link.

## Resilience and monitoring

Both migration methods benefit from Azure Arc's integrated monitoring capabilities, allowing you to track migration status, view completed and in-progress migrations, and identify any issues that arise.

The Managed Instance link offers greater resilience during migration:

- Replication automatically resumes after SQL Server restarts or network interruptions
- Migration continues uninterrupted during SQL Managed Instance system updates or failovers
- Issues are self-healing once underlying problems are resolved

LRS migrations can stall if there's a broken backup chain or incorrectly specified backup files. For General Purpose targets, migrations automatically resume after system updates. For Business Critical targets, migrations must be manually restarted after interruptions.

## Performance considerations

When planning your migration, consider these factors that affect migration performance:

- **Managed Instance link** - Performance depends on network latency and bandwidth between SQL Server and SQL Managed Instance. A stable, low-latency connection ensures data remains synchronized in near real-time.

- **Log Replay Service** - Performance depends on the size of backup files being uploaded and restored. Splitting large backups into multiple smaller files and enabling backup compression can improve transfer speeds.

For both methods, ensure your target SQL Managed Instance is appropriately sized for your workload. The assessment process provides tier recommendations based on collected performance data from your source instance.

## Reverse migration considerations

Reverse migration back to SQL Server from Azure SQL Managed Instance is only supported when using the Managed Instance link, and depends on the update policy configured for your SQL managed instance:

- **SQL Server 2022 update policy** - Databases can be restored back to SQL Server 2022 instances
- **SQL Server 2025 update policy** - Databases can be restored back to SQL Server 2025 instances
- **Always-up-to-date update policy** - Reverse migration isn't supported

If your source SQL Server version is earlier than SQL Server 2022, reverse migration isn't possible because migrated databases undergo an internal upgrade to a newer database version that isn't compatible with earlier SQL Server versions.
