As a .NET developer tasked with implementing real-time web functionality, ASP.NET Core SignalR is the most viable option. In the **MilesLong (&trade;) Warehouse Incorporated** notification scenario, we will use SignalR to implement a real-time notification system that all employees will leverage. Here, you will learn the terminology associated with SignalR.

:::image type="content" source="../media/2-fundamentals/server-client-user-diagram.png" alt-text="ASP.NET Core SignalR: Server to client and user relationship.":::

## Fundamentals

Familiarizing yourself with the common nomenclature of SignalR is very helpful. You will learn what components are required in a server application, versus those in client applications. Additionally, you'll gain an understanding of the various duplex communication mechanisms.

### Transports

SignalR supports the following techniques (*transports*) for handling real-time communication (in order of graceful fallback):

- WebSockets
- Server-Sent Events
- Long Polling

SignalR automatically chooses the best transport method that is within the capabilities of the server and client.

For more information, see the official specification for [SignalR Transport Protocols](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/TransportProtocols.md).

### Server

The server is responsible for exposing an endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub?displayProperty=nameWithType> or <xref:Microsoft.AspNetCore.SignalR.Hub%601?displayProperty=nameWithType> subclass. The server can exist on-premises, in a cloud provider (such as Azure), or with the [Azure SignalR Service](/azure/azure-signalr).

#### Hub

SignalR uses *hubs* to communicate between clients and servers. A hub is a high-level pipeline that allows a client and server to call methods on each other. SignalR handles the dispatching across machine boundaries automatically, allowing clients to call methods on the server and vice versa. You can think of a hub as a proxy betwixt all connected clients and the server.

#### Protocols

SignalR provides two built-in hub protocols:

- A text protocol based on JSON (default)
- A binary protocol based on *MessagePack* (*MessagePack* generally creates smaller messages compared to JSON).

> [!NOTE]
> There is a third hub protocol named *BlazorPack*, but it is used exclusively with Blazor-Server applications. It cannot be used *without* the Blazor-Server hosting model.

For more information, see the official specification for [SignalR Hub Protocol](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/HubProtocol.md).

### Clients

The client is responsible for establishing a connection to the server's endpoint through a `HubConnection`. With a hub connection instance that's started successfully, messages flow freely in both directions. Users are free to communicate notifications to the server, as well as receive notifications from the server. Clients are *not* limited to web browsers. For more information, see [ASP.NET Core SignalR supported platforms](/aspnet/core/signalr/supported-platforms).

#### Users

A user in the system acts as an individual, but they can also be part of a group. Messages can be sent to groups, an all group members will be notified.
