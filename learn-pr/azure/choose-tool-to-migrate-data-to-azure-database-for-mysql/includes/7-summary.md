In this module, you learned about the various phases involved in a successful migration completion. You completed the data migration from your on-premises MySQL server to a new Azure Database for MySQL flexible server. You chose an offline migration because network settings prevented a direct connection between flexible server and on-premises server. You chose to use the Azure Import CLI as the simplest route. You created a full database backup using Percona XtraBackup, and then you restored it to a new MySQL flexible server. Finally, you redirected the database client applications to the MySQL flexible server and completed the migration.

The main takeaways from this module are understanding the best tools and approaches for different migration scenarios. The Azure MySQL Import CLI is recommended for migrations from VMs and on-premises, while DMS is suggested for all other migrations. Other community tools can be used where these two can't support the migration. Each tool has its own pros and cons, and the choice depends on the specific requirements of the migration. The process of migrating an on-premises MySQL server to an Azure Database for MySQL flexible server involves several steps and considerations, including the non-migration of users and privileges, which must be manually dumped and migrated after the import operation.

## Additional Reading
1. [Azure Database Migration Guide](https://docs.microsoft.com/en-us/azure/dms/)
2. [MySQL Workbench: Database Migration](https://dev.mysql.com/doc/workbench/en/wb-migration.html)
3. [Azure Database for MySQL: Flexible Server](https://docs.microsoft.com/en-us/azure/mysql/flexible-server/)
4. [Azure Database for MySQL: Migration Tools](https://docs.microsoft.com/en-us/azure/mysql/concepts-migration-tools)
1. [Percona XtraBackup 8](https://docs.percona.com/percona-xtrabackup/8.0/index.html)
1. [Azure CLI reference: mysql flexible-server import](/cli/azure/mysql/flexible-server/import)
