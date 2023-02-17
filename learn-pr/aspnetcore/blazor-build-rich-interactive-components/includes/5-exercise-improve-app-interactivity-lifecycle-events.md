The Blazor component lifecycle allows you to write code for when a lifecycle event occurs.

The pizza company has decided they'd like to sell a family-sized pizza. The problem is that this pizza is only available in one 24-inch size. The current app doesn't support a single-sized pizza. You've been asked to add the new special pizza and disable the size option.

In this exercise, you'll make changes to the pizza database to add the new family pizza. You'll change the pizza model to support the new pizza. With the model altered, you'll then make changes to the configure pizza dialog component to handle the special case and see when your code runs in the lifecycle.

## Create the new family-size special pizza

1. In Visual Studio Code, in the file explorer, select *Models/PizzaSpecial.cs*.
1. After the `ImageUrl` property, add the following new property:

    ```csharp
    public int? FixedSize { get; set; }
    ```

1. Select *Models/Pizza.cs*, and update the `GetBasePrice` method with the following implementation:

    ```csharp
    public decimal GetBasePrice() =>
        Special is { FixedSize: not null }
            ? Special.BasePrice
            : (decimal)Size / DefaultSize * Special?.BasePrice ?? 1;
    ```

    This code now accounts for when a special has a `FixedSize` and will return the `BasePrice`.

1. Now select *Data/SeedData.cs*.
1. Near the bottom of the `InitializeAsync` method, add the new family size special to the `specials` array declaration.

    ```csharp
    new()
    {
        Id = 9,
        Name = "Margherita Family Size",
        Description = "24\" of pure tomatoes and basil",
        BasePrice = 14.99m,
        ImageUrl = "img/pizzas/margherita.jpg",
        FixedSize = 24
    }
    ```

    The `SeedData` class is used to pre-populate the pizza database with special pizzas. You'll need to delete the existing database for the new `PizzaSpecial` to be created.

1. In the file explorer, select and delete the *pizza.db*, *pizza.db-shm*, and *pizza.db-wal* files.

    If you run the app, you'll see a new pizza is available to configure.

1. In Visual Studio Code, press <kbd>F5</kbd>or, in the **Run** menu, select **Start Debugging**.

    :::image type="content" source="../media/5-new-family-pizza.png" lightbox="../media/5-new-family-pizza.png" alt-text="Screenshot of the new family size pizza.":::

    Add the pizza to your order and you'll see you can change the size.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.

## Omit the size slider

One way to disable user input is to conditionally omit the rendering of the user control all together. The `ConfigurePizzaDialog` component uses an HTML `range` element to allow the customer to select the size of the pizza.

1. In the file explorer, expand **Shared**, then select *ConfigurePizzaDialog.razor*.
1. In the `@code` directive, under the existing properties, add the following members:

    ```csharp
    bool supportSizing = true;

    protected override void OnInitialized()
    {
        if (Pizza is { Special.FixedSize: not null })
        {
            Pizza.Size = Pizza.Special.FixedSize.Value;
            supportSizing = false;
        }
    }
    ```

    The `supportSizing` field defaults to `true`, but if the pizza has a fixed size, it will be set to `false`. The `OnInitialized` lifecycle method override will set the pizza size to the fixed size and disable sizing support.

1. In the markup, replace the existing `label` and `input` with the following markup:

    ```razor
    @if (supportSizing)
    {
        <label>Size:</label>
        <input type="range" min="@Pizza.MinimumSize" max="@Pizza.MaximumSize"
            step="1" @bind="Pizza.Size" @bind:event="oninput" />
    }
    ```

    If your code needed to rely on JavaScript interop, using the `OnInitialized` method wouldn't have worked. Instead, you would have needed to use the `OnAfterRenderAsync` method to ensure the JavaScript interop was available.

1. In Visual Studio Code, press <kbd>F5</kbd> or, in the **Run** menu, select **Start Debugging**.

    If you try to add the family-size pizza, the size slider should be disabled as it's omitted from rendering. Select any other pizza and this slider should still work.

    :::image type="content" source="../media/5-not-sizeable.png" lightbox="../media/5-not-sizeable.png" alt-text="Screenshot of the new family size pizza with the size range omitted from rendering.":::

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.
