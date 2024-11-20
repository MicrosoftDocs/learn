In this unit, you learn how client-side polling was refactored out and ASP.NET Core SignalR was added. Both the server and the client applications required refactoring. The server hub had to be created, mapped, and configured. The client then had to establish a connection to the hub and handle order status change notifications.

## NuGet packages

The *BlazingPizza.Server.csproj* file added the following NuGet package reference:

- [Microsoft.AspNetCore.SignalR.Protocols.MessagePack](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Protocols.MessagePack)

:::code language="xml" source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/BlazingPizza.Server.csproj" highlight="15":::

The *BlazingPizza.Client.csproj* file added the following NuGet package references:

- [Microsoft.AspNetCore.SignalR.Client](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Client)
- [Microsoft.AspNetCore.SignalR.Protocols.MessagePack](https://www.nuget.org/packages/Microsoft.AspNetCore.SignalR.Protocols.MessagePack)

:::code language="xml" source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Client/BlazingPizza.Client.csproj" highlight="12-13":::

The MessagePack NuGet package was added to make the messages that are sent between the client and server smaller.

## Refactored server app

The server is responsible for exposing a SignalR endpoint. The endpoint maps to a <xref:Microsoft.AspNetCore.SignalR.Hub> or <xref:Microsoft.AspNetCore.SignalR.Hub%601> subclass. The server exposes hub methods that can be called from clients, and it exposes events that clients can subscribe to.

### The addition of the `OrderStatusHub`

ASP.NET Core SignalR supports hub implementations that are "strongly typed" such as <xref:Microsoft.AspNetCore.SignalR.Hub%601>, where `T` is the client type. Consider the following *IOrderStatusHubs.cs* file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/Hubs/IOrderStatusHub.cs":::

The preceding interface defines a single method, which acts as an event that clients can subscribe to. Consider the following *OrderStatusHub.cs* file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/Hubs/OrderStatusHub.cs":::

The preceding hub implementation exposes two methods that are invokable from clients. A client calls `StartTrackingOrder` and is given an `order` instance, and the client's unique connection is added to a group that notifications are sent from. Likewise, a call to `StopTrackingOrder` has the connection leave the group and no longer receive notifications.

### SignalR server configuration

The `Startup` class needed to be updated to add ASP.NET Core SignalR and the MessagePack protocol. The `"/orderstatus"` endpoint is also mapped to the `OrderStatusHub` implementation. Consider the following *Startup.cs* file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Server/Startup.cs" highlight="29-30,62":::

The preceding code highlights these changes:

- Add SingalR and the MessagePack protocol.
- Map `OrderStatusHub` to the `"/orderstatus"` endpoint.

## Refactored client app

The client application needed to refactor the *OrderDetails.razor* file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Client/Pages/OrderDetails.razor":::

Notice that the process removes several directives:

- The `@using System.Threading` directive is no longer needed in the markup.
- The `@inject OrdersClient OrdersClient` directive is now part of the code-behind.
- The `@implements IDisopsable` is replaced in the code-behind with an implementation of <xref:System.IAsyncDisposable>.
- The `@code { ... }` directive is removed, because all logic is now in the code-behind.

Additionally, the Blazor component is now more pure because it primarily represents binding and templating. The logic is moved to a code-behind file instead.

### Grow component with code-behind

As more logic is introduced into Blazor components, it's common for them to evolve into two separate files:

- *OrderDetails.razor*: The Razor markup.
- *OrderDetails.razor.cs*: The corresponding C# code-behind. It's the same component but only a `partial class`.

Consider the _OrderDetails.razor.cs_ file:

:::code source="~/../blazing-pizza-signalr/blazor-workshop/src/BlazingPizza.Client/Pages/OrderDetails.razor.cs":::

The preceding C# component represents the code-behind for the `OrderDetails` component, which is possible because the class is being defined as `partial`. It's an implementation of `IAsyncDisposable`, which cleans up the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnection> instance. This component defines several class-scoped fields, each with its own intent:

- `_hubConnection`: A connection for invoking methods on the SignalR Server.
- `_orderWithStatus`: The contextual order and its current status.
- `_invalidOrder`: A value that indicates whether the order is invalid.

With this refactoring, all required code that was in the original `@code { ... }` directive is now in the code-behind:

- The `[Parameter] public int OrderId { get; set; }` is exactly the same.
- The attribute-decorated property, `[Inject] public OrdersClient OrdersClient { get; set; }`, replaces the `@inject OrdersClient OrdersClient` directive.

The configuration of the SignalR connection requires a few more injected properties:

- The `[Inject] public NavigationManager Nav { get; set; }` property is used to resolve the hub's endpoint.
- The `[Inject] public IAccessTokenProvider AccessTokenProvider { get; set; }` property is used to assign the `AccessTokenProvider` to the hub connection's options object. This property ensures that all communications correctly provide the authenticated user's access token.

The `OnInitializedAsync` override method uses the <xref:Microsoft.AspNetCore.SignalR.Client.HubConnectionBuilder> object to build the `_hubConnection` instance. The `_hubConnection` instance is configured to automatically reconnect, and it specifies the MessagePack protocol. With the `_hubConnection` instance, the page subscribes to the `"OrderStatusChanged"` hub event and sets the `OnOrderStatusChangedAsync` as its corresponding event handler. The hub connection is then started using <xref:Microsoft.AspNetCore.SignalR.Client.HubConnection.StartAsync%2A?displayProperty=nameWithType>.

The `OnOrderStatusChangedAsync` event handler method accepts the `OrderWithStatus` instance as its parameter and then returns <xref:System.Threading.Tasks.Task>. It reassigns the `_orderWithStatus` class variable and calls <xref:Microsoft.AspNetCore.Components.ComponentBase.StateHasChanged>.

The `OnParametersSetAsync` override method is called when the `OrderId` is assigned. The initial state of the `_orderWithStatus` object is assigned from the `OrdersClient.GetOrder` call. If the order is delivered, it's no longer tracked, and the hub connection is stopped using <xref:Microsoft.AspNetCore.SignalR.Client.HubConnection.StopAsync%2A?displayProperty=nameWithType>. If the order isn't delivered yet, it continues to be tracked.
