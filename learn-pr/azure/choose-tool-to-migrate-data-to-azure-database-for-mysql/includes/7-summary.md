In this module, you learned how to successfully migrate data from your on-premises MySQL server to a new Azure Database for MySQL flexible server. You chose an offline migration because network settings prevented a direct connection between flexible server and on-premises server. After you chose the Azure Import CLI as the simplest option, you created a full database backup using Percona XtraBackup and then restored it to a new MySQL flexible server. Finally, you redirected the database client applications to the MySQL flexible server and completed the migration.

The main takeaways are understanding the best tools and approaches for different migration scenarios. The Azure MySQL Import CLI is recommended for migrations from VMs and on-premises, while DMS is suggested for all other migrations. Other community tools can be used where these two can't support the migration. Each tool has its own pros and cons, and the choice depends on the specific requirements of the migration.

## Additional reading

- [Azure Database Migration Guide](https://learn.microsoft.com/azure/dms/)
- [Azure Database for MySQL: Flexible Server](https://learn.microsoft.com/azure/mysql/flexible-server/)
- [Percona XtraBackup 8](https://docs.percona.com/percona-xtrabackup/8.0/index.html)
- [Azure CLI reference: mysql flexible-server import](/cli/azure/mysql/flexible-server/import)
