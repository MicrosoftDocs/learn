You completed the data migration from your on-premises MySQL server to a new Azure Database for MySQL flexible server. You chose an offline migration because network settings prevented a direct connection between flexible server and on-premises server.
You chose to use the Azure Import CLI as the simplest route. You created a full database backup using Percona XtraBackup, and then you restored it to a new MySQL flexible server. Finally, you redirected the database client applications to the MySQL flexible server and completed the migration.

## References

- [Percona XtraBackup 8](https://docs.percona.com/percona-xtrabackup/8.0/index.html)
- Azure CLI reference: [mysql flexible-server import](/cli/azure/mysql/flexible-server/import)
