Blazor has a navigation state helper that helps C# code manage a URI in your app. There's also a **NavLink** component that's a drop-in replacement for the `<a>` element. One of NavLink's features is adding an active class to HTML links for an app's menus.

Your team made a start on the Blazing Pizza app and built Blazor components to represent pizzas and orders. Now the app needs to add checkout and other order-related pages.

In this exercise, you add a new checkout page, add a top navigation to the app, and then use a Blazor **NavLink** component to improve your code.

## Clone your team's existing app

> [!NOTE]
> This module uses the .NET command-line interface (CLI) and Visual Studio Code for local development. After you finish this module, you can apply the concepts by using Visual Studio (Windows) or Visual Studio for Mac (macOS). For continued development, use Visual Studio Code for Windows, Linux, and macOS.

[!include[](../../../includes/dotnet9-sdk-version.md)]

If you're creating your first Blazor app, follow the [setup instructions for Blazor](https://aka.ms/blazor-getting-started) to install the correct version of .NET and check that your machine is set up correctly. Stop at the **Create your app** step.

1. Open Visual Studio Code.
1. Open the integrated terminal from Visual Studio Code by selecting **View**. Then on the main menu, select **Terminal**.
1. In the terminal, go to where you want the project to be created.
1. Clone the app from GitHub.

    ```powershell
    git clone https://github.com/MicrosoftDocs/mslearn-blazor-navigation.git BlazingPizza
    ```

1. Select **File**, and then select **Open folder**.
1. In the **Open** dialog, go to the **BlazingPizza** folder, and choose **Select Folder**.

    Visual Studio Code might prompt you about unresolved dependencies. Select **Restore**.

1. Run the app to check everything is working correctly.
1. In Visual Studio Code, select <kbd>F5</kbd>. Or on the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/blazing-pizza-setup.png" alt-text="Screenshot showing the cloned version of the Blazing Pizza app.":::

    Configure some pizzas and add them to your order. Select **Order >** at the bottom of the page. The default message "Sorry, there's nothing at this address." appears because there isn't a checkout page yet.

1. To stop the app, select <kbd>Shift</kbd> + <kbd>F5</kbd>.

## Add a checkout page

1. In Visual Studio Code, in the file explorer, select **App.razor**.

    ```razor
    <Router AppAssembly="@typeof(Program).Assembly" PreferExactMatches="@true">
        <Found Context="routeData">
            <RouteView RouteData="@routeData" />
        </Found>
        <NotFound>
            <LayoutView>
                <p>Sorry, there's nothing at this address.</p>
            </LayoutView>
        </NotFound>
    </Router>
    ```

    The `<NotFound>` code block is what customers see if they try to go to a page that doesn't exist.

1. In the file explorer, expand **Pages**, right-click the folder, and select **New File**.
1. Name the new file **Checkout.razor**. In this file, write the following code:

    ```razor
    @page "/checkout"
    @inject OrderState OrderState
    @inject HttpClient HttpClient
    @inject NavigationManager NavigationManager
    
    <div class="top-bar">
        <a class="logo" href="">
            <img src="img/logo.svg" />
        </a>
    
        <a href="" class="nav-tab">
            <img src="img/pizza-slice.svg" />
            <div>Get Pizza</div>
        </a>
    
    </div>
    
    <div class="main">
        <div class="checkout-cols">
            <div class="checkout-order-details">
                <h4>Review order</h4>
                @foreach (var pizza in Order.Pizzas)
                {
                    <p>
                        <strong>
                            @(pizza.Size)"
                            @pizza.Special.Name
                            (£@pizza.GetFormattedTotalPrice())
                        </strong>
                    </p>
                }
    
                <p>
                    <strong>
                        Total price:
                        £@Order.GetFormattedTotalPrice()
                    </strong>
                </p>
            </div>
        </div>
    
        <button class="checkout-button btn btn-warning">
            Place order
        </button>
    </div>

    @code {
        Order Order => OrderState.Order;
    }
    ```

    This page builds on the current app and makes use of the app state saved in `OrderState`. The first `div` is the app's new header navigation. Let's add it to the index page.

1. In the file explorer, expand **Pages**, and then select **index.razor**.
1. Above the `<div class="main">` class, add the `top-bar` html.

    ```html
    <div class="top-bar">
        <a class="logo" href="">
            <img src="img/logo.svg" />
        </a>
    
        <a href="" class="nav-tab" >
            <img src="img/pizza-slice.svg" />
            <div>Get Pizza</div>
        </a>    
    </div>
    ```

    When we're on this page, it would be nice to show the customers by highlighting the link. The team already created an `active` css class, so add `active` to the `class` attribute that already contains the `nav-tab` style.

    ```html
    <div class="top-bar">
        <a class="logo" href="">
            <img src="img/logo.svg" />
        </a>
    
        <a href="" class="nav-tab active" >
            <img src="img/pizza-slice.svg" />
            <div>Get Pizza</div>
        </a>   
    </div>
    ```

