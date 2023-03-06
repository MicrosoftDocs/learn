
Backup center for Azure Backup provides a single unified management experience in Azure. Enterprises can govern, monitor, operate, and analyze their backups at scale. The Backup center interface is consistent with Azure's native management experiences.

In the Azure portal, search for **Backup center** and browse to the Backup center dashboard:

:::image type="content" source="../media/backup-center-b3bf1f45.png" alt-text="Screenshot of the Backup center dashboard for Azure Backup showing jobs and backup instances.":::

### Things to consider when using Backup center

Consider the following benefits of implementing Backup center for Azure Backup.

- **Consider range of capabilities**. Backup center is designed to function well across a large and distributed Azure environment. You can use Backup center to efficiently manage backups spanning multiple workload types, vaults, subscriptions, regions, and tenants.

- **Consider datasource-centric management**. Backup center provides views and filters that are centered on the datasources that you're backing up like virtual machines and databases. A resource owner or backup administrator can manage backup items across different vaults. The admin can also filter views by datasource-specific properties, including datasource subscription, resource group, and tags.

- **Consider connected experiences**. Backup center provides native integrations to existing Azure services that enable management at scale. Backup center uses the Azure Policy experience to help you govern your backups. It uses the Azure Workbooks of Azure Monitor and Azure Monitor Logs (Log Analytics) to help you view detailed reports on backups. You don't need to learn new principles to use the varied features that Backup center offers. You can also discover community resources from the Backup center.

- **Consider supported scenarios**. Backup center is currently supported in many scenarios:
   - Azure Virtual Machines backup, including SQL and SAP HANA in Azure Virtual Machines backup
   - Azure Files backup, Azure Blob Storage backup, and Azure-managed disks backup
   - Azure Database for PostgreSQL Server backup