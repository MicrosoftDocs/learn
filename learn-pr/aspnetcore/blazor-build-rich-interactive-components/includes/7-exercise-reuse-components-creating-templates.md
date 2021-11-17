A template could help improve how a customer's past orders are displayed on the Blazing Pizza app.

The pizza company has asked that the My Orders page show more details to a customer about their past orders. They'd like this area to be enhanced so that a customer can see all the pizzas in an order, and what time they made their order.

In this exercise, you'll use Blazor templates to create a tab page and improve the order history page.

## Create a container for tabs

1. In Visual Studio Code, in the file explorer, right-click **Shared**, then select **New File**.
1. Use **TabContainer.razor** for the filename.
1. Add code for the new template.

    ```razor
    <CascadingValue Value="this">
      <div class="row align-items-start">
        <ul class="nav nav-pills flex-column">
            @foreach (TabPage tabPage in Items)
            {
              <li class="nav-item pb-1"><a class="nav-link @GetActiveTab(tabPage)" @onclick=@(() => ActivateItem(tabPage) )>@tabPage.Title</a></li>
            }
        </ul>
            
        <div class="flex-fill px-4">
          @ChildContent
        </div>
      </div>
    </CascadingValue>
    ```

    The code creates a cascading value that the tab pages will use. The tab page can then add itself to this container using the cascading parameter. There's a `<ul>` list that will act as the tab's navigation and control which tab page is displayed. The `@ChildContent` is a render fragment that comes from the component that uses this container.

1. Add the `@code` block to handle which tab page is active and connect the tab pages.

    ```razor
    @code {
        [Parameter]
        public RenderFragment ChildContent { get; set; }
        
        public TabPage CurrentItem { get; set; }
        private List<TabPage> Items = new List<TabPage>();
    
        internal void AddItem(TabPage tabPage)
        {
            Items.Add(tabPage);
            if (Items.Count == 1)
            {
                CurrentItem = tabPage;
            }
            StateHasChanged();
        }
    
        string GetActiveTab(TabPage tabPage) => tabPage == CurrentItem ? "active bg-danger" : "bg-light";
    
        void ActivateItem(TabPage tabPage) => CurrentItem = tabPage;
    }
    ```

## Create a tab page

1. In the file explorer, right-click **Shared**, then select **New File**.
1. Use **TabPage.razor** for the filename.
1. Add code for the tab page.

    ```razor
    @if (Container.CurrentItem == this)
    {
      @ChildContent
    }
    
    @code {
        [CascadingParameter]
        private TabContainer Container { get; set; }
    
        [Parameter]
        public RenderFragment ChildContent { get; set; }
    
        [Parameter]
        public string Title { get; set; }
      
        protected override void OnInitialized()
        {
            if (Container is null)
            {
                throw new ArgumentNullException(nameof(Container), "Cannot create a tab page without a tab container");
            }
            base.OnInitialized();
            Container.AddItem(this);
        }
    }
    ```

## Update the My Order component

1. In the file explorer, expand **Pages**, then select **MyOrders.razor**.
1. Replace this else clause:

    ```razor
    else
    {
      <div class="list-group orders-list">
        @foreach (var item in ordersWithStatus)
        {
          <div class="list-group-item">
            <div class="col">
                <h5>@item.Order.CreatedTime.ToLongDateString()</h5>
                Items: <strong>@item.Order.Pizzas.Count()</strong>
                Total price: <strong>£@item.Order.GetFormattedTotalPrice()</strong>
            </div>
            <div class="col">
              Status: <strong>@item.StatusText</strong>
            </div>
            @if (@item.StatusText != "Delivered")
            {
              <div class="col flex-grow-0">
                <a href="myorders/@item.Order.OrderId" class="btn btn-success">
                  Track &gt;
                </a>
              </div>
            }
          </div>
        }
      </div>
    }
    ```

    With this code:

    ```razor
    else
    {
      <TabContainer>
        <div class="track-order">
          @foreach (var item in ordersWithStatus)
          {
            <TabPage Title=@item.Order.CreatedTime.ToLongDateString()>
              <div class="track-order-title">
                <h2>Order placed: @item.Order.CreatedTime.ToShortTimeString()</h2>
                <p class="ml-auto mb-0">
                  Items: <strong>@item.Order.Pizzas.Count()</strong> 
                  Total price: <strong>£@item.Order.GetFormattedTotalPrice()</strong>
                  @if (@item.StatusText != "Delivered")
                  {
                  <a href="myorders/@item.Order.OrderId" class="btn btn-success ml-4">
                    Track &gt;
                  </a>
                  }
                </p>
              </div>
              <div class="track-order-body">
                <div class="track-order-details">
                  @foreach (var pizza in item.Order.Pizzas) 
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
            </TabPage>
          }
        </div>
      </TabContainer>
    }
    ```

    The code is similar. Note where the `<TabContainer>` and `<TabPage>` components are added to the markup. The only large change is the new `track-order-details` for each pizza in the order.

## Test your updates

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/7-new-order-history-page.png" alt-text="Screenshot of the new order history page.":::

    Run your updated app and select **My Orders**. You'll see a list of any past orders you've made. Select the date on the left to load the order details tab component.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

