
The pizza company has decided they'd like to sell a special family-sized pizza that's only available in one 24-inch size. The current pizza app has a size slider that doesn't support a single-sized pizza. You're asked to add the new family-size pizza and disable the size option for that pizza.

In this exercise, you change the pizza database to add the family-size pizza and change the pizza model to support the new pizza. To handle Blazor component lifecycle events, you make changes to the configure pizza dialog to handle the fixed-size case.

## Create the new family-size pizza

First, you add the new `FixedSize` capability to the pizza model, and create the new family-size pizza in the pizza database.

1. In Visual Studio Code **Explorer**, expand *Models* and select *PizzaSpecial.cs*.
1. In the *PizzaSpecial.cs* file, after the `ImageUrl` property, add the following new property:

   ```csharp
   public int? FixedSize { get; set; }
   ```

1. Open the *Pizza.cs* file, and replace the `GetBasePrice` method with the following code:

   ```csharp
   public decimal GetBasePrice() =>
       Special is { FixedSize: not null }
           ? Special.BasePrice
           : (decimal)Size / DefaultSize * Special?.BasePrice ?? 1;
   ```

   The code now accounts for a special that has a `FixedSize` when it returns the `BasePrice`.

1. Expand *Data*, and select *SeedData.cs*.

1. In the *SeedData.cs* file, add the following code for the new family size pizza to the end of the `specials` array declaration in the `InitializeAsync` method.

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

1. The `SeedData` class prepopulates the pizza database with special pizzas. For the new `PizzaSpecial` to be created, you need to delete the existing database. In **Explorer**, select and delete the *pizza.db*, *pizza.db-shm*, and *pizza.db-wal* files.

1. In Visual Studio Code, press <kbd>F5</kbd>or select **Run** > **Start Debugging**.

1. In the app, select the new **Margherita Family Size** pizza.

   :::image type="content" source="../media/5-new-family-pizza.png" lightbox="../media/5-new-family-pizza.png" alt-text="Screenshot of the new family size pizza.":::
   
1. In the order form, notice that you can still change the pizza size.

1. Press <kbd>Shift</kbd>+<kbd>F5</kbd> or select **Run** > **Stop Debugging** to stop the app.

## Remove the size slider

The `ConfigurePizzaDialog` component uses an HTML `range` element to allow the customer to select the pizza size. One way to disable user input is to conditionally omit the rendering of the size user control altogether.

1. In Visual Studio Code **Explorer**, expand *Shared* and then select *ConfigurePizzaDialog.razor*.
1. In the `@code` directive, after the existing properties, add the following members:

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

    The `supportSizing` field defaults to `true`, but if the pizza has a fixed size, the field is set to `false`. The `OnInitialized` lifecycle method override sets the pizza size to the fixed size and disables sizing support.

   >[!NOTE]
   >If your code relied on JavaScript interop, using the `OnInitialized` method wouldn't work. Instead, you'd need to use the `OnAfterRenderAsync` method to ensure the JavaScript interop was available.

1. Near the top of the file in the `<form class="dialog-body">`, replace the existing `label` and `input` lines with the following code:

   ```razor
   @if (supportSizing)
   {
       <label>Size:</label>
       <input type="range" min="@Pizza.MinimumSize" max="@Pizza.MaximumSize"
           step="1" @bind="Pizza.Size" @bind:event="oninput" />
   }
   ```

1. Press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

1. Add the family-size pizza, and verify that the size slider is disabled because it's omitted from rendering.

    :::image type="content" source="../media/5-not-sizeable.png" lightbox="../media/5-not-sizeable.png" alt-text="Screenshot of the new family size pizza with the size range omitted from rendering.":::

1. Order a different pizza, and verify that you can still use the size slider for that pizza.

1. Press <kbd>Shift</kbd>+<kbd>F5</kbd> or select **Run** > **Stop Debugging** to stop the app.