1. In Visual Studio Code, select <kbd>F5</kbd>. Or on the **Run** menu, select **Start Debugging**.

    The app now has a nice menu bar at the top, which includes the company's logo. Add some pizzas and select the **Order** button to progress to the checkout page. You see the pizzas listed and the active indicator missing from the menu.

    :::image type="content" source="../media/blazing-checkout-page.png" alt-text="Screenshot showing the checkout page with some pizzas.":::

1. To stop the app, select <kbd>Shift</kbd> + <kbd>F5</kbd>.

## Allow customers to place an order

At the moment, the checkout page doesn't allow customers to place their orders. The logic of the app needs to store the order to send to the kitchen. After the order is sent, let's redirect customers back to the home page.

1. In the file explorer, expand **Pages**, and select **Checkout.razor**.
1. Modify the button element with a call to the `PlaceOrder` method. Add the `@onclick` and `disabled` attributes as shown:

    ```razor
    <button class="checkout-button btn btn-warning" @onclick="PlaceOrder" disabled=@isSubmitting>
      Place order
    </button>
    ```

    We don't want customers placing duplicate orders, so we disable the **Place order** button until the order is processed.

1. In the `@code` block, add this code under the `Order Order => OrderState.Order;` code.

    ```razor
    bool isSubmitting;

    async Task PlaceOrder()
    {
        isSubmitting = true;
        var response = await HttpClient.PostAsJsonAsync(NavigationManager.BaseUri + "orders", OrderState.Order);
        var newOrderId= await response.Content.ReadFromJsonAsync<int>();
        OrderState.ResetOrder();
        NavigationManager.NavigateTo("/");
    }
    ```

    The preceding code disables the **Place order** button, posts JSON and adds it to **pizza.db**, clears the order, and uses `NavigationManager` to redirect customers to the home page.

    You need to add code to handle the order. Add an **OrderController** class for this task. If you look at **PizzaStoreContext.cs**, you only see entity framework database support for `PizzaSpecials`. Let's fix that first.

## Add entity framework support for orders and pizzas

1. In the file explorer, select **PizzaStoreContext.cs**.
1. Replace the `PizzaStoreContext` class with this code:

    ```csharp
    public class PizzaStoreContext : DbContext
    {
        public PizzaStoreContext(
            DbContextOptions options) : base(options)
        {
        }
    
        public DbSet<Order> Orders { get; set; }
    
        public DbSet<Pizza> Pizzas { get; set; }
    
        public DbSet<PizzaSpecial> Specials { get; set; }
    
        public DbSet<Topping> Toppings { get; set; }
    
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
    
            // Configuring a many-to-many special -> topping relationship that is friendly for serialization
            modelBuilder.Entity<PizzaTopping>().HasKey(pst => new { pst.PizzaId, pst.ToppingId });
            modelBuilder.Entity<PizzaTopping>().HasOne<Pizza>().WithMany(ps => ps.Toppings);
            modelBuilder.Entity<PizzaTopping>().HasOne(pst => pst.Topping).WithMany();
        }
    }
    ```

    This code adds entity framework support for the app's order and pizza classes.

1. In Visual Studio Code, on the menu, select **File** > **New File**.
1. Enter **OrderController.cs** as the filename. Make sure you save the file in the same directory as **OrderState.cs**.
1. Add the following code:

    ```csharp
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    
    namespace BlazingPizza;
    
    [Route("orders")]
    [ApiController]
    public class OrdersController : Controller
    {
        private readonly PizzaStoreContext _db;

        public OrdersController(PizzaStoreContext db)
        {
            _db = db;
        }

        [HttpGet]
        public async Task<ActionResult<List<OrderWithStatus>>> GetOrders()
        {
            var orders = await _db.Orders
            .Include(o => o.Pizzas).ThenInclude(p => p.Special)
            .Include(o => o.Pizzas).ThenInclude(p => p.Toppings).ThenInclude(t => t.Topping)
            .OrderByDescending(o => o.CreatedTime)
            .ToListAsync();

            return orders.Select(o => OrderWithStatus.FromOrder(o)).ToList();
        }

        [HttpPost]
        public async Task<ActionResult<int>> PlaceOrder(Order order)
        {
            order.CreatedTime = DateTime.Now;

            // Enforce existence of Pizza.SpecialId and Topping.ToppingId
            // in the database - prevent the submitter from making up
            // new specials and toppings
            foreach (var pizza in order.Pizzas)
            {
                pizza.SpecialId = pizza.Special.Id;
                pizza.Special = null;
            }

            _db.Orders.Attach(order);
            await _db.SaveChangesAsync();

            return order.OrderId;
        }
    }
    ```

    The preceding code allows our app to get all the current orders and place an order. The `[Route("orders")]` Blazor attribute allows this class to handle incoming HTTP requests for **/orders** and **/orders/{orderId}**.

1. Save your changes with <kbd>Ctrl</kbd>+<kbd>S</kbd>.

1. In the file explorer, select **OrderState.cs**.
1. At the bottom of the class under the `RemoveConfiguredPizza` method, modify `ResetOrder()` to reset the order:

    ```csharp
    public void ResetOrder()
    {
        Order = new Order();
    }
    ```

## Test the checkout functionality

1. In Visual Studio Code, select <kbd>F5</kbd>. Or on the **Run** menu, select **Start Debugging**.

    The app should compile, but if you create an order and try to check out, you see a runtime error. The error occurs because our **pizza.db** SQLLite database was created before there was support for orders and pizzas. We need to delete the file so that a new database can be created correctly.

1. To stop the app, select <kbd>Shift</kbd> + <kbd>F5</kbd>.

1. In the file explorer, delete the **pizza.db** file.

1. Select <kbd>F5</kbd>. Or on the **Run** menu, select **Start Debugging**.

    As a test, add pizzas, go to the checkout, and place an order. You're redirected to the home page, and you can see that the order is now empty.

1. To stop the app, select <kbd>Shift</kbd> + <kbd>F5</kbd>.

The app is improving. We have pizza configuration and a checkout. We want to allow customers to see the status of their pizza order after they place it.

## Add an orders page

1. In the file explorer, expand **Pages**, right-click the folder, and select **New File**.
1. Name the new file **MyOrders.razor**. In this file, write the following code:

    ```razor
    @page "/myorders"
    @inject HttpClient HttpClient
    @inject NavigationManager NavigationManager
    
    <div class="top-bar">
        <a class="logo" href="">
            <img src="img/logo.svg" />
        </a>
    
        <a href="" class="nav-tab">
            <img src="img/pizza-slice.svg" />
            <div>Get Pizza</div>
        </a>
    
        <a href="myorders" class="nav-tab active">
            <img src="img/bike.svg" />
            <div>My Orders</div>
        </a>
    </div>
    
    <div class="main">
        @if (ordersWithStatus == null)
        {
            <text>Loading...</text>
        }
        else if (!ordersWithStatus.Any())
        {
            <h2>No orders placed</h2>
            <a class="btn btn-success" href="">Order some pizza</a>
        }
        else
        {
            <div class="list-group orders-list">
                @foreach (var item in ordersWithStatus)
                {
                    <div class="list-group-item">
                        <div class="col">
                            <h5>@item.Order.CreatedTime.ToLongDateString()</h5>
                            Items:
                            <strong>@item.Order.Pizzas.Count()</strong>;
                            Total price:
                            <strong>£@item.Order.GetFormattedTotalPrice()</strong>
                        </div>
                        <div class="col">
                            Status: <strong>@item.StatusText</strong>
                        </div>
                        @if (@item.StatusText != "Delivered")
                        {
                            <div class="col flex-grow-0">
                                <a href="myorders/" class="btn btn-success">
                                    Track &gt;
                                </a>
                            </div>
                        }
                    </div>
                }
            </div>
        }
    </div>
    
    @code {
        List<OrderWithStatus> ordersWithStatus = new List<OrderWithStatus>();
    
        protected override async Task OnParametersSetAsync()
        {
          ordersWithStatus = await HttpClient.GetFromJsonAsync<List<OrderWithStatus>>(
              $"{NavigationManager.BaseUri}orders");
        }
    }
    ```

    The navigation needs to change on all the pages we have now to include a link to the new **My orders** page. Open **Checkout.razor** and **Index.razor** and replace the navigation with this code:

    ```html
    <div class="top-bar">
        <a class="logo" href="">
            <img src="img/logo.svg" />
        </a>
    
        <a href="" class="nav-tab active" >
            <img src="img/pizza-slice.svg" />
            <div>Get Pizza</div>
        </a>
    
        <a href="myorders" class="nav-tab" >
            <img src="img/bike.svg" />
            <div>My orders</div>
        </a>    
    </div>
    ```

    By using `<a>` elements, we can manage which is the active page manually by adding the `active` css class. Let's update all the navigation to use a **NavLink** component instead.

1. On all three of the pages with navigation (**Index.razor**, **Checkout.razor**, and **MyOrders.razor**), use the same Blazor code for navigation:

    ```razor
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
    ```

    The `active` css class is now added automatically to pages by the **NavLink** component. You don't have to remember to do it on each page the navigation is on.

1. The last step is to change `NavigationManager` to redirect to the `myorders` page after an order is placed. In the file explorer, expand **Pages**, and then select **Checkout.razor**.
1. Change the `PlaceOrder` method to redirect to the correct page by passing `/myorders` to `NavigationManager.NavigateTo()`:

    ```razor
    async Task PlaceOrder()
    {
        isSubmitting = true;
        var response = await HttpClient.PostAsJsonAsync($"{NavigationManager.BaseUri}orders", OrderState.Order);
        var newOrderId = await response.Content.ReadFromJsonAsync<int>();
        OrderState.ResetOrder();
        NavigationManager.NavigateTo("/myorders");
    } 
    ```

1. In Visual Studio Code, select <kbd>F5</kbd>. Or on the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/myorder-page-example.png" alt-text="Screenshot showing the order page.":::

    You should be able to order some pizzas and then see the orders currently in the database.

1. Stop the app by selecting <kbd>Shift</kbd> + <kbd>F5</kbd>.
