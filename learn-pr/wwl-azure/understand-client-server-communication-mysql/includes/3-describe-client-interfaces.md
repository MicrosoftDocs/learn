The application layer is the interfaces and applications that interact with the MySQL server. At this level, there are services for allowing clients to connect, be authenticated, and their security privileges verified. There are three main components at this level, namely:

- Client interface and utilities
- Administrative interface and utilities
- Query interface

In this unit, we discuss the client interface and utilities. In Azure Database for MySQL, admin tasks are managed through the Azure portal. For example, you can display, create, and delete databases from the **Database** menu option. You can also set up **Alerts** display **Metrics**. To access these options, in the Azure portal, navigate to your MySQL flexible server, and select the relevant option from the left menu. In the next unit, we discuss the query interface.

When you install MySQL server a many different programs are installed, all managed by the MySQL daemon. Azure Database for MySQL is a service that allows you to focus on creating and optimizing your databases by providing an interface to manage your MySQL server either through the Azure portal, or Azure CLI. Two key client tasks are **backup and restore**, and **server configuration**.

## Backup and restore

Azure Database for MySQL automatically takes a backup of your server and databases. You don't need to configure or enable anything; backups will be made soon after you've created your Azure Database for MySQL server. A backup is done every day, and if a backup fails for any reason Azure Database for MySQL will retry the backup every 20 minutes until a successful backup has been done.

By default, backups are retained for seven days, but you can configure backups to be retained for 35 days. All backups are encrypted using AES 256-bit encryption.

Azure Database for MySQL doesn't expose the file system, and backup files aren't available to be exported. They can only be used for restoring to a point in time in Azure Database for MySQL. You can, however, use [**mysqldump**](/azure/mysql/concepts-migrate-dump-restore) to copy a database.

The automatic backups in Azure Database for MySQL take the place of mydumper and myloader - the backup utilities in MySQL. Mydumper and myloader are distributed separately from MySQL and are popular because they perform better than the utilities distributed with MySQL - **mysqldump** and **mysqlpump**.

To configure the length of time to retain a backup:

1. In the Azure portal, navigate to your Azure Database for MySQL.
1. From the overview blade, under **Essentials**, select **Configuration**. The Compute + storage blade is displayed.
1. Under **Backups**, select Backup retention period (in days) using the slider. You can select from 1 to 35 days.
    :::image type="content" source="../media/compute-storage-backup.png" alt-text="Screenshot showing the Compute + storage blade, where you can set the retention period for backups." lightbox="../media/compute-storage-backup.png":::

## Server configuration

**my.cnf** is a text file that contains the huge number of parameters, defaults, and options that MySQL uses. Azure Database for MySQL provides a user interface to these configuration settings in the **Server Parameters** blade. In the Azure portal, navigate to your Azure Database for MySQL. In the left menu, under **Settings**, select **Server Parameters**. For Flexible server, there are 22 pages of dynamic and static parameters you can view or modify.

Azure Database for MySQL is a service, which means you don't have to worry about where this configuration file is located or how to amend it; this is all managed for you.

> [!NOTE]
> Not all the options in my.cnf are available to modify in Server Parameters. However, all the parameters you need are available in Server Parameters.

**Mysqladmin** is an administration program used to manage the server's configuration and status. For example, it's used to create and drop databases and to view parameter settings.
