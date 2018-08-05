# Optimize network performance

## Motivation

One of the most basic things we can do to have a large impact performance of our application is to put the data close to where it's needed, not just when the data is at rest like databases, but also when it's in-flight. Especially in complex architectures with many different services, minimizing the latency at each hop can have a huge impact on the overall performance. In this section, we'll talk about the importance of network latency and understand how Lamna Healthcare adopted strategies to minimize network latency between their azure resources and between their users and Azure.

## The importance of network latency

Latency is a measure of delay. When we think about network latency, we are thinking about the time needed to get from a source to a destination across some form of network infrastructure. This is typically considered as a round trip delay (The time taken to get from the source to destination and back again).

If you are coming from an on-premises environment, then you may not consider latency as a big issue. This is because on-premises resources (let's assume virtual machines in this scenario) often share the same location and a common set of infrastructure. This reduces the time taken to get from source to destination, as they are housed so closely together. This means that the round-trip time of communications between those virtual machines is also less.

Consider a cloud environment. In comparison, a cloud environment is built for scale. The Virtual Machines that you host in the cloud may not be in the same set of racks, cluster, or even data center. This will have an impact on the round trip time of your network communications. Every transaction that is sent from the source to destination will be penalized in comparison to on premises, because of the extra time needed for the round-hop in cloud.

The chattier an application, the more round trips are required, therefore you want to batch your communications into as few requests as possible. You also want to be aware of which parts of your applications are chatty. Think about a web application. A web application may use an Object-relational mapping (ORM) framework to communicate to a back-end database. These ORM frameworks can typically ease your application development by generating migration scripts for your database schema and help you in quickly writing database queries (inserts, updates, deletions etc.). However, they may not be optimized for data transmission and typically split out into separate requests/calls.

Let's consider the example of a website and a database communicating with each other and I want to update a number of records.

* If I issue one query through my ORM I might expect one call to occur. Instead, it may be split into 10 individual calls.
* On premises, that may not be such a significant problem as the round trip time may be 5ms. In a cloud environment, that may increase to 20ms.
* This then means that my round trip time increases from 50ms (10 calls * 5ms) to 200ms (10 calls * 20ms), and would be a notable performance impact
* On top of the round-trip time, the request itself would also need to be executed by the database and the connection would need to be opened/closed.

A final point worth mentioning is transient faults. A [transient fault][transient-faults] is a temporary or momentary loss of network connectivity to a component or service, unavailability of the service itself or timeouts due to a busy service. These faults can occur in all applications that communicate with remote services. In a cloud environment (due to internet connectivity) and shared resources, these transient faults are likely to be encountered. If you do not have any retry logic or preparation for transient faults in your application already, then you should familiarize yourself with the [retry mechanisms as part of Client SDKs][retry-guidance-services] or whether you need to build your own [retry pattern][retry-pattern].

## Latency in the context of Azure Resource to Azure Resource Communication

Before we talk about latency between Azure resources, we should first address the concept of an Azure region. An [Azure region][azure-regions] is a set of data centres deployed within a geography connected through a dedicated regional low-latency network.

### Lamna Healthcare web application and database example

Let's consider Lamna Healthcare. Imagine that Lamna Healthcare have begun piloting a new patient booking system with a simple architecture, one web server and one database in a single Azure region (West Europe, which is hosted in the Netherlands). The website is retrieving media assets (images, javascript, stylesheet) from Azure blob storage in the same region. This is a clean approach, and minimizes the data time on the wire due to the co-location of resources inside an Azure region.

However, let's suppose that the pilot of the patient booking system has gone well and has been expanded to users in Ireland. Those users may suffer the roundtrip time from Ireland to the Netherlands to view the website.

The Lamna Healthcare team make a decision to host another website frontend instance in the North Europe region (hosted in Ireland) to reduce user latency. This is a naive approach, as the web server has been designed to still connect to the database and Azure blob storage in West Europe. This will decrease the latency of the user loading the front end page, but will then introduce latency between the web server and the database/Azure blob storage. Additionally, the team will need to consider whether the database is now set at a suitable level of scale to handle the multiple website front end nodes.

The latency between the newly created website and the database /Azure blob storage is a point to consider. Remember the point initially discussed in the section describing network latency about ORMs. Each of those individual requests from an ORM will now have to travel from one Azure region (North Europe) into another (West Europe) and back again. This will introduce a significant performance bottleneck and network egress charges into the solution.

There are strategies to handling this.

* Consider co-locating an API endpoint with the master database, so that the latency of writes to the database is minimized from the point where they are executed.
* Consider adopting the [Command Query Responsibility Separation (CQRS)][cqrs-pattern] pattern. This is an approach where you separate out your reads from your writes, or even [sharding][sharding] the database across regions. The benefit is that the application could reduce the latency for round-trip reads by co-locating a read replica, while also enabling the master to scale primarily for write activities.
  * Lamna Healthcare could consider adopting [Azure Cosmos DB][azure-cosmosdb], a platform as a service (PaaS) option to [globally distribute their data][azure-cosmosdb-global-distribution]. They could host an API endpoint in the same region as their CosmosDB write-region, and have a read-region locally.
  * Lamna Healthcare may also consider using [Azure SQL DB][azure-sql-db], the PaaS version of Microsoft SQL Server. This also allows for read replicas of the database by using [Active geo-replication][azure-sql-db-activegeoreplication].

## Latency in the context of users to Azure

We previously considered the latency between our Azure resources, but we also want to consider the latency between users and our solution. This will optimise for the delivery of the front-end user interface to our users.

In the Lamna Healthcare example, we saw that the team created an additional web front end node in North Europe. A challenge in their current approach is that end-users would have to explicitly target which endpoint that they want to use. As the designer of a solution, Lamna Healthcare would want to make this experience as seamless for their users as possible.

This is where Azure Traffic Manager comes into play. [Azure Traffic Manager][azure-traffic-manager] is a DNS-based load balancer and enables you to balance traffic across multiple Azure regions. Rather than making the user browse to a specific deployment of our Web front end, Azure traffic manager can route users based upon a set of characteristics.

These include:

* **Priority** - You would set a prioritized order of instances web front end instances. If the one with the highest priority is unavailable, then traffic manager will route the user to the next available.
* **Weighted** - You would set a weight against each web front end instance. This then allows you to distribute traffic according to a certain ratio.
* **Performance** - Azure traffic manager would route your users to the closest web front end instance in terms of the lowest network latency.
* **Geographic** - You could setup geographical regions for web front end deployments, routing your users based upon data sovereignty mandates or localization of content.

Traffic Manager profiles can also be nested. This means that you could first route your users across different Geographies (e.g. US and EMEA) based upon rules you have defined and then route users to another traffic manager that takes users to a web front end deployment instance based upon network latency performance.

Let's factor that into the Lamna Healthcare example. Consider that they have deployed a web front end in North Europe and West Europe. Let's assume they have deployed Azure SQL DB with their primary deployment in west europe, and a read replica in north europe. Let's also assume the application is able to connect to the local SQL instance for read queries.

The team could deploy an Azure Traffic Manager instance in performance mode and add those two front end instances as Traffic Manager profiles. As an end-user, you would then navigate to a custom domain name (e.g. lamnahealthcare.com) which is actually Azure traffic manager. Azure traffic manager then routes you to either north europe or west europe based upon the network latency performance.

There is another optimization that could be made. The website will likely be using some form of static content (either whole pages or assets such as images and videos). The team could use the [static content hosting pattern][static-content-hosting-pattern] to serve the static content to end-users.

The way to achieve this is by using a Content Delivery Network (CDN). A [Content Delivery Network][azure-cdn] is a globally distributed set of servers used to serve content to end-users. This could be used to cache media assets or even full pages of a website. A benefit of this approach is that it reduces the compute required assets from the web front ends. In addition, the content will also be cached at a CDN edge server local to the user, resulting in low latency access to the cached content.

Content Delivery Networks can also be used to host dynamic content, though thought should be given here to the TTL (Time to Live) on how long the content should be cached, before repopulating from the origin (or source). If the TTL is too long, then this could mean that out of date content is being displayed and the cache needs to be purged. There is also an option to use additional features of CDN called [Dynamic Site Acceleration][azure-cdn-dynamic-site-acceleration] to increase the performance of web pages with dynamic content. This allows you to have a low-latency path to additional services in your solution (for example, an API endpoint) rather than caching it.

Let's add this into the Lamna Healthcare solution. 

* The team configure an AzureCDN instance to cache edge servers with the assets from Azure blob storage.
* The team configure the application to retrieve  assets from the CDN edge servers instead of Azure blob storage directly. This means the user will retrieve the media assets from an edge server near to them, minimizing the latency.

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