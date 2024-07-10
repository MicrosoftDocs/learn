Azure Cache for Redis is a data store, as a service, based on the popular open-source software Redis. In many everyday use cases, Azure Cache for Redis is used to improve the performance of applications by providing a distributed data cache as a low-latency, high-throughput, managed service. Redis and, in turn, Azure Cache for Redis can be used as more than just a straightforward content or data cache.

For example, Azure Cache for Redis can be used as an event aggregation pipeline for microservices in a more comprehensive overall solution.

:::image type="complex" source="../media/1-event-aggregator.svg" alt-text="Event aggregator diagram" border="false":::
Diagram that illustrates Azure Cache for Redis as an aggregator pipeline. It shows receiving events from various application components and routing the events to the destination application components.
:::image-end:::

Azure Cache for Redis can also be used as a message broker between various application components.

:::image type="complex" source="../media/1-message-broker.svg" alt-text="Message broker diagram" border="false":::
Diagram illustrating Azure Cache for Redis receiving messages from an application component and storing the message in a stream. Meanwhile, other application components consume messages from various streams.
:::image-end:::

## Example scenario

Suppose you work at a fictional retail company developing the middleware that connects all of the microservices that the company uses for business functions, including, but not limited to:

- Inventory management
- Shipping
- Monitoring of client apps

In the past, the microservices directly communicated with each other. This communication requirement forced each microservice to keep a list of services it could contact.

:::image type="content" source="../media/1-scenario.svg" alt-text="Web of microservices communicating with each other.":::

As the company experienced tremendous growth, the challenge of managing massive routing tables, developing communication protocols, and hosting a communication infrastructure proved to be too much. If you spun up a new service or scaled out an existing service, every other impacted service is required to have its code updated manually to include the latest list of services it would need to contact.

Your company has decided to investigate middleware that could handle the communication needs between all of the microservices across the entire company’s portfolio of technology solutions.

:::image type="content" source="../media/1-solution.svg" alt-text="Group of microservices communicating through middleware.":::

## What are we doing?

In this module, create an Azure Cache for Redis account and then use the account to implement the following two Redis features:

- **Pub/Sub**: You subscribe to channels and publish new messages to the channel\[s\]
- **Streams**: You add entries to a stream and then measure and consume entries from the stream

> [!IMPORTANT]
> Redis Streams is the newest list data type available in Redis 6.0. When creating a new Azure Cache for Redis instance, you will see an option to select a version of Redis. You should select Redis 6.0 to use this feature.

## What is the main goal?

By the end of this module, you're able to implement both the **Pub/Sub** and **Streams** features of Redis in Azure Cache for Redis.
