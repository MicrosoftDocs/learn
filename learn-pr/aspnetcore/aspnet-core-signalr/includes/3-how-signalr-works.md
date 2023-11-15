## Servers and the `Hub` class

The `Hub` class is a SignalR server concept. It's defined within the `Microsoft.AspNetCore.SignalR` namespace and is part of the [Microsoft.AspNetCore.SignalR](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR) NuGet package. ASP.NET Core web apps that target the Microsoft.NET.Sdk.Web SDK don't need to add a package reference for SignalR, because it's already available as part of the [shared framework](/aspnet/core/fundamentals/metapackage-app).

A `Hub` is exposed through a *route*. For example, the `https://www.contoso-pizza.com/hubs/orders` route could be used to represent an `OrdersHub` implementation. Through the various hub APIs, authors can define methods and events.

There are two modalities to expose methods on a hub. You create a subclass of the following types and write [methods](#methods):

- <xref:Microsoft.AspNetCore.SignalR.Hub>: A standard hub.
- <xref:Microsoft.AspNetCore.SignalR.Hub%601>: A strongly typed generic hub.

### Example `Hub`

As a point of reference, consider the following `Notification` object:

```csharp
namespace RealTime.Models;

public record Notification(string Text, DateTime Date);
```

The object can be shared when you use the .NET client SDK, so that the server and client have exactly the same object. Imagine a notification hub:

```csharp
using Microsoft.AspNetCore.SignalR;
using System;
using System.Threading.Tasks;
using RealTime.Models;

namespace ExampleServer.Hubs;

public sealed class NotificationHub : Hub
{
    public Task NotifyAll(Notification notification) =>
        Clients.All.SendAsync("NotificationReceived", notification);
}
```

Regarding the difference between methods and events, the method in the preceding hub implementation is `NotifyAll`, and the event is `NotificationReceived`. `NotificationHub` is a subclass of `Hub`. The `NotifyAll` method returns a `Task`, and it accepts a single `Notification` parameter. The method is expressed as the invocation to `SendAsync` from `Clients.All`, which represents all connected clients. The `NotificationReceived` event is fired, depending on the `notification` instance.

### The `IHubContext` instance

You fire [events](#events) from either a `Hub` or an `IHubContext` instance. The SignalR hub is the core abstraction for sending messages to clients that are connected to the SignalR server. It's also possible to send messages from other places in your app by using either of the following types:

- <xref:Microsoft.AspNetCore.SignalR.IHubContext%601>: A context where `THub` represents a standard hub.
- <xref:Microsoft.AspNetCore.SignalR.IHubContext%602>: A context where `THub` represents a strongly typed generic hub, and `T` represents the corresponding type of client.

> [!IMPORTANT]
> `IHubContext` is for sending notifications to clients. It is *not* used to call methods on the `Hub`.

#### An example `IHubContext`

Considering the previous notification hub implementation, you could use `IHubContext<NotificationHub>` as follows:

```csharp
using Microsoft.AspNetCore.SignalR;
using System;
using System.Threading.Tasks;
using RealTime.Models;

namespace ExampleServer.Services;

public sealed class NotificationService(
    IHubContext<NotificationHub> hubContext)
{
    public Task SendNotificationAsync(Notification notification) =>
        notification is not null
            ? hubContext.Clients.All.SendAsync("NotificationReceived", notification)
            : Task.CompletedTask;
}
```

The preceding C# code relies on `IHubContext<NotificationHub>` to access the contextual listing of clients, exposing the ability to broadcast notifications. The `hubContext` primary constructor parameter that's captured in scope is used to fire the `"NotificationReceived"` event, but it isn't intended to be used to call the hub's `NotifyAll` method.

### Methods

`Hub` or `Hub<T>` methods are just like any other C# method. They define a return type, method name, and parameters.

- The most common return type for a hub method is `Task` or `Task<TResult>`, which represents the asynchronous hub operation.
- The method name is used to call the method from clients. You can customize it by using <xref:Microsoft.AspNetCore.SignalR.HubMethodNameAttribute>.
- Parameters are optional, but when they're defined, clients are expected to provide corresponding arguments.

Methods aren't required to fire events, but they often do.

### Events

An event can be subscribed to by name from a client. The server is responsible for raising events. `Hub`, `Hub<T>`, `IHubContext<THub>`, and `IHubContext<THub, T>` events are *named* and can define up to 10 parameters. Events are fired on the server and handled by interested clients. A client is considered interested when it subscribes to events on its hub's connection. Clients can indirectly trigger events when they call hub methods that fire events as a result of their invocation. Events can't be directly triggered by clients, though, because that's the responsibility of the server.

#### Event client scopes

You call events from an <xref:Microsoft.AspNetCore.SignalR.IClientProxy> instance. You implement the <xref:Microsoft.AspNetCore.SignalR.IHubClients> and <xref:Microsoft.AspNetCore.SignalR.IHubCallerClients> interfaces from the <xref:Microsoft.AspNetCore.SignalR.Hub.Clients%2A> type. There are many ways to scope to a specific `IClientProxy` instance. You can target the following scopes from the `Hub.Clients` property:

| Member | Details |
|---|---|
| [`All`][all] | All connected clients (such as a broadcast). |
| [`AllExcept`][all-except] | All connected clients, excluding the specified connections (such as a filtered broadcast). |
| [`Caller`][caller] | The connected client that triggered the method (such as an echo). |
| [`Client`][client] | The specified client connection (single connection). |
| [`Clients`][clients] | The specified client connections (multiple connections). |
| [`Group`][group] | All connected clients within the specified group. |
| [`GroupExcept`][group-except] | All connected clients within the specified group, excluding the specified connections. |
| [`Groups`][groups] | All connected clients within the specified groups (multiple groups). |
| [`Others`][others] | All connected clients, excluding the client that triggered the method. |
| [`OthersInGroup`][others-in-group] | All connected clients within the specified group, excluding the client that triggered the method. |
| [`User`][user] | All connected clients for the specified user (a single user can connect on more than one device). |
| [`Users`][users] | All connected clients for the specified users. |

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

#### **Example scopes**

Consider the following images, which can help you visualize how the hub sends messages to targeted clients. You can expand the images for improved readability.

- **Broadcast to all**

    :::image type="content" source="../media/signalr-all.png" lightbox="../media/signalr-all-large.png" alt-text="ASP.NET Core SignalR hub sending message with Clients.All syntax.":::

    All connected clients receive this message, regardless of the group that they might or might not belong to.

- **Isolated user**

    :::image type="content" source="../media/signalr-user.png" lightbox="../media/signalr-user-large.png" alt-text="ASP.NET Core SignalR hub sending message with Clients.User syntax.":::

    A single user receives this message, regardless of how many devices they're currently using.

- **Isolated group**

    :::image type="content" source="../media/signalr-group.png" lightbox="../media/signalr-group-large.png" alt-text="ASP.NET Core SignalR hub sending message with Clients.Group syntax.":::

    Only clients that belong to a certain group receive this message.

## Clients and the `HubConnection` class

The `HubConnection` class is a SignalR client concept, which represents the client's connection to the [server `Hub`](#servers-and-the-hub-class). It's defined within the `Microsoft.AspNetCore.SignalR.Client` namespace, and it's part of the [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client) NuGet package.

You create a `HubConnection` by using the builder pattern and the corresponding `HubConnectionBuilder` type. Given the hub's route (or <xref:System.Uri?displayProperty=fullName>), you can create a `HubConnection`. The builder can also specify additional configuration options, including logging, the desired protocol, authentication token forwarding, and automatic reconnection, among others.

The `HubConnection` API exposes start and stop functions, which you use to start and stop the connection to the server. Additionally, there are capabilities for streaming, calling [hub methods](#methods), and subscribing to [events](#events).

### An example `HubConnection` creation

To create a `HubConnection` object from the .NET SignalR client SDK, you use the `HubConnectionBuilder` type:

```csharp
using Microsoft.AspNetCore.SignalR.Client;
using System;
using System.Threading.Tasks;
using RealTime.Models;

namespace ExampleClient;

public sealed class Consumer : IAsyncDisposable
{
    private readonly string HostDomain =
        Environment.GetEnvironmentVariable("HOST_DOMAIN");
    
    private HubConnection _hubConnection;

    public Consumer()
    {
        _hubConnection = new HubConnectionBuilder()
            .WithUrl(new Uri($"{HostDomain}/hub/notifications"))
            .WithAutomaticReconnect()
            .Build();
    }

    public Task StartNotificationConnectionAsync() =>
        _hubConnection.StartAsync();

    public async ValueTask DisposeAsync()
    {
        if (_hubConnection is not null)
        {
            await _hubConnection.DisposeAsync();
            _hubConnection = null;
        }
    }
}
```

### Call hub methods

If a client is given a client `HubConnection` instance that has successfully started, that client can call methods on a hub by using the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.InvokeAsync%2A> or <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync%2A> extensions. If the hub method returns a `Task<TResult>`, the result of `InvokeAsync<TResult>` is of type `TResult`. If the hub method returns `Task`, there's no result. Both `InvokeAsync` and `SendAsync` require the name of the hub method, and zero to 10 parameters.

- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.InvokeAsync%2A>: Invokes a hub method on the server by using the specified method name and optional arguments.
- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync%2A>: Invokes a hub method on the server by using the specified method name and optional arguments. This method *doesn't* wait for a response from the receiver.

### An example hub method invocation

When `SendNotificationAsync` adds a method to the previous `Consumer` class, `SendNotificationAsync` delegates out to the `_hubConnection` and calls the `NotifyAll` method on the server's hub, depending on the `Notification` instance.

```csharp
public Task SendNotificationAsync(string text) =>
    _hubConnection.InvokeAsync(
        "NotifyAll", new Notification(text, DateTime.UtcNow));
```

<!--
### Streaming APIs

SignalR supports streaming and provides the following APIs. To invoke a streaming hub method on the server by using the specified method name and return type, use one of the following APIs:

- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.StreamAsChannelAsync%2A>: Returns `Task<ChannelReader<TResult>>`.
- <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.StreamAsync%2A>: Returns `IAsyncEnumerable<TResult>`.

Although streaming isn't a requirement of Contoso Pizza's live map feature, it's still good to know that it's available.
-->

### Handle events

To handle events, you register a handler with the `HubConnection` instance. Call one of the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.On%2A?displayProperty=nameWithType> overloads when you know the name of the hub method and have zero to eight parameters. The handler can satisfy any of the following `Action` variations:

- <xref:System.Action>
- <xref:System.Action%601>
- <xref:System.Action%602>
- <xref:System.Action%603>
- <xref:System.Action%604>
- <xref:System.Action%605>
- <xref:System.Action%606>
- <xref:System.Action%607>
- <xref:System.Action%608>

Alternatively, you can use the asynchronous handler APIs, which are `Func<TResult>` where the `TResult` is a `Task` variation:

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

The result of registering an event handler is an `IDisposable`, which serves as the subscription. To unsubscribe the handler, call <xref:System.IDisposable.Dispose%2A>.

### An example event registration

By updating the previous `Consumer` class, you register to an event by providing a handler and calling `On`:

```csharp
using Microsoft.AspNetCore.SignalR.Client;
using System;
using System.Threading.Tasks;
using RealTime.Models;

namespace ExampleClient;

public sealed class Consumer : IAsyncDisposable
{
    private readonly string HostDomain =
        Environment.GetEnvironmentVariable("HOST_DOMAIN");
    
    private HubConnection _hubConnection;

    public Consumer()
    {
        _hubConnection = new HubConnectionBuilder()
            .WithUrl(new Uri($"{HostDomain}/hub/notifications"))
            .WithAutomaticReconnect()
            .Build();

        _hubConnection.On<Notification>(
            "NotificationReceived", OnNotificationReceivedAsync);
    }

    private async Task OnNotificationReceivedAsync(Notification notification)
    {
        // Do something meaningful with the notification.
        await Task.CompletedTask;
    }

    // Omitted for brevity.
}
```

The `OnNotificationReceivedAsync` method is called when the server's hub instance fires the `"NotificationReceived"` event.

## Contoso Pizza live order updates

The server code for the web application needs to have a `Hub` implementation, and expose a route to clients. The `Hub` could use the order object's unique identifier to create a group for tracking. All order status change updates could then be communicated in this group.

The client code would also need to be updated to indicate that the Contoso Pizza application is a Blazor WebAssembly app. You could use either the JavaScript SDK or the .NET client SDK. You would replace the client-side polling functionality with code that builds a `HubConnection`, and then start the connection to the server. As it navigates to the order tracking page, the code would have to join the order's specific group where the change updates are sent. You'd subscribe to the event for order status changes, and then handle it accordingly.
