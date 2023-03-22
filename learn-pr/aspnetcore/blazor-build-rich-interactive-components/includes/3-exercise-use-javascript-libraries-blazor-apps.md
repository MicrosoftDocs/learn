When a customer adds a pizza to their order, they can select a **X** to remove it without confirmation. The company thinks customers might have been accidentally clicking this and removing items from their order. You'll add a feature that prompts the user to make sure they do want to remove the pizza. The pizza company wants to be able to show customers the live status of their orders. You'll update the order detail page to query the order status in real-time.

In this exercise, you'll extend an existing app created for the pizza delivery company. You'll use JS interop to call JavaScript on the client side from a Blazor component. You'll then see how to integrate with a third-party JavaScript library to improve the popup. In the final steps of the exercise, you'll call a Blazor method from JavaScript to get the real-time status of a customer order.

## Clone your team's existing app

> [!TIP]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, and macOS).

If you haven't created a Blazor app before, follow the [setup instructions for Blazor](https://aka.ms/blazor-getting-started) to install the correct version of .NET and check your machine is set up correctly. Stop at the **Create your app** step.

[!include[](../../../includes/dotnet7-sdk-version.md)]

1. Open **Visual Studio Code**.
1. Open the integrated terminal from Visual Studio Code by selecting **View**, then select **Terminal** from the main menu.
1. In the terminal, go to where you'd like the project to be created.
1. Clone the app from GitHub.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-build-interactive-components-blazor.git BlazingPizza
    ```

1. Select **File**, then select **Open folder...**.
1. In the Open dialog, go to the **BlazingPizza** folder, and select **Select Folder**.

    Visual Studio Code might prompt you about unresolved dependencies. Select **Restore**.

1. Run the app to check everything is working correctly.
1. In Visual Studio Code, press <kbd>F5</kbd>, or in the **Run** menu, select **Start Debugging**.

    Try configuring some pizzas and adding them to your order. With a few pizzas in your order, select the **X** and see how that item is removed without any prompt.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.

## Refactor the order process

To use the JavaScript interop, you inject the `IJSRuntime` abstraction.

1. In the file explorer, expand **Pages**, then select **Index.razor**.
1. Under the `@inject OrderState OrderState` statement, add the `IJSRuntime` injection.

    ```razor
    @inject OrderState OrderState
    @inject IJSRuntime JavaScript
    ```

1. Currently, the `onclick` event for the remove pizza functionality calls the `OrderState.RemoveConfiguredPizza(configuredPizza))` method directly. Replace the entire `<a >...</a>` element with the following markup:

   ```razor
   <button type="button" class="close text-danger" aria-label="Close"
        @onclick="@(async () => await RemovePizzaConfirmation(configuredPizza))">
        <span aria-hidden="true">&times;</span>
    </button>
   ```

1. Add a new method to call the native JavaScript `confirm` function. If the customer selects **OK** from this prompt, then call the `RemoveConfiguredPizza`, otherwise leave the pizza in the order.

    ```razor
    async Task RemovePizzaConfirmation(Pizza removePizza)
    {
        if (await JavaScript.InvokeAsync<bool>(
            "confirm",
            $"""Do you want to remove the "{removePizza.Special!.Name}" from your order?"""))
        {
            OrderState.RemoveConfiguredPizza(removePizza);
        }
    }
    ```

    The server uses the <xref:Microsoft.JSInterop.IJSRuntime.InvokeAsync%2A?displayProperty=nameWithType> method to call the `confirm` function on the client side. The response from the call returns a `bool` value. If the result of the confirm dialog is `true` the pizza is removed from the order.

1. In Visual Studio Code, press <kbd>F5</kbd>, or in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/3-confirm-remove-dialog.png" lightbox="../media/3-confirm-remove-dialog.png" alt-text="Screenshot of the default JavaScript confirm dialog.":::

    Try configuring some pizzas and adding them to your order. With a few pizzas in your order, select the **X**. A standard JavaScript confirm dialog lets you select **Cancel** or **OK**.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.

## Add a third-party JavaScript library to a Blazor app

The pizza company feels that their customers could be confused by the word *cancel* in the popup. They'd like the text on the buttons to be clearer. Also, they don't like how their existing branding and styling aren't used.

After some research, you find a small JavaScript library called SweetAlert that looks like a good replacement.

1. In the file explorer, expand **Pages**, then select **_Host.cshtml**.

1. At the bottom of the page, under the Blazor framework, add a `script` element to include the SweetAlert library.

    ```html
            <!-- Omitted for brevity... -->
            <script src="_framework/blazor.server.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert@latest/dist/sweetalert.min.js"></script>
        </body>
    </html>
    ```

    With the `<script>` tag added, the SweetAlert is available to call on the client side.

1. Back in the Update the `RemovePizzaConfirmation` method to use the new library.

    ```csharp
    async Task RemovePizzaConfirmation(Pizza removePizza)
    {
        var messageParams = new
        {
            title = "Remove Pizza?",
            text = $"""Do you want to remove the "{removePizza.Special!.Name}" from your order?""",
            icon = "warning",
            buttons = new
            {
                abort = new { text = "No, leave it in my order", value = false },
                confirm = new { text = "Yes, remove pizza", value = true }
            },
            dangerMode = true
        };

        if (await JavaScript.InvokeAsync<bool>("swal", messageParams))
        {
            OrderState.RemoveConfiguredPizza(removePizza);
        }
    }
    ```
    
    The `"swal"` name is the indentifier used for the JavaScript function that comes from the third party _sweetalert.js_ reference. The code to call the `swal` function looks similar to `confirm`. The bulk of the update is in how the function receives parameters.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/3-sweetalert-remove-dialog.png" lightbox="../media/3-sweetalert-remove-dialog.png" alt-text="Screenshot showing the SweetAlert dialog box.":::

    SweetAlert can accept a JSON object that includes all the settings it needs. The `confirm` dialog will now have two buttons that say **No, leave it in my order** and **Yes, remove pizza**.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.

## Update the order page to show real-time order status

The `OrderDetail` component shows the current status of a pizza order. Customers would like to see how their order is progressing in real-time. You'll update the component to call a .NET method from JavaScript to continuously get the order status until it's delivered.

1. In the file explorer, expand *Pages*, then select *OrderDetail.razor*.
1. Add this declaration at the top of the component, under the last `@inject` statement.

    ```razor
    @implements IDisposable
    ```

    The `@implements` declaration lets you define a `Dispose` method.

1. Add a spinner to provide feedback to the customer that the page is updating.
1. Above the `@foreach` statement, add the following markup.

    ```razor
    @if (IsOrderIncomplete)
    {
        <div class="spinner-grow text-danger float-right" role="status">
            <span class="sr-only">Checking your order status...</span>
        </div>
    }
    @foreach (var pizza in orderWithStatus.Order.Pizzas)
    ```

1. Under the `OrderId` property declaration, add the following members.

    ```razor
    bool IsOrderIncomplete =>
        orderWithStatus is null || orderWithStatus.IsDelivered == false;

    PeriodicTimer timer = new(TimeSpan.FromSeconds(3));
    ```

1. Replace the existing `OnParametersSetAsync` method with the following code:

    ```csharp
    protected override async Task OnParametersSetAsync() =>
        await GetLatestOrderStatusUpdatesAsync();
    ```

    This code now calls the `GetLatestOrderStatusUpdatesAsync` method to update the order status.

1. Next, add the following methods after the updated `OnParametersSetAsync` method.

    ```csharp
    protected override Task OnAfterRenderAsync(bool firstRender) =>
        firstRender ? StartPollingTimerAsync() : Task.CompletedTask;

    async Task GetLatestOrderStatusUpdatesAsync()
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

    async Task StartPollingTimerAsync()
    {
        while (IsOrderIncomplete && await timer.WaitForNextTickAsync())
        {
            await GetLatestOrderStatusUpdatesAsync();
            StateHasChanged();
        }
    }

    public void Dispose() => timer.Dispose();
    ```

    The `OrderDetail` component starts polling after the page has been rendered, and stops when the order is delivered.

    The `StartPollingTimerAsync` function uses a <xref:System.Threading.PeriodicTimer> to asynchronously wait for the next tick, while the order status is incomplete.

    When the order has been delivered the animated spinner is removed from the page, and the final order status is shown.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/3-order-status-updated-realtime.gif" lightbox="../media/3-order-status-updated-realtime.gif" alt-text="Animation showing the order status changing in real-time.":::

    Start the app and order a pizza. When the customer gets to the order detail screen the status updates and the spinner is removed when the pizza is delivered.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.
