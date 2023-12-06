After you've created your XAML UI, you can add code to respond to the interactions that occur as the user visits the page. .NET MAUI notifies the application of user input and interactions through standard .NET events.

In this unit, you'll learn how to handle these events and carry out the operations expected by the user.

## Naming elements in a XAML page

Event-handling code frequently needs to refer to specific controls and their properties on a page. You can assign a unique name to each control. To do this, use the XAML attribute `x:Name`. The `x:Name` attribute does two things:

- It adds a private field to the generated code-behind file that's mapped to this element. Use this field in your code to interact with the visual element to set runtime properties and to handle events.

- The element is made known to XAML through this name. You can refer to these elements from other elements defined in the same XAML file.

You can't use any arbitrary string when you name the element. The value assigned to the `x:Name` attribute is used to create a field in code. Instead, it must conform to the naming conventions for a variable. The name also must be unique because it's compiled into the code-behind definition.

After you provide a name for an element, you can interact with that element in the code-behind file. The following XAML fragment defines a `Label` control. It's named **CounterLabel** (this example is taken from the default app the .NET MAUI template generates):

```xml
    <Label Text="Current count: 0"
        ...
        x:Name="CounterLabel"
        ... />
```

In this page's code-behind, you can reference this control through the `CounterLabel` field and modify its properties:

```csharp
count++;
CounterLabel.Text = $"Current count: {count}";
```

> [!IMPORTANT]
> The field won't be initialized until the `InitializeComponent` method of the page is run. This method is part of the XAML parsing and object-instantiation process. Place any code that interacts with an element that's defined in XAML after this call. The exception to this rule is the `ContentPage` class itself. You can access all properties on the class, prior to executing the `InitializeComponent` method. However, if you set any properties on this class in XAML, these property values will overwrite any values you might have set before executing `InitializeComponent`.

## Use an attribute to wire up events

Many controls expose properties that correspond to the events to which those controls can respond, such as the `Clicked` event for a button. Different controls support varying sets of events. For example, a `Button` control can respond to `Clicked`, `Pressed`, and `Released` events, while an `Entry` control has events such as `TextChanged`. You can initialize an event property in a page's XAML markup, and specify the name of the method to run when the event is triggered. The event method must meet the following signature requirements:

- It can't return a value; the method must be `void`.
- It must take two parameters; an `object` reference that indicates the object that triggered the event (known as the *sender*), and an `EventArgs` parameter that contains any arguments passed to the event handler by the sender.
- The event handler should be `private`. This isn't enforced, but if you make an event handler public it becomes accessible to the outside world, and an action other than the expected event being triggered could invoke it.
- The event handler can be `async` if it needs to run asynchronous operations.

The following example shows the definition of the `Clicked` event handler for the button in the sample app from the .NET MAUI template. The method name follows a standard convention; **On** followed by the name of the control (the button is named **Counter**), and the name of the event (**Clicked**). This convention isn't enforced, but is good practice:

```C#
private void OnCounterClicked(object sender, EventArgs e)
{
    ...
}
```

## Separation of Concerns

Wiring up events in XAML is convenient, but it mixes the control behavior with the UI definition. Many developers prefer to keep those elements distinct and do all the event-handler subscriptions in the code behind to named elements. It's easier to see what's hooked up and to where the behavior is mapped. This method also makes it harder to accidentally break the code by removing a handler in the XAML without realizing it. The compiler won't catch a removed handler, and it will only show itself as an issue when the code doesn't perform that behavior properly.

Whether you choose to wire up event handlers using XAML or by using code is a matter of personal choice.

To wire up an event handler in code, use the `+=` operator to subscribe to the event. You typically perform this operation in the constructor for the page, after the call to `InitializeComponent`:

```csharp
public partial class MainPage : ContentPage, IPage
{
    public MainPage()
    {
        InitializeComponent();
        Counter.Clicked += OnCounterClicked;
    }

    ...

    private void OnCounterClicked(object sender, EventArgs e)
    {
        ...
    }
}
```

> [!NOTE]
> You can use this approach to subscribe to multiple event-handling methods for the same event. Each event-handling method runs when the event occurs, although you shouldn't assume that they will execute in any particular order, so don't introduce any dependencies between them.

Similarly, you can remove an event handler by unsubscribing from it from the event with the `-=` operator later in your application:

```csharp
Counter.Clicked -= OnCounterClicked;
```
