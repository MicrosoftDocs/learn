![Polling-based web application](../media/serverless-app-signalr-concept.png)

In this unit, we'll look at a way to move away from a polling-based solution to one that pushes data updates to clients as they occur. Using this approach, we reduce traffic between our server and the clients and make our UI more efficient, by only updating when something has changed. The three technologies that we'll use to deliver this updated solution are **Cosmos DB**, **Azure Functions**, and **SignalR**.

As data changes in the database, **Cosmos DB** exposes a "change feed". Change feed support in Azure Cosmos DB works by listening to an Azure Cosmos DB container for any changes. It then outputs the sorted list of documents that were changed in the order in which they were modified. By listening to the change feed your application can automatically respond to data changes.

**Azure Functions** features binding that runs code anytime there is an update to the Cosmos DB change feed. Once a  function is listening to the change feed, then you can work with a subset of your data that just represents data changes. When paired with a persistent connection to the client, the function can contact individual clients on-demand, which is the foundation for a real-time application architecture.

<!-- REVIEW -We used a Cosmos DB binding in the as-is architecture. Is there anything new here? -->

## SignalR and Persistent connections

In contrast to polling, a more favorable design features persistent connections between the client and server. Establishing a persistent connection allows the server to push data to the client at will. The on-demand nature of the connection reduces network traffic and load on the server. SignalR allows you to easily add this type of architecture to your application.

**SignalR** is an abstraction for a series of technologies that allows your app to enjoy two-way communication between the client and server. SignalR handles connection management automatically, and lets you broadcast messages to all connected clients simultaneously, like a chat room. You can also send messages to specific clients. The connection between the client and server is persistent, unlike a classic HTTP connection, which is re-established for each communication. 

A key benefit of the abstraction provided by SignalR is the way it supports "transport" fallbacks. A transport is method of communicating between the client and server. A SignalR connection starts with a standard request and then switches to the most appropriate communication method (transport) depending on APIs that are supported on the client.

For clients that support HTML 5, the WebSockets API is used as the transport. If the client doesn't support WebSockets, then SignalR falls back to Server Sent Events (also known as EventSource). For older clients, Ajax long polling or Forever Frame (IE only) are used to mimic two-way communication.

The abstraction layer offered by SignalR provides two benefits to your application. The first is that as the web evolves and APIs superior to WebSockets become available, your application doesn't need to change. You could update to a version of SignalR that supports any new APIs and your application code won't need an overhaul.

The second benefit of SignalR'a abstraction is that it allows your application to gracefully degrade depending on supported technologies of the client. If it doesn't support WebSockets, then Server Sent Events are used. If the client can't handle Server Sent Events, then it uses Ajax long polling, etc.

Let's look at how to use SignalR in our app, so our Azure Function can broadcast information from the Cosmos DB change feed to connected clients.
