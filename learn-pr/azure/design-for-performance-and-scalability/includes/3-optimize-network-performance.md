Network performance can have a dramatic impact on a users experience. In complex architectures with many different services, minimizing the latency at each hop can have a huge impact on the overall performance. In this unit, we'll talk about the importance of network latency and how to reduce it within your architecture. We'll also discuss how Lamna Healthcare adopted strategies to minimize network latency between their Azure resources as well as between their users and Azure.

## The importance of network latency

Latency is a measure of delay. Network latency is the time needed to get from a source to a destination across some network infrastructure. This time period is commonly known as a round-trip delay, or the time taken to get from the source to destination and back again.

In a traditional data center environment latency may be minimal since resources often share the same location and a common set of infrastructure. The time taken to get from source to destination is lower physically close together.

In comparison, a cloud environment is built for scale. Cloud hosted resources may not be in the same rack, data center, or even region. This distributed approach can have an impact on the round-trip time of your network communications. While all Azure regions are interconnected by a high-speed fiber backbone, the speed of light is still a physical limitation. Calls between services in different physical locations will still have network latency directly correlated to the distance between them.

On top of this, the chattier an application, the more round trips that are required. Each round trip comes with a latency tax, with each round trip adding to the overall latency.

![NetworkLatency](networkLatency.png)

Now let's take a look at how to improve performance between Azure resources and from your end users to yor Azure resources.

## Latency in the context of Azure Resource to Azure Resource Communication

Imagine that Lamna Healthcare is piloting a new patient booking system using one web server and one database in a the West Europe Azure region. The website is retrieving static media assets (images, javascript, stylesheets) from Azure blob storage in the same region. This architecture minimizes the data time on the wire as resources are co-located inside an Azure region.

Suppose that the pilot of the system went well and has been expanded to users in Australia. Those users will incur the round trip time from Ireland to the Australia to view the website and end user experience is poor due to the network latency.

The Lamna Healthcare team decide to host another front end instance and storage account in the Australia East region to reduce user latency. While this design helps reduce the time for the web server to return content to end users, experience is still poor since there's significant latency communicating between the front end web server in Australia East and the database in West Europe.

There's a few ways we could reduce the remaining latency:

* Create a read-replica of the database in Australia East. This would allow reads to perform well, but writes would still incur latency. Azure SQL Database geo-replication allows for read-replicas.
* Sync your data between regions with Azure SQL Data Sync.
* Use a globally distributed database such as [Azure Cosmos DB][azure-cosmosdb]. This would allow both reads and writes to occur regardless of location.

The goal here is to minimize the network latency between each layer of the application. How this is solved depends on your application and data architecture, but Azure provides mechanisms to solve this on several services.

## Latency in the context of users to Azure

We've looked at the latency between our Azure resources, but we should also consider the latency between users and our solution. We're looking to optimize delivery of the front end user interface to our users. Let's take a look at some ways to improve the network performance between end users and the application.

### Use a DNS load balancer for endpoint path optimization

In the Lamna Healthcare example, we saw that the team created an additional web front end node in Australia East. However, end users have to explicitly specify which front end endpoint they want to use. As the designer of a solution, Lamna Healthcare wants to make the experience as smooth as possible for their users.

Azure Traffic Manager could help. [Azure Traffic Manager][azure-traffic-manager] is a DNS-based load balancer and enables you to distribute traffic within and across Azure regions. Rather than having the user browse to a specific instance of our web front end, Azure Traffic Manager can route users based upon a set of characteristics:

* **Priority** - You specify an ordered list of front end instances. If the one with the highest priority is unavailable, then traffic manager will route the user to the next available.
* **Weighted** - You would set a weight against each front end instance. Traffic manager then distributes traffic according to those defined ratios.
* **Performance** - Azure traffic manager routes users to the closest front end instance based on network latency.
* **Geographic** - You could set up geographical regions for front end deployments, routing your users based upon data sovereignty mandates or localization of content.

