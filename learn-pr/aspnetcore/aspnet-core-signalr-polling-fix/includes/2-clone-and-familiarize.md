In this unit, you'll clone the existing applications' source code repository. With a local clone of the source, you'll then familize yourself with the existing client-side polling functionality and evaluate how best to refactor the code.

## Clone the repository

Regardless of whether you use Visual Studio, Visual Studio Code, or some other integrated development environment (IDE), you'll indirectly use git to clone the repo. This module builds upon the [Blazor Workshop](https://github.com/dotnet-presentations/blazor-workshop) which contains a pizza ordering application.

# [Linux](#tab/linux)

```bash
git clone https://github.com/dotnet-presentations/blazor-workshop
```

# [Windows](#tab/windows)

```PowerShell
git clone https://github.com/dotnet-presentations/blazor-workshop
```

---

After you've successfully cloned the repository, it's best to build and run the app. You'll need to change directories into the _src_ directory of the repo before using the .NET CLI.

# [Linux](#tab/linux)

```bash
cd ./blazor-workshop/src
```

# [Windows](#tab/windows)

```PowerShell
cd .\blazor-workshop\src
```

---

### Run the application

You're free to use your IDE or the .NET CLI, from the CLI use the `dotnet run` command:

# [Linux](#tab/linux)

```dotnetcli
dotnet run --project ./BlazingPizza.Server/BlazingPizza.Server.csproj
```

# [Windows](#tab/windows)

```dotnetcli
dotnet run --project .\BlazingPizza.Server\BlazingPizza.Server.csproj
```

---

