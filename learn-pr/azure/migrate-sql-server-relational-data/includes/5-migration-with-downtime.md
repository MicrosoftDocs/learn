There are two options for doing a migration: **offline** and **online**.

With the offline option, the source database is removed from service during the entire migration process.

With the online option, also known as **migration with minimal downtime**, the database remains in operation until the very end of the migration. Once you initiate the cutover, the source database is taken offline and any final changes are brought into the target database, minimizing downtime. 

Let's look closer at both options and how the tools work with them.

## Offline

![Offline Migration](../media/5-01-offline.svg)

With the offline mode, the source database must be taken offline. It must be placed in a state where no more updates are being made. Once this is done, the Azure Data Migration Service can be used to do the migration.

## Online

![Online Migration](../media/5-02-online.svg)

During an online migration, the service takes a backup of the source database and migrates the data to the target platform. This allows the source database to continue to receive incoming transactions and return data. When the main part of the migration is complete, the user initiates the cutover process. The source database is then taken offline, rendering it unavailable for use.

The Data Migration Service will then read the data from the transaction log to bring the target database into sync. Once completed, the new target database will become available for use. This is why the online option is sometimes referred to as **minimal downtime**. There is indeed some downtime, but it is minimal compared to doing an offline migration.

While the online option appears attractive, there is a major downside: cost. The online option requires creating an instance of your Azure SQL Server that is based on the Premium price tier. This can become cost prohibitive, especially in situations where you don't need any of the features of the Premium tier except its support of online migrations.

Because of this, it is a recommended best practice to first test using the offline option to ascertain whether it can run in an acceptable time frame.

## Migration exercises

In the next two exercises, you'll begin the migration process for your company's social database. In the first, you'll use the Azure Data Migration Assistant to analyze the database for any inconsistencies, repair them, and finally migrate the database schema to our target Azure SQL Database service.

In the second exercise, you'll use the Azure Data Migration Service to move the data from your social database to its new home in Azure SQL Database.
