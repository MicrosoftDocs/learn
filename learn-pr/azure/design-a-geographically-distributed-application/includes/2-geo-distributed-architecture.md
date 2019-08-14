Azure is a global system. By designing an architecture that is present in more than one Azure region, you can build an application that is resilient to even region-wide disasters.

In your shipping company, your shipments tracking portal is scalable, because you have built it by using a range of Azure services that have scalability built-in. It's also resilient to many failures, because its components can have multiple instances. However, your board of directors has become concerned that a large-scale disaster could cause an interuption in service, because the portal is entirely contained in the East US Azure region. You want to propose a modified architecture that can failover to a second region, if East US fails.

Here, you'll learn why such an architecture is advantageous for business-critical applications and see an overview of it. In later units, you'll see further details of the networking, application services, and data components in the proposed distributed architecture. 

## Original web app architecture

Your shipments tracking portal has the architecture shown in this diagram:

<!-- TODO: This diagram is taken from the following location. A Learn version should be created by the design team: https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/scalable-web-app -->

![A scalable web app architecture](../media/2-scalable-web-app.png)

The entire application is hosted in a single resource group and all components are created in the East US region. This arrangement creates the resilience weakness because, if the East US region fails, the portal becomes unavailable to users. Let's examine the components of the architecture.

### Networking

The shipment tracking portal has these networking components:

- **Azure DNS.** To resolve host names to IP addresses, you have configured the Azure DNS service. This setup means that you can manage your DNS records by using your Azure credentials in the Azure portal. Records are automatically distributed globally to Azure's network of DNS servers.
- **Application Gateway.** To balance traffic between multiple instances of the web front end, you have set up Azure Application Gateway. This type of load balancer is localized to one Azure region.
- **Azure CDN.** To maximize the speed of delivery for unsecured static content, such as graphics files, you've set up Azure CDN. THe global service caches static content at points of presence all around the world.

### Application Services

To respond to user requests and deliver content rapidly, your architecture uses these application components:

- **Azure Active Directory.** All users have accounts in Azure AD. This directory is automatically replicated globally.
- **Azure App Service.** The Azure App Service runs two front ends; a set of dynamic web pages and a web API. Browsers access the web pages. Mobile apps and other clients, use the web API.
- **Azure Function Apps.** Your developers have implemented all background tasks as function apps. Some of these tasks run on a regular schedule. Other tasks operate on message in the queue.
- **Azure Storage Queues.** If the App Service must call a function app, it places a message in a queue in the Azure Storage account. Function apps watch these queues and take action on message when they appear. By using a queue, you ensure that the application is robust at times of high demand, because messages are handled in order and will not be lost or timed out.
- **Redis cache.** You use a Redis cache between the front-end app service and the data storage systems to maximize the performance of queries.
- **Azure Blob Storage.** Static content, such as graphics and video files, are kept as Binary Large Objects (Blobs) in an Azure Storage account. These are delivered throught the Azure CDN.
- **Azure Search.**  To enable users to search your content, and to provide search suggestions and fuzzy search results, you have implemented the Azure Search service.

### Data Storage

You're using two services to store data such as order details and tracking data:

- **Azure SQL Database.** Relational data, including order and customer details, are kept in SQL Database tables.
- **Cosmos DB.** Semi-structure data, including the product catalog, are kept in Cosmos DB.

## Issues with the original architecture

The existing architecture for the tracking portal is designed to be scalable. Many components scale out, because you can add instances of those components to increase capacity. For example, if demand is high and responses to user requests is slow, you can consider adding more instances of the front end web app in the App Service. 

This also helps to increase availability, because when an individual instance fails, the Application Gateway can route requests to other instances. 

### Regional failures

Some large events have the potential to interrupt an entire Azure region. Azure datacenters are designed to be highly resilient but a large weather event such as a hurricane or flood can interrupt service from the region. 

This is an unusual occurance, and many companies feel that they can sustain that risk. However, for your tracking portal, the consequences of a regional failure could be so negative that your executives have decided to eliminate that risk. You must find a way to remove it.

### Service Level Agreements

