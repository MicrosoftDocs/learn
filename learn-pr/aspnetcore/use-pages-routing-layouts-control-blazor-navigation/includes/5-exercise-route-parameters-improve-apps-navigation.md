Blazor route parameters let components access data passed in the URL. Route parameters will let our app access specific orders by their `OrderId`.

Customers want to be able to see more information about specific orders. You'll update the checkout page to take customers directly to their placed orders. Then you'll update the orders page to allow them to track any currently open order.

In this exercise you'll add a new order detail page that makes use of route parameters. You'll see how you can add a constraint to the parameter to check the correct data type.

## Create an order detail page

1. In Visual Studio Code, in the menu, select **File**, then select **New File**.
1. Select C# as the language.
1. Create an order detail page component with this code.

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

    This page will look similar to the **MyOrders** component. We are making a call to the **OrderController** but this time we are asking for a specific order. The one that matches `OrderId`. Let's add the code to process this request. 

1. Save your changes with <kbd>CTRL</kbd>+<kbd>S</kbd>.
1. For the filename use **OrderDetail.razor**. Make sure you save the file in the **Pages** directory.
1. In the explorer, select **OrderController.cs**.
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

    This code enabled the **Order** controller to respond to an HTTP request with an **orderId** in the URL. The method then uses this ID to query the database and, if an order is found, return an `OrderWithStatus` object.

    Let's use this new page when a customer checks out. You need to update the **Checkout.razor** component.

1. In the explorer, expand **Pages**, then select **Checkout.razor**.
1. Change the call to `NavigationManager.NavigateTo("/myorders")` to use the **orderId** of the placed order.

    ```razor
    NavigationManager.NavigateTo($"myorders/{newOrderId}");
    ```

    The existing code was already capturing the `newOrderId` as the response from placing the order. You can use it now to navigate directly to that order.

1. In Visual Studio Code press <kbd>F5</kbd>, or in the **Run** menu select **Start Debugging**.

    :::image type="content" source="../media/detail-order-page.png" alt-text="Screenshot showing the detail order page for a single order.":::

    Go through the app, order, and checkout. You'll be taken to the detailed order screen and see the status of the order.

## Restrict the route parameter to the correct data type

At the moment the app will respond to requests at [http://localhost:5000/myorders/6](http://localhost:5000/myorders/6). You can test this directly by changing the 6 to another number. There's nothing stopping someone trying to use non-numeric orders.

1. As the app is still running try to navigate to [http://localhost:5000/myorders/a](http://localhost:5000/myorders/a)

    :::image type="content" source="../media/unhandled-exception.png" alt-text="Screenshot showing that the app has crashed with an unhandled exception.":::

    The error happens because, when the **OrderDetail** component executes, it tries to pass a route parameter to the component parameter **OrderId** that's declared as an integer. 

    This kind of exception can give away potential information about your app to hackers. Let's fix that.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.
1. In the explorer, expand **Pages**, then select **OrderDetail.razor**.
1. Change the route parameter so that the component will only accept integers.

    ```razor
    @page "/myorders/{orderId:int}"
    ```
	
1. Now if someone tries to navigate to [http://localhost:5000/myorders/non-number](http://localhost:5000/myorders/non-number), Blazor routing won't find a match for the URL and return the page not found. 

    :::image type="content" source="../media/page-not-found.png" alt-text="Screenshot of the page not found screen.":::

1. In Visual Studio Code press <kbd>F5</kbd>, or in the **Run** menu select **Start Debugging**.

    Try different order IDs. If you use an integer that isn't a valid order you'll get a nice **not found** message.

    :::image type="content" source="../media/order-not-found.png" alt-text="Screenshot showing order not found message.":::

    If you use non-integer order IDs, you'll see the page not found - and more importantly the app won't have an unhandled exception.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Update the orders page

At the moment, the **My Orders** page has links to view more detail, but the URL is wrong.

1. In the explorer, expand **Pages**, then select **MyOrders.razor**.
1. Replace the `<a>` element with this:

    ```razor
    <a href="myorders/@item.Order.OrderId" class="btn btn-success">
    ```

You can test this works by making your last pizza order for this exercise. Then select **My Orders**, and follow the **Track >** link. 
