Backup center in Azure is a single view that helps you monitor backup jobs and your backup inventory on a daily basis. Backup center also is where you can perform various standard operations, such as responding to on-demand backup requests, restoring backups, and creating backup policies. Now, you can also use Backup center to monitor your jobs and replication inventory as a disaster recovery admin.

## Monitor backup jobs

By using Backup center, you can view detailed information on all the jobs that were created in your backup estate, and then take appropriate action for failing jobs. You can select an item in the grid to view more details about a specific job. Right-click an item to go to the resource to take the necessary actions.

:::image type="content" source="../media/backup-center-jobs.png" alt-text="Screenshot shows how to view details of the backup job.":::

On the **Backup jobs** tab, you can view jobs for the last seven days. To view earlier jobs, use Backup Reports.

## Monitor backup instances

Backup center gives you easy search and discoverability of backup instances across your backup estate.

1. In Backup center, select the **Backup instances** tile. A summarized view of all the backup instances you have access to appears.

   You can view the following information about each of your backup instances:

   - Datasource subscription
   - Datasource resource group
   - Latest recovery point
   - Vault associated with the backup instance
   - Protection status

   You can also filter the list of backup instances on the following parameters:

   - Datasource subscription
   - Datasource resource group
   - Datasource location
   - Datasource type
   - Vault
   - Protection status
   - Datasource tags

2. Right-click any item in the grid to perform actions on the backup instance. For example, you can go to the resource, trigger on-demand backups and restores, or stop backup.

:::image type="content" source="../media/backup-center-instances.png" alt-text="Screenshot that shows backup instances in Backup center.":::
