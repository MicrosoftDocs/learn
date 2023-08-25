Now you've a well-managed, secured, and cost-effective search solution. The next step is to make sure your service is highly available and protected from disasters. 

Here, you'll explore how to protect your search service reliability and make it more responsive globally.

## Make your search solution highly available

The first and easiest way to improve the availability of your search solution is to increase the number of replicas. The only option is to have more than one in the paid-for search service tiers.

The Azure Cognitive Search service has availability guarantees based on the number of replicas you've:

- Two replicas guarantee 99.9% availability for your queries
- Three or more replicas guarantee 99.9% availability for both queries and indexing

The second way to add redundancy to your search solution is to use the Availability Zones. This option requires that you use at least a standard tier.

:::image type="content" source="../media/availability-zones.png" alt-text="A diagram showing three availability zones in a single region." border="false":::

When you add replicas, you can choose to host them in different Availability Zones. The benefit of distributing your replicas this way is that they're physically located in different data centers.

## Distribute your search solution globally

The most cost-efficient way to architect an Azure Cognitive Search service is in a single resource group and region. If your business priorities are availability and performance, host multiple versions of your search services in different geographical regions. The benefits of this architecture are:

- Protection against failure in a region. Azure Cognitive Search doesn't support instant failover, you would need to handle it manually.
- If you've globally distributed users or apps, locating a search service nearer to them will improve response times.

There's more work you'll need to do to replicate your indexes across all the regions you want to support. The options include having the same indexers based in each region ingesting the same source data. Or you can use the Push API to programmatically update all indexes in each region. The final piece is to manage search requests through an Azure Traffic Manager to route requests to the fastest responding search index (normally this will be the closest geographically unless that service isn't responding).

## Back up options for your search indexes

At present, Azure doesn't offer a formal backup and restore mechanism for Azure Cognitive Search. However, you can build your own tools to back up index definitions as a series of JSON files. Then you can recreate your search indexes using these files.
