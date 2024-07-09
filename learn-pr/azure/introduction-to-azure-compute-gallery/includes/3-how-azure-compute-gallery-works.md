Now that you know the basics of Azure Compute Gallery, let's see how it works. We'll look at the ideas behind some of Azure Compute Gallery's features, including scaling, sharing, and replication.

## Scaling

Azure Compute Gallery allows you to specify the number of replicas you want to keep. In multi-VM deployment scenarios the VM deployments can be spread to different replicas reducing the chance of instance creation processing being throttled due to overloading of a single replica. 

With Azure Compute Gallery, you can deploy up to a 1,000 VM instances in a scale set. You can set a different replica count in each target region, based on the scale needs for the region. Since each replica is a copy of your resource, this helps scale your deployments linearly with each extra replica.

![Diagram showing how images can be scaled.](../media/3-compute-gallery-scaling.png)

## High availability

Azure Compute Gallery uses Azure Zone Redundant Storage, which provides resilience against an Availability Zone failure in the region. With the general availability of Azure Compute Gallery, you can choose to store your images in ZRS accounts in regions with Availability Zones.

## Replication

Azure Compute Gallery allows you to replicate your resources to other Azure regions automatically. Each image version can be replicated to different regions depending on what makes sense for your organization.

The regions that a resource is replicated to can be updated after creation time. The time it takes to replicate to different regions depends on the amount of data being copied and the number of regions the version is replicated to. While the replication is happening, you can view the status of replication per region. Once the image replication is complete in a region, you can then deploy a VM or scale-set using that resource in the region.

## Sharing

There are three main ways to share images in an Azure Compute Gallery, depending on who you want to share with:

| Sharing with: | People | Groups | Service Principal | All users in a specific   subscription (or) tenant | Publicly with all users in   Azure |
|---|---|---|---|---|---|
| RBAC Sharing | Yes | Yes | Yes | No | No |
| RBAC + Direct shared gallery  | Yes | Yes | Yes | Yes | No |
| RBAC + Community gallery | Yes | Yes | Yes | No | Yes |
