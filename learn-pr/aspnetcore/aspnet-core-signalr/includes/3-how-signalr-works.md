<!--
# How ASP.NET Core SignalR works?

Parts
Parts working together
Apply to scenario

-->

## Servers and the `Hub` class

The `Hub` class is a SignalR server concept. It's defined within the `Microsoft.AspNetCore.SignalR` namespace, and is part of the [Microsoft.AspNetCore.SignalR](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR) NuGet package. A `Hub` is exposed through a route, for example; the `"https://www.contoso-pizza.com/hubs/orders"` route could be used to represent an `OrdersHub` implementation. The various hub APIs allow authors to define methods and events.

There are two modalities to expose methods on a hub, you create a subclass of the following types and write [methods](#methods):

- <xref:Microsoft.AspNetCore.SignalR.Hub>: Standard hub.
- <xref:Microsoft.AspNetCore.SignalR.Hub%601>: Strongly-typed generic hub.

You fire [events](#events) from either a `Hub` or `IHubContext` instance.

### The `IHubContext`

The SignalR hub is the core abstraction for sending messages to clients connected to the SignalR server. It's also possible to send messages from other places in your app using either of the following types:

- <xref:Microsoft.AspNetCore.SignalR.IHubContext%601>: A context where `THub` represents the standard hub.
- <xref:Microsoft.AspNetCore.SignalR.IHubContext%602>: A context where `THub` represents the strongly-typed generic hub, and `T` represents the corresponding type of client.

> [!IMPORTANT]
> The `IHubContext` is for sending notifications to clients, it _**is not**_ used to call methods on the `Hub`.

### Methods

`Hub` or `Hub<T>` methods are just like any other C# method, they define a return type, method name, and parameter(s).

- The most common return type for a hub method is `Task` or `Task<TResult>`, which represents the asynchronous hub operation.
- The method name is used to call the method from clients, it can be customized using the <xref:Microsoft.AspNetCore.SignalR.HubMethodNameAttribute>.
- Parameters are optional, but when they're defined, clients are expected to provide corresponding arguments.

Methods are not required to fire events, but they often do.

### Events

`Hub`, `Hub<T>`, `IHubContext<THub>`, or `IHubContext<THub, T>` events are *named* and define up to ten parameters. Events are fired on the server and handled by interested clients. A client is considered interested when it subscribes to events on its hub's connection. Clients can indirectly trigger events when calling hub methods that fire events as a result of their invocation. However; events cannot be directly triggered by clients as that is the responsibility of the server.

#### Event client scopes

You call events from an <xref:Microsoft.AspNetCore.SignalR.IClientProxy> instance. The <xref:Microsoft.AspNetCore.SignalR.IHubClients> and <xref:Microsoft.AspNetCore.SignalR.IHubCallerClients> interfaces are implemented from the <xref:Microsoft.AspNetCore.SignalR.Hub.Clients%2A> type. There are many ways to scope to a specific `IClientProxy` instance, you can target the following scopes from the `Hub.Clients` property:

| Member                             | Details                                                                                           |
|------------------------------------|---------------------------------------------------------------------------------------------------|
| [`All`][all]                       | All connected clients (such as a broadcast).                                                      |
| [`AllExcept`][all-except]          | All connected clients, excluding the specified connections (such as filtered broadcast).          |
| [`Caller`][caller]                 | The connected client that triggered the method (such as an echo).                                 |
| [`Client`][client]                 | Specified client connection (single connection).                                                  |
| [`Clients`][clients]               | Specified client connections (multiple connections).                                              |
| [`Group`][group]                   | All connected clients within the specified group.                                                 |
| [`GroupExcept`][group-except]      | All connected clients within the specified group, excluding the specified connections.            |
| [`Groups`][groups]                 | All connected clients within the specified groups (multiple groups).                              |
| [`Others`][others]                 | All connected clients, excluding the client that triggered the method.                            |
| [`OthersInGroup`][others-in-group] | All connected clients within the specified group, excluding the client that triggered the method. |
| [`User`][user]                     | All connected clients for the specified user (a single user can connect on more than one device). |
| [`Users`][users]                   | All connected clients for the specified users.                                                    |

[all]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.All%2A
[all-except]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.AllExcept%2A
[caller]: xref:Microsoft.AspNetCore.SignalR.IHubCallerClients%601.Caller%2A
[client]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Client%2A
[clients]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Clients%2A
[group]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Group%2A
[group-except]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.GroupExcept%2A
[groups]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Groups%2A
[others]: xref:Microsoft.AspNetCore.SignalR.IHubCallerClients%601.Others%2A
[others-in-group]: xref:Microsoft.AspNetCore.SignalR.IHubCallerClients%601.OthersInGroup%2A
[user]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.User%2A
[users]: xref:Microsoft.AspNetCore.SignalR.IHubClients%601.Users%2A

## Clients and the `HubConnection` class

The `HubConnection` class is a SignalR client concept, which represents the client's connection to the [server `Hub`](#servers-and-the-hub-class). It's defined within the `Microsoft.AspNetCore.SignalR.Client` namespace, and is part of the [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client) NuGet package. A `HubConnection` is created using the builder pattern, and the corresponding `HubConnectionBuilder` type. Given the hub's route (or <xref:System.Uri?displayProperty=fullName>) a `HubConnection` can be created. The builder can also specify additional configuration options, such as but not limited to; logging, the desired protocol, authentication token forwarding, and automatic reconnection.

The `HubConnection` API exposes start and stop functions, used to start and stop the connection to the server respectively. Additionally, there are capabilities for streaming, calling [hub methods](#methods), and subscribing to [events](#events).

### Call hub methods

Given a client `HubConnection` instance that has successfully started, the client can call methods on a hub using the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.InvokeAsync%2A> or <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync%2A> extensions. If the hub method returns a `Task<TResult>` the result of the `InvokeAsync<TResult>` is of type `TResult`. If the hub method returns `Task`, then there is no result. Both `InvokeAsync` and `SendAsync` expect the name of the hub method, and zero to ten parameters.

- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.InvokeAsync%2A>: Invokes a hub method on the server using the specified method name and optional arguments.
- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync%2A>: Invokes a hub method on the server using the specified method name and optional arguments. This method *does not wait* for a response from the receiver.

### Steam APIs

SignalR supports streaming and provides the following APIs. To invoke a streaming hub method on the server using the specified method name and return type use one of the following APIs:

- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.StreamAsChannelAsync%2A>: Returns `Task<ChannelReader<TResult>>`.
- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.StreamAsync%2A>: Returns `IAsyncEnumerable<TResult>`.

While the streaming is not a requirement of the Contoso Pizza's live map feature, it's still good to know it's available.

### Handle events

To handle events, you register a handler with the `HubConnection` instance. Call one of the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.On%2A?displayProperty=nameWithType> overloads given the name of the hub method and zero to eight parameters. The handler can satisfy any of the following `Action` variations:

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

- [`Func<Task>`][func1]
- [`Func<T,Task>`][func2]
- [`Func<T1,T2,Task>`][func3]
- [`Func<T1,T2,T3,Task>`][func4]
- [`Func<T1,T2,T3,T4,Task>`][func5]
- [`Func<T1,T2,T3,T4,T5,Task>`][func6]
- [`Func<T1,T2,T3,T4,T5,T6,Task>`][func7]
- [`Func<T1,T2,T3,T4,T5,T6,T7,Task>`][func8]
- [`Func<T1,T2,T3,T4,T5,T6,T7,T8,Task>`][func9]

[func1]: xref:System.Func%601
[func2]: xref:System.Func%602
[func3]: xref:System.Func%603
[func4]: xref:System.Func%604
[func5]: xref:System.Func%605
[func6]: xref:System.Func%606
[func7]: xref:System.Func%607
[func8]: xref:System.Func%608
[func9]: xref:System.Func%609

The result from registering an event handler is an `IDisposable`, which serves as the subscription. To unsubscribe the handler call <xref:System.IDisposable.Dispose%2A>.

## Contoso Pizza live order updates

The server code for the web application needs to have a `Hub` implementation and expose a route to clients. The `Hub` could use the order object's unique identifier to create a group for tracking. All order status change updates could then be communicated in this group.

The client code would also need to be updated, the Contoso Pizza application is a Blazor WebAssembly app. You could use either the JavaScript or .NET client SDK. You'd then replace the client-side polling functionality with code that builds a `HubConnection`, and start the connection to the server. As the user navigates to the order tracking page, the code would have to join the order's specific group where the change updates will be sent. You'd subscribe to the event for order status changes, and handle it accordingly.
