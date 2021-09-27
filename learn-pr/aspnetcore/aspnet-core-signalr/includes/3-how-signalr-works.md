<!--
# How ASP.NET Core SignalR works?

Parts
Parts working together
Apply to scenario

-->

## Servers and the `Hub` class

The `Hub` class is a SignalR server concept. It's defined within the `Microsoft.AspNetCore.SignalR` namespace, and is part of the [Microsoft.AspNetCore.SignalR](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR) NuGet package. A `Hub` is exposed through a route, for example; the `"https://www.contoso-pizza.com/hubs/orders"` route could be used to represent an `OrdersHub` implementation. The various hub APIs allow authors to define methods and events.

There are two modalities to expose methods on a hub, you create a subclass of either following types and write [methods](#methods):

- <xref:Microsoft.AspNetCore.SignalR.Hub?displayProperty=fullName>: Standard hub.
- <xref:Microsoft.AspNetCore.SignalR.Hub%601?displayProperty=fullName>: Strongly-typed generic hub.

You fire [events](#events) from either a `Hub` or `IHubContext` instance.

### The `IHubContext<T>`

The SignalR hub is the core abstraction for sending messages to clients connected to the SignalR server. It's also possible to send messages from other places in your app using either of the following types:

- <xref:Microsoft.AspNetCore.SignalR.IHubContext%601?displayProperty=fullName>: A context where `THub` represents the standard hub.
- <xref:Microsoft.AspNetCore.SignalR.IHubContext%602?displayProperty=fullName>: A context where `THub` represents the strongly-typed generic hub, and `T` represents the corresponding type of client.

The `IHubContext` is for sending notifications to client, it _**is not**_ used to call method on the `Hub`.

### Methods

`Hub` or `Hub<T>` methods are just like any other C# method, they define a return type, method name, and parameter(s).

- The most common return type for a hub method is `Task` or `Task<TResult>`, which represents the asynchronous hub operation.
- The method name is used to call the method from clients, it can be customized using the <xref:Microsoft.AspNetCore.SignalR.HubMethodNameAttribute?displayProperty=fullName>.
- Parameters are optional, but when they're defined, clients are expected to provide corresponding arguments.

Methods are not required to fire events, but they often do.

### Events

`Hub`, `Hub<T>`, `IHubContext<THub>`, or `IHubContext<THub, T>` events are *named* and define up to ten parameters. Events are fired on the server, and handled by interested clients. A client is considered interested when it subscribes to events on its hub's connection. Clients can indirectly trigger events when calling hub methods that fire events as a result of their invocation. However; events cannot be directly triggered by clients as that is a responsibility of the server.

#### Event client scopes

You call events from an <xref:Microsoft.AspNetCore.SignalR.IClientProxy?displayProperty=fullName> instance. The <xref:Microsoft.AspNetCore.SignalR.IHubClients?displayProperty=fullName> and <xref:Microsoft.AspNetCore.SignalR.IHubCallerClients?displayProperty=fullName> interfaces are implemented from the <xref:Microsoft.AspNetCore.SignalR.Hub.Clients%2A?displayProperty=fullName> type. There are many ways to scope to a specific `IClientProxy` instance, you can target the following client scopes:

- [`All`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.All%2A): All connected clients (such as a broadcast).
- [`AllExcept`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.AllExcept%2A): All connected clients, excluding the specified connections (such as filtered broadcast).
- [`Caller`](xref:Microsoft.AspNetCore.SignalR.IHubCallerClients%601.Caller%2A): The connected client that triggered the method (such as an echo).
- [`Client`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Client%2A): Specified client connection (single connection).
- [`Clients`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Clients%2A): Specified client connections (multiple connections).
- [`Group`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Group%2A): All connected clients within the specified group.
- [`GroupExcept`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.GroupExcept%2A): All connected clients within the specified group, excluding the specified connections.
- [`Groups`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Groups%2A): All connected clients within the specified groups (multiple groups).
- [`Others`](xref:Microsoft.AspNetCore.SignalR.IHubCallerClients%601.Others%2A): All connected clients, excluding the client that triggered the method.
- [`OthersInGroup`](xref:Microsoft.AspNetCore.SignalR.IHubCallerClients%601.OthersInGroup%2A): All connected clients within the specified group, excluding the client that triggered the method.
- [`User`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.User%2A): All connected clients for the specified user (a single user can connect on more than one device).
- [`Users`](xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Users%2A): All connected clients for the specified users.

## Clients and the `HubConnection` class

The `HubConnection` class is a SignalR client concept, which represents the client's connection to the [server `Hub`](#servers-and-the-hub-class). It's defined within the `Microsoft.AspNetCore.SignalR.Client` namespace, and is part of the [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client) NuGet package. A `HubConnection` is created using the builder-pattern, and the corresponding `HubConnectionBuilder` type. Given the hub's route (or <xref:System.Uri?displayProperty=fullName>) a `HubConnection` can be created. The builder can also specify additional configuration options, such as but not limited to; logging, the desired protocol, authentication token forwarding, and automatic reconnection.

The `HubConnection` API exposes start and stop functions, used to start and stop the connection to the server. Additionally, there are capabilities for streaming, calling [hub methods](#methods), and subscribing to [events](#events).

### Call hub methods

Given a client `HubConnection` instance that has successfully started, the client can call methods on a hub using the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.InvokeAsync%2A> or <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync%2A> extensions. If the hub method returns a `Task<TResult>` the result of the `InvokeAsync<TResult>` is of type `TResult`. If the hub method returns `Task`, then there is no result. Both `InvokeAsync` and `SendAsync` expect the name of the hub method, and zero to ten parameters.

- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.InvokeAsync%2A?displayProperty=fullName>: Invokes a hub method on the server using the specified method name and optionally arguments.
- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync%2A?displayProperty=fullName>: Invokes a hub method on the server using the specified method name and optionally arguments. *Does not wait* for a response from the receiver.

### Steam APIs

SignalR supports streaming, and provides the following APIs. To invoke a streaming hub method on the server using the specified method name and return type:

- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.StreamAsChannelAsync%2A?displayProperty=fullName>: Returns `Task<ChannelReader<TResult>>`.
- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.StreamAsync%2A?displayProperty=fullName>: Returns `IAsyncEnumerable<TResult>`.

### Handle events

To handle events, you'l register a handler with the `HubConnection` instance. Call one of the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.On%2A> overloads given the name of the hub method and zero to eight parameters. The handler can any of the following `Action` variations:

- <xref:System.Action>
- <xref:System.Action%601>
- <xref:System.Action%602>
- <xref:System.Action%603>
- <xref:System.Action%604>
- <xref:System.Action%605>
- <xref:System.Action%606>
- <xref:System.Action%607>
- <xref:System.Action%608>

Alternatively, you can use the asynchronous handler APIs which are `Func<TResult>` where the `TResult` is a `Task` variations:

- <xref:System.Func%601>
- <xref:System.Func%602>
- <xref:System.Func%603>
- <xref:System.Func%604>
- <xref:System.Func%605>
- <xref:System.Func%606>
- <xref:System.Func%607>
- <xref:System.Func%608>
- <xref:System.Func%609>

The result from registering a event handler is an `IDisopsable`, this serves as your subscription. To unsubscribe, call <xref:System.IDisposable.Dispose%2A>.
