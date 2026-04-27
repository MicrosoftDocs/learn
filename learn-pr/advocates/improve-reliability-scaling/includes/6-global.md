In the previous unit, we described scaling compute, and making it more available in the process. We also suggested adding Azure Managed Redis to improve performance, and scaling out Azure SQL databases via sharding.

The next step, as your business grows, might be to go global. However, there are some things you need to think about before trying to implement a fully global architecture.

## Questions to ask

The first question is: *Do you really need to go global?*

It’s important to understand what pain our customers have before taking on such a task, so ask yourself a few more questions:

- Can you get content closer to your users via a content delivery network?
- Do you really need to scale this particular system across two (or more) geographies? For example, does a user in the United States need to have the exact same account in the United Kingdom? Would independent systems be more suitable? This pattern is common in e-commerce.
- If you really do need a globally distributed system, what consistency do you need for the database? Strong consistency across the globe is difficult to get right. Services such as Cosmos DB do support strong consistency in multi-region configurations, but it comes with significant trade-offs including higher latency, reduced availability during regional outages, and increased RU consumption per operation.

## Data consistency

Let’s look a bit more closely at the issue of data consistency.

In distributed computing, *consistency* refers to how up-to-date and uniform the data is across all replicas of a system. There are two primary consistency models.

*Strong consistency* offers a guarantee of linearizability. The reads are guaranteed to return the most recent committed version of an item.

And then there’s *eventual consistency*, the idea that a database or system will eventually become consistent over time. There's no ordering guarantee for reads. In the absence of any further writes, the replicas eventually converge.

Services like Cosmos DB also offer intermediate consistency models, such as bounded staleness, session, and consistent prefix, which provide different balances between performance and data freshness.

## Tools for going global

If you find that you really do need to scale your application globally, there are some Azure services that can help you achieve that. Let's take a look at Azure Traffic Manager and Azure Front Door:

- Azure Traffic Manager is a global DNS-based load-balancing service. It uses DNS and health probes to route your users to the best healthy back end based on the routing policies you’ve defined. This routing could be based on performance, location, round robin, and so on. After a healthy back end is identified, clients always connect directly to the back end.
- Azure Front Door is a modern cloud CDN and global load balancer, offering various layer 7 load-balancing capabilities for your applications. It provides dynamic site acceleration (DSA) along with global load balancing with near real-time failover. It's a highly available and scalable service, fully managed by Azure.

Azure Front Door is basically a global HTTP-based load balancer. The client establishes a connection with Front Door itself, so Front Door is proxying the users’ request. If the requested item isn’t in the cache, the correct routing rule is identified. Then, it checks the health probe of the relevant back end, and assuming all is healthy, forwards the user request to the best back end based on the routing method.

Because Azure Front Door proxies the connection, you can perform some advanced functions such as running a Web Application Firewall, and caching, which is helpful for scaling. Neither of these functions can be achieved with Traffic Manager.

The diagram shows how you can use both together.

:::image type="content" source="../media/global-architecture.png" alt-text="Full architecture diagram showing both Azure Front Door and Traffic Manager in the same architecture.":::

This setup uses Traffic Manager for simple DNS-based load balancing to your static assets in storage accounts. It also uses Front Door for path-based routing on your web application across App Service and VMs.
