In this unit, we will explore few best practices that you should consider implementing when developing applications with Azure Database for MySQL - Flexible Server, to ensure better performance, resilience and security.

> [!NOTE] The below list is not comprehensive. Consult [Azure Database for MySQL documentation](https://aka.ms/mysqldocs) for detailed guides to implement best practices in terms of Networking, Security, Monitoring, Performance Optimization, Business Continuity and Disaster Recovery, etc.

:::image type="content" source="../media/best-practices.png" alt-text="Diagram showing six key best practices to be followed for application development.":::

## 1. Co-locate resources

Make sure all your resource dependencies are in the same region when deploying your application in Azure. Spreading instances across regions or availability zones creates network latency, which might affect the overall performance of your application.

## 2. Implement connection pooling

Managing database connections can have a significant impact on the performance of the application as a whole. To optimize performance, you should reduce the number of times connections are established and the time taken to establish these connections in key code paths.

To improve application performance and resiliency, consider implementing connection pooling to connect to Azure Database for MySQL. A connection pooler (like ProxySQL) can decrease idle connections and reuse existing connections.

## 3. Choose the right application container size

To ensure optimized performance, verify that your application is allocated sufficient compute and memory resources. Perform load testing using utilities like JMeter to help you size the resources correctly.

## 4. Implement network isolation and SSL connectivity

Azure Database for MySQL - Flexible with Virtual Network (VNet) integration (private access connectivity method) brings the Azure's benefits of network security and isolation. Virtual Network (VNet) integration enables you to lock down access to the server to only your virtual network infrastructure. Your application and database resources can either be secured in a single VNet or may stretch across different VNets in the same or different regions (and connected seamless with virtual network peering).

Also, it is also recommended to secure data in motion by ensuring that your application connects to MySQL flexible server using Secure Sockets Layer (SSL).

## 5. Retry on transient faults

Given that cloud environments are more likely to encounter transient faults, like network connectivity interruptions or service timeouts, applications must implement logic to deal with them, typically by retrying requests after a delay.

A good practice is to wait for 5 seconds before your first retry. Then follow each retry by increasing the wait gradually, up to 60 seconds. After a fixed number of retries, application can consider the operation failed and you can further investigate the persistent error.

## 6. Choose right compute and storage size for database

It is important to analyze your workload and size your Flexible Server instances correctly for an acceptable balance between application performance and costs. You can create a flexible server in one of three compute tiers: Burstable, General Purpose, and Memory Optimized. To choose a compute tier, use the following table as a starting point.

| Compute tier | Target workloads |
| ------------ | ---------------- |
| Burstable | Best for workloads that don’t need the full CPU continuously. Cost-effective for smaller web applications and development workloads. |
| General Purpose | Most business workloads that require balanced compute and memory with scalable I/O throughput. Examples include servers for hosting web and mobile apps and other enterprise applications. |
| Memory Optimized | High-performance database workloads that require in-memory performance for faster transaction processing and higher concurrency. Examples include servers for processing real-time data and high-performance transactional or analytical apps. |

Flexible servers can also be resized after creation. However, note that compute tier can be scaled up or down between General Purpose or Memory Optimized tiers only.

In terms of storage, you can scale up when you are approaching storage capacity limits. You can also enable the storage auto-grow feature to ensure that the service automatically scales the storage as it nears the storage limits.

To make informed decisions on time, constantly monitor key Azure Monitor metrics like Host CPU percent, Host Memory percent, Storage percent, IO percent, Active connections, etc. or set up alerts to notify you when you approach the capacity of your deployment.
