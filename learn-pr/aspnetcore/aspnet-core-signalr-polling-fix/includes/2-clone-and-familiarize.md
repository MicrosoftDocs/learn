In this unit, you'll clone the existing applications' source code repository. With a local clone of the source, you'll then familize yourself with the existing client-side polling functionality and evaluate how best to refactor the code.

## Clone the repository

Regardless of whether you use Visual Studio, Visual Studio Code, or some other integrated development environment (IDE), you'll indirectly use git to clone the repo. This module builds upon the [Blazor Workshop](https://github.com/dotnet-presentations/blazor-workshop) which contains a pizza ordering application.

### [Linux](#tab/linux)

```bash
git clone https://github.com/dotnet-presentations/blazor-workshop
```

### [Windows](#tab/Windows)

```PowerShell
git clone https://github.com/dotnet-presentations/blazor-workshop
```

---

After you've successfully cloned the repository, it's best to build and run the app. You'll need to change directories into the _src_ directory of the repo before using the .NET CLI.

### [Linux](#tab/linux)

```bash
cd ./blazor-workshop/src
```

### [Windows](#tab/Windows)

```PowerShell
cd .\blazor-workshop\src
```

---

### Run the application

Again, you're free to use your IDE or the .NET CLI:

### [Linux](#tab/linux)

```dotnetcli
dotnet run --project ./BlazingPizza.Server/BlazingPizza.Server.csproj
```

### [Windows](#tab/Windows)

```dotnetcli
dotnet run --project .\BlazingPizza.Server\BlazingPizza.Server.csproj
```

---

This application is for learning purposes, and its authentication allows users to register any email address. When actively developing the app, you can complete the registration process by clicking a link to confirm your account - without actually validating the email address. For more information, see [Blazor Workshop: register a user and log in](https://github.com/dotnet-presentations/blazor-workshop/blob/4c8cb74dedb7a42eda534a03493ab9fd6b198131/docs/06-authentication-and-authorization.md#register-a-user-and-log-in).

### Place a pizza order

Once you've logged in, you can place an order for pizza. Select a pizza, choose the toppings and add it to the order. As an example, consider the following screen capture:

:::image type="content" source="../media/add-to-order.png" alt-text="Blazing Pizza: A pizza(s) to order.":::

After adding pizza(s) to the order, place the order by selecting the **Order >** button.

:::image type="content" source="../media/place-order.png" alt-text="Blazing Pizza: Place order.":::

Immediately following the order creation, the app redirects to the order status page. This displays the various order status details from **Preparing**, to **Out for delivery**, and finally **Delivered**. While the order is **Out for delivery** the live map will update incrementally emulating the delivery drivers location.

Consider the following series of screen captures that show the gradual progression from the starting location to the ending location:

:::image type="content" source="../media/out-for-delivery-1.png" alt-text="Blazing Pizza: Order status, driver just leaving, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-2.png" alt-text="Blazing Pizza: Order status, driver a quarter of the way there, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-3.png" alt-text="Blazing Pizza: Order status, driver halfway there, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-4.png" alt-text="Blazing Pizza: Order status, driver three quarters of the way there, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-5.png" alt-text="Blazing Pizza: Order status, driver arriving at destination, out for delivery.":::

Finally, the order status page reflects the that order has been delivered:

:::image type="content" source="../media/delivered-order.png" alt-text="Blazing Pizza: Order status, driver delivered order.":::

### Stop the application

The console should output various logs, letting you know that the app has successfully built and that it's serving content at <https://localhost:5001/>. Open your favorite browser, and navigate to <https://localhost:5001/> to see the running application. Close the browser, and from the command line session press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the application.

## Familiarize yourself with the code

The primary focus for this module is refactoring the client-side polling to instead use ASP.NET Core SignalR. Consider the _OrderDetails.razor_ file:

```razor
@page "/myorders/{orderId:int}"
@attribute [Authorize]
@using System.Threading
@inject OrdersClient OrdersClient
@implements IDisposable

<div class="main">
    @if (invalidOrder)
    {
        <h2>Nope</h2>
        <p>Sorry, this order could not be loaded.</p>
    }
    else if (orderWithStatus == null)
    {
        <text>Loading...</text>
    }
    else
    {
        <div class="track-order">
            <div class="track-order-title">
                <h2>
                    Order placed @orderWithStatus.Order.CreatedTime.ToLongDateString()
                </h2>
                <p class="ml-auto mb-0">
                    Status: <strong>@orderWithStatus.StatusText</strong>
                </p>
            </div>
            <div class="track-order-body">
                <div class="track-order-details">
                    <OrderReview Order="orderWithStatus.Order" />
                </div>
                <div class="track-order-map">
                    <Map Zoom="13" Markers="orderWithStatus.MapMarkers" />
                </div>
            </div>
        </div>
    }
</div>

@code {
    [Parameter] public int OrderId { get; set; }

    OrderWithStatus orderWithStatus;
    bool invalidOrder;
    CancellationTokenSource pollingCancellationToken;

    protected override void OnParametersSet()
    {
        // If we were already polling for a different order, stop doing so
        pollingCancellationToken?.Cancel();

        // Start a new poll loop
        PollForUpdates();
    }

    private async void PollForUpdates()
    {
        invalidOrder = false;
        pollingCancellationToken = new CancellationTokenSource();
        while (!pollingCancellationToken.IsCancellationRequested)
        {
            try
            {
                orderWithStatus = await OrdersClient.GetOrder(OrderId);
                StateHasChanged();

                if (orderWithStatus.IsDelivered)
                {
                    pollingCancellationToken.Cancel();
                }
                else
                {
                    await Task.Delay(4000);
                }
            }
            catch (AccessTokenNotAvailableException ex)
            {
                pollingCancellationToken.Cancel();
                ex.Redirect();
            }
            catch (Exception ex)
            {
                invalidOrder = true;
                pollingCancellationToken.Cancel();
                Console.Error.WriteLine(ex);
                StateHasChanged();
            }
        }
    }

    void IDisposable.Dispose()
    {
        pollingCancellationToken?.Cancel();
    }
}
```

The preceding Razor markup:

- Binds values from the `orderWithStatus` object as part of the component template.
- When the `OrderId` parameter is set, the `PollForUpdates` is started.
  - This method will make an HTTP request to the server every four seconds.
  - The latest order status details are re-assigned to the `orderWithStatus` variable.
