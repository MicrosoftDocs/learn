Blazor route parameters let components access data passed in the URL. Route parameters allow our app to access specific orders by their `OrderId`.

Customers want to be able to see more information about specific orders. So you decide to update the checkout page to take customers directly to their placed orders. Then, you want to update the orders page to allow them to track any currently open order.

In this exercise, you add a new order detail page that makes use of route parameters. Then you see how you can add a constraint to the parameter to check the correct data type.

## Create an order detail page

1. In Visual Studio Code, on the menu, select **File** > **New Text File**.
1. Select ASP.NET Razor as the language.
1. Create an order detail page component with this code:

    ```razor
    @page "/myorders/{orderId}"
    @inject NavigationManager NavigationManager
    @inject HttpClient HttpClient
    
    <div class="top-bar">
        <a class="logo" href="">
            <img src="img/logo.svg" />
        </a>
    
        <NavLink href="" class="nav-tab" Match="NavLinkMatch.All">
            <img src="img/pizza-slice.svg" />
            <div>Get Pizza</div>
        </NavLink>
    
        <NavLink href="myorders" class="nav-tab">
            <img src="img/bike.svg" />
            <div>My Orders</div>
        </NavLink>
    
    </div>
    
    <div class="main">
        @if (invalidOrder)
        {
            <h2>Order not found</h2>
            <p>We're sorry but this order no longer exists.</p>
        }
        else if (orderWithStatus == null)
        {
            <div class="track-order">
                <div class="track-order-title">
                    <h2>
                      <text>Loading...</text>
                    </h2>
                    <p class="ml-auto mb-0">
                        ...
                    </p>
                </div>
            </div>
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
                      @foreach (var pizza in orderWithStatus.Order.Pizzas)
                      {
                          <p>
                              <strong>
                                  @(pizza.Size)"
                                  @pizza.Special.Name
                                  (£@pizza.GetFormattedTotalPrice())
                              </strong>
                          </p>
                      }
                    </div>
                </div>
            </div>
        }
    </div>
    
    @code {
        [Parameter] public int OrderId { get; set; }
    
        OrderWithStatus orderWithStatus;
        bool invalidOrder = false;
    
        protected override async Task OnParametersSetAsync()
        {
          try
          {
              orderWithStatus = await HttpClient.GetFromJsonAsync<OrderWithStatus>(
                  $"{NavigationManager.BaseUri}orders/{OrderId}");
          }
          catch (Exception ex)
          {
              invalidOrder = true;
              Console.Error.WriteLine(ex);
          }
        }
    }
    
    ```

    This page looks similar to the **MyOrders** component. We're making a call to the **OrderController**, but this time we're asking for a specific order. We want the one that matches `OrderId`. Let's add the code that processes this request.

1. Save your changes by selecting <kbd>Ctrl</kbd>+<kbd>S</kbd>.
1. For the filename, use **OrderDetail.razor**. Make sure you save the file in the **Pages** directory.
1. In the file explorer, select **OrderController.cs**.
1. Under the `PlaceOrder` method, add a new method to return orders with a status.

    ```razor
    [HttpGet("{orderId}")]
    public async Task<ActionResult<OrderWithStatus>> GetOrderWithStatus(int orderId)
    {
        var order = await _db.Orders
            .Where(o => o.OrderId == orderId)
            .Include(o => o.Pizzas).ThenInclude(p => p.Special)
            .Include(o => o.Pizzas).ThenInclude(p => p.Toppings).ThenInclude(t => t.Topping)
            .SingleOrDefaultAsync();
    
        if (order == null)
        {
            return NotFound();
        }
    
        return OrderWithStatus.FromOrder(order);
    }
    ```

    This code enabled the **Order** controller to respond to an HTTP request with **orderId** in the URL. The method then uses this ID to query the database and, if an order is found, return an `OrderWithStatus` object.

    Let's use this new page when a customer checks out. You need to update the **Checkout.razor** component.

1. In the file explorer, expand **Pages**. Then select **Checkout.razor**.
1. Change the call to the following to use the order ID of the placed order.

    ```razor
    NavigationManager.NavigateTo($"myorders/{newOrderId}");
    ```

    The existing code was already capturing `newOrderId` as the response from placing the order. You can use it now to go directly to that order.

## Restrict the route parameter to the correct data type

The app should only respond to requests with numeric order IDs, such as `(http://localhost:5000/myorders/6)`. There's nothing stopping someone from trying to use non-numeric orders. Let's change that.

1. In the file explorer, expand **Pages**. Then select **OrderDetail.razor**.
1. Change the route parameter so that the component only accepts integers.

    ```razor
    @page "/myorders/{orderId:int}"
    ```

1. Now if someone tries to go to`(http://localhost:5000/myorders/non-number)`, Blazor routing doesn't find a match for the URL, and returns the page not found.

    :::image type="content" source="../media/page-not-found.png" alt-text="Screenshot of the page not found screen.":::

1. In Visual Studio Code, select <kbd>F5</kbd>. Or on the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/detail-order-page.png" alt-text="Screenshot showing the detail order page for a single order.":::

    Go through the app, order, and check out. You're taken to the detailed order screen and you see the status of the order.

1. Try different order IDs. If you use an integer that isn't a valid order, you get an **Order not found** message.

    :::image type="content" source="../media/order-not-found.png" alt-text="Screenshot showing Order not found message.":::

    If you use noninteger order IDs, you see the page not found. More important, the app doesn't have an unhandled exception.

1. To stop the app, select <kbd>Shift</kbd> + <kbd>F5</kbd>.

## Update the orders page

At the moment, the **My Orders** page has links to view more detail, but the URL is wrong.

1. In the file explorer, expand **Pages**. Then select **MyOrders.razor**.
1. Replace the `<a href="myorders/" class="btn btn-success">` element with this code:

    ```razor
    <a href="myorders/@item.Order.OrderId" class="btn btn-success">
    ```

You can test how this code works by making your last pizza order for this exercise. Then select **My Orders**, and follow the **Track >** link.
