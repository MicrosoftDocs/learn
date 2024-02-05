In this module you will learn the most common Azure technologies for microservices. You will learn about most common compute services used for Microservices, as well as data storage options.

### Compute services

There are several options for hosting SaaS and microservices applications in Azure, especially containers in particular, which are well suited for microservices architecture as they provide a high level of isolation between different microservices, encapsulate the entire runtime environment, including the application, libraries, and configuration.  Each microservice runs in its own container with its own environment, dependencies, and runtime, preventing conflicts between services. Azure provides variety of services to run microservices in containers, such as:

- **Azure Kubernetes Service (AKS):** Azure's managed Kubernetes service, which allows you to deploy, manage, and scale containerized applications using Kubernetes. It's a popular choice for orchestrating microservices.

- **Azure Container Apps**: Azure Container Apps is a serverless container service that allows you to run containers without managing the underlying infrastructure. It's designed for scenarios where you want to deploy individual containers quickly and efficiently, without the need to manage a Kubernetes cluster or virtual machines. You can run any containerized application, including microservices, APIs, and batch jobs. 

- **Azure App Service:** You can deploy microservices in different containers or as separate instances of Azure Web Apps. This option is suitable for scenarios where you want a platform-as-a-service (PaaS) approach with simplified deployment and management.

- **Azure Container Instances :** ACI is a serverless container service that allows you to deploy containers without managing the underlying infrastructure. You can deploy individual containers or groups of containers as instances. ACI is suitable for scenarios where you need lightweight, isolated containers for specific tasks.

  

When deciding on Azure service for your microservice, it's important to consider various aspects of your solution and select the best technology. 

Your decision should be based on factors such as the complexity of your microservices architecture, your team's familiarity with Kubernetes, your scalability requirements, and your preference for serverless vs. container orchestration approaches. 



**Azure Kubernetes Service (AKS):**

- Use AKS when your application consists of multiple interconnected microservices or containers that require <u>advanced</u> orchestration, scaling, and management.
- AKS is suitable for <u>complex</u> applications where you need features like automated scaling, load balancing, rolling updates, and service discovery.
- If your microservices architecture is expected to grow and requires dynamic scaling and orchestration, AKS provides a more comprehensive solution.

**Azure Container Apps:**

Azure Container Apps supports Kubernetes-style apps and microservices with features like service discovery and traffic splitting, however Azure Container Apps doesn't provide direct access to the underlying Kubernetes APIs.

With Azure Container Apps many of the complexities of the previous AKS architecture are replaced by these features:

- Built-in service discovery
- Fully managed HTTP and HTTP/2 endpoints
- Integrated load balancing
- Logging and monitoring
- Autoscaling based on HTTP traffic or events powered by KEDA
- Application upgrades and versioning 

**Azure Container Instances:**

Azure Container Instances can be thought of as a lower-level "building block" option compared to Container Apps. Concepts like scale, load balancing, and certificates are not provided with ACI containers. 

- Use ACI for simple and quick container deployments, such as one-off batch jobs, scheduled tasks, or short-lived processes.
- ACI is suitable for scenarios where you don't want to manage the complexity of a full Kubernetes cluster but need the flexibility of deploying single containers without much configuration.
- If your microservices architecture consists of independent, stateless microservices that don't require advanced orchestration, ACI might be a good fit.

Azure offers a range of container hosting services that are designed to accommodate various workloads, architectures, and business requirements.  You can follow this [guidance](https://learn.microsoft.com/azure/architecture/guide/choose-azure-container-service) to understand which Azure container service is best suited to your workload scenarios and requirements.

### Data and storage

Microsoft Azure offers a wide range of data options for building Software as a Service (SaaS) solutions. The choice of data services and architecture will depend on your specific requirements, such as data volume, latency, scalability, and budget. Here are some of the key Azure data options for SaaS solutions:

- **Azure SQL Database**: Azure SQL Database is a fully managed, highly available, and scalable relational database service. It is suitable for SaaS solutions that require structured data storage and support for SQL queries. You can choose between single databases and elastic pools for multitenant applications.
- **Azure Cosmos DB**: Azure Cosmos DB is a globally distributed, multi-model database service that provides high availability and low-latency access to data. It's an excellent choice for SaaS solutions that need to handle large volumes of data with flexible schema and low-latency requirements, such as real-time analytics or IoT applications.
- **Azure Table Storage**: Azure Table Storage is a NoSQL data store that provides key/attribute-based access to semi-structured data. It's a cost-effective option for SaaS solutions that need to store and query large volumes of semi-structured data.
- **Azure Data Lake Storage**: Azure Data Lake Storage is a scalable and secure data lake solution that can store and analyze large amounts of structured and unstructured data. It's suitable for SaaS solutions that deal with big data and require analytics and machine learning capabilities.
- **Azure Blob Storage**: Azure Blob Storage is an object storage service that is ideal for storing large binary and unstructured data, such as images, videos, and backups. It can be used in conjunction with other Azure services to build SaaS solutions that require file storage or content delivery.
- **Azure Cache for Redis**: Azure Cache for Redis is a fully managed, in-memory data store that can be used to improve the performance and scalability of SaaS applications. It's commonly used for caching frequently accessed data and session management.



In addition to databases and storage options, there are several services which are widely used in SaaS and microservices architectures, where it is necessary to implement event-driven architecture and eventual consistency. 

- **Azure Event Hubs**: Azure Event Hubs is a real-time data streaming platform that can ingest and process large volumes of event data from various sources. It's suitable for SaaS solutions that require event-driven architectures and stream processing.
- **Azure Event Grid**: Azure Event Grid enables you to route events from Azure services, like Azure Blob Storage, Azure Functions, Azure Logic Apps, and custom sources, to various endpoints such as Azure Functions, Azure Logic Apps, webhooks, and more. It's ideal for building event-driven SaaS applications, handling events like file uploads, data changes, and system alerts, and triggering automated workflows based on these events.
- **Azure Data Factory**: Azure Data Factory is a cloud-based data integration service that allows you to create, schedule, and manage data workflows. It's useful for data movement, transformation, and orchestration in SaaS solutions.
- **Azure Data Explorer**: Azure Data Explorer is a fast and scalable data exploration service designed for analyzing large volumes of data in real-time. It's suitable for SaaS solutions that require real-time analytics and log analysis.



When designing a SaaS solution on Azure, it's essential to consider factors like data security, compliance, scalability, and performance. You may also choose to combine multiple Azure data services to meet your specific needs and create a robust, efficient data architecture for your SaaS application.