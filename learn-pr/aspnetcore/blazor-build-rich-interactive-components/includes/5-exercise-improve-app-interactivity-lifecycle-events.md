The Blazor lifecycle allows you to write your own code for when a lifecycle event happens.

The pizza company has decided they'd like to sell a family sized pizza. The problem is that this pizza is only available in one 24-inch size. The current app doesn't have any support to cater for single sized pizzas. You've been asked to add the new special pizza and disable the size option.

In this exercise, you'll make changes to the pizza database to add the new family pizza. You'll change the pizza model to support the new pizza. With the model altered, you'll then change the configure pizza dialog component to handle the special case and see when your code runs in the lifecycle.

## Create the new family size special pizza

1. In Visual Studio Code, in the file explorer, select **SeedData.cs**.
1. At the bottom of the `SeedData` class, add the new family size special.

    ```razor
    new PizzaSpecial()
    {
        Id = 9,
        Name = "Margherita Family Size",
        Description = "Only 24\" of pure tomatoes and basil",
        BasePrice = 12.99m,
        ImageUrl = "img/pizzas/margherita.jpg",
    },
    ```

    This class is used to prepopulate the pizza database with special pizzas. You'll need to delete the existing database for this new special to be created.

1. In the file explorer, right-click **pizza.db**, and then select **Delete**.

    If you run the app, you'll see a new pizza is available to configure.

1. In Visual Studio Code, press <kbd>F5</kbd>or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/5-new-family-pizza.png" alt-text="Screenshot of the new family size pizza.":::

    Add the pizza to your order and you'll see you can change the size.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Disable the size slider

As the `ConfigurePizzaDialog` component uses a range HTML control, you'll use JavaScript to disable it.

1. In the file explorer, expand **Pages**, then select **_Host.cshtml**.
1. At the bottom, inside the last `<script>` tag, add this new function.

    ```javascript
    window.disableElement = (element) => element.disabled = "disabled";
    ```

    The function takes an element as a parameter and sets it to disabled.

1. In the file explorer, expand **Shared**, then select **ConfigurePizzaDialog.razor**.
1. At the top, under the `@inject` statement, add the declaration to allow JavaScript interoperability.

    ```razor
    @inject IJSRuntime JS
    ```

1. To be able to pass a reference to the size slider, add `@ref="sizeRange"` to the `input` element.

    ```razor
    <input @ref="sizeRange" type="range" min="@Pizza.MinimumSize" max="@Pizza.MaximumSize" step="1" @bind="Pizza.Size" @bind:event="oninput" />
    ```

1. In the `@code` block, under the parameters, create an `ElementReference` for the size slider.

    ```razor
    ElementReference sizeRange;
    ```

1. After the component has been rendered, it's safe to disable the control. Add this method.

    ```razor
    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
      if (Pizza.Special.Name == "Margherita Family Size") {
        if (firstRender)
        {
          await JS.InvokeVoidAsync("disableElement", sizeRange);
        }
      }
    }    
    ```

    If this is the special pizza case, call the disableElement JavaScript function, passing a reference to the size element.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    If you try to add the family size pizza, the size slider should be disabled. Select any other pizza and this slider should still work.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Fix the price and size

Currently, the price is correct, but the size is showing as the default 12 inches for a pizza. In the `ConfigurePizzaDialog` component, we need to set the default size to 24 inches. 

1. In the file explorer, expand  **Model**, then select **Pizza.cs**.
1. Change the `DefaultSize` from a constant to a property that can be set.

    ```csharp
    public int DefaultSize { get; set; } = 12;
    ```

1. In the file explorer, expand **Model**, then select **Pizza.cs**.
1. Change the `ShowConfigurePizzaDialog` method to access the DefaultSize after the new pizza has been created.

    ```csharp
    public void ShowConfigurePizzaDialog(PizzaSpecial special)
    {
        ConfiguringPizza = new Pizza()
        {
            Special = special,
            SpecialId = special.Id,
            Toppings = new List<PizzaTopping>(),
        };

        ConfiguringPizza.Size = ConfiguringPizza.DefaultSize;

        ShowingConfigureDialog = true;
    }
    ```

1. Now when the component loads, if the pizza is the family size, we can set it to 24.
1. At the top of the `OnAfterRenderAsync` method, add this code.

    ```razor
    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
      if (Pizza.Special.Name == "Margherita Family Size") {
    
        Pizza.DefaultSize = 24;
        Pizza.Size = 24;
        if (firstRender)
        {
          await JS.InvokeVoidAsync("disableElement", sizeRange);
        }
      }
    }   
    ```

    We now have code to set the pizza size and disable the slider. Let's test it.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    Nothing has changed. The family size pizza is still set to 12 inches.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Change when the pizza size is updated in the lifecycle

The problem is that the code setting the pizza size is happening at the wrong time in the lifecycle. Let's move the code to `OnInitializedAsync`.

1. In the file explorer, expand **Shared**, then select **ConfigurePizzaDialog.razor**.

    ```razor
    protected override async Task OnInitializedAsync() {
      if (Pizza.Special.Name == "Margherita Family Size") {
        Pizza.DefaultSize = 24;
        Pizza.Size = 24;
        await JS.InvokeVoidAsync("disableElement", sizeRange);
      }
    }
    ```

    Do you think this will resolve the problem? Let's test it.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    That's great. The pizza is now the correct size and price, but the slider isn't disabled.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

    The code needs to run at two different stages in the lifecycle. The pizza size should set when the component is initialized. The control should be disabled after the component is rendered.

1. Replace the current method with these two.

    ```razor
    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
      if (Pizza.Special.Name == "Margherita Family Size") {
        if (firstRender)
        {
          await JS.InvokeVoidAsync("disableElement", sizeRange);
        }
      }
    }
  
    protected override void OnInitialized() {
      if (Pizza.Special.Name == "Margherita Family Size") {
        Pizza.DefaultSize = 24;
        Pizza.Size = 24;
      }
    }
    ```

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    Test the final fix to check that we've solved the problem.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.
