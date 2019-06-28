Consider carefully how each component of your app behaves across locations and when there's a failure.

To make the shipping application architecture fault-tolerant and resilient to the failure of an entire region, you need to explicitly duplicate certain components in a paired region. This duplication includes Azure App Service, the Function App, Redis Cache, and the queue. You'll have two of each of these services in respective regions.

Here, you'll learn how to use resource groups and Azure Storage accounts in a distributed app.

## Using resource groups

For ease of administration and management, you'll group resources together in the most logical resource group combinations. All of the resources that share the same lifecycle should be grouped together. For example, you should place the components of the shipping company's architecture for the primary region in one resource group. The components of the secondary region can go in another resource group. Traffic Manager, which sits outside and orchestrates between the regions, should have its own independent resource group. In this way, all the components that belong together are managed and administered using the same tools.

Other services are less tied to a single region. For example:

- **Azure DNS**, which provides domain name resolution. You looked at this area in the last unit.
- **Azure AD**, which will provide authentication services for the app.
- **The Azure CDN**, which serves static content from locations closest to the user and is present in multiple point-of-presence (POP) locations. There are more POPs than Azure has regions.

<!-- todo: DIAGRAM based on the one here https://docs.microsoft.com/en-us/azure/cdn/cdn-overview but clearly showing POPs in more (or different) areas than there are Azure regions. This will illustrate the point that a number of Azure services are highly multiregional out of the box-->

## Azure Storage

The best approach for Azure Storage is to use read-access geo-redundant storage (RA-GRS). Data is replicated to the secondary paired region and, if there's a regional outage, there will be read-only access to data in the secondary region.

You'll have some important data loss possibilities when a problem affects Azure Storage in a region. RA-GRS also provides for data being written to a secondary region but this replication happens asynchronously. If you've a problem in Azure Storage, it might be that certain writes aren't replicated to the secondary region, so there's some data loss. 

The decision about whether to do a full failover to the secondary region is taken by the Azure Storage team rather than at a user's discretion. There could be a period of time when you only have read access to the secondary region, and no write access. As you've seen throughout this module, your app needs to be robust against the possibility of momentary failures that aren't attributable to the failure of a region and therefore won't trigger a full failover. You can build some mitigations into your app to guard against these kinds of failures. The application should already be designed to retry writes in case there's a failure. 

These retry attempts need to be intelligent. If a given service is experiencing problems, there's no point hammering it, so retries should be exponentially spaced out. After a sufficiently long period of retries without success, it might be worth manually switching to a queue in another region. This action would collect writes while the primary region is experiencing problems – but not so severe as to have triggered a full failover. 

Other possible mitigations include providing read-only access to the system for a period, and deliberately reducing the available functionality. For example, the UI to create and manage shipments could be grayed out while the application subsystems are experiencing problems.