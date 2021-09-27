<!--
# How ASP.NET Core SignalR works?

Parts
Parts working together
Apply to scenario

-->

## Servers and the `Hub` class

The `Hub` class in SignalR server concept. It's defined within the `Microsoft.AspNetCore.SignalR` namespace, and is part of the [Microsoft.AspNetCore.SignalR](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR) NuGet package. It is exposed through a route, for example; the `"https://contoso-pizza.com/hubs/orders"` route could be used to represent an `OrdersHub` implementation. The various hub APIs allow authors to define methods and events.

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

- The most common return type for a hub method is `Task`, which represents the asynchronous hub operation.
- The method name is used to call the method from clients, it can be customized using the <xref:Microsoft.AspNetCore.SignalR.HubMethodNameAttribute?displayProperty=fullName>.
- Parameters are optional, but when they're defined, clients are expected to provide corresponding arguments.

Methods are not required to fire events, but they often do.

### Events

`Hub`, `Hub<T>`, or `IHubContext` events are named and can define up to eight parameter(s).


## Clients and the `HubConnection` class

The `HubConnection` class in SignalR client concept, which represents a client's connection to a [server `Hub`](#servers-and-the-hub-class). It's defined within the `Microsoft.AspNetCore.SignalR.Client` namespace, and is part of the [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client) NuGet package. A `HubConnection` is created using the builder-pattern, and the corresponding `HubConnectionBuilder` type.

### Call methods

A client 

### Handle events

