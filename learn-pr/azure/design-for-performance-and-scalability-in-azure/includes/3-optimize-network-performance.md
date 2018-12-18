Network performance can have a dramatic impact on a user's experience. In complex architectures with many different services, minimizing the latency at each hop can have a huge impact on the overall performance. In this unit, we'll talk about the importance of network latency and how to reduce it within your architecture. We'll also discuss how Lamna Healthcare adopted strategies to minimize network latency between their Azure resources as well as between their users and Azure.

## The importance of network latency

Latency is a measure of delay. Network latency is the time needed to get from a source to a destination across some network infrastructure. This time period is commonly known as a round-trip delay, or the time taken to get from the source to destination and back again.

In a traditional datacenter environment, latency may be minimal since resources often share the same location and a common set of infrastructure. The time taken to get from source to destination is lower when resources are physically close together.

In comparison, a cloud environment is built for scale. Cloud-hosted resources may not be in the same rack, datacenter, or even region. This distributed approach can have an impact on the round-trip time of your network communications. While all Azure regions are interconnected by a high-speed fiber backbone, the speed of light is still a physical limitation. Calls between services in different physical locations will still have network latency directly correlated to the distance between them.

On top of this, the chattier an application, the more round trips that are required. Each round trip comes with a latency tax, with each round trip adding to the overall latency. The following illustration shows how the latency perceived by the user is the combination of the roundtrips required to service the request.

![An illustration showing network latency among resources placed at different geographical locations in the cloud.](../media/3-networkLatency.png)

Now let's take a look at how to improve performance between Azure resources and from your end users to your Azure resources.

## Latency between Azure resources

Imagine that Lamna Healthcare is piloting a new patient booking system running on several web servers and a database in the West Europe Azure region. This architecture minimizes the data time on the wire as resources are co-located inside an Azure region.

Suppose that the pilot of the system went well and has been expanded to users in Australia. Users in Australia will incur the round-trip time to the resources in West Europe to view the website, and their end-user experience will be poor due to the network latency.

The Lamna Healthcare team decide to host another front-end instance in the Australia East region to reduce user latency. While this design helps reduce the time for the web server to return content to end users, their experience is still poor since there's significant latency communicating between the front-end web servers in Australia East and the database in West Europe.

There are a few ways we could reduce the remaining latency:

- Create a read-replica of the database in Australia East. This would allow reads to perform well, but writes would still incur latency. Azure SQL Database geo-replication allows for read-replicas.
- Sync your data between regions with Azure SQL Data Sync.
- Use a globally distributed database such as Azure Cosmos DB. This would allow both reads and writes to occur regardless of location, but may require changes to the way your application stores and references data.
- Use caching technology such as Azure Cache for Redis to minimize high-latency calls to remote databases for frequently accessed data.

The goal here is to minimize the network latency between each layer of the application. How this is solved depends on your application and data architecture, but Azure provides mechanisms to solve this on several services.

## Latency between users and Azure resources

We've looked at the latency between our Azure resources, but we should also consider the latency between users and our cloud application. We're looking to optimize delivery of the front end-user interface to our users. Let's take a look at some ways to improve the network performance between end users and the application.

### Use a DNS load balancer for endpoint path optimization

In the Lamna Healthcare example, we saw that the team created an additional web front-end node in Australia East. However, end users have to explicitly specify which front-end endpoint they want to use. As the designer of a solution, Lamna Healthcare wants to make the experience as smooth as possible for their users.

Azure Traffic Manager could help. Traffic Manager is a DNS-based load balancer that enables you to distribute traffic within and across Azure regions. Rather than having the user browse to a specific instance of our web front end, Traffic Manager can route users based upon a set of characteristics:

- **Priority** - You specify an ordered list of front-end instances. If the one with the highest priority is unavailable, Traffic Manager will route the user to the next available instance.
- **Weighted** - You would set a weight against each front-end instance. Traffic Manager then distributes traffic according to those defined ratios.
- **Performance** - Traffic Manager routes users to the closest front-end instance based on network latency.
- **Geographic** - You could set up geographical regions for front-end deployments, routing your users based upon data sovereignty mandates or localization of content.

Traffic Manager profiles can also be nested. You could first route your users across different geographies (for example, Europe and Australia) using geographic routing and then route them to local front-end deployments using the performance routing method.

Consider that Lamna Healthcare has deployed a web front end in West Europe and Australia. Assume they have deployed Azure SQL Database with their primary deployment in West Europe, and a read replica in Australia East. Let's also assume the application can connect to the local SQL instance for read queries.

The team deploy a Traffic Manager instance in performance mode and add the two front-end instances as Traffic Manager profiles. As an end user, you navigate to a custom domain name (for example, lamnahealthcare.com) which routes to Traffic Manager. Traffic Manager then returns the DNS name of the West Europe or Australia East front end based on the best network latency performance.

It's important to note that this load balancing is only handled via DNS, there's no inline load balancing or caching that's happening here, Traffic Manager is simply returning the DNS name of the closest front end to the user.

### Use CDN to cache content close to users

The website will likely be using some form of static content (either whole pages or assets such as images and videos). This content could be delivered to users faster by using a content delivery network (CDN) such as Azure CDN. 

When Lamna deploys content to Azure CDN, those items are copied to multiple servers around the globe. Let's say one of those items is a video served from blob storage: `HowToCompleteYourBillingForms.MP4`. The team then configure the website so that each user's link to the video will actually reference the CDN edge server nearest them, rather than referencing blob storage. This approach puts content closer to the destination, reducing latency and improving user experience. The following illustration shows how using Azure CDN puts content closer to the destination which reduces latency and improves the user experience.

![An illustration showing usage of Azure content delivery network to reduce latency.](../media/3-cdnSketch.png)

Content delivery networks _can_ also be used to host cached dynamic content. Extra consideration is required, though, since cached content may be out of date compared with the source. Context expiration can be controlled by setting a time to live (TTL). If the TTL is too high, out-of-date content may be displayed and the cache would need to be purged.

One way to handle cached content is with a feature called **dynamic site acceleration**, which can increase performance of webpages with dynamic content. Dynamic site acceleration can also provide a low-latency path to additional services in your solution (for example, an API endpoint).

### Use ExpressRoute for connectivity from on-premises to Azure

Optimizing network connectivity from your on-premises environment to Azure is also important. For users connecting to applications, whether they're hosted on virtual machines or on PaaS offerings like Azure App Service, you'll want to ensure they have the best connection to your applications. 

You can always use the public internet to connect users to your services, but internet performance can vary and may be impacted by outside issues. On top of that, you may not want to expose all of your services over the internet, and you may want a private connection to your Azure resources.

Site-to-site VPN over the internet is also an option, but for high throughput architectures, VPN overhead and internet variability can increase latency noticeably.

Azure ExpressRoute can help. ExpressRoute is a private, dedicated connection between your network and Azure, giving you guaranteed performance and ensuring that your end users have the best path to all of your Azure resources. The following illustration shows how ExpressRoute Circuit provides connectivity between on-premises applications and Azure resources.

![An architectural diagram showing an ExpressRoute Circuit connecting the customer network with Azure resources.](../media/3-expressroute-connection-overview.png)

Once again looking at Lamna's scenario, they decide to further improve end-user experience for users who are in their facilities by provisioning an ExpressRoute circuit in both Australia East and West Europe. This gives their end users a direct connection to their booking system and ensures the lowest latency possible for their application.

Considering the impact of network latency on your architecture is important to ensure the best possible performance for your end users. We've taken a look at some options to lower network latency between end users and Azure and between Azure resources.