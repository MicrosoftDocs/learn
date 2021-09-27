<!--
# What is ASP.NET Core SignalR?

Definition
Value

-->

As with all internet-connected applications, there are servers and clients. Clients rely on servers for data, and the primary mechanism in which they get data is through making hypertext transfer protocol (HTTP) requests. Some client applications require data that changes frequently.

ASP.NET Core SignalR provides an API for creating server-to-client remote procedure calls (RPC). The RPCs invoke functions on clients from the server-side .NET Core code. There are several supported platforms, each with their respective client SDK. Because of this, the programming language being invoked by the RPC call varies.

Familiarizing yourself with the common nomenclature of SignalR is very helpful. You will learn what components are required in a server application, versus those in client applications. Additionally, you'll gain an understanding of the various duplex communication mechanisms.

### Transports

SignalR supports the following techniques (*transports*) for handling real-time communication (in order of graceful fallback):

1. WebSockets
2. Server-Sent Events
3. Long Polling

SignalR automatically chooses the best transport method that is within the capabilities of the server and client.

For more information, see the official specification for [SignalR Transport Protocols](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/TransportProtocols.md).

### Server

The server is responsible for exposing an endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub?displayProperty=nameWithType> or <xref:Microsoft.AspNetCore.SignalR.Hub%601?displayProperty=nameWithType> subclass. The server can exist on-premises, in a cloud provider (such as Azure), or with the [Azure SignalR Service](/azure/azure-signalr).

#### Hub

SignalR uses *hubs* to communicate between clients and servers. A hub is a high-level pipeline that allows a client and server to call methods on each other. SignalR handles the dispatching across machine boundaries automatically, allowing clients to call methods on the server and vice versa. You can think of a hub as a proxy betwixt all connected clients and the server.

- <xref:Microsoft.AspNetCore.SignalR.Hub?displayProperty=nameWithType>

#### Protocols

SignalR provides two built-in hub protocols:

- A text protocol based on JSON (default)
- A binary protocol based on *MessagePack* (*MessagePack* generally creates smaller messages compared to JSON).

To use the *MessagePack* protocol, both server and client need to opt-in to configuring it. There is a third hub protocol named *BlazorPack*, but it is used exclusively with Blazor-Server applications. It cannot be used *without* the Blazor-Server hosting model.

For more information, see the official specification for [SignalR Hub Protocol](https://github.com/dotnet/aspnetcore/blob/068797e16a1bfe66461e15c8a2ffa864369d384d/src/SignalR/docs/specs/HubProtocol.md).

### Clients

The client is responsible for establishing a connection to the server's endpoint through a `HubConnection`. The hub connection object is represented within each target platform:

- [.NET Client](/aspnet/core/signalr/dotnet-client): [`Microsoft.AspNetCore.SignalR.Client.HubConnection`](xref:Microsoft.AspNetCore.SignalR.Client.HubConnection?displayProperty=nameWithType)
- [JavaScript Client](/aspnet/core/signalr/javascript-client): [`@microsoft/signalr.HubConnection`](xref:@microsoft/signalr.HubConnection)
- [Java Client](/aspnet/core/signalr/java-client): [`com.microsoft.signalr.HubConnection`](xref:com.microsoft.signalr.HubConnection)

For more information, see [ASP.NET Core SignalR supported platforms](/aspnet/core/signalr/supported-platforms).

With a hub connection instance that's started successfully, messages flow freely in both directions. Users are free to communicate notifications to the server, as well as receive notifications from the server. Clients are *not* limited to web browsers.

#### Users

A user in the system acts as an individual, but they can also be part of a group. Messages can be sent to groups, and all group members will be notified.
