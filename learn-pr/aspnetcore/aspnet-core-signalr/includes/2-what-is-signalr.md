All internet-connected applications are composed of servers and clients. Clients rely on servers for data, and their primary mechanism for receiving data is through making Hypertext Transfer Protocol (HTTP) requests. Some client applications require data that changes frequently.

ASP.NET Core SignalR provides an API for creating server-to-client remote procedure calls (RPCs). RPCs invoke functions on clients from the server-side .NET Core code. There are several supported platforms, each with its own client SDK. Therefore, the programming language being invoked by RPC calls can vary.

It's helpful to familiarize yourself with the common terminology that's associated with SignalR. In this unit, you'll learn what SignalR components are required in a server application, versus those in client applications. Additionally, you'll gain an understanding of the various duplex communication mechanisms. SignalR encapsulates multiple real-time protocols, and abstracts away the complexities of each implementation. For more information, see the [ASP.NET Core SignalR](/aspnet/core/signalr/introduction) documentation.

The principal terms that are used in SignalR are discussed in the following sections.

### Transports

SignalR supports the following techniques, or *transports*, for handling real-time communication:

1. WebSockets
2. Server-Sent Events
3. Long Polling

The order in which the transports are listed here signifies their graceful fallback order. In other words, WebSockets is preferred over Server-Sent Events, and Server-Sent Events is preferred over Long Polling, although any one of these transports could be used. SignalR automatically chooses the best transport method that's within the capabilities of the server and the client. For more information, see the official specification for [SignalR Transport Protocols](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/TransportProtocols.md).

### Server

The server is responsible for exposing a SignalR endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub> or <xref:Microsoft.AspNetCore.SignalR.Hub%601> subclass. The server can exist on-premises, in a cloud provider (such as Azure), or with the [Azure SignalR Service](/azure/azure-signalr). The server exposes both the hub methods, which can be called from clients, and the events that clients can subscribe to. These are considered remote procedures.

#### Hub

In SignalR, a *hub* is used to communicate between clients and servers. A hub is a high-level pipeline that allows a client and a server to call methods on each other. To this end, SignalR handles the dispatching across machine boundaries automatically. You can think of a hub as a proxy between all connected clients and the server.

#### Protocols

The SignalR Protocol is a protocol for a two-way RPC over any [message-based transport](#transports). Either party in the connection can invoke procedures on the other party, and procedures can return zero or more results or an error. SignalR provides two built-in hub protocols:

- A text protocol that's based on JSON, which is the default.
- A binary protocol that's based on *MessagePack*, which generally creates smaller messages than JSON does.

To use the *MessagePack* protocol, both server and client need to opt in to configuring it, and both server and client have to support it. There's a third hub protocol, called *BlazorPack*, but it's used exclusively with Blazor-Server applications. It can't be used *without* the Blazor-Server hosting model. For more information, see the official specification for [SignalR Hub Protocol](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/HubProtocol.md).

#### Users

A user in the system acts as an individual, but can also be part of a group. Messages can be sent to [groups](#groups), and all group members are notified. A single user can connect from multiple client applications. For example, the same user can use a mobile device and a web browser and get real-time updates on both at the same time.

#### Groups

A group consists of one or more [connections](#connections). The server can create groups, add connections to a group, and remove connections from a group. A group has a specified name, which acts as its unique identifier. Groups serve as a scoping mechanism to help target messages. That is, real-time functionality can only be sent to users within a named group.

#### Connections

A connection to a hub is represented by a unique identifier that's known only to the server and client. A single connection exists per hub type. Each client has a unique connection to the server. That is, a single user can be represented on multiple clients, but each client connection has its own identifier.

### Clients

The client is responsible for establishing a connection to the server's endpoint through a `HubConnection` object. The hub connection is represented within each target platform:

- [.NET client](/aspnet/core/signalr/dotnet-client): [`Microsoft.AspNetCore.SignalR.Client.HubConnection`](xref:Microsoft.AspNetCore.SignalR.Client.HubConnection?displayProperty=nameWithType)
- [JavaScript client](/aspnet/core/signalr/javascript-client): [`@microsoft/signalr.HubConnection`][js-hubconnection]
- [Java client](/aspnet/core/signalr/java-client): [`com.microsoft.signalr.HubConnection`][java-hubconnection]

[js-hubconnection]: /javascript/api/@microsoft/signalr/hubconnection
[java-hubconnection]: /java/api/com.microsoft.signalr.hubconnection

For more information, see [ASP.NET Core SignalR supported platforms](/aspnet/core/signalr/supported-platforms).

When a hub connection instance is started successfully, messages flow freely in both directions. Users are free to both communicate notifications to the server and receive notifications from the server. A client is any connected application, for example, a web browser, a mobile app, or a desktop app, among others.
