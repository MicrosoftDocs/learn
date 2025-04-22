Events in C# enable communication between objects, allowing a class or object to notify other classes or objects when something of interest occurs. This learning unit focuses on the practical aspects of subscribing and unsubscribing from events, ensuring efficient resource usage and avoiding common pitfalls like memory leaks.

As you continue developing the retail store application, your team is now focused on ensuring that event subscriptions are managed effectively. For example, when a customer completes a purchase, you want the inventory system to update stock levels and the sales reporting system to log the transaction. Properly managing event subscriptions ensures that these processes are efficient and don't lead to resource leaks or unexpected behavior.

## Subscribing to events

Subscribing to an event involves attaching a method to the event using the `+=` operator. Event subscription allows the method to be invoked whenever the event is raised.

**Example: Subscribing to an event**
```csharp
public class Button
{
    public event EventHandler Clicked;

    public void OnClick()
    {
        Clicked?.Invoke(this, EventArgs.Empty);
    }
}

public class Program
{
    public static void Main()
    {
        Button button = new Button();
        button.Clicked += Button_Clicked;

        button.OnClick(); // Output: "Button was clicked!"
    }

    private static void Button_Clicked(object sender, EventArgs e)
    {
        Console.WriteLine("Button was clicked!");
    }
}
```

## Unsubscribing from events

Unsubscribing from an event involves detaching a method from the event using the `-=` operator. Unsubscribing events is important to prevent memory leaks, especially when the event publisher has a longer lifetime than the subscriber.

**Example: Unsubscribing from an event**

```csharp
public class Button
{
    public event EventHandler Clicked;

    public void OnClick()
    {
        Clicked?.Invoke(this, EventArgs.Empty);
    }
}

public class Program
{
    public static void Main()
    {
        Button button = new Button();
        EventHandler handler = Button_Clicked;

        button.Clicked += handler;
        button.Clicked -= handler;

        button.OnClick(); // No output, as the handler was unsubscribed.
    }

    private static void Button_Clicked(object sender, EventArgs e)
    {
        Console.WriteLine("Button was clicked!");
    }
}
```

## Managing subscriptions dynamically

In some scenarios, you need to dynamically add or remove event handlers based on specific conditions. Removeing event handlers dynamically can be useful for managing complex workflows or ensuring that only relevant handlers are attached at any given time.

**Example: Dynamic subscription management**

```csharp
public class Button
{
    public event EventHandler Clicked;

    public void OnClick()
    {
        Clicked?.Invoke(this, EventArgs.Empty);
    }
}

public class Program
{
    public static void Main()
    {
        Button button = new Button();
        bool isSubscribed = false;

        EventHandler handler = (sender, e) => Console.WriteLine("Dynamic handler executed!");

        if (!isSubscribed)
        {
            button.Clicked += handler;
            isSubscribed = true;
        }

        button.OnClick(); // Output: "Dynamic handler executed!"

        if (isSubscribed)
        {
            button.Clicked -= handler;
            isSubscribed = false;
        }

        button.OnClick(); // No output, as the handler was unsubscribed.
    }
}
```

## Avoiding memory leaks

Memory leaks can occur when event handlers aren't unsubscribed, especially if the event publisher outlives the subscriber. To avoid this, always unsubscribe from events when they're no longer needed.

**Best practices for avoiding memory leaks:**

- Use weak references or `WeakEventManager` in scenarios where the subscriber's lifetime is shorter than the publisher's.
- Unsubscribe from events in the `Dispose` method of disposable objects.
- Avoid anonymous methods or lambda expressions for event handlers unless you can explicitly unsubscribe them.

**Example: Unsubscribing in `Dispose`**

```csharp
public class Subscriber : IDisposable
{
    private readonly Button _button;

    public Subscriber(Button button)
    {
        _button = button;
        _button.Clicked += Button_Clicked;
    }

    private void Button_Clicked(object sender, EventArgs e)
    {
        Console.WriteLine("Button clicked!");
    }

    public void Dispose()
    {
        _button.Clicked -= Button_Clicked;
    }
}
```

## Summary

By understanding how to subscribe and unsubscribe from events, you can ensure efficient resource usage and avoid common pitfalls like memory leaks. Proper event management is essential for building robust and maintainable applications.