Traffic Manager profiles can also be nested. You could first route your users across different Geographies (for example, Europe and Australia) using geographic routing and then route to local front end deployments using the performance routing method.

Consider that Lamna Healthcare has deployed a web front end in West Europe and Australia. Assume they have deployed Azure SQL Database with their primary deployment in West Europe, and a read replica in Australia East. Let's also assume the application can connect to the local SQL instance for read queries.

The team deploy an Azure Traffic Manager instance in performance mode and add the two front-end instances as Traffic Manager profiles. As an end user, you navigate to a custom domain name (for example, lamnahealthcare.com) which routes to Azure traffic manager. Azure traffic manager then returns the DNS name of the West Europe or Australia East front end based on the best network latency performance.

It's important to note that this load balancing is only handled via DNS, there's no inline load balancing or caching that's happening here, Traffic Manager is simply returning the DNS name of the closest front end to the user.

### Use CDN to cache content close to users

The website will likely be using some form of static content (either whole pages or assets such as images and videos). The team could use the [static content hosting pattern][static-content-hosting-pattern] to serve the static content to end users.

The pattern could be achieved by using a content delivery network (CDN) such as Azure CDN. [Azure CDN][azure-cdn] is a globally distributed set of servers used to provide content to end users. The CDN could be used to cache media assets or even full pages of a website. This approach not only places the content closer to the end user, but also offloads request from your web servers. The content will be cached at a CDN edge server local to the user, resulting in low latency access to the cached content.

![CDNExample](cdnSketch.png)

Content Delivery Networks can be used to host dynamic content. Extra consideration should be made when caching dynamic content, as cached content may be out of date compared with the source content. Context expiration can controlled by setting a TTL (time to live). If the TTL is too high, out-of-date content may be displayed and the cache would need to be purged.

Azure CDN has a feature called [Dynamic Site Acceleration][azure-cdn-dynamic-site-acceleration], which can increase performance of web pages with dynamic content. Dynamic Site Acceleration can also provide a low-latency path to additional services in your solution (for example, an API endpoint).

Let's add the static content hosting pattern into the Lamna Healthcare solution.

The team configure an Azure CDN instance to cache edge servers with the assets from Azure blob storage. They also configure the application to retrieve assets from the CDN edge servers instead of Azure blob storage directly. Users will retrieve media assets from an edge server near to them instead of the original blob store, minimizing the latency.

### Use ExpressRoute for connectivity from on-premises to Azure

Optimizing network connectivity from your on-premises environment to Azure is also important. For users connecting to applications, whether they're hosted on virtual machines or on PaaS services, you'll want to ensure they have the best connection to your applications. 

You can always use the public internet to connect users to your services, but internet performance can vary, and may be impacted by outside issues. On top of that, you may not want to expose all of your services over the internet, and would like a private connection to your Azure resources.

Azure ExpressRoute can help. ExpressRoute is a private, dedicated connection between your network and Azure, giving you guaranteed performance and ensuring that your end users have the best path to all of your Azure resources.

![ExpressRoute](expressroute-connection-overview.png)


Once again looking at Lamna's scenario, they decide to further improve end user experience for those who are in their facilities by provisioning an ExpressRoute circuit in both Australia East and West Europe, giving their end users a direct connection to their booking system and ensuring the lowest latency possible for their application.

## Summary

Considering the impact of network latency on your architecture is important to ensure the best possible performance for your end users. We've take a look at some options to lower network latency between end users and Azure and between Azure resources. Next, we'll talk about optimizing storage performance.

## Knowledge Check

Network latency is:

* The amount of noise on the network
* The amount of time it takes for information to be sent from a source to a destination
* The TTL of an asset in my Content Delivery Network
* The delay before packets will be sent (Correct)

Our application is hosted on East US. Pick two strategies to optimize network latency for users that are located across the globe (e.g. Europe or Australia):

* Deploy ExpressRoute to each of your users
* Use a Content Delivery network to place assets/content closer to your users (Correct)
* Use Traffic Manager in Performance routing mode (Correct)
* Deploy more instances in East US to server the extra user load

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
