![Polling-based web application.](../media/serverless-app-signalr-concept.png)

Next, we move away from polling and toward an app that pushes data updates (as they occur) to connected clients. This new design reduces traffic and makes a more efficient UI by only updating as data changes. The three technologies that we use to deliver this updated solution are **Azure Cosmos DB**, **Azure Functions**, and **SignalR**.

* **Azure Cosmos DB**: As data changes in the database, Azure Cosmos DB exposes a *change feed*. The change feed support in Azure Cosmos DB works by listening to a database container for changes. It then outputs the sorted list of changed documents in the order in which they were modified. When your application listens to the change feed, it can automatically respond to data changes.

* **Azure Functions**: The key difference between this function and the original `getStocks` function is that the function is now triggered based on changes to our data. In the preceding exercise, we triggered our function based on requests from the client and pulled back all data through an Azure Cosmos DB input binding. Using the Azure Cosmos DB trigger automatically makes our data retrieval more efficient. Azure Functions features a binding that runs code anytime data is updated in an Azure Cosmos DB change feed. Once a function is listening to the change feed, then you can work with a subset of your data that just represents data changes. 

* **Azure SignalR**: This service provides 2-way communication with a SignalR connection on the client listening to SignalR broadcasts from the Azure Functions app.

## SignalR and persistent connections

In contrast to polling, a more favorable design features persistent connections between the client and server. Establishing a persistent connection allows the server to push data to the client at will. The on-demand nature of the connection reduces network traffic and load on the server. SignalR allows you to easily add this type of architecture to your application.

**SignalR** is an abstraction for a series of technologies that allows your app to enjoy two-way communication between the client and server. SignalR handles connection management automatically, and lets you broadcast messages to all connected clients simultaneously, like a chat room. You can also send messages to specific clients. The connection between the client and server is persistent, unlike a classic HTTP connection, which is re-established for each communication.

A key benefit of the abstraction provided by SignalR is the way it supports "transport" fallbacks. A transport is a method of communicating between the client and server. SignalR connections begin with a standard HTTP request. As the server evaluates the connection, the most appropriate communication method (transport) is selected. When paired with a persistent connection to the client, the function can contact individual clients on-demand, which is the foundation for a real-time application architecture. Transports are chosen depending on the APIs available on the client:

* **HTML 5**: For clients that support HTML 5, the WebSockets API transport is used by default. 
* **WebSockets**: If the client doesn't support WebSockets, then SignalR falls back to Server Sent Events (also known as EventSource). 
* **Other technology**: For older clients, Ajax long polling or Forever Frame (IE only) is used to mimic a two-way connection.

The abstraction layer offered by SignalR provides two benefits to your application. The first advantage is future-proofing your app. As the web evolves and APIs superior to WebSockets become available, your application doesn't need to change. You could update to a version of SignalR that supports any new APIs and you don't need to overhaul your application code.

The second benefit is that SignalR allows your application to gracefully degrade depending on supported technologies of the client. If it doesn't support WebSockets, then Server Sent Events are used. If the client can't handle Server Sent Events, then it uses Ajax long polling, and so on.

Let's look at how to use SignalR to broadcast information from a function that reads the Azure Cosmos DB change feed.
