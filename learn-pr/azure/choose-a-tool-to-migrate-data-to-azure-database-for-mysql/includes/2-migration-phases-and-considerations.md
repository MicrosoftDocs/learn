A successful migration balances considerations across several phases.
## Migration phases

Migrations occur in several phases. First, **plan** the migration scope: discovery and assessment of database resources, business requirements like downtime, and a fallback plan if migration fails. Then, **prepare** the migration by provisioning appropriate resources and setting up connectivity between source and target environments. After the migration approach is set and resources are ready, it's advisable to perform a **dry run** in a staging environment to identify issues ahead of production migration. Lastly, perform the **final migration**, and **validate** its ongoing progress and successful completion.

:::image type="content" source="../media/2-migration-phases-and-considerations/migration-phases.png" alt-text="Screenshot of migration-phases." lightbox="../media/2-migration-phases-and-considerations/migration-phases.png":::

This module focuses on the preparation (2) and final migration (4, 5) phases.

## Migration considerations

You should evaluate requirements for application downtime, version compatibility, networking and security, performance, cost, and business continuity.

:::image type="content" source="../media/2-migration-phases-and-considerations/migration-considerations.png" alt-text="Screenshot of migration-considerations." lightbox="../media/2-migration-phases-and-considerations/migration-considerations.png":::

### Application downtime

One of the first things you should consider is how much downtime your business scenario can accommodate. The answer will strongly constrain your available migration options.

The best downtime is one that users don't notice. In practice, migrations are complex procedures and decisions regarding the considerations in this module will dictate the required downtime. The tradeoffs include availability versus the cost and risk of the migration. Because of the complexity involved in reducing downtime to minutes or even seconds, it's important to test assumptions and determine how much migration downtime is acceptable.

#### Offline migrations

With an **offline** migration, you must shut down the application to move the database. This guarantees that there won't be any changes to the data during migration. However, this approach requires taking down the database to finalize the data export. At a minimum, the downtime will be as long as it takes to transfer the data. An offline migration involves:

1. Disconnecting all apps from the source database.
1. Exporting the source database's contents.
1. Importing the source data to the target database.
1. Reconnecting applications to the target database after the import is complete.

Some applications have scheduled maintenance windows during periods of low traffic. These are great times to perform offline migrations.

An **incremental offline** migration reduces downtime by moving the bulk of the data before taking the application offline. First, migrate a full database backup. Then, migrate the changes to the database that occurred added since the previous migration. When the time required to migrate these new changes fits within your acceptable downtime, take the application offline to freeze the data and finalize the migration. You might find that a single migration increment is enough to reduce downtime by an order of magnitude or more, especially for databases with years of history. For large and busy databases, you might need to migrate several increments to reach acceptable downtime.

An incremental offline migration requires:

1. At time t1, exporting a full database snapshot.
1. Restoring the snapshot taken at time t1 to the target server.
1. Exporting a delta or incremental snapshot of all changes between times t1 and t2.
1. Restoring the delta snapshot to the target server. Repeat steps 3 and 4 as many times as desired.
1. Taking the application offline and performing a final incremental migration.
1. Pointing clients to the new instance and resuming operations.

#### Online migrations

With an **online** migration, you can greatly reduce or even eliminate the need for downtime by replicating changes from the source server to the target server during the migration, and then cutting over to the target server when the replication is fully synchronized.

Sometimes, downtime is undesirable or even unacceptable. In this case, it's impossible to "freeze" the database state by turning off the application. Instead, the source database is replicated into the target database during normal operations. When the target is fully caught up with the source, the application cuts over to the target database.

An online migration requires that you:

1. Begin replicating the source database to the target database.
1. When the target database is caught up, freeze the source database either by pausing the application or by forcing writes to fail by enabling read-only mode.
1. When the target database is 100% caught up with the changes, turn off replication in the target.
1. Redirect all clients to the target database and resume operations.
1. Shut down the legacy source database.

#### Compare online and offline migrations

While offline migrations require downtime, the incremental migration technique discussed above greatly reduces downtime. Multiple increments can shrink the final migration to a day's worth of data or less. Automated services like Azure DMS minimize downtime by performing a series of ever smaller migrations. Incremental offline migrations can also be performed manually if network settings prevent automation.

Online migrations coordinate a delicate operation across database and application teams. Client applications must be tooled to react gracefully to write failures to avoid data loss during migration. Clients must also support connecting to a new database server without interrupting the user experience. If this application tooling doesn't already exist, it might be quite expensive to build.

### Version compatibility

Most application operations are compatible with MySQL upgrades. However, in some cases application components or database usage might only work with certain MySQL versions.

Check that all application components are compatible with the target database version. Consider separating version upgrades from migrations that relocate or reconfigure a database. For example, if migrating from on-premises MySQL 5.7 to an Azure Database for MySQL flexible server running MySQL 8.0, consider migrating from on-premises to an Azure Database for MySQL flexible server running MySQL 5.7, and then upgrading from 5.7 to 8.0 in-place.

### Networking and security

Database migrations require transferring data from the source database to the target. How this happens, and how quickly, depends largely on the connection between the two networks. If you cannot establish a live connection from the source to the target, you'll need to transfer physical data files another way, for example via an intermediate workstation or server. In that case, make sure you have enough disk space to store the snapshots on each system along the way.

It's also vital to consider security requirements during the migration. You'll need appropriate authentication and permissions to source and target databases. You might also wish to create service accounts to perform some or all of the migration steps, and then you can remove their access upon completion.

Whether the source database is on-premises or located on another cloud provider, network settings typically don't allow external connections. You'll need to configure the network to allow connections with Azure.

If the source database is on-premises and the data volume is large, moving terabytes of data over a regular Internet connection might be impractically slow. In this scenario, consider setting up an [Azure ExpressRoute](/azure/expressroute/expressroute-introduction) connection between your network and Azure.

Even if you use an ExpressRoute, the connection it is on will probably also serve other traffic, and the two can interfere with each other. Depending on contention, the performance hit to existing applications and the migration process could be significant.

### Performance

Database migrations are an excellent opportunity to increase capacity by resizing infrastructure. Your database usage might benefit from increased CPU, RAM, or I/O resources.

Before provisioning your target server, consider your current database usage. Monitor performance metrics like CPU usage together with forecast growth and SLAs to decide if you should allocate a larger compute size. Conversely, you might find that your capacity is overallocated, and that downsizing will save costs.

### Cost

When you migrate to Azure, you can take advantage of transparent pricing. Using your selected SKU and other parameters such as redundancy and high availability, the Azure pricing calculator lets you estimate your post-migration costs during planning. You can also use the calculator to inform tradeoffs such as availability vs cost.

### Business continuity

Database migrations are a good time to review business continuity metrics and goals. It might be appropriate to change backup retention policies or shift to geo-redundant backups or high availability. Consider your historical uptime vs SLA, and outage recovery time. Migrations also provide real-world examples of standing up a new database from physical data files, which can inform disaster recovery plans.