This application is for learning purposes, and its authentication allows users to register any email address. When actively developing the app, you can complete the registration process by clicking a link to confirm your account - without actually validating the email address. For more information, see [Blazor Workshop: register a user and log in](https://github.com/dotnet-presentations/blazor-workshop/blob/4c8cb74dedb7a42eda534a03493ab9fd6b198131/docs/06-authentication-and-authorization.md#register-a-user-and-log-in).

### Place a pizza order

Once you've logged in, you can place an order for pizza. Select a pizza, choose the toppings, and add them to the order. As an example, consider the following screen capture:

:::image type="content" source="../media/add-to-order.png" lightbox="../media/add-to-order.png" alt-text="Blazing Pizza: A pizza(s) to order.":::

After adding pizza(s) to the order, place the order by selecting the **Order >** button.

:::image type="content" source="../media/place-order.png" lightbox="../media/place-order.png" alt-text="Blazing Pizza: Place order.":::

Immediately following the order creation, the app redirects to the order status page. This displays the various order status details from **Preparing** to **Out for delivery**, and finally **Delivered**. While the order is **Out for delivery** the live map will update incrementally emulating the delivery driver's location.

Consider the following series of screen captures that show the gradual progression from the starting location to the ending location:

:::image type="content" source="../media/out-for-delivery-1.png" lightbox="../media/out-for-delivery-1.png" alt-text="Blazing Pizza: Order status, driver just leaving, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-2.png" lightbox="../media/out-for-delivery-2.png" alt-text="Blazing Pizza: Order status, driver a quarter of the way there, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-3.png" lightbox="../media/out-for-delivery-3.png" alt-text="Blazing Pizza: Order status, driver halfway there, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-4.png" lightbox="../media/out-for-delivery-4.png" alt-text="Blazing Pizza: Order status, driver three quarters of the way there, out for delivery.":::
:::image type="content" source="../media/out-for-delivery-5.png" lightbox="../media/out-for-delivery-5.png" alt-text="Blazing Pizza: Order status, driver arriving at destination, out for delivery.":::

Finally, the order status page reflects the **Delivered** order status:

:::image type="content" source="../media/delivered-order.png" lightbox="../media/delivered-order.png" alt-text="Blazing Pizza: Order status, driver delivered order.":::

### Stop the application

The console should output various logs, letting you know that the app has successfully built and that it's serving content at <https://localhost:5001/>. To stop the application, close the browser, and from the command line session press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the application.

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
  - The created time, and status text values are bound in the order title markup.
  - The order is passed as an argument to the `OrderReview` component.
  - The map markers (which represent the markings on the live map) are passed to the `Map` component.
- When the `OrderId` parameter is set, the `PollForUpdates` is started.
  - This method will make an HTTP request to the server every four seconds.
  - The latest order status details are re-assigned to the `orderWithStatus` variable.

> [!NOTE]
> The `PollForUpdates` method is `async void` which means it's fire-and-forget. This can cause unexpected behavior and should be avoided if possible.

Each time the order is received, it recalculates delivery status updates and corresponding map marker changes. This is achieved by calculating properties on the `OrderWithStatus` object. Consider the following _OrderWithStatus.cs_ C# file:

```csharp
using BlazingPizza.ComponentsLibrary.Map;
using System;
using System.Collections.Generic;

namespace BlazingPizza
{
    public class OrderWithStatus
    {
        public readonly static TimeSpan PreparationDuration =
            TimeSpan.FromSeconds(10);
        public readonly static TimeSpan DeliveryDuration =
            TimeSpan.FromMinutes(1); // Unrealistic, but more interesting to watch

        public Order Order { get; set; }

        public string StatusText { get; set; }

        public bool IsDelivered => StatusText == "Delivered";

        public List<Marker> MapMarkers { get; set; }

        public static OrderWithStatus FromOrder(Order order)
        {
            // To simulate a real backend process, 
            // we fake status updates based on the amount
            // of time since the order was placed
            string statusText;
            List<Marker> mapMarkers;
            var dispatchTime = order.CreatedTime.Add(PreparationDuration);

            if (DateTime.Now < dispatchTime)
            {
                statusText = "Preparing";
                mapMarkers = new List<Marker>
                {
                    ToMapMarker("You", order.DeliveryLocation, showPopup: true)
                };
            }
            else if (DateTime.Now < dispatchTime + DeliveryDuration)
            {
                statusText = "Out for delivery";

                var startPosition = ComputeStartPosition(order);
                var difference = (DateTime.Now - dispatchTime).TotalMilliseconds;
                var proportionOfDeliveryCompleted =
                    Math.Min(1, difference / DeliveryDuration.TotalMilliseconds);

                var driverPosition =
                    LatLong.Interpolate(
                        startPosition, order.DeliveryLocation, proportionOfDeliveryCompleted);
                mapMarkers = new List<Marker>
                {
                    ToMapMarker("You", order.DeliveryLocation),
                    ToMapMarker("Driver", driverPosition, showPopup: true),
                };
            }
            else
            {
                statusText = "Delivered";
                mapMarkers = new List<Marker>
                {
                    ToMapMarker(
                        "Delivery location",
                        order.DeliveryLocation, showPopup: true),
                };
            }

            return new OrderWithStatus
            {
                Order = order,
                StatusText = statusText,
                MapMarkers = mapMarkers,
            };
        }

        static LatLong ComputeStartPosition(Order order)
        {
            // Random but deterministic based on order ID
            var rng = new Random(order.OrderId);
            var distance = 0.01 + rng.NextDouble() * 0.02;
            var angle = rng.NextDouble() * Math.PI * 2;
            var offset = (distance * Math.Cos(angle), distance * Math.Sin(angle));

            return new LatLong(
                order.DeliveryLocation.Latitude + offset.Item1,
                order.DeliveryLocation.Longitude + offset.Item2);
        }

        static Marker ToMapMarker(
            string description, LatLong coords, bool showPopup = false) =>
            new Marker
            {
                Description = description,
                X = coords.Longitude,
                Y = coords.Latitude,
                ShowPopup = showPopup
            };
    }
}
```

In the preceding C# code, the `FromOrder` calculates a new order status based on the current time. Based on the understanding of how this was implemented, we'll be able to reuse the `OrderWithStatus` object, but you'll learn how the app was refactored.

## Fetch the refactored code

The refactored code is in a separate branch named `signalr`.

# [Linux](#tab/linux)

Use the `git remote` command to determine the name of the `https://github.com/dotnet-presentations/blazor-workshop` repo:

```bash
git remote -v
```

The remote name that corresponds to the <https://github.com/dotnet-presentations/blazor-workshop> repo is the name you'll need to use. Next, use the `git fetch` command to fetch the `signalr` branch (assuming your remote is named `upstream`):

```bash
git fetch upstream signalr
```

Finally, use the `git checkout` command to context switch into the refactored source:

```bash
git checkout signalr
```

# [Windows](#tab/windows)

Use the `git remote` command to determine the name of the `https://github.com/dotnet-presentations/blazor-workshop` repo:

```PowerShell
git remote -v
```

The remote name that corresponds to the <https://github.com/dotnet-presentations/blazor-workshop> repo is the name you'll need to use. Next, use the `git fetch` command to fetch the `signalr` branch (assuming your remote is named `upstream`):

```PowerShell
git fetch upstream signalr
```

Finally, use the `git checkout` command to context switch into the refactored source:

```PowerShell
git checkout signalr
```

---
