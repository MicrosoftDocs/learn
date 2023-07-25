After a customer adds a pizza to their order, they can select an **X** icon to remove the pizza from the order without confirmation. To prevent customers from accidentally removing pizzas from their orders, the pizza company wants you to add a confirmation prompt for item removal.

The pizza company also wants customers to see how their order is progressing in real time. You need to update the order detail page to continuously query order status, and give customers feedback that the page is updating.

In this exercise, you extend the pizza delivery company's existing app by using JS interop from a Blazor component to call JavaScript on the client side. You integrate with a third-party JavaScript library to improve the cancellation popup, and call a Blazor method from JavaScript to get the real-time status of a customer order.

## Clone the existing app

To use Blazor, make sure you have the [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet/7.0) installed. For more information, see [Check everything installed correctly](https://dotnet.microsoft.com/learn/aspnet/blazor-cli-tutorial/install).

1. Open Visual Studio Code, and open an integrated terminal by selecting **Terminal** > **New Terminal** from the top menu.

1. In the terminal, change to the directory where you want to create the project.

1. Run the following command to clone the app from GitHub to a local subdirectory.

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-build-interactive-components-blazor.git BlazingPizza
   ```

1. In the top menu bar, select **File** > **Open Folder**.

1. In the **Open Folder** dialog box, browse to the *BlazingPizza* folder and select **Select Folder**.

   If Visual Studio Code prompts you about missing assets or unresolved dependencies, select **Yes** or **Restore**.

1. To run the app and check that everything is working correctly, press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

1. In the web app, select some pizzas and add them to your order. With a few pizzas in your order list, select the **X** next to one of the pizzas and verify that the item disappears without any prompt.

1. Press <kbd>Shift</kbd>+<kbd>F5</kbd> or select **Run** > **Stop Debugging** to stop the app.

## Refactor the order process

To use JS interop, you inject the `IJSRuntime` abstraction.

1. In Visual Studio Code **Explorer**, expand *Pages* and then select *Index.razor*.
1. In the *Index.razor* file, after the `@inject OrderState OrderState` statement, add the `IJSRuntime` injection as follows.

    ```razor
    @inject OrderState OrderState
    @inject IJSRuntime JavaScript
    ```

1. Currently, the `onclick` event for the remove pizza functionality calls the `OrderState.RemoveConfiguredPizza(configuredPizza))` method directly. Replace the entire `<a @onclick="@(() => OrderState.RemoveConfiguredPizza(configuredPizza))" class="delete-item">❌</a>` element with the following code:

   ```razor
   <button type="button" class="close text-danger" aria-label="Close"
        @onclick="@(async () => await RemovePizzaConfirmation(configuredPizza))">
        <span aria-hidden="true">&times;</span>
   </button>
   ```

1. In the `@code` directive at the end of the file, add a new method to call the native JavaScript `confirm` function. If the customer selects **OK** from the prompt, the method calls `OrderState.RemoveConfiguredPizza` to remove the pizza from the order. Otherwise, the pizza remains in the order.

   ```csharp
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

   The server uses the <xref:Microsoft.JSInterop.IJSRuntime.InvokeAsync%2A?displayProperty=nameWithType> method to call the `confirm` function on the client side. The response from the call returns a `bool` value. If the result of the confirm dialog is `true`, the pizza is removed from the order.

1. Press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

1. In the app, add some pizzas to your order.

1. With a few pizzas in your order, select the **X** next to one of the pizzas. A standard JavaScript confirm dialog appears.

   :::image type="content" source="../media/3-confirm-remove-dialog.png" lightbox="../media/3-confirm-remove-dialog.png" alt-text="Screenshot of the default JavaScript confirm dialog.":::

1. Select **OK** and verify that the pizza is removed from your order. Select **X** next to another pizza, select **Cancel** in the confirm dialog, and verify that the pizza remains in your order.

1. Press <kbd>Shift</kbd>+<kbd>F5</kbd> or select **Run** > **Stop Debugging** to stop the app.

## Add a third-party JavaScript library to a Blazor app

