When a customer adds a pizza to their orders, they can select a **X** to remove it. The company thinks customers might have been clicking this and accidentally removing items from their order. You'll add a feature that prompts the user to make sure they do want to remove the pizza.

The pizza company wants to be able to show customers the live status of their order. You'll update the order detail page to query the order status in real time.

In this exercise, you'll extend an existing app created for the pizza delivery company. You'll use JS interop to call JavaScript on the client side from a Blazor component. You'll then see how to integrate with a third-party JavaScript library to improve the popup. In the final steps of the exercise, you'll call a Blazor method from JavaScript to get the real-time status of a customer order.

## Clone your team's existing app

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, and macOS).

If you haven't created a Blazor app before, follow the [setup instructions for Blazor](https://aka.ms/blazor-getting-started) to install the correct version of .NET and check your machine is set up correctly. Stop at the **Create your app** step.

[!include[](../../../includes/dotnet6-sdk-version.md)]

1. Open **Visual Studio Code**.
1. Open the integrated terminal from Visual Studio Code by selecting **View**, then select **Terminal** from the main menu.
1. In the terminal, go to where you'd like the project to be created.
1. Clone the app from GitHub.

    ```powershell
    git clone https://github.com/MicrosoftDocs/mslearn-build-interactive-components-blazor.git BlazingPizza
    ```

1. Select **File**, then select **Open folder...**.
1. In the Open dialog, go to the **BlazingPizza** folder, and select **Select Folder**.

    Visual Studio Code might prompt you about unresolved dependencies. Select **Restore**.

1. Run the app to check everything is working correctly. 
1. In Visual Studio Code, press <kbd>F5</kbd>, or in the **Run** menu, select **Start Debugging**.

    Try configuring some pizzas and adding them to your order. With a few pizzas in your order, select the **X** and see how that item is removed without any prompt.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Refactor the order process

To use the JavaScript interop, you inject the `IJSRuntime` abstraction. 

1. In the file explorer, expand **Pages**, then select **Index.razor**.
1. Under the `@inject OrderState OrderState` statement, add the `IJSRuntime` injection.

    ```razor
    @inject OrderState OrderState
    @inject IJSRuntime JsRuntime
    ```

1. Currently, the `OnClick` event for the **X** calls the `OrderState.RemoveConfiguredPizza(configuredPizza))` method directly.
1. Add a new method to call the JavaScript `confirm` function. If the customer selects **OK** call the `RemoveConfiguredPizza`.

    ```razor
    private async Task ShowConfirm(Pizza removePizza)
    {
      if (await JsRuntime.InvokeAsync<bool>("confirm",$"Do you want to remove the {removePizza.Special.Name} from your order?")) {
        OrderState.RemoveConfiguredPizza(removePizza);
      }
    }
    ```

    This method takes the selected pizza as a parameter. The server then uses the `InvokeAsync` method to call the `confirm` function on the client side. The response from the call is stored in the boolean response variable.

    The response variable can then be checked, and if it's set to true, remove the pizza from the order.

1. In Visual Studio Code, press <kbd>F5</kbd>, or in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/3-confirm-remove-dialog.png" alt-text="Screenshot of the default JavaScript confirm dialog.":::

    Try configuring some pizzas and adding them to your order. With a few pizzas in your order, select the **X**. A standard JavaScript confirm dialog lets you select **Cancel** or **OK**.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Add a third-party JavaScript library to a Blazor app

The pizza company feels that their customers could be confused by the word *cancel* in the popup. They'd like the text on the buttons to be clearer. Also, they don't like how their existing branding and styling aren't used.

After some research you find a small JavaScript library called SweetAlert that looks like a good replacement.

1. In the file explorer, expand **Pages**, then select **_Host.cshtml**.

1. At the bottom of the page, under the Blazor framework, add a `script` element to include the SweetAlert library.

    ```html
            <script src="_framework/blazor.server.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert@latest/dist/sweetalert.min.js"></script>
        </body>
    </html>    
    ```
    
    This now makes SweetAlert available to call on the client side.

1. Update the ShowConfirm method to use the new library.

    ```razor
    private async Task ShowConfirm(Pizza removePizza)
    {
      var messageParams = new {
        title = "Are you sure?",
        text = $"Do you want to remove the {removePizza.Special.Name}from your order?",
        icon = "warning",
        buttons = new {
            abort = new {
                text = "Leave it in my order",
                value = false
            },
            confirm = new {
                text = "Remove pizza",
                value = true
            }
        },
        dangerMode = true
      };

      if (await JsRuntime.InvokeAsync<bool>("swal", messageParams)) {
        OrderState.RemoveConfiguredPizza(removePizza);
      }
    }    
    ```

    The code to call the `swal` function instead of the `confirm` will look similar. The bulk of the update is in how the function receives parameters.
    
