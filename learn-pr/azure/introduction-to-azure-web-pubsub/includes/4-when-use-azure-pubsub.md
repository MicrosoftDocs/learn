Any scenario that requires real-time publish-subscribe messaging between server and clients or among clients can use the Azure Web PubSub service. Traditional real-time features that often require polling from server or submitting HTTP requests can also use the Web PubSub service.

Azure Web PubSub service can be used in any application type that requires real-time content updates. While Azure Web PubSub can scale to provide real-time messaging and notifications for millions of client connections, you can use it equally well for applications that operate at smaller scale.

## When to use Azure Web PubSub

Azure Web PubSub has a variety of applications, including but not limited to:

- **High frequency data updates** - gaming, voting, polling, auction.

- **Live dashboards and monitoring** - company dashboard, financial market data, instant sales update, multi-player game leader board, and IoT monitoring.

- **Cross-platform live chat** - live chat room, chat bot, on-line customer support, real-time shopping assistant, messenger, in-game chat, and so on.

- **Real-time location on map** - logistic tracking, delivery status tracking, transportation status updates, GPS apps.

- **Real-time targeted ads** - personalized real-time push ads and offers, interactive ads.

- **Collaborative apps** - coauthoring, whiteboard apps and team meeting software.

- **Push instant notifications** - social network, email, game, travel alert.

- **Real-time broadcasting** - live audio/video broadcasting, live captioning, translating, events/news broadcasting.

- **IoT and connected devices** - real-time IoT metrics, remote control, real-time status, and location tracking.

- **Automation** - real-time trigger from upstream events.

A few more scenarios where Azure Web PubSub is very useful:

- **Build serverless real-time applications** - Use Azure Functions' integration with Azure Web PubSub to build serverless real-time applications in languages such as JavaScript, C#, Java, and Python.

- **Use WebSocket sub-protocol to do client-side only Pub/Sub** - Azure Web PubSub service provides WebSocket subprotocols to empower authorized clients to publish to other clients in a convenience manner.

- **Use provided SDKs to manage the WebSocket connections in self-hosted app servers** - Azure Web PubSub service provides SDKs in C#, JavaScript, Java, and Python to manage the WebSocket connections. Easily broadcast messages to the connections, add connections to some groups, and close connections.

- **Send messages from server to clients via REST API**: Azure Web PubSub service provides a REST API to enable applications to post messages to connected clients, in any REST-capable programming language.