Blazor gives you the power to connect C# code to HTML DOM events. You'll use this ability to improve an existing app.

As part of a development team working to enhance a Blazing Pizza app, you've been asked to finish the checkout process to capture customers' addresses. You'll add some text fields and improve the checkout process.

In this exercise, you'll clone an existing app and create a new address component to capture address details. With the fields in place, you'll set the focus to the first field on the form.

## Clone your team's existing app

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet6-sdk-version.md)]

If you haven't created a Blazor app before, follow the [setup instructions for Blazor](https://aka.ms/blazor-getting-started) to install the correct version of .NET and check your machine is set up correctly. Stop at the **Create your app** step.

1. Open **Visual Studio Code**.
1. Open the integrated terminal from Visual Studio Code by selecting **View**, then select **Terminal** from the main menu.
1. In the terminal, navigate to where you'd like the project to be created.
1. Clone the app from GitHub.

    ```powershell
    git clone https://github.com/MicrosoftDocs/mslearn-use-forms-in-blazor-web-apps.git BlazingPizza
    ```

1. Select **File**, then select **Open folder...**.
1. In the Open dialog, navigate to the **BlazingPizza** folder, and select **Select Folder**.

    Visual Studio Code might prompt you about unresolved dependencies. Select **Restore**.

1. Run the app to check everything is working correctly.
1. In Visual Studio Code, press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

    :::image type="content" source="../media/3-blazing-pizza-starting-state.png" alt-text="Screenshot of the Blazing Pizza app after cloning it":::

    Try configuring some pizzas and adding them to your order. Select **Order >** at the bottom of the page. You'll see the current checkout page.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.

## Refactor the checkout page

1. In Visual Studio Code, in the file explorer, expand **Pages**, then select **Checkout.razor**.

    At the moment, the checkout page just shows the list of pizzas that have been configured. You've been asked to refactor the page to include an address section.

1. Replace the existing `<div class="main">` HTML block to have two columns for data.

    ```razor
    <div class="main">
        <div class="checkout-cols">
            <div class="checkout-order-details">
                <h4>Review order</h4>
                <OrderReview Order="Order" />
            </div>
    
            <div class="checkout-delivery-address">
                <h4>Deliver to...</h4>
                <AddressEditor Address="Order.DeliveryAddress" />
            </div>
        </div>
    
        <button class="checkout-button btn btn-warning" @onclick="PlaceOrder" disabled=@isSubmitting>
            Place order
        </button>
    </div>
    ```

    The preceding code connects the HTML `onclick` event for the button element to the `PlaceOrder` Blazor method in the `@code` block.

    The refactoring references two new Blazor controls `OrderReview` and `AddressEditor`. You'll move the old checkout code that listed the pizzas to the `OrderReview` component.

1. In the file explorer, right-click on **Shared**, then select **New File**.
1. Enter **OrderReview.razor** as the filename.
1. Add a `foreach` loop to display the pizzas in an order.

    ```razor
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
    
    @code {
        [Parameter] public Order Order { get; set; }
    }
    ```

1. In the file explorer, right-click on **Shared**, then select **New File**.
1. Enter **AddressEditor.razor** as the filename.
1. Add code that uses an `input` element for each field in an address. The `Address` class in **Model** folder shows you all the fields.

    ```razor
    <div class="form-field">
        <label>Name:</label>
        <div>
            <input @bind="Address.Name" />
        </div>
    </div>
    
    <div class="form-field">
        <label>Line 1:</label>
        <div>
            <input @bind="Address.Line1" />
        </div>
    </div>
    
    <div class="form-field">
        <label>Line 2:</label>
        <div>
            <input @bind="Address.Line2" />
        </div>
    </div>
    
    <div class="form-field">
        <label>City:</label>
        <div>
            <input @bind="Address.City" />
        </div>
    </div>
    
    <div class="form-field">
        <label>Region:</label>
        <div>
            <input @bind="Address.Region" />
        </div>
    </div>
    
    <div class="form-field">
        <label>Postal code:</label>
        <div>
            <input @bind="Address.PostalCode" />
        </div>
    </div>
    
    @code {
        [Parameter] public Address Address { get; set; }
    }
    ```

## Test the new checkout page

1. In Visual Studio Code, press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

    :::image type="content" source="../media/3-new-checkout-page.png" alt-text="Screenshot of the new checkout page.":::

    Add some pizzas and select **Order >** to see the new checkout flow.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Improve usability of the form

When the customer is taken to the checkout page, the first thing they do is enter their name. Blazor allows you to set the focus on HTML elements on a page. Let's make our app better by adding this.

1. In **AddressEditor.razor**, change the HTML for the name `input` element to add `@ref="startName"`.

    ```razor
    <input @ref="startName" @bind="Address.Name" />
    ```

    The Blazor directive `@ref="startName"` lets the code block create an `ElementReference` to reference the input element. You can then use this element reference to call `FocusAsync` after a page has been rendered.

1. Add code to call `FocusAsync` after a page has loaded under the `[Parameter] public Address Address { get; set; }` declaration.

    ```razor
    private ElementReference startName;

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender) {
            await startName.FocusAsync();
        }
    }    
    ```

    This code creates the `ElementReference` and then after a page has been rendered sets the focus to the `Name` field.

1. In Visual Studio Code, press <kbd>F5</kbd> or select **Run** > **Start Debugging**.

    :::image type="content" source="../media/3-focus-name-field.png" alt-text="Screenshot of the Name field getting focus on page render.":::

    Add some pizzas and select **Order >** to see that on the checkout page the **Name** form field has focus.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app from running.
