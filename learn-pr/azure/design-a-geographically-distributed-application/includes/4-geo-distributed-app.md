When your networking components route requests to multiple regions to mitigate the effects of a regional outage, you must design application services that can respond to those requests in both primary and standby regions.

Suppose you've decided to use Azure Front Door in priority mode to send requests to the Azure App Service in East US. When a regional failure occurs and East US is not available, you want to send those requests to West US instead. Now, you want to understand how to configure resources in West US to support these failovers. You want to design all application services in West US.

Here, you'll learn about Active Directory, static content storage, web apps, web APIs, queues, Azure functions, and data caches in a multi-region architecture.

<!-- TODO: The design team should recreate this diagram in MSLearn style -->

![Multi-region architecture application services](../media/4-multi-region-web-app-services.png)

## Azure Active Directory

In your shipments tracking portal, users can track deliver without setting up a user account by entering a tracking number. However, regular users can register for membership to access advanced features, such as delivery promptness and other statistics. User accounts for this functionality, and also for system administrators, are stored in Azure Active Directory (AD).

Azure AD is designed as a global system by default. As such it's not vulnerable to regional failures and you don't have to modify this component of the system.

## Azure Blob Storage

Static content, such as images and videos, are stored in Azure Storage accounts as Binary Large Objects (Blobs) and served to users through the Azure CDN. 

In your original architecture, the storage account is contained in a single region, because you chose to use Locally Redundant Storage (LRS), where data is replicated only within a single datacenter. If there is a regional outage, the account is unavailable but any static content that has already been cached by the CDN remains available to users. The same is true of Zone Redundant Storage (ZRS) - although data is replicated to different datacenters, all those datacenters are in the same region, so the storage account is affected by regional outages.

There's chance that, during the outage, a user might request a static file that is not yet in the CDN cache. This request would result in a graphic or video that can't be displayed. If you want to eliminate this possibility, you can replicate the storage account to multiple regions by choosing a geo-redundant storage option. You can choose a read-only replication option if you can support the inability to add static content during a regional outage. Choose from Read-Access Geo-Redundant Storage (RA-GRS) or Read-Acces Geo-Zone-Redundant Storage (RA-GZRS) based on your budget and the percentage up time that you need.

## Azure App Service and Azure Function Apps

The Azure App Service hosts a web app that implements the user interface of the shipments tracking portal for web browsers. It also hosts a web API that mobile apps can call to find out about shipments. Background tasks run as Azure Function apps. These components have been written by your developers by using the ASP.NET framework. 

Each Azure App Service is localized to a single Azure region. To support the new multi-region architecture, create a second App Service in the secondary region (West US) and deploy the ASP.NET project to it. Configure the Azure Front Door priority routing mode to send requests to this instance, when the primary region is unavailable.

To ensure that failover is as smooth as possible, make sure that the ASP.NET application does not store any session state information in memory. For example, if your code stored a list of the users' shipments in memory, then this list would be lost if a failover occurred and may affect users. Talk to your developers about this issue. 

If no session state is stored, each web request is handled independently as it arrives, and two subsequent requests can be handled by different instances with no impact on users. If a failover occurs in the middle of a user's session, they shouldn't notice.

As for App Services, create a separate instance of the Azure Function in the secondary region and deploy the same custom code to it as runs in the primary region. 

> [!IMPORTANT]
> When you deploy an update to the custom code in the App Service or Function App service, remember to distribute it to all the instances of the App Service. If you want to automate this process, Azure DevOps has tools that can help.

## Azure Storage Queues

In your original single-region architecture, you used a queue in an Azure Storage account to manage communications between the App Service and the function app. When the web app or the web API needs to run a background task, it places a message with all the required information in the queue. The function app monitors the queue for new messages, and executes the background task by running the necessary queries against the data stores. 

When you use a queue like this, you can manage high demand in an orderly way. When there are many background tasks to run, the queue may build up but tasks will not be dropped by an over-utilized function app. The function apps can work through the queue and reduce its size when demand falls. If demand persists, you can increase the number of instances of the function app. 

For the multi-region version of the shipments tracking portal, you must make sure that queue items are not lost when failover occurs. Because the queue is in Azure Storage, you can utilize a redundancy option as you did for the static content blob storage. However, you can't use a read-access redundancy option, because the App Service must add items to the queue, and the function app must remove completed items from the queue. Use Geo-Redundant Storage (GRS) or Geo-Zone-Redundant Storage (GZRS) instead. 

## Azure Redis Cache

You're using Azure Redis Cache to maximize the performance of data storage. When the web app, web API, or function apps query the databases, they send the query through Redis, which caches the results. Subsequent queries for similar data can be satisfied from memory in the Redis cache, and do not need to run a query on the database server.

For the multi-region architecture, create a Redis Cache instance in both primary and standby regions. Remember that, when a failover occurs, the Redis Cache in the standby region is likely to be empty. That empty cache won't cause any errors, but performance may temporarily drop, as data fills the new cache. 