Most Azure services offer a Service Level Agreement (SLA) or a guarantee of uptime. When you design an application architecture that consists of multiple Azure services, think of the overall SLA for the app as a composite of all those SLAs. 

You calculate this SLA by multiplying together the SLAs of the component services. A simple example would be an app that consists of Azure App Service (99.95% SLA) and Azure Active Directory (99.9% SLA); the resultant SLA will be 99.85%. 

If this percentage uptime is not enough for your application, one way to improve it is to arrange for the application to fail over onto another region.

### Global, regional, and configurable components

In your original architecture, some components all global by default and so are not vulnerable to a regional failure. You don't have to do anything about these components. 

Some components are confined to a single region, such as the Application Gateway. You'll have to select an alternate service for these components.

Some components can be configured to support multiple regions. For example, you can use the Geo-Redundant Storage (GRS) option in the Azure Storage account that store static content. GRS replicates blobs to another region.

This table shows which components are global, regional, and configurable:

| Component | Support for multiple regions | Comments |
| --- | --- | --- |
| Azure DNS | Global | No changes are necessary. |
| Application Gateway | Regional | Each instance of Application Gateway is located in a single region. |
| Azure CDN | Global | No changes are necessary, content is cached globally by default. |
| Azure Active Directory | Global | No changes are necessary. |
| Azure App Service | Regional | Each instance of the app is located in a single region. |
| Azure Function Apps | Regional | Each instance of the function app is located in a single region. |
| Azure Storage Queues | Configurable | You can choose to replicate a Storage Account to multiple regions. |
| Azure Redis Cache | Regional |  Each instance of the cache is located in a single region. |
| Azure Blob Storage | Configurable | You can choose to replicate a Storage Account to multiple regions. |
| Azure Search | Regional |  Each instance of the search service is located in a single region. |
| Azure SQL Database | Configurable | You can use geo-replication to synchronize data to multiple regions |
| Azure Cosmos DB | Configurable | You can use geo-replication to synchronize data to multiple regions |
| | |

## Proposed distributed architecture

After some investigation, you propose the architecture in this diagram:

<!-- TODO: This diagram is taken from the following location. A Learn version should be created by the design team: https://docs.microsoft.com/azure/architecture/reference-architectures/app-service-web-app/multi-region -->

![Highly-available architecture](../media/2-multi-region-web-app-diagram.png)

In this architecture, there is an active region (East US) and a standby region (West US). Under ordinary circumstances, all requests are handled by the components in the East US region. If there is a disaster that causes that region to fail, the application fails over onto the West US region.

Let's examine, at a high level, how you have modified the original architecture. You examine these changes in more detail in later units.

### Networking

Azure DNS and Azure CDN are global systems by default and already resilient to regional failures. They remain in place in the same configuration.

An instance of Azure Application Gateway, however, is contained within a region. By replacing this service with Azure Traffic Manager, you remove this vulnerability. Also, you can configure Traffic Manager to poll instances of the App Service in multiple regions. If the East US App Service becomes unavailable, it's Traffic Manager that handles the fail over to West US.

### Application Services

Azure AD is a global system and needs no modification.

Azure Storage accounts, which contain static content blobs and queues, can be configured to replicate content to multiple regions. Use one of the geo-redundant storage options.

The other components, including the App Service, Function Apps, the Redis cache, and Azure Search are regional. In the new architecture, create duplicate instances of these components in the West US region. In this way, when a failover occurs, the new region can take over smoothly. There may be minor consequences - for example, the Redis cache in West US will not contain any data, so there may be a temporary fall in performance that subsequently recovers automatically as the new cache fills.

### Data Storage

Both Azure SQL Database and Azure Cosmos DB support geo-replication of data to other regions. Configure these services to replicate East US data to the equivalent services in West US.

## Regional Pairs

An Azure region is area with a single geography that contains one or more Azure datacenters. All regions are paired with another region in the same geography. Within these pairs, updates and planned maintenance are done on only one region at a time. Also, if there is a failure that affects multiple regions, at least one region in each pair will be prioritized for rapid recovery. 

That's why it is best practice to place a two-region architecture for your app on the two regions in a regional pair. For example, East US is paired with West US, so your proposed architecture uses East US for its active region and West US for its standby region.