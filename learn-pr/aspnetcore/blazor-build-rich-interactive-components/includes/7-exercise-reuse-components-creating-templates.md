A template could help improve how a customer's past orders are displayed on the Blazing Pizza app.

The pizza company has asked that the **My Orders** page shows more details to a customer about their past orders. They'd like this area to be enhanced so that a customer can see all the pizzas in the order, and what time they made their order.

In this exercise, you'll use Blazor templates to create a pagination component and improve the order history page.

## Create the pagination template component

1. In Visual Studio Code, in the file explorer, create a new folder named **Components**, then create a **New File**.
1. Use **PaginationComponent.razor** for the filename.
1. Add the following Razor markup code to the newly created template component:

    ```razor
    @typeparam TItem
    
    <div class="container-sm py-4">
        @ItemContent(Items.ElementAt(selectedIndex))
    </div>
    <nav aria-label="Pagination functionality">
        <ul class="pagination pagination-lg justify-content-center">
            <li class="page-item @(previousDisabled ? "disabled" : "")" disabled="@previousDisabled">
                <a class="page-link" @onclick="@(() => SetIndex(0))">
                    <span>⏪</span>
                </a>
            </li>
            <li class="page-item @(previousDisabled ? "disabled" : "")" disabled="@previousDisabled">
                <a class="page-link" @onclick="DecrementIndex"><span>⬅️</span></a>
            </li>
            @foreach ((int index, TItem item) in Items.Select((item, index) => (index, item)))
            {
                var isActive = index == selectedIndex;
                <li class="page-item @(isActive ? "active" :"")">
                    <a class="page-link" @onclick="@(() => SetIndex(index))">
                        @ItemLabel(item)
                    </a>
                </li>
            }
            <li class="page-item @(nextDisabled ? "disabled" : "")" disabled="@nextDisabled">
                <a class="page-link" @onclick="IncrementIndex"><span>➡️</span></a>
            </li>
            <li class="page-item @(nextDisabled ? "disabled" : "")" disabled="@nextDisabled">
                <a class="page-link" @onclick="@(() => SetIndex(Items.Count - 1))">
                    <span>⏩</span>
                </a>
            </li>
        </ul>
    </nav>
    ```

    The markup accepts a generic type parameter `TItem`, and defines a container to display the selected item. It then uses a `<nav>` element to display the pagination controls. The controls are defined using a `<ul>` element, with each item in the list being a page number. The page number is defined by the `ItemLabel` render fragment, which is passed in as a parameter. The `ItemLabel` render fragment is defined in the component that uses the template.

1. Add the `@code` directive to handle which item is active:

    ```razor
    @code {
        [Parameter, EditorRequired]
        public required List<TItem> Items { get; set; }
    
        [Parameter, EditorRequired]
        public required RenderFragment<TItem> ItemContent { get; set; }
    
        [Parameter, EditorRequired]
        public required Func<TItem, MarkupString> ItemLabel { get; set; }
    
        int selectedIndex;
    
        bool previousDisabled => selectedIndex == 0;
        bool nextDisabled => selectedIndex == Items.Count - 1;
    
        void IncrementIndex() => selectedIndex++;
        void DecrementIndex() => selectedIndex--;
        void SetIndex(int index) => selectedIndex = index;
    
        protected override void OnInitialized() =>
            selectedIndex = Items.Count - 1;
    }
    ```

    The code block defines the parameters that are required to use the template. The `Items` parameter is a list of `TItem` items to display. The `ItemContent` parameter is a render fragment that defines how to display the content of a selected item. The `ItemLabel` parameter is a function that defines how to display the label for each item. The `selectedIndex` field is used to track which item is currently selected. The `IncrementIndex`, `DecrementIndex`, and `SetIndex` methods are used to change the selected item index. The `OnInitialized` method is used to set the initial selected item to the last item in the list.

## Update the `MyOrder` component

1. In the file explorer, expand **Pages**, then select *MyOrders.razor*.
1. Under the last `@inject` directive, add the `@using` directive:

    ```razor
    @using BlazingPizza.Components
    ```

    This enables the newly created component template to be visible to the `MyOrder` component.

1. Within the `<div class="main">` markup, there's an `if / else if / else` logical block, replace the existing `else` branch with the following code:

    ```razor
    else
    {
        <PaginationComponent TItem="OrderWithStatus"
            Items="ordersWithStatus.OrderBy(o => o.Order.CreatedTime).ToList()"
            ItemLabel='item => new($"{item.Order.CreatedTime:ddd, MMM. d, yyyy}")'>
            <ItemContent>
                <div class="list-group-item bg-secondary text-white">
                    <div class="col">
                        <h5>@($"{context.Order.CreatedTime:dddd, MMMM d, yyyy hh:mm tt}")</h5>
                        Items:
                        <strong>@context.Order.Pizzas.Count</strong>
                    </div>
                    <div class="col">
                        Status: <strong>@context.StatusText</strong>
                    </div>
                    @if (@context.StatusText != "Delivered")
                    {
                        <div class="col flex-grow-0">
                            <a href="myorders/@context.Order.OrderId" class="btn btn-success">
                                Track &gt;
                            </a>
                        </div>
                    }
                </div>
                <div class="list-group-item">
                    <div class="col">
                        <OrderReview Order="@context.Order" />
                    </div>
                </div>
            </ItemContent>
        </PaginationComponent>
    }
    ```

    The code now relies on the `PaginationComponent`, providing the generic type of `OrderWithStatus`, a list of past orders sorted by their creation date, and a function to generate the label for each item. The `ItemContent` render fragment is used to define the markup for each item.

## Test your updates

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/7-new-order-history-page.png" lightbox="../media/7-new-order-history-page.png" alt-text="Screenshot of the new order history page.":::

    Run your updated app and select **My Orders**. You'll see a list of any past orders you've made. Select the date from the pagination controls to load the order details.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.
