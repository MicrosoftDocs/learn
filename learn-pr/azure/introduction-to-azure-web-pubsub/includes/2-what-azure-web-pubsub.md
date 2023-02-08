 The Azure Web PubSub Service helps you build real-time messaging web applications using WebSockets and the publish-subscribe pattern easily. This real-time functionality allows publishing content updates between server and connected clients (for example, a single-page web application or mobile application). The clients don't need to poll the latest updates, or submit new HTTP requests for updates. 

## Benefits of using Azure Web PubSub service

There are a lot of benefits to using Azure Web PubSub. Here's a list of benefits that make it a compelling choice:

:::image type="content" source="../media/benefits.png" alt-text="This image depicts the benefits of Azure Web PubSub.":::

- **Built-in support for large-scale client connections and highly available architectures:** Azure Web PubSub service is designed for large-scale real-time applications. The service allows multiple instances to work together and scale to millions of client connections. Web PubSub also supports multiple global regions for sharding, high availability, or disaster recovery purposes.

- **Support for a wide variety of client SDKs and programming languages:** Azure Web PubSub service works with a broad range of clients, such as web and mobile browsers, desktop apps, mobile apps, server process, IoT devices, and game consoles. Since this service supports the standard WebSocket connection with publish-subscribe pattern, it's easy to use any standard WebSocket client SDK in different languages with this service.

- **Offer rich APIs for different messaging patterns:** Azure Web PubSub service is a bi-directional messaging service that allows different messaging patterns between server and clients, for example:
  - The server sends messages to a particular client, all clients, or a subset of clients that belong to a specific user, or have been placed in an arbitrary group.
  - The client sends messages to clients that belong to an arbitrary group.
  - The clients send messages to server.

In the next unit, you'll learn how Azure Web PubSub works.