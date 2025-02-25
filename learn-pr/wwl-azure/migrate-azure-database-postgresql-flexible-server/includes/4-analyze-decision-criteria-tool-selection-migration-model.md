

Now that we explored the options for migration methodologies and tooling options, we can explore the decision criteria we need to consider to execute our migrations to Azure Database for PostgreSQL Flexible Server. The three main criteria that help us make our choices are **Downtime**, **Source database location**, and **Customizability**.

## Downtime

Downtime is a key facet of migration activities and the duration that is acceptable to the stakeholders helps us decide on whether we have to perform an offline or online migration activity.

Normally, migration activities are planned well in advance to ensure that appropriate change controls and associated governance are completed for the activity. This planning allows a dialog with key stakeholders to understand how long the system can be offline. In this situation, it's advisable to know how long it takes for the different options you can establish estimated minimum and maximum downtime durations.

Establishing the minimum downtime needed to perform an application cut-over is key. Ultimately, this time is the amount that you have to take the system offline even for an online (or minimal downtime) migration activity. The complexity of the application is going to dictate this timescale. For a relatively simple application, this process could be a case of stopping a service, updating a configuration file, then turning it back on. In more complex environments, this process can take a lot longer if there are multiple servers and application layers in play.

Understanding the duration needed for online or offline migration activities is the next important element related to downtime. If it's an offline migration, the time taken to extract, transfer, and load the data from the source to the destination followed by validation and verification is your downtime. This downtime is then sandwiched between the time it takes to turn off the app/workload and the time taken to turn the app/workload back on.

If it's an online (minimal downtime) migrations, the downtime is the duration needed to synchronize the final changes from the source to the destination once the application is turned off. Add to that downtime, the validation, and verification activities before then reconfiguring and enabling the application/workload.

Once we have this information, we can look at the technical elements of the migration to help establish what our viable options are.

## Source database location

The source location of the databases to be migrated play a part because of the constraints that are likely to be in place for any given configuration.

### On-premises or non-Azure sources

For an on-premises or non-Azure located database, the key constraint is typically the network connectivity between source and target. The three points to consider here are bandwidth, latency, and volume of data. Once we understand these points, we can make an informed decision about which type of migration is viable.

If we have a large volume of data to migrate and a proportionally small amount of bandwidth, then a simple dump and restore is probably going to not be viable. Whereas if we have a large volume of data and a large amount of bandwidth, then it's less of a concern.

Likewise, if it's an online migration where data synchronization is going to take place then latency is one of the key factors. If latency is high, there could be adverse impacts on system performance because the synchronization process takes excessively long to complete.

One important factor to also consider when migrating from other cloud providers is whether they charge for data egress. If so, then being able to minimize the physical footprint of the data being transferred could be a consideration. In situations like this, compression technology can be important for dumps or data streams used for synchronization.

### Other Azure based services

There are going to be situations where you want to migrate from other Azure based services into Azure Database for PostgreSQL Flexible Server. These source databases could be in Azure VMs, containers, or possibly Azure Database for PostgreSQL Single Server. If so, then there's a different set of considerations to explore but at the same time, several opportunities to benefit from optimizations within the Azure services for these scenarios.

## Customizability

The final area of consideration is how much customization is needed or desired. This consideration can take the form of needing to modify the source database structure to support data replication, alternatively, it could mean how easy it's for you to automate via scripting.

A good example would be automating the offline migration of a database via pg_dump and pg_restore but at the same time including the compression and decompression of the dump files.

## Decision making

Now that we went through the process for gathering all of this information, we can work with the stakeholders to determine the best option for a given scenario. When making the decision on which methodology and technology set to use it's important to not just work with the business stakeholders, but also the technical stakeholders. This collaboration helps avoid a situation where the business drives for a minimal downtime migration, which the technical team isn't in a position to deliver because of staffing, resource, or technology constraints.

The key thing here's to manage expectations and have an open and honest dialog. It's also important to ensure that the business takes ownership of validation tasks that sit outside the remit of the technical teams delivering the database migration. This validation can involve data consistency and validation checks, and user experience testing.
