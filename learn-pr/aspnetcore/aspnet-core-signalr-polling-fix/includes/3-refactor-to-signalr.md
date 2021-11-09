In this unit, you'll learn how client-side polling was refactored out and ASP.NET Core SignalR was added. Both the server and the client applications required refactoring. The server hub needed to be created, mapped, and configured. The client then needed to establish a connection to the hub and handle order status change notifications.

## NuGet packages

The _BlazingPizza.Server.csproj_ added the following NuGet package reference:

- [Microsoft.AspNetCore.SignalR.Protocols.MessagePack](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Protocols.MessagePack)

:::code language="xml" source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/BlazingPizza.Server.csproj" highlight="14":::

The _BlazingPizza.Client.csproj_ added the following NuGet package references:

- [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client)
- [Microsoft.AspNetCore.SignalR.Protocols.MessagePack](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Protocols.MessagePack)

:::code language="xml" source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Client/BlazingPizza.Client.csproj" highlight="11-12":::

The MessagePack NuGet package was added to make messages sent between the client and server smaller.

## Refactored server app

The server is responsible for exposing a SignalR endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub> or <xref:Microsoft.AspNetCore.SignalR.Hub%601> subclass. The server exposes hub methods that can be called from clients, and events that clients can subscribe to.

### The addition of the `OrderStatusHub`

ASP.NET Core SignalR supports strongly-typed hub implementations, <xref:Microsoft.AspNetCore.SignalR.Hub%601> where `T` is the client type. Consider the following _IOrderStatusHubs.cs_ file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/Hubs/IOrderStatusHub.cs":::

The preceding interface defines a single method, which will act as an event that clients can subscribe to. Consider the following _OrderStatusHub.cs_ file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/Hubs/OrderStatusHub.cs":::

The preceding hub implementation exposes two methods that are invokable from clients. A client calls `StartTrackingOrder` given an `order` instance, and the client's unique connection will be added to a group where notifications will be sent. Likewise, a call to `StopTrackingOrder` will have the connection leave the group and no longer receive notifications.

### SignalR server configuration

The `Startup` class needed to be updated to add ASP.NET Core SignalR, and the MessagePack protocol. Additionally, the `"/orderstatus"` endpoint is mapped to the `OrderStatusHub` implementation. Consider the following _Startup.cs_ file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/Startup.cs" highlight="39-40,72":::

The preceding highlighted changes:

- Add SingalR and the MessagePack protocol.
- Map the `OrderStatusHub` to the `"/orderstatus"` endpoint.

## Refactored client app

The client application needed to refactor the _OrderDetails.razor_ file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Client/Pages/OrderDetails.razor":::

You'll notice that several directives have been removed:

- The `@using System.Threading` directive is no longer needed in the markup.
- The `@inject OrdersClient OrdersClient` directive is now part of the code-behind.
- The `@implements IDisopsable` has been replaced in the code-behind with an implementation of <xref:System.IAsyncDisposable>.
- The `@code { ... }` directive has been removed, as all logic is now in the code-behind.

Additionally, the Blazor component is now more pure in that it's primarily representing binding and templating. The logic has been moved to a code-behind file instead.

### Grow component with code-behind

As more logic is introduced into Blazor components, it's common for them to evolve into two separate files:

- _OrderDetails.razor_: This is the Razor markup.
- _OrderDetails.razor.cs_: The is the corresponding C# code-behind, and it's the same component just a `partial class`.

Consider the _OrderDetails.razor.cs_ file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Client/Pages/OrderDetails.razor.cs":::

The preceding C# component represents the code-behind for the `OrderDetails` component and this is possible due to the class being defined as `partial`. It's an implementation of `IAsyncDisposable` to clean up the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnection> instance. This component defines several class-scoped fields, each with various intents:

- `_hubConnection`: A connection used to invoke methods on the SignalR Server.
- `_orderWithStatus`: The contextual order and its current status.
- `_invalidOrder`: A value indicating whether the order is invalid.

With this refactoring, all required code that was in the original `@code { ... }` directive is now in the code-behind:

- The `[Parameter] public int OrderId { get; set; }` is the exact same.
- The attribute-decorated property `[Inject] public OrdersClient OrdersClient { get; set; }`, replaces the `@inject OrdersClient OrdersClient` directive.

There are a few additional injected properties that the configuration of the SignalR connection requires:

- The `[Inject] public NavigationManager Nav { get; set; }` property is used to resolve the hub's endpoint.
- The `[Inject] public IAccessTokenProvider AccessTokenProvider { get; set; }` property is used to assign the `AccessTokenProvider` to the hub connection's options object. This ensures that all communications correctly provide the authenticated user's access token.

The `OnInitializedAsync` override method uses the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionBuilder> object to build the `_hubConnection` instance. It's configured to automatically reconnect and specifies the MessagePack protocol. With the `_hubConnection` instance the page subscribes to the `"OrderStatusChanged"` hub event and sets the `OnOrderStatusChangedAsync` as its corresponding event handler. The hub connection is then started using <xref:Microsoft.AspNetCore.SignalR.Client.HubConnection.StartAsync%2A?displayProperty=nameWithType>.

The `OnOrderStatusChangedAsync` event handler method accepts the `OrderWithStatus` instance as its parameter and returns a <xref:System.Threading.Tasks.Task>. It reassigns the `_orderWithStatus` class variable and calls <xref:Microsoft.AspNetCore.Components.ComponentBase.StateHasChanged>.

The `OnParametersSetAsync` override method is called when the `OrderId` is assigned. The initial state of the `_orderWithStatus` object is assigned from the `OrdersClient.GetOrder` call. If the order has been delivered, the order is no longer tracked, and the hub connection is stopped using <xref:Microsoft.AspNetCore.SignalR.Client.HubConnection.StopAsync%2A?displayProperty=nameWithType>. If the order has not yet been delivered, the order is tracked.
