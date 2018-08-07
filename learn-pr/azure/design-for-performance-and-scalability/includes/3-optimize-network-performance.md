# Optimize network performance

## Motivation

One of the most basic things we can do to improve application performance is to put the data close to where it's needed. This change isn't just when data is at rest, but also when it's in-flight. In complex architectures with many different services, minimizing the latency at each hop can have a huge impact on the overall performance. In this section, we'll talk about the importance of network latency. We'll also discuss how Lamna Healthcare adopted strategies to minimize network latency between their azure resources and between their users and Azure.

## The importance of network latency

Latency is a measure of delay. Network latency is the time needed to get from a source to a destination across some network infrastructure. This time period is commonly known as a round-trip delay, or the time taken to get from the source to destination and back again.

If you're used to building on-premises, then you may not think of latency as a significant issue. On-premises resources often share the same location and a common set of infrastructure. The time taken to get from source to destination is lower as they're housed so close together.

In comparison, a cloud environment is built for scale. Cloud-hosted virtual machines may not be in the same set of racks, cluster, or even data center. This deployment approach will have an impact on the round-trip time of your network communications. Every transaction that is sent from a source to a destination in a cloud environment will appear longer than on-premises. This increase is because of the extra time needed for the round-hop in cloud.

The chattier an application, the more round trips that are required. Consider batching your communications into as few requests as possible. You'll want to be aware of which parts of the applications are chatty. Think about a web application. A web application may use an Object-relational mapping (ORM) framework to communicate to a database. These ORM frameworks can typically ease your application development by creating migration scripts for your database schema and help you to quickly write database queries (inserts, updates, deletions). However, they may not be optimized for data transmission and typically split out queries into separate requests/calls.

Let's consider the example of a website and a database communicating with each other and I want to update a number of records.

* If I issue one query through my ORM, I might expect one call to occur. Instead, it may be split into 10 individual calls.
* On premises, that may not be such a significant problem as the round-trip time may be 5 ms. In a cloud environment, that may increase to 20 ms.
* The added network latency means that my round-trip time increases from 50 ms (10 calls * 5 ms) to 200 ms (10 calls * 20 ms), and would be a notable performance impact.
* Next, the request itself would also need to be executed by the database and the connection would need to be opened/closed.

A final point worth mentioning is transient faults. A [transient fault][transient-faults] could be thought as:

* Temporary loss of network connectivity to a component or service
* Unavailability of a service
* Timeouts because of a busy service

These faults can occur in all applications that communicate with remote services. In a cloud environment (relying on internet connectivity) and shared resources, these transient faults are likely to occur. You can protect against this by using [retry mechanisms as part of Client SDKs][retry-guidance-services] and the [retry pattern][retry-pattern].

## Latency in the context of Azure Resource to Azure Resource Communication

Before we talk about latency between Azure resources, we should first address the concept of an Azure region. An [Azure region][azure-regions] is a set of data centers connected through a dedicated regional low-latency network.

### Lamna Healthcare web application and database example

Let's consider Lamna Healthcare. Imagine that Lamna Healthcare is piloting a new patient booking system using one web server and one database in a single Azure region (West Europe). The website is retrieving media assets (images, javascript, stylesheets) from Azure blob storage in the same region. This architecture minimizes the data time on the wire as resources are co-located inside an Azure region.

Suppose that the pilot of the system went well and has been expanded to users in Ireland. Those users may suffer the roundtrip time from Ireland to the Netherlands to view the website.

The Lamna Healthcare team decide to host another frontend instance in North Europe to reduce user latency. This design is naive, as the frontend is designed to connect to the database and Azure blob storage in West Europe. It will lower the latency of users loading the front-end page, but will then introduce latency between the web server and the backend services.

The latency between the newly created website and the database /Azure blob storage is a point to consider. Remember the point initially discussed in the section describing network latency about ORMs. Each of those individual requests from an ORM will now have to travel from one Azure region (North Europe) into another (West Europe) and back again. Significant performance bottleneck and network egress charges will be introduced into the solution.

There are strategies to reducing latency between resources;

* Co-locate an API endpoint with the master database. Latency of writes to the database is minimized from the point where they are requested.
* Consider adopting the [Command Query Responsibility Separation (CQRS)][cqrs-pattern] pattern, which separating reads from writes. Database [sharding][sharding] across regions could be adopted. The application could reduce latency of round-trip reads by hosting a local read replica, while enabling the master to scale for write activities.
  * Lamna Healthcare could consider adopting [Azure Cosmos DB][azure-cosmosdb], a platform as a service (PaaS) option to [globally distribute their data][azure-cosmosdb-global-distribution]. They could host an API endpoint in the same region as their CosmosDB write-region, and have a read-region locally.
  * Lamna Healthcare may also consider using [Azure SQL DB][azure-sql-db], the PaaS version of Microsoft SQL Server. Azure SQL DB enables simple read replica databases by using [Active geo-replication][azure-sql-db-activegeoreplication].

