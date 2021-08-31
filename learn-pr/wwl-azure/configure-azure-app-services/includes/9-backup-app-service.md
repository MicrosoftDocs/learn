The Backup and Restore feature in Azure App Service lets you easily create app backups manually or on a schedule. You can configure the backups to be retained up to an indefinite amount of time. You can restore the app to a snapshot of a previous state by overwriting the existing app or restoring to another app.

:::image type="content" source="../media/web-app-backup-ff2a9e7f.png" alt-text="Screenshot of the Web app backup page.":::


## What gets backed up

App Service can back up the following information to an Azure storage account and container that you have configured your app to use.

 -  App configuration.
 -  File content.
 -  Database connected to your app (SQL Database, Azure Database for MySQL, Azure Database for PostgreSQL, MySQL in-app).

## Considerations

 -  The Backup and Restore feature requires the App Service plan to be in the Standard tier or Premium tier.
 -  You can configure backups manually or on a schedule.
 -  You need an Azure storage account and container in the same subscription as the app that you want to back up. After you have made one or more backups for your app, the backups are visible on the Containers page of your storage account, and your app. In the storage account, each backup consists of a.zip file that contains the backup data and an .xml file that contains a manifest of the .zip file contents. You can unzip and browse these files if you want to access your backups without actually performing an app restore.
 -  Full backups are the default. When a full backup is restored, all content on the site is replaced with whatever is in the backup. If a file is on the site, but not in the backup it gets deleted.
 -  Partial backups are supported. Partial backups allow you choose exactly which files you want to back up. When a partial backup is restored, any content that is located in one of the excluded directories, or any excluded file, is left as is. You restore partial backups of your site the same way you would restore a regular backup.
 -  You can exclude files and folders you do not want in the backup.
 -  Backups can be up to 10 GB of app and database content.
 -  Using a firewall enabled storage account as the destination for your backups is not supported.
