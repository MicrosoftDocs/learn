At the moment, the Blazing Pizza app is using HTML elements to capture data and for buttons. The Blazor framework has improved support for forms that allow them to use components that can be bound to a C# model.

The team would like you to change the current HTML elements with Blazor components. The team would like you to only submit orders if the address and name aren't blank.

In the exercise, you'll replace the current HTML fields with a Blazor component and change how the customer orders submission. You'll see how to use the EditContext to write manual validations for a form.

## Add a Blazor EditForm component

1. In Visual Studio Code, in the file explorer, expand **Pages**, then select **Checkout.razor**.
1. Under the `<div class="main">` block, add a new `EditForm` component.

    ```razor
    <div class="main">
        <EditForm Model=Order.DeliveryAddress OnSubmit=CheckSubmission>
    ```

1. Under the `</button>` element, close the EditForm component.

    ```razor
            </button>
        </EditForm>
    </div>
    ```

1. Remove the `@onclick` event on the `</button>`.

    ```razor
    <button class="checkout-button btn btn-warning" disabled=@isSubmitting>
    ```

1. In the `@code` block, add the code to handle the form submission above the existing `PlaceOrder` method.

    ```csharp
    private async Task CheckSubmission()
    {
        isSubmitting = true;
        await PlaceOrder();
        isSubmitting = false;
    }
    ```

1. Delete the `isSubmitting = true;` line of code from the `PlaceOrder()` method.

1. In Visual Studio Code press <kbd>F5</kbd>, or in the **Run** menu select **Start Debugging**.

    The app will work as it did previously. At the moment we've added an EditForm component, we now need to replace the HTML input elements.

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running.

## Replace HTML elements with Blazor components

1. In the file explorer, expand **Shared**, then select **AddressEditor.razor**.

1. Select the **Edit** menu, then select **Replace**. 
1. In the first field, enter `<input` in the replace field enter `<InputText`, then select replace all.

    :::image type="content" source="../media/5-replace-input-elements.png" alt-text="Screenshot of Visual Studio Code and the text replace dialog."::: 

1. Select the **Edit** menu, then select **Replace**. 
1. In the first field, enter `@bind=` in the replace field enter `@bind-Value=`, then select replace all.
1. Remove the `@ref="startName"` code on the Name field. 
1. Remove all the code below the Parameter declaration in the `@code` block. The block should now look like this.

    ```razor
    @code {

        [Parameter] public Address Address { get; set; }

    }    
    ```

    FocusAsync is currently only supported on HTML elements.

## Check for empty fields before submitting a form

Let's add an error message the app can show a customer if they don't enter their name or address.

1. In the file explorer, expand **Pages**, then select **Checkout.razor**.
1. Add an error message under the `h4>Deliver to...</h4>` element.

    ```razor
    <div class="checkout-delivery-address">
      <h4>Deliver to...</h4>
      @if (isError) {
        <div class="alert alert-danger">Please enter a name and address.</div>
      }
      <AddressEditor Address="Order.DeliveryAddress" />
    </div>
    ```

1. In the `@code` block, add a declaration for the `isError` boolean. 

    ```csharp
    bool isError = false;
    ```

1. Improve the `CheckSubmission()` method to only place an order if the name and postal code fields have data in them.

    ```csharp
    private async Task CheckSubmission(EditContext editContext)
    {
        var model = editContext.Model as Address;
        isSubmitting = true;
        if (string.IsNullOrWhitespace(model?.Name) || 
            string.IsNullOrWhitespace(model?.Line1) ||
            string.IsNullOrWhitespace(model?.PostalCode)
        {
            isError = true;
        } 
        else 
        {
            isError = false;
            await PlaceOrder();
        }
      isSubmitting = false;
    }  
    ```

1. In Visual Studio Code press <kbd>F5</kbd>, or in the **Run** menu select **Start Debugging**.

    Try to order some pizzas without entering any information. You should see the error message.

    :::image type="content" source="../media/5-showing-error-message.png" alt-text="Screenshot of the error message.":::

1. Press <kbd>Shift</kbd> + <kbd>F5</kbd> to stop the app running. 

