[Azure Front Door ](/azure/frontdoor/front-door-overview)offers a fast, reliable, and secure modern cloud Content Delivery Network (CDN) by using the Microsoft global edge network to integrate with intelligent threat protection. Azure Front Door optimizes access times to content. Front Door can be used to provide another layer of reliability in front of your Azure resources. It is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, caching, etc. to improve performance and high-availability of your applications.

## How Azure Front Door works in reliability scenarios

 

In the following graphic, users are connecting to an app hosted in the custom domain Contoso.com. Azure Front Door is implemented at the edge location. Initially, the app is hosted in the primary region (marked active in the graphic). Front Door routes incoming requests to that region. However, if the app running in that region becomes unavailable, Front Door fails over to the secondary region (shown as standby). Azure Front Door refers to this strategy as priority-based traffic-routing.

:::image type="content" source="../media/front-door-integrate.png" alt-text="Front Door with an active and standby region.":::



This architecture builds on the following:

- **Primary and secondary region.** This architecture uses two regions to achieve higher availability. The app is deployed to each region. During normal operations, network traffic is routed to the primary region. If the primary region becomes unavailable, traffic is routed to the secondary region.

- **Front Door.** Front Door routes incoming requests to the primary region. If the application running that region becomes unavailable, Front Door fails over to the secondary region.

- **Geo-replication.** Geo-replication of SQL Database and/or Cosmos DB.

A multi-region architecture can provide higher availability than deploying to a single region. If a regional outage affects the primary region, you can use Front Door to fail over to the secondary region.

> [!TIP]
> This architecture can also help if an individual subsystem of the application fails.

**High availability scenarios**

There are several general approaches to achieving high availability across regions.

| **Approach**| **Description** |
| - | - |
| Active/passive with hot standby| Traffic goes to one region, while the other waits on hot standby. Hot standby means the VMs in the secondary region are always running. |
| Active/passive with cold standby| Traffic goes to one region, while the other waits on cold standby. Cold standby means the VMs in the secondary region aren’t allocated until needed for failover. This approach costs less to run but will generally take longer to come online during a failure. |
| Active/active| Both regions are active, and requests are load balanced between them. If one region becomes unavailable, it’s taken out of rotation. |