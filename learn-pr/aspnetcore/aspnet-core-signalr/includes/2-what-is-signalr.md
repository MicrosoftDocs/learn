<!--
# What is ASP.NET Core SignalR?

Definition
Value

-->

As with all internet-connected applications, there are servers and clients. Clients rely on servers for data, and the primary mechanism in which they get data is through making hypertext transfer protocol (HTTP) requests. Some client applications require data that changes frequently.

ASP.NET Core SignalR provides an API for creating server-to-client remote procedure calls (RPC). The RPCs invoke functions on clients from the server-side .NET Core code. There are several supported platforms, each with its respective client SDK. Because of this, the programming language being invoked by the RPC call varies.

Familiarizing yourself with the common nomenclature of SignalR is very helpful. You will learn what SignalR components are required in a server application, versus those in client applications. Additionally, you'll gain an understanding of the various duplex communication mechanisms. SignalR encapsulates multiple real-time protocols and abstracts away the complexities of each implementation. For more information, see [ASP.NET Core SignalR](/aspnet/core/signalr/introduction) docs.

### Transports

SignalR supports the following techniques (*transports*) for handling real-time communication:

- WebSockets
- Server-Sent Events
- Long Polling

The order in which the transports are list above, signify their graceful fallback order. In other words, WebSockets is preferred over Server-Sent Events, and Server-Sent Events is preferred over Long Polling - but any one of these transports could be used. SignalR automatically chooses the _best transport_ method that is within the capabilities of the server and client. For more information, see the official specification for [SignalR Transport Protocols](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/TransportProtocols.md).

### Server

The server is responsible for exposing a SignalR endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub> or <xref:Microsoft.AspNetCore.SignalR.Hub%601> subclass. The server can exist on-premises, in a cloud provider (such as Azure), or with the [Azure SignalR Service](/azure/azure-signalr). The server exposes hub methods that can be called from clients, and events that clients can subscribe to. These are considered remote procedures.

#### Hub

In SignalR, a *hub* is used to communicate between clients and servers. A hub is a high-level pipeline that allows a client and server to call methods on each other. SignalR handles the dispatching across machine boundaries automatically, allowing clients to call methods on the server and vice versa. You can think of a hub as a proxy betwixt all connected clients and the server.

#### Protocols

The SignalR Protocol is a protocol for two-way RPC over any [message-based transport](#transports). Either party in the connection may invoke procedures on the other party, and procedures can return zero or more results or an error. SignalR provides two built-in hub protocols:

- A text protocol based on JSON, which is the default.
- A binary protocol based on *MessagePack*, *MessagePack* generally creates smaller messages compared to JSON.

To use the *MessagePack* protocol, both server and client need to opt-in to configuring it, and both server and client have to support it. There is a third hub protocol named *BlazorPack*, but it is used exclusively with Blazor-Server applications. It cannot be used *without* the Blazor-Server hosting model. For more information, see the official specification for [SignalR Hub Protocol](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/HubProtocol.md).

#### Users

A user in the system acts as an individual, but they can also be part of a group. Messages can be sent to [groups](#groups), and all group members will be notified. A single user can connect from multiple client applications, for example; the same user may use a mobile device and a web browser and get real-time updates on both at the same time.

#### Groups

A group consists of one or more [connection](#connections). The server can create groups, add connections to a group, and remove connections from a group. A group has a given name, which acts as its unique identifier. Groups serve as a scoping mechanism to help target messages, in other words real-time functionality can be sent to only those within a named group.

#### Connections

A connection to a hub is represented by a unique identifier that is known only by the server and client. A single connection exists per hub type. Each client has a unique connection to the server, in other words a single user can be represented on multiple clients, but each client connection has its own identifier.

### Clients

The client is responsible for establishing a connection to the server's endpoint through a `HubConnection` object. The hub connection is represented within each target platform:

- [.NET Client](/aspnet/core/signalr/dotnet-client): [`Microsoft.AspNetCore.SignalR.Client.HubConnection`](xref:Microsoft.AspNetCore.SignalR.Client.HubConnection?displayProperty=nameWithType)
- [JavaScript Client](/aspnet/core/signalr/javascript-client): [`@microsoft/signalr.HubConnection`][js-hubconnection]
- [Java Client](/aspnet/core/signalr/java-client): [`com.microsoft.signalr.HubConnection`][java-hubconnection]

[js-hubconnection]: /javascript/api/@microsoft/signalr/hubconnection
[java-hubconnection]: /java/api/com.microsoft.signalr.hubconnection

For more information, see [ASP.NET Core SignalR supported platforms](/aspnet/core/signalr/supported-platforms).

With a hub connection instance that's started successfully, messages flow freely in both directions. Users are free to communicate notifications to the server, as well as receive notifications from the server. A client is any connected application, such as but not limited to; a web browser, a mobile app, and a desktop app.
