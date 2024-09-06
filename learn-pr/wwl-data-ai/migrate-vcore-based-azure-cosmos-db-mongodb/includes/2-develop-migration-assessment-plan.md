There are several ways to migrate an existing MongoDB database and application to an vCore-based Azure Cosmos DB for MongoDB account. To ensure a smooth migration process, we should first do some up-front planning and decision-making about the migration process before you actually move any data. In this unit, we review some of those premigration steps in more detail. Migration planning is a critical step in ensuring a successful migration.

![Diagram of the three migration steps.](../media/2-migration-steps.png)

## Plan the premigration

Our initial decision-making process is referred as premigration.

The goal of this premigration is to:

- Ensure that you set up the vCore-based Azure Cosmos DB for MongoDB account to fulfill your application's requirements.
- Plan out how you execute the migration.

Our premigration is broken down into the following four steps or stages.

- **Pre-migration discovery** - Discover your existing MongoDB resources and create a data estate spreadsheet to track them.
- **Pre-migration assessment** - Assess the readiness of your existing MongoDB resources for data migration.
- **Pre-migration mapping** - Map your existing MongoDB resources to new vCore-based Azure Cosmos DB for MongoDB cluster.
- **Pre-migration logistics planning** - Plan the logistics of migration process end-to-end, before you kick off the full-scale data migration.

Following these four steps ensures a successful migration. Let's discuss these stages in more detail.

### Premigration discovery

The first step in the premigration process is to discover your existing MongoDB resources. This process includes identifying all the MongoDB databases, collections, and indexes that you want to migrate to the new vCore-based Azure Cosmos DB for MongoDB account.

To help us keep track of our MongoDB resources, it's helpful to create a data estate migration spreadsheet. This spreadsheet will:

- Include a comprehensive list of the existing resources (databases or collections) in your MongoDB data estate.
- Help you to plan migration from end-to-end.
- Should be used as a tracking document throughout the migration process.

### Assess the Premigration

Once you completed your discovery, you need to find out what features your current MongoDB environment uses that the vCore-based Azure Cosmos DB for MongoDB cluster might not support. You also need to know the vCore-based Azure Cosmos DB for MongoDB [cluster tier offerings](/azure/cosmos-db/mongodb/vcore/introduction#low-total-cost-of-ownership-tco). Once you make this assessment, you're able to address those findings as needed during rest of the migration planning. To learn more MongoDB compatibility info, visit the [MongoDB compatibility and feature support with vCore-based Azure Cosmos DB for MongoDB](/azure/cosmos-db/mongodb/vcore/compatibility) documentation.

### Map the premigration

The discovery and assessment were all about our MongoDB Source, now it's time to move the vCore-based Azure Cosmos DB for MongoDB side in these next two stages. Let's start with the capacity planning.

- **Capacity planning**: You need to determine the capacity requirements for your new vCore-based Azure Cosmos DB for MongoDB cluster. This planning includes deciding on the number of vCores, memory, and storage capacity you need to support your MongoDB workloads.
- **Plan the vCore-based Azure Cosmos DB for MongoDB data estate**: You need to map your existing MongoDB resources to the new vCore-based Azure Cosmos DB for MongoDB cluster. This plan includes deciding which databases, collections, and indexes you migrate to the new cluster.

### Premigration logistics plan

You collected, mapped, and modeled your vCore-based Azure Cosmos DB for MongoDB resources, its time to plan the actual execution logistics of the migration itself. Before you kick off the data migration, you need to answer a few questions:

- **Who is doing the Migration?** - Depending on the size of the migration, you would need to assign one or more individuals to both the migration of the resources and also monitor the migration progress of each resource.
- **What tools are you going to use to do the Migration?** - We can use many tools to perform the migration either online or offline. These tools are: the native MongoDB tools, using Azure Data Studio, or using the Azure Databricks service. In the next units, we'll go into more detail on these tools and how we can use those tools to migrate a MongoDB database to a vCore-based Azure Cosmos DB for MongoDB cluster.
- **In what order should we migrate the resources?** - Prioritizing what to migrate first allows you to keep your migration on schedule. A good practice is to prioritize migrating those resources that need the most time to be moved; migrating these resources first bring the greatest progress toward completion. Since the larger resources usually are the resources with the most data, migrating them first can additionally pinpoint any migration problems early on.
- **How will you monitor the migration process?** - You need to work with your team on what the monitoring process is so that you have a comprehensive view of how the high-priority migrations are going.

By answering these questions, you're able to plan out the logistics of your migration process and ensure that you're ready to start moving your MongoDB resources to the new vCore-based Azure Cosmos DB for MongoDB cluster.

## Post-migration

In the premigration phase, spend some time also detailing the post migration steps.

Some steps to take:

- **Cut over your application** - You should be redirect your application to the Azure Cosmos DB environment.
- **Plan your post migration configurations** - Subjects like scaling, high availability, backup, and restore should be planned. These settings can usually be changed on the fly and will most likely change during the lifespan of your collections. You should plan where those settings will sit right after the migration is done.

Migrating a MongoDB database isn't a point-and-click operation. You should spend some time planning for that migration. In the next couple of units, we'll discuss the actual migration steps further.
