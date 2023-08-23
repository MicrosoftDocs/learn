The Backup and Restore feature in Azure App Service lets you easily create backups manually or on a schedule. You can configure the backups to be retained for a specific or indefinite amount of time. You can restore your app or site to a snapshot of a previous state by overwriting the existing content or restoring to another app or site.

Watch the following video on how to configure a backup for your App Service instance. This video is based on [Azure Tips and Tricks #28 - Configure a backup for Azure App Service](https://microsoft.github.io/AzureTipsAndTricks/blog/blog/tip28.html).

#### <!-- Video -->

> [!VIDEO https://www.youtube.com/embed/uQXDkW1pCzs]

### Things to know about Backup and Restore

Examine the following details about the Backup and Restore feature. Think about how you can implement this feature for your App Service apps.

- To use the Backup and Restore feature, you need the Standard or Premium tier App Service plan for your app or site.

- You need an Azure storage account and container in the same subscription as the app to back up.

- Azure App Service can back up the following information to the Azure storage account and container you configured for your app:
   - App configuration settings
   - File content
   - Any database connected to your app (SQL Database, Azure Database for MySQL, Azure Database for PostgreSQL, MySQL in-app)

- In your storage account, each backup consists of a Zip file and XML file:
   - The Zip file contains the back-up data for your app or site.
   - The XML file contains a manifest of the Zip file contents. 

- You can configure backups manually or on a schedule.

- Full backups are the default.

- Partial backups are supported. You can specify files and folders to exclude from a backup.

- You restore partial backups of your app or site the same way you restore a regular backup.

- Backups can hold up to 10 GB of app and database content.

- Backups for your app or site are visible on the **Containers** page of your storage account and app (or site) in the Azure portal. 

### Things to consider when creating backups and restoring backups

Let's review some considerations about creating a backup for your app or site, and restoring data and content from a backup.

- **Consider full backups**. Do a full backup to easily save all configuration settings, all file content, and all database content connected with your app or site.

   When you restore a full backup, all content on the site is replaced with whatever is in the backup. If a file is on the site, but not in the backup, the file is deleted.

- **Consider partial backups**. Specify a partial backup so you can choose exactly which files to back up.
   
   When you restore a partial backup, any content located in an excluded folder or file is left as-is.

- **Consider browsing back-up files**. Unzip and browse the Zip and XML files associated with your backup to access your backups. This option lets you view the content without actually performing an app or site restore.

- **Consider firewall on back-up destination**. If your storage account is enabled with a firewall, you can't use the storage account as the destination for your backups.