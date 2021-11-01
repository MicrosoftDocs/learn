In this unit, you'll learn how client-side polling was refactored out and ASP.NET Core SignalR was added.

## NuGet packages

The _BlazingPizza.Server.csproj_ added the following NuGet package reference:

- [Microsoft.AspNetCore.SignalR.Protocols.MessagePack](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Protocols.MessagePack)

:::code language="xml" source="../code/BlazingPizza.Server/BlazingPizza.Server.csproj" highlight="14":::

The _BlazingPizza.Client.csproj_ added the following NuGet package references:

- [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client)
- [Microsoft.AspNetCore.SignalR.Protocols.MessagePack](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Protocols.MessagePack)

:::code language="xml" source="../code/BlazingPizza.Client/BlazingPizza.Client.csproj" highlight="11-12":::

## Refactored server app

The server is responsible for exposing a SignalR endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub> or <xref:Microsoft.AspNetCore.SignalR.Hub%601> subclass. The server exposes hub methods that can be called from clients, and events that clients can subscribe to.

### The addition of the `OrderStatusHub`

ASP.NET Core SignalR supports strongly-typed hub implementations, <xref:Microsoft.AspNetCore.SignalR.Hub%601> where `T` is the client type. Consider the following _IOrderStatusHubs.cs_ file:

:::code source="../code/BlazingPizza.Server/Hubs/IOrderStatusHub.cs":::

The preceding interface defines a single method, which will act as an event that clients can subscribe to. Consider the following _OrderStatusHub.cs_ file:

:::code source="../code/BlazingPizza.Server/Hubs/OrderStatusHub.cs":::

The preceding hub implementation exposes two methods that are invokable from clients. A client calls `StartTrackingOrder` given an `order` instance, and the client's unique connection will be added to a group where notifications will be sent. Likewise, it calls `StopTrackingOrder` to leave the group and no longer receive notifications.

### Configure SignalR server

The `Startup` class needed to be updated to add ASP.NET Core SignalR, and the MessagePack protocol. Additionally, the `"/orderstatus"` endpoint is mapped to the `OrderStatusHub` implementation. Consider the following _Startup.cs_ file:

:::code source="../code/BlazingPizza.Server/Startup.cs" highlight="22-23,32":::

The preceding highlighted changes:

- Add SingalR and the MessagePack protocol.
- Map the `OrderStatusHub` to the endpoint.

## Refactored client app

// TODO:

### Grow component with code-behind

// TODO:
