The decisions you make early in an app project about architecture can have a profound impact on the performance of the final app. To make these decisions, you must understand distributed apps and their structures.

As you start to develop the architecture for the shipping company's application, it might be useful to compare traditional on-premises architectural styles. How well do those styles transfer to the cloud?

Here, you will learn how Azure supports a distributed app architecture.

## Architecting for the cloud

Some of the principles of architecting applications for traditional environments are directly transferable to the cloud. However, there are also significant differences. In a traditional deployment environment, you typically dedicate hardware in a particular location to your application. This choice is based on an estimation of the resources you'll need when it's at peak usage. 

App usage is frequently under this peak and, consequently, many of the dedicated resources sit unused. In a cloud environment, by contrast, you scale infinitely and on demand. If your application is used heavily, you instantaneously provision more resources to deal with it. When it becomes idle again, you disable those resources. You only pay for what you use.

One aspect of this infinite scale in the cloud is that failure becomes an expected condition, and a natural part of the environment, not an anomaly. When you have one large powerful server sitting on-premises, over which you have full control, and an IT Ops team exclusively dedicated to its monitoring and maintenance, failures are more rare and recovery is quicker. 

When you have millions of virtual machines based on commodity hardware sitting in a data center with associated networking equipment, power, cooling, and cabling, it's likely that some part of that infrastructure *will* occasionally fail. Many Azure services have a premium SKU whereby you can pay for more premium-grade hardware, but the problem doesn't go away entirely. 

Azure's controlling infrastructure deals with this expected condition by carrying out constant health probes. Azure also shifts deployed services from an intermittently failing part of the data center to a healthy one seamlessly and transparently. IT Ops teams in the cloud go to work on the failing hardware.

## Service Level Agreements

Most Azure services offer a Service Level Agreement (SLA) or a guarantee of uptime. When you design an application architecture that consists of multiple Azure services, think of the overall SLA for the app as a composite of all those SLAs. You calculate this SLA by multiplying together the SLAs of the component services. A simple example would be an app that consists of Azure App Service (99.95% SLA) and Azure Active Directory (99.9% SLA); the resultant SLA will be 99.85%. 

You can expect the combined availability of those services to be 99.85%. However, such SLAs merely address the uptime of the services on which the application is built. A sound, 'cloud-native' application architecture and coding method are also crucial to its overall resiliency and fault-tolerance. 

Suppose you have an Azure App Service trying to retrieve data from an Azure SQL Database, and the latter has a momentary hardware problem that's being shifted elsewhere in the data center. The front end can be coded in a way that prepares the database to deal with such failures, and trys again in an intelligent way so that the database isn't flooded with requests. This kind of intelligent retry logic and other proven methods will help secure a truly resilient app architecture.

## Azure is worldwide

Applications built for Azure typically have access to an infrastructure that spans the globe. You can place resources in whichever Azure region is closest to your customers. You'll see that SLAs for cloud services are rarely 100%. One reason for this situation is that it's impossible to secure entire regions against natural events or human error. Historically, many public cloud outages occur because of regional failures. In 2012, for example, Hurricane Sandy took out a number of Manhattan data centers. Consequently, a key part of making any cloud architecture resilient and highly available is to ensure it spans more than one region.

Such an architecture can fail over easily and reliably to a secondary region with minimal loss of data. But even a multi-regional architecture is vulnerable to data loss. No architecture can provide 100% reliability and 100% uptime. The goal is to provide as much reliability as possible, and understand and defend against any problematic choke points. You use design patterns and strategies that have been adapted or devised for a cloud environment.

## The shipping company architecture

If you examine the application mentioned in the introduction, you'll see it uses several Azure services. To solidify the architecture against the possibility of a regional failure, you'll need to ensure that none of the Azure services used are tightly coupled to a single region. In some cases, like Azure DNS and the Azure CDN, this loose coupling is an integral part of the service. In other cases, you'll need to explicitly duplicate your resources in another region, and provide a mechanism to effect a failover if there's a failure.

Azure is designed to cope with momentary failures in the data center by making constant probes and a readiness to shift around resources. Azure has been designed so that regions are explicitly paired. For the purposes of this module, we'll deploy our app in West Europe and, if necessary, fail over to North Europe.

It's worth reviewing the original plan for the shipping company's application architecture. At that time, they thought a single region would be sufficient. This process will better enable us to see how to take an existing app and make it fault tolerant across regions. The shipping company has a website hosted Azure App Service for direct consumers. It also has a web API interaction with other businesses through their APIs, also in the App Service. To improve performance and scalability, static resources like images, CSS, and HTML files are fetched from the Azure CDN. Typically, Azure SQL Database provides the information to fulfill website read operations, like tracking shipments. But over time that data will increasingly be fetched from Redis Cache. 

Write operations (like creating, updating, and deleting shipments) are added to an Azure Queue storage queue that triggers a Function App. When the Function App is triggered by the addition of a message to the queue, it attempts to write to SQL Database, and remove the message from the queue if successful. Cosmos DB is used to hold overall product catalog data, because different manufacturers may describe their offerings with different schemas. This scenario is ideally suited for Cosmos DB. Again, over time, this information may be retrieved from Redis Cache instead. Domain name resolution is provided by Azure DNS. Website authentication is provided by Azure AD.

<!--Todo: diagram of this architecture based in a single region based on the diagram here https://docs.microsoft.com/en-gb/azure/architecture/reference-architectures/app-service-web-app/multi-region-->

Replicate those parts of the system that can be replicated in a pair of regions. These parts include Azure App Service, Function App, Redis Cache, and the queue. For other services, like SQL Database and Cosmos DB, it's more a case of flipping a switch so that they become present in other regions. The architecture uses some supporting services that are inherently multi-region, like Azure DNS, Azure AD, and Azure CDN. Finally, the global Traffic Manager service is used as an orchestrator to switch incoming traffic from one region to another if there's regional failure.

<!--Todo: diagram of this architecture based in two regions for failover based on the diagram here https://docs.microsoft.com/en-gb/azure/architecture/reference-architectures/app-service-web-app/multi-region-->

In the following units, we'll consider the networking, application and data components of this architecture, and how to make them multi-regional.