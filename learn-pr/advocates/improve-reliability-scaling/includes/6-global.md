In the previous unit, we've described scaling compute, and making it more
available in the process. We've also suggested adding an Azure Cache for
Redis to improve performance, and scaling out Azure SQL databases via
sharding.

The next step, as your business grows, might be to go global. However,
there are some things you need to think about before trying to implement a
completely global architecture.

## Questions to ask

The first question is: _Do you really need to go global?_

It’s important to understand what pain our customers have before taking on
such a task, so ask yourself a few more questions:

-   Can you get content closer to your users via a content delivery
    network?
-   Do you really need to scale this particular system across two (or more)
    geographies? For example, does a user in the United States need to have
    the exact same account in the United Kingdom? Would independent systems
    be more suitable? This pattern is very common in e-commerce.
-   If you really do need a globally distributed system, what consistency
    do you need for the database? Strong consistency across the globe is
    very difficult to get right, and is not permitted in services such as
    Cosmos DB, literally due to the speed of light.

## Data consistency

Let’s look a bit more closely at the issue of data consistency.

*Consistency in database systems* refers to the requirement that any
given database transaction must change affected data only in ways that are
allowed.  There are two consistency models used in distributed computing.

_Strong consistency_ offers a linearizability guarantee. This basically
means that the reads are guaranteed to return the most recent committed
version of an item.

And then there’s _eventual consistency_, which is a little less consistent.
This is the idea that a database or system will eventually become
consistent over time. There's no ordering guarantee for reads. In the
absence of any further writes, the replicas eventually converge.

## Tools for going global

If you find that you really do need to scale your application globally,
there are some Azure services that can help you achieve that. Take a look
at Azure Traffic Manager and Azure Front Door:

-   Azure Traffic Manager is a global DNS-based load-balancing service.
    This means that it uses DNS and health probes to route your users to
    the best healthy back end based on the routing policies you’ve defined.
    This could be based on performance, location, round robin, and so on. After a
    healthy back end is identified, clients always connect directly to the
    back end.
-   Azure Front Door Service is an Application Delivery Network (ADN) as a
    service, offering various layer 7 load-balancing capabilities for your
    applications. It provides dynamic site acceleration (DSA) along with
    global load balancing with near real-time failover. It is a highly
    available and scalable service, which is fully managed by Azure.

Azure Front Door is basically a global HTTP-based load balancer. The client
establishes a connection with Front Door itself, so Front Door is proxying
the users’ request. If the item requested isn’t in the cache, the correct
routing rule will be identified. Then, it will check the health probe of the
relevant backend, and assuming all is healthy, the user request is
forwarded to the best back end based on the routing method.

Because the connection is proxied by Azure Front Door, you can perform some
advanced functions such as running a Web Application Firewall, as well as
caching, which is helpful for scaling. Neither of these can be achieved
with Traffic Manager.

The illustration shows how you can use both together.

:::image type="content" source="../media/global-architecture.png" alt-text="Full architecture diagram showing both Azure Front Door and Traffic manager in the same architecture.":::

This setup uses Traffic Manager for simple DNS-based load balancing to your
static assets in storage accounts, and Front Door for path-based routing on
your web application across App Service and VMs.