1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/3-sweetalert-remove-dialog.png" alt-text="Screenshot showing the SweetAlert dialog box.":::

    SweetAlert can accept a JSON object that includes all the settings it needs. The `confirm` dialog will now have two buttons that say **Leave it in my order** and **Remove pizza**. The current CSS is used for styling, so the dialog fits in better with the pizza company's branding.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Update the order page to show order status in real time

The `OrderDetail` component currently shows the current status of a pizza order. Customers would like to see how their order is progressing in real time. You'll update the component to call a .NET method from JavaScript to continuously get the order status until it's delivered.

1. In the file explorer, expand **Pages**, then select **OrderDetail.razor**.
1. Add some HTML element IDs to make it easier to reference them from JavaScript.
1. Add an ID to the Status `<strong>` tag.

    ```razor
    Status: <strong id="orderStatus">@orderWithStatus.StatusText</strong> 
    ```
1. Add a spinner to provide feedback to the customer that the page is updating.
1. Above the `@foreach ` statement, add this bootstrap HTML.

    ```razor
    <div id="progressSpinner" class="spinner-grow text-danger float-right" role="status">
      <span class="sr-only">Checking your order status...</span>
    </div>
    @foreach (var pizza in orderWithStatus.Order.Pizzas)    
    ```
1. Add these two declarations at the top of the component.

    ```razor
    @inject IJSRuntime JS
    @implements IDisposable    
    ```

    The first declaration allows us to use JavaScript interop in this component. The second declaration lets you define a `Dispose` method.

1. Under the `invalidOrder` declaration, create a new `objRef` variable you'll pass to JavaScript to allow it to call our instance method.

    ```razor
    bool invalidOrder = false;
    private DotNetObjectReference<OrderDetail> objRef;
    ```
1. After the page has been rendered, you can pass the object reference. Add this method at the bottom of the `@code` block.

    ```razor
    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
      if (firstRender)
      {
        objRef = DotNetObjectReference.Create(this);
        await JS.InvokeVoidAsync("populateObjectRef", objRef);
      }
    }
    ```

    The code checks to make sure the reference is initialized the first time the page is rendered. You'll learn more about the lifecycle of components in the next unit.

1. Next, you add the method that JavaScript will call on the client side.

    ```razor
    [JSInvokable]
    public async Task<string> GetOrderStatus()
    {
      orderWithStatus = await HttpClient.GetFromJsonAsync<OrderWithStatus>(NavigationManager.BaseUri + $"orders/{OrderId}");
      return orderWithStatus.StatusText;
    }
    ```

    This method will return the order status text when called from JavaScript.

1. The last change for this component is to dispose of the object reference.

    ```razor
    public void Dispose()
    {
        objRef?.Dispose();
    }    
    ```

## Call an instance method from JavaScript

There are two ways the client side can get the current order status. You could have chosen to call the underlying API of the app and handle the JSON response with JavaScript like this:

```javascript
<script lang="javascript">
    window.updateOrderStatus = (orderId) => {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", `orders/${orderId}`, true);
        xhr.onload = function (e) {
          if (xhr.readyState === 4) {
            if (xhr.status === 200) {
              const orderStatus = xhr.response;
              document.querySelector('#orderStatus').innerText = orderStatus.statusText;
              
              if (orderStatus.statusText != "Delivered") {
                setTimeout(function(){ updateOrderStatus(orderId); }, 3000);
              } else {
                document.querySelector('#progressSpinner').remove();
              }
        
            } else {
              console.error(xhr.statusText);
            }
          }
        };
        xhr.onerror = function (e) {
          console.error(xhr.statusText);
        };
        xhr.responseType = 'json';
        xhr.send(); 
    }
</script>
```

You would also need to call this function with the `OrderId` from the component. Instead, you're going to call a method on the `OrderDetail` component.

1. In the file explorer, expand **Pages**, then select **_Host.cshtml**.
1. At the bottom of the page, above the closing `</body>` tag, add this JavaScript.

    ```javascript
    <script lang="javascript">
        var objectRef;
        
        window.populateObjectRef = (ref) => {
            objectRef = ref;
            refreshOrderStatus();
        };

        window.refreshOrderStatus = async () => {
            var statusText = await objectRef.invokeMethodAsync('GetOrderStatus');
            document.querySelector('#orderStatus').innerText = statusText;
            if (statusText != "Delivered") {
              setTimeout(function(){ refreshOrderStatus(); }, 3000);
            } else {
              document.querySelector('#progressSpinner').remove();
            }
        };
    </script>    
    ```

    The `OrderDetail` component calls the `populateObjectRef` function after the page has rendered with a reference to itself.

    The `refreshOrderStatus` function uses this reference to call `GetOrderStatus` then updates the `<strong>` tag with the returned status string.

    The string is checked, and if it's not set to "Delivered", calls itself in three seconds. Otherwise the function ends by deleting the spinner.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/3-order-status-updated-realtime.gif" alt-text="Animated gig showing the order status changing in real time.":::

    Start the app and order a pizza. When the customer gets to the order detail screen the status updates and the spinner is removed when the pizza is delivered.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.
