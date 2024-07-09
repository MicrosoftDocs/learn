In this unit, you explore some best practices to apply when developing apps with Azure Database for MySQL - Flexible Server that can help to ensure better performance, resilience, and security. These best practices include:

- Co-locating resources.
- Implementing connection pooling.
- Choosing the right app container size.
- Implementing networking isolation and SSL connectivity.
- Implementing retry logic to manage transient faults.
- Choosing the right compute and storage size for the database.

These best practices come into play at various points during the app development process with Azure Database for MySQL - Flexible Server, as shown in the following diagram.

:::image type="content" source="../media/best-practices.png" alt-text="Diagram showing six key best practices to be followed for app development.":::

> [!NOTE]
> This list of best practices is not exhaustive. Be sure to consult the [Azure Database for MySQL documentation](https://aka.ms/mysqldocs) for detailed guides on implementing best practices related to networking, security, monitoring, performance optimization, business continuity and disaster recovery, etc.

## Co-locate resources

When deploying your app to Azure, be sure that all of your resource dependencies are hosted in the same region. Spreading resource instances across regions or availability zones can create network latency, which might affect the overall performance of your app.

## Implement connection pooling

Managing database connections within an app can significantly impact the overall app performance.  To improve app performance and resiliency, consider implementing connection pooling to connect to a MySQL flexible server. A connection pooler (like ProxySQL) can decrease the number of idle connections and reuse existing connections.

> [!TIP]
> To optimize performance, in key code paths, reduce the number of times that connections are established and the time it takes to establish these connections.

## Choose the right app container size

Because selecting the appropriate size for your app container is vital, be sure that the app has enough compute and memory resources to handle expected loads. You can use tools like JMeter to assist in load testing, which can help you to correctly size your resources based on the results.

## Implement network isolation and SSL connectivity

Azure Database for MySQL - Flexible Server with VNet integration (the private access connectivity method) offers network security and isolation. You can use VNet integration to lock down server access only to your virtual network (VNet) infrastructure. Private endpoints enhance this security by allowing you to connect to your flexible server securely over a private network, avoiding exposure to the public internet. You can secure your app and database resources either in a single VNet or across different VNets in the same or different regions (and connected seamlessly with virtual network peering).

We also recommend securing data in transit by ensuring that your app connects to a MySQL flexible server using Secure Sockets Layer (SSL).

## Implement retry logic to manage transient faults

Because cloud environments are more likely to encounter transient faults like network connectivity interruptions or service timeouts, you should ensure that your apps implement logic to deal with these issue, typically by retrying requests after a delay.

It is a good practice to wait for five seconds before your first retry. Then, with each subsequent retry, increase the wait time gradually, up to 60 seconds. After a fixed number of retries, the app can consider the operation failed and notify you so that you can investigate the persistent error further.

## Choose right compute and storage size for your database

It's important to analyze your workload and size your MySQL flexible server instances correctly to achieve an acceptable balance between app performance and cost.

### Compute

You can create a MySQL flexible server in one of three compute tiers: Burstable, General Purpose, and Business Critical. As a starting point for choosing the compute tier, consider the detail in the following table.

| Compute tier | Target workloads |
| ------------ | ---------------- |
| Burstable | Best for workloads that don’t need the full CPU continuously. Cost-effective for smaller web apps and development workloads. |
| General Purpose | Best for most business workloads that require balanced compute and memory with scalable I/O throughput. Examples include servers for hosting web and mobile apps and other enterprise apps. |
| Business Critical | Best for high-performance database workloads that require in-memory performance for faster transaction processing and higher concurrency. Examples include servers for processing real-time data and high-performance transactional or analytical apps. |

While you can also resize MySQL flexible servers after creation, you can only scale up or down between the General Purpose or Business Critical tiers.

### Storage

In terms of storage, you can scale up when you are approaching storage capacity limits. You can also enable the storage auto-grow feature to ensure that the service automatically scales the storage as it nears the storage limits.

To make informed decisions about compute and storage in a timely manner, monitor key Azure Monitor metrics like Host CPU percent, Host Memory percent, Storage percent, IO percent, Active connections, etc. constantly or set up alerts to notify you when the solution approaches the limits of your deployment.

## Adjust IOPS for optimal performance

A significant enhancement available in Azure Database for MySQL - Flexible Server is the Autoscale IOPS (Input/Output Operations Per Second) feature, which complements the existing pre-provisioned IOPS feature. This section explores how you can use pre-provisioned IOPS and Autoscale IOPs options to optimize database performance based on varying workload requirements.

### Pre-provisioned IOPS

You can allocate a specific number of IOPS to your database instance using pre-provisioned IOPS. This feature is crucial for workloads that require consistent and predictable performance. By setting a defined IOPS limit, you can ensure that your database can handle a certain number of requests per second, thus maintaining stable and reliable performance. You also have the flexibility to adjust the number of IOPS provisioned as your workload changes, allowing for both scalability and precise control over your database performance.

### Autoscale IOPS

Autoscale IOPS brings dynamic performance scaling, an essential feature for effectively managing fluctuating workloads. With this feature enabled, the database server automatically adjust IOPS based on real-time demand without the need for pre-provisioning. Having this flexibility is particularly beneficial for tier-1, mission-critical apps that may experience variable performance needs.

The key benefits of using Autoscale IOPS functionality include:

- **Dynamic Scaling**: Autoscale IOPS automatically adjusts the IOPS limits based on actual workload demand. This dynamic adjustment helps ensure that your database consistently operates at optimal performance levels without manual intervention.

- **Handling Workload Spikes**: This feature allows your database to seamlessly handle sudden increases in load, ensuring that app performance remains consistent during peak periods. This capability is crucial for maintaining service availability and user satisfaction.

- **Cost Efficiency**: Unlike pre-provisioned IOPS, where you pay for a specified limit regardless of actual usage, Autoscale IOPS ensures you only pay for the I/O operations actually used. This can result in significant cost savings, especially for databases with variable I/O needs.

- **Simplified Management**: By reducing the need for manual scaling and capacity planning, Autoscale IOPS frees up administrative resources, allowing your team to focus on more strategic initiatives rather than routine maintenance.