The pizza company wants clearer text on the buttons in the confirm dialog, and wants to use their branding and styling in the dialog box. After some research, you decide to use a small JavaScript library called SweetAlert as a good replacement for the standard dialog.

1. In Visual Studio Code **Explorer**, expand *Pages* and then select *_Host.cshtml*.

1. At the end of the *_Host.cshtml* file, after the `<script src="_framework/blazor.server.js"></script>` line but before the `</body>` line, add the following `script` element to include the SweetAlert library.

   ```html
   <script src="https://cdn.jsdelivr.net/npm/sweetalert@latest/dist/sweetalert.min.js"></script>
   ```

   The SweetAlert library is now available to call on the client side.

1. To use the new library, update the `RemovePizzaConfirmation` method in the *Index.razor* file as follows.

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
   
   The `"swal"` name is the identifier for the JavaScript function that comes from the third-party *sweetalert.js* reference. The code to call the `swal` function looks similar to `confirm`. Most of the update is in how the function receives parameters. SweetAlert accepts a JSON object that includes all the settings it needs.

1. In Visual Studio Code, press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

1. Verify that the `confirm` dialog now has two buttons that say **No, leave it in my order** and **Yes, remove pizza**, and that they function as expected.

    :::image type="content" source="../media/3-sweetalert-remove-dialog.png" lightbox="../media/3-sweetalert-remove-dialog.png" alt-text="Screenshot showing the SweetAlert dialog box.":::

1. Press <kbd>Shift</kbd>+<kbd>F5</kbd> or select **Run** > **Stop Debugging** to stop the app.

## Update the order page to show real-time order status

Once a customer places a pizza order, the **My Orders** page uses the `OrderDetail` component to show the current status of the order. The pizza company wants customers to see how their order is progressing in real-time. You update the component to call a .NET method from JavaScript that continuously gets the order status until the status shows delivered.

1. In Visual Studio Code **Explorer**, expand *Pages* and then select *OrderDetail.razor*.
1. In the *OrderDetail.razor* file, add the following declaration at the top of the component, under the last `@inject` statement.

   ```razor
   @implements IDisposable
   ```

   This `@implements` declaration lets you define a `Dispose` method.

1. Add a spinner to the page to give the customer feedback that the page is updating. In `<div class="track-order-details">`, above the `@foreach` statement, add the following code:

   ```razor
   @if (IsOrderIncomplete)
   {
       <div class="spinner-grow text-danger float-right" role="status">
           <span class="sr-only">Checking your order status...</span>
       </div>
   }
   ```

1. In the `@code` directive, under the `OrderId` property declaration, add the following members.

   ```csharp
   bool IsOrderIncomplete =>
       orderWithStatus is null || orderWithStatus.IsDelivered == false;
   
   PeriodicTimer timer = new(TimeSpan.FromSeconds(3));
   ```

1. Replace the existing `OnParametersSetAsync` method with the following code:

   ```csharp
   protected override async Task OnParametersSetAsync() =>
       await GetLatestOrderStatusUpdatesAsync();
   ```

   The code now calls the `GetLatestOrderStatusUpdatesAsync` method to update the order status.

1. Add the following methods after the updated `OnParametersSetAsync` method.

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

   The `OrderDetail` component starts polling after the page renders, and stops polling when the order is delivered. While the order status is incomplete, the `StartPollingTimerAsync` function uses a <xref:System.Threading.PeriodicTimer> to asynchronously wait for the next tick. When the order is delivered, the animated spinner is removed, and the page shows the final order status.

1. In Visual Studio Code, press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

1. In the app, order a pizza. Go to the **My Orders** screen and verify that the animated red dot appears while the order is incomplete and disappears when the status shows **Delivered**.

   :::image type="content" source="../media/3-order-status-updated-realtime.gif" lightbox="../media/3-order-status-updated-realtime.gif" alt-text="Animation showing the order status changing in real-time.":::

1. Press <kbd>Shift</kbd>+<kbd>F5</kbd> or select **Run** > **Stop Debugging** to stop the app.
