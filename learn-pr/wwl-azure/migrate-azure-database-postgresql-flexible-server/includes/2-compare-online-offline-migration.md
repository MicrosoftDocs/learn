

There are two distinct methodologies for migrating databases between servers, Online and Offline. The key differences between these methodologies are the amount of downtime for the applications, and the processes using the databases. Typically, offline migrations have a longer period of downtime and online is typically shortest with minimal disruption.

## Offline migration characteristics

When you perform an offline migration activity, the "Offline" description refers to the need to stop the applications and workloads associated with the database before the migration activity starts. The data or database is then migrated from the source system to the target system and verified, before the application is reconfigured to point to the new location and workloads restated.

The two most common methods for an offline migration activity are: either a backup & restore for a schema migration and use an ETL (Extract, Transform, and Load) to transfer the data at an object level or a replication processes.

Offline migrations typically result in longer periods of downtime for the system because the duration needed to perform the data migration activity. This downtime grows proportionally based on the volume of data to transfer during the migration. Bandwidth is a finite resource and only so much data can be transferred per-second.

There are some optimizations that we can make for offline migrations that can minimize the amount of downtime that we have to deal with. However, these optimizations normally involves an increase in the complexity of the migration and therefore the risks of something to go wrong. It's about finding the balance between complexity, risk, and allowable downtime.

## Online migration characteristics

Online migrations are migrations that can take place while the applications and workloads are still running. This situation means that the downtime needed to perform the cut-over from the old database to the new database is small and results in minimal disruption to the users.

> [!NOTE]
> It is important to understand that even with online migrations, there is normally a small window where the application has to be taken offline to redirect it to the new database location. There are ways to engineer an application to not incur downtime but that is outside the scope of this module.

Typically an online migration makes use of a database engine technology like replication to synchronize data from the source to the target database. The overall duration of an online migration activity is longer than an offline activity because the synchronization of data is set up in advance of the cut-over event.

When evaluating whether to perform an online migration, it's important to understand the potential performance impact that the synchronization process applies to the source system. Additionally, there could be some requirements of the synchronization process, which mean changes need to be made in a database for it to be completed successfully.

## Offline vs. online comparison

The following table briefly summarizes the key differences between offline and online migration processes.

|                    | Offline Migration | Online Migration|
|--------------------|:-----------------:|:---------------:|
|**Downtime**        |Longer             |Shorter          |
|**Complexity**      |Lower              |Higher           |
|**Impact on Source**|Lower              |Higher           |
|**Data Transfer**   |One time process   |Synchronous      |

## Which Method to Choose

Understanding the two migration methods is only part of the story for performing a migration. We need to understand which tools are available to us before we can make a choice about how to perform our data migration.