## Latency in the context of users to Azure

We previously considered the latency between our Azure resources, but we should also consider the latency between users and our solution. This thought will optimize delivery of the front-end user interface to our users.

In the Lamna Healthcare example, we saw that the team created an additional web front-end node in North Europe. However, end users have to explicitly target which frontend endpoint they want to use. As the designer of a solution, Lamna Healthcare wants to make the experience as smooth as possible for their users.

Azure Traffic Manager could help. [Azure Traffic Manager][azure-traffic-manager] is a DNS-based load balancer and enables you to balance traffic across Azure regions. Rather than making the user browse to a specific deployment of our Web front end, Azure traffic manager can route users based upon a set of characteristics.

The approaches are:

* **Priority** - You would set an ordered list of front-end instances. If the one with the highest priority is unavailable, then traffic manager will route the user to the next available.
* **Weighted** - You would set a weight against each front-end instance. Traffic manager then distributes traffic according to those defined ratios.
* **Performance** - Azure traffic manager routes users to the closest front-end instance based on network latency.
* **Geographic** - You could set up geographical regions for front-end deployments, routing your users based upon data sovereignty mandates or localization of content.

Traffic Manager profiles can also be nested. You could first route your users across different Geographies (for example, US and Europe) using Geographic routing and then route to local front-end deployments using the Performance routing method.

Consider that Lamna Healthcare has deployed a web front end in North Europe and West Europe. Assume they have deployed Azure SQL DB with their primary deployment in west europe, and a read replica in north europe. Let's also assume the application can connect to the local SQL instance for read queries.

The team deploy an Azure Traffic Manager instance in performance mode and add the two front-end instances as Traffic Manager profiles. As an end user, you navigate to a custom domain name (for example, lamnahealthcare.com) which routes to Azure traffic manager. Azure traffic manager then routes you to either north europe or west europe based on the best network latency performance.

The website will likely be using some form of static content (either whole pages or assets such as images and videos). The team could use the [static content hosting pattern][static-content-hosting-pattern] to serve the static content to end users.

The pattern could be achieved by using a Content Delivery Network (CDN). A [Content Delivery Network][azure-cdn] is a globally distributed set of servers used to provide content to end users. The CDN could be used to cache media assets or even full pages of a website. A benefit of this approach is that it reduces the compute required assets from the web front ends. The content will also be cached at a CDN edge server local to the user, resulting in low latency access to the cached content.

Content Delivery Networks can be used to host dynamic content. Extra consideration should be made when caching dynamic content, as cached content may be out of date compared with the source content. Context expiration can controlled by setting a TTL (time to live). If the TTL is too high, out-of-date content may be displayed and the cache would need to be purged.

There is an option called [Dynamic Site Acceleration][azure-cdn-dynamic-site-acceleration], which can increase performance of web pages with dynamic content. Dynamic Site Acceleration can also provide a low-latency path to additional services in your solution (for example, an API endpoint).

Let's add the static content hosting pattern into the Lamna Healthcare solution.

The team configure an AzureCDN instance to cache edge servers with the assets from Azure blob storage. They also configure the application to retrieve assets from the CDN edge servers instead of Azure blob storage directly. Users will retrieve media assets from an edge server near to them instead of the original blob store, minimizing the latency.

We have discussed the options to lower network latency between end users and Azure and between Azure resources. Next, we'll talk about optimizing storage performance.

<!-- links -->
[azure-cdn]: https://docs.microsoft.com/en-us/azure/cdn/cdn-overview
[azure-cdn-dynamic-site-acceleration]: https://docs.microsoft.com/en-us/azure/cdn/cdn-dynamic-site-acceleration
[azure-cosmosdb]: https://docs.microsoft.com/en-us/azure/cosmos-db/
[azure-cosmosdb-global-distribution]: https://docs.microsoft.com/en-us/azure/cosmos-db/distribute-data-globally
[azure-sql-db]: https://docs.microsoft.com/en-us/azure/sql-database/
[azure-sql-db-activegeoreplication]: https://docs.microsoft.com/en-us/azure/sql-database/sql-database-geo-replication-overview

[azure-regions]: https://azure.microsoft.com/en-gb/global-infrastructure/regions/

[azure-traffic-manager]: https://docs.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview
[cqrs-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/cqrs
[retry-guidance-services]: https://docs.microsoft.com/en-us/azure/architecture/best-practices/retry-service-specific
[retry-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/retry
[sharding]: https://docs.microsoft.com/en-us/azure/architecture/patterns/sharding
[static-content-hosting-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/static-content-hosting
[transient-faults]: https://docs.microsoft.com/en-us/azure/architecture/best-practices/transient-faults