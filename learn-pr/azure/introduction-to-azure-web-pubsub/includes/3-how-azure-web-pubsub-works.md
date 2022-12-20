The Azure Web PubSub Service helps you build real-time messaging web applications. The clients connect to the service using the standard WebSocket protocol, and the service exposes REST APIs and SDKs for you to manage these clients.

Here are a few terms that you need to familiarize yourself with:

- **Connection**: A connection, also known as a client or a client connection, represents an individual WebSocket connection to the Web PubSub service. When successfully connected, a unique connection ID is assigned to this connection by the Web PubSub service.

- **Hub**: A hub is a logical concept for a set of client connections. Usually you use one hub for one purpose, for example, a chat hub, or a notification hub. When a client connection connects, it connects to a hub, and during its lifetime, it belongs to that hub. Different applications can share one Azure Web PubSub service by using different hub names.

- **Group**: A group is a subset of connections to the hub. You can add a client connection to a group, or remove the client connection from the group, anytime you want. For example, when a client joins a chat room, or when a client leaves the chat room, the chat room can be considered to be a group. A client can join multiple groups, and a group can contain multiple clients.

- **User**: Connections to Web PubSub can belong to one user. A user might have multiple connections, for example when a single user is connected across multiple devices or multiple browser tabs.

- **Message**: When the client is connected, it can send messages to the upstream application, or receive messages from the upstream application, through the WebSocket connection.

An illustration of how it works:

:::image type="content" source="../media/workflow.png" alt-text="Workflow of Azure Web PubSub.":::

1. A client connects to the service `/client` endpoint using WebSocket transport. The service forwards every WebSocket frame to the configured upstream server. The WebSocket connection can connect with any custom subprotocol for the server to handle, or it can connect with the service-supported subprotocols (such as `json.webpubsub.azure.v1`) that enable the clients to do PubSub directly. Details are described in [client protocol](/azure/azure-web-pubsub/concept-service-internals#client-protocol).

2. The service invokes the server using the CloudEvents protocol on different client events. [CloudEvents](https://github.com/cloudevents/spec/blob/v1.0.1/spec.md) is a standardized and protocol-agnostic definition of the structure and metadata description of events hosted by the Cloud Native Computing Foundation (CNCF). Details are described in [server protocol](/azure/azure-web-pubsub/concept-service-internals#server-protocol).

3. The server can invoke the service using REST API to send messages to clients or to manage the connected clients. Details are described in [server protocol](/azure/azure-web-pubsub/concept-service-internals#server-protocol).

In the next unit, explore when to use Azure Web PubSub.