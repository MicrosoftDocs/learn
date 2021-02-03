Azure can help you tackle tough business challenges. You bring your requirements, creativity, and favorite software development tools. Azure brings a massive global infrastructure that's always available for you to build your applications on.

Let's take a quick tour of the high-level services Azure offers.

#### Azure: overall picture

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuas]

## Azure services

Here's a big-picture view of the available services and features in Azure.

[![Diagram showing overall view of popular Azure services with sections for security and management, platform services, hybrid cloud, and infrastructure services.](../media/3-azure-services.png)](../media/3-azure-services.png#lightbox)

Let's take a closer look at the most commonly used categories:

:::row:::
  :::column:::

- Compute
- Networking
- Storage
- Mobile
- Databases

  :::column-end:::
  :::column:::

- Web
- Internet of Things
- Big Data
- Artificial Intelligence
- DevOps

  :::column-end:::
:::row-end:::

### Compute

Compute services are often one of the primary reasons why companies move to the Azure platform. Azure provides a range of options for hosting applications and services. Here are some examples of computing services in Azure:

> [!div class="mx-tableFixed"]
> | Service name | Service function |
> |--------------|------------------|
> | Azure Virtual Machines    | Windows or Linux virtual machines (VMs) hosted in Azure                  |
> | Azure Virtual Machine Scale Sets | Scaling for Windows or Linux VMs hosted in Azure                  |
> | Azure Kubernetes Service  | Enables management of a cluster of VMs that run containerized services   |
> | Azure Service Fabric      | Distributed systems platform. Runs in Azure or on-premises               |
> | Azure Batch               | Managed service for parallel and high-performance computing applications |
> | Azure Container Instances | Run containerized apps on Azure without provisioning servers or VMs      |
> | Azure Functions           | An event-driven, serverless compute service                              |

### Networking

Linking compute resources and providing access to applications is the key function of Azure networking. Networking functionality in Azure includes a range of options to connect the outside world to services and features in the global Microsoft Azure datacenters.

Azure networking facilities have the following features:

> [!div class="mx-tableFixed"]
> | Service name | Service function |
> |--------------|------------------|
> | Azure Virtual Network     | Connects VMs to incoming Virtual Private Network (VPN) connections                   |
> | Azure Load Balancer       | Balances inbound and outbound connections to applications or service endpoints       |
> | Azure Application Gateway | Optimizes app server farm delivery while increasing application security             |
> | Azure VPN Gateway         | Accesses Azure Virtual Networks through high-performance VPN gateways                |
> | Azure DNS                 | Provides ultra-fast DNS responses and ultra-high domain availability                 |
> | Azure Content Delivery Network  | Delivers high-bandwidth content to customers globally                          |
> | Azure DDoS Protection     | Protects Azure-hosted applications from distributed denial of service (DDOS) attacks |
> | Azure Traffic Manager     | Distributes network traffic across Azure regions worldwide                           |
> | Azure ExpressRoute        | Connects to Azure over high-bandwidth dedicated secure connections                   |
> | Azure Network Watcher     | Monitors and diagnoses network issues using scenario-based analysis                  |
> | Azure Firewall            | Implements high-security, high-availability firewall with unlimited scalability      |
> | Azure Virtual WAN         | Creates a unified wide area network (WAN), connecting local and remote sites         |

### Storage

Azure provides four main types of storage services. These services are:

> [!div class="mx-tableFixed"]
> | Service name | Service function |
> |--------------|------------------|
> | Azure Blob storage  | Storage service for very large objects, such as video files or bitmaps               |
> | Azure File storage  | File shares that you can access and manage like a file server                        |
> | Azure Queue storage | A data store for queuing and reliably delivering messages between applications       |
> | Azure Table storage | A NoSQL store that hosts unstructured data independent of any schema                 |

These services all share several common characteristics:

- **Durable** and highly available with redundancy and replication.
- **Secure** through automatic encryption and role-based access control.
- **Scalable** with virtually unlimited storage.
- **Managed**, handling maintenance and any critical problems for you.
- **Accessible** from anywhere in the world over HTTP or HTTPS.

### Mobile

Azure enables developers to create mobile backend services for iOS, Android, and Windows apps quickly and easily. Features that used to take time and increase project risks, such as adding corporate sign-in and then connecting to on-premises resources such as SAP, Oracle, SQL Server, and SharePoint, are now simple to include.

Other features of this service include:

- Offline data synchronization.
- Connectivity to on-premises data.
- Broadcasting push notifications.
- Autoscaling to match business needs.

### Databases

Azure provides multiple database services to store a wide variety of data types and volumes. And with global connectivity, this data is available to users instantly.

> [!div class="mx-tableFixed"]
> | Service name | Service function |
> |--------------|------------------|
> | Azure Cosmos DB            | Globally distributed database that supports NoSQL options                                       |
> | Azure SQL Database         | Fully-managed relational database with auto-scale, integral intelligence, and robust security    |
>| Azure Database for MySQL   | Fully-managed and scalable MySQL relational database with high availability and security        |
>| Azure Database for PostgreSQL   | Fully-managed and scalable PostgreSQL relational database with high availability and security   |
> | SQL Server on VMs  | Host enterprise SQL Server apps in the cloud     |
> | Azure Synapse Analytics | Fully-managed data warehouse with integral security at every level of scale at no extra cost    |
> | Azure Database Migration Service    | Migrates your databases to the cloud with no application code changes                  |
> | Azure Cache for Redis      | Caches frequently used and static data to reduce data and application latency                   |
> | Azure Database for MariaDB | Fully-managed and scalable MariaDB relational database with high availability and security        |

### Web

Having a great web experience is critical in today's business world. Azure includes first-class support to build and host web apps and HTTP-based web services. The Azure services focused on web hosting include:

> [!div class="mx-tableFixed"]
> | Service Name | Description |
> |--------------|-------------|
> | Azure App Service | Quickly create powerful cloud web-based apps |
> | Azure Notification Hubs |Send push notifications to any platform from any back end. |
> | Azure API Management | Publish APIs to developers, partners, and employees securely and at scale. |
> | Azure Cognitive Search | Fully-managed search as a service. |
> | Web Apps feature of Azure App Service | Create and deploy mission-critical web apps at scale. |
> | Azure SignalR Service | Add real-time web functionalities easily. |

### Internet of Things

People can access more information than ever before. It began with personal digital assistants (PDAs), then morphed into smartphones. Now there are smartwatches, smart thermostats, even smart refrigerators. Personal computers used to be the norm. Now the internet allows any item that's online-capable to access valuable information. This ability for devices to garner and then relay information for data analysis is referred to as the Internet of Things (IoT).

Several services can assist and drive end-to-end solutions for IoT on Azure.

> [!div class="mx-tableFixed"]
> | Service Name | Description |
> |--------------|-------------|
> | IoT Central | Fully-managed global IoT software as a service (SaaS) solution that makes it easy to connect, monitor, and manage your IoT assets at scale |
> | Azure IoT Hub | Messaging hub that provides secure communications between and monitoring of millions of IoT devices |
> | IoT Edge | Push your data analysis models directly onto your IoT devices, allowing them to react quickly to state changes without needing to consult cloud-based AI models.

### Big Data

Data comes in all formats and sizes. When we talk about Big Data, we're referring to _large_ volumes of data. Data from weather systems, communications systems, genomic research, imaging platforms, and many other scenarios generate hundreds of gigabytes of data. This amount of data makes it hard to analyze and make decisions. It's often so large that traditional forms of processing and analysis are no longer appropriate.

Open source cluster technologies have been developed to deal with these large data sets. Microsoft Azure supports a broad range of technologies and services to provide big data and analytic solutions.

> [!div class="mx-tableFixed"]
> | Service Name | Description |
> |--------------|-------------|
> | Azure Synapse Analytics | Run analytics at a massive scale using a cloud-based Enterprise Data Warehouse (EDW) that leverages massive parallel processing (MPP) to run complex queries quickly across petabytes of data |
> | Azure HDInsight | Process massive amounts of data with managed clusters of Hadoop clusters in the cloud |
> | Azure Databricks | Collaborative Apache Spark-based analytics service that can be integrated with other Big Data services in Azure. |

### Artificial Intelligence

Artificial Intelligence, in the context of cloud computing, is based around a broad range of services, the core of which is Machine Learning. Machine Learning is a data science technique that allows computers to use existing data to forecast future behaviors, outcomes, and trends. Using machine learning, computers learn without being explicitly programmed.

Forecasts or predictions from machine learning can make apps and devices smarter. For example, when you shop online, machine learning helps recommend other products you might like based on what you've purchased. Or when your credit card is swiped, machine learning compares the transaction to a database of transactions and helps detect fraud. And when your robot vacuum cleaner vacuums a room, machine learning helps it decide whether the job is done.

Some of the most common Artificial Intelligence and Machine Learning service types in Azure are:

> [!div class="mx-tableFixed"]
> | Service Name | Description |
> |--------------|-------------|
> | Azure Machine Learning Service | Cloud-based environment you can use to develop, train, test, deploy, manage, and track machine learning models. It can auto-generate a model and auto-tune it for you. It will let you start training on your local machine, and then scale out to the cloud |
> | Azure Machine Learning Studio | Collaborative, a drag-and-drop visual workspace where you can build, test, and deploy machine learning solutions using pre-built machine learning algorithms and data-handling modules |

A closely related set of products are _cognitive services_. These are pre-built APIs you can leverage in your applications to solve complex problems.

> [!div class="mx-tableFixed"]
> | Service Name | Description |
> |--------------|-------------|
> | Vision | Image-processing algorithms to smartly identify, caption, index, and moderate your pictures and videos. |
> | Speech | Convert spoken audio into text, use voice for verification, or add speaker recognition to your app. |
> | Knowledge mapping | Map complex information and data to solve tasks such as intelligent recommendations and semantic search. |
> | Bing Search | Add Bing Search APIs to your apps and harness the ability to comb billions of webpages, images, videos, and news with a single API call. |
> | Natural Language processing | Allow your apps to process natural language with pre-built scripts, evaluate sentiment, and learn how to recognize what users want. |

### DevOps

DevOps (Development and Operations) brings together people, processes, and technology, automating software delivery to provide continuous value to your users. Azure DevOps Services allows you to create _build_ and _release_ pipelines that provide continuous integration, delivery, and deployment for your applications. You can integrate repositories and application tests, perform application monitoring, and work with build artifacts. You can also work with and backlog items for tracking, automate infrastructure deployment, and integrate a range of third-party tools and services such as Jenkins and Chef. All of these functions and many more are closely integrated with Azure to allow for consistent, repeatable deployments for your applications to provide streamlined build and release processes.

Some of the main DevOps services available with Azure are Azure DevOps Services and Azure DevTest Labs.

> [!div class="mx-tableFixed"]
> | Service Name | Description |
> |--------------|-------------|
> | Azure DevOps | Azure DevOps Services (formerly known as Visual Studio Team Services, or VSTS), provides development collaboration tools including high-performance pipelines, free private Git repositories, configurable Kanban boards, and extensive automated and cloud-based load testing |
> | Azure DevTest Labs | Quickly create on-demand Windows and Linux environments you can use to test or demo your applications directly from your deployment pipelines |
