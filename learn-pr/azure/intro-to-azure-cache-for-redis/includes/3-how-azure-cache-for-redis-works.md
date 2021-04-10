Azure Cache for Redis provides a number of features that can help improve the performance and scalability of apps that rely heavily on backend data stores. In this unit, you'll learn what the following Azure Cache for Redis features do:

- Distributed cache
- Session store
- Message broker
- Cloud migration

## Distributed cache

The distributed cache feature in Azure Cache for Redis helps improve your apps' response times. It achieves this because it copies frequently accessed data to a cache; this cache has lower latency and provides for higher throughput than the primary datastore. The distributed cache feature provides the following capabilities:

- Accelerates application responsiveness.
- Helps reduce load on primary datastores and compute resources.
- Integrates with many Azure databases, including Azure SQL and Azure Cosmos DB, as indicated in the following graphic.

You can use the distributed cache feature to address the following requirements:

- Handle spikes in traffic.
- Cache and provide commonly accessed data to users.
- Help reduce compute load on your databases.
- Locate content geographically closer to users.
- Provide for output caching.


As indicated in the following graphic, Azure Cache for Redis can help improve performance in apps that interface with many database solutions, including Azure SQL Database, Azure Cosmos DB, and Azure Database for MySQL.

:::image type="content" source="../media/distributed-cache.png" alt-text="A graphic depicting clients apps connecting to database hosted apps. Azure Cache for Redis sits between the app interfaces and the backend database and storage systems..":::

## Session store

Your session-oriented apps require the ability to store and access to temporary session data. This is required when the user signs in and remains active on your apps. The session store feature in Azure Cache for Redis provides the following key capabilities:

- Handles up to hundreds of thousands of simultaneous users.
- Provides for data replication options to help provide for maximum reliability.
- Helps reduce costs, as is typically more cost effective and scalable than alternative database or storage options.

You can use the session store feature to address the following requirements:

- Help facilitate eCommerce shopping carts.
- Store user cookies.
- Maintain user login and session state data.
- Enable IoT telemetry.

## Message broker 

Apps built on microservices often need to asynchronously communicate. Azure Cache for Redis can can implement a publish/subscribe or queue architecture that can help enable fast and reliable communication between these microservices. The Azure Cache for Redis message broker provides the following key capabilities:

- Provides for a great temporary data store with minimal overhead and cost.
- Supports TLS encryption for data in transit.
- Provides network isolation for secure communication between your services.

You can use the message broker feature to address the following requirements:

- Publish news, financial data, or application updates to users.
- Handle chat messages.
- Enable communication between microservices.

In the following graphic, a number of group chats, notifications, and stock quotes are occurring. These are connected to the message broker feature in Azure Cache for Redis. This, in turn, is connected to Azure API Apps instances and Azure Web Apps. These elements provide access to the group chats, notifications, and stock quotes for connected client devices. 

:::image type="content" source="../media/message-broker.png" alt-text="A graphic that represents the message broker architecture in Azure Cache for Redis, as described in the preceding text.":::

## Cloud migration

A critical issue for anyone planning to move away from an on-premises cache to a managed service is how to move your content to the managed service. Azure Cache for Redis helps to migrate to the cloud, and provides the following key features:

- Enables both import and export of RDB files
- Provides compatibility with open-source Redis to help simplify migration
- Provides a fully managed service that handles:

   - Patching
   - Updates
   - Provisioning
   - Scaling
   - Setup

You can use this cloud migration feature in Azure Cache for Redis to address the following requirements: 

- Migrate your apps from your on-premises environment to the cloud
- Help modernize your current  IaaS apps through the benefits of PaaS services

