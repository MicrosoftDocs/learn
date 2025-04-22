Events in C# are built on the foundation of delegates, which define the method signature for event handlers. While earlier units introduced the basics of events and delegates, this unit focuses on advanced concepts, including the use of `EventHandler<T>`, multicast delegates, and best practices for managing complex event-driven systems.

As you continue developing the retail store application, your team is now focused on handling more complex scenarios, such as notifying multiple systems when a significant event occurs or passing detailed event data to subscribers. By learning these advanced concepts, you can build robust and maintainable applications.

## Advanced Delegate-Event Relationship

Delegates are type-safe function pointers that allow methods to be passed as parameters and invoked dynamically. Events encapsulate delegates, providing a structured way to notify subscribers when something significant occurs. This unit explores how to use built-in delegates like `EventHandler` and `EventHandler<T>` to simplify event handling.

### Using `EventHandler<T>` with Custom Event Data

The `EventHandler<T>` delegate is a built-in delegate that simplifies event handling when custom event data needs to be passed to subscribers. It allows you to define event handlers that include additional information about the event.

**Example: Using `EventHandler<T>` with custom event data**

```csharp
public class OrderEventArgs : EventArgs
{
    public int OrderId { get; set; }
    public DateTime OrderDate { get; set; }
}

public class OrderProcessor
{
    public event EventHandler<OrderEventArgs> OrderProcessed;

    protected virtual void OnOrderProcessed(OrderEventArgs e)
    {
        OrderProcessed?.Invoke(this, e);
    }

    public void ProcessOrder(int orderId)
    {
        Console.WriteLine($"Processing order {orderId}...");
        OnOrderProcessed(new OrderEventArgs
        {
            OrderId = orderId,
            OrderDate = DateTime.Now
        });
    }
}

// Subscribing to the event
public class Program
{
    public static void Main()
    {
        OrderProcessor processor = new OrderProcessor();
        processor.OrderProcessed += (sender, e) =>
        {
            Console.WriteLine($"Order {e.OrderId} processed on {e.OrderDate}");
        };

        processor.ProcessOrder(123); // Output: "Processing order 123..."
                                     // Output: "Order 123 processed on [current date and time]"
    }
}
```

### Multicast Delegates

Multicast delegates allow multiple methods to be invoked for a single event. Multicast delegates are useful when multiple subscribers need to respond to the same event.

**Example: Using multicast delegates**

```csharp
public class NotificationService
{
    public event EventHandler NotificationSent;

    public void SendNotification()
    {
        NotificationSent?.Invoke(this, EventArgs.Empty);
    }
}

public class Program
{
    public static void Main()
    {
        NotificationService service = new NotificationService();

        // Subscribing multiple methods to the event
        service.NotificationSent += EmailNotification;
        service.NotificationSent += SmsNotification;

        service.SendNotification();
        // Output:
        // "Email notification sent!"
        // "SMS notification sent!"
    }

    private static void EmailNotification(object sender, EventArgs e)
    {
        Console.WriteLine("Email notification sent!");
    }

    private static void SmsNotification(object sender, EventArgs e)
    {
        Console.WriteLine("SMS notification sent!");
    }
}
```

### Best Practices for Managing Events

Managing events effectively is critical for building robust and maintainable applications. Here are some best practices to follow:

1. **Avoid Memory Leaks:**  
   Always unsubscribe from events when they're no longer needed, especially if the event publisher has a longer lifetime than the subscriber.

2. **Use Weak References:**  
   In scenarios where the subscriber's lifetime is shorter than the publisher's, consider using weak references or the `WeakEventManager` to avoid memory leaks.

3. **Ensure Thread Safety:**  
   If events are raised in a multithreaded environment, ensure thread safety by using synchronization mechanisms like locks or thread-safe collections.

**Example: Unsubscribing to avoid memory leaks**

```csharp
public class Subscriber : IDisposable
{
    private readonly NotificationService _service;

    public Subscriber(NotificationService service)
    {
        _service = service;
        _service.NotificationSent += HandleNotification;
    }

    private void HandleNotification(object sender, EventArgs e)
    {
        Console.WriteLine("Notification received!");
    }

    public void Dispose()
    {
        _service.NotificationSent -= HandleNotification;
    }
}
```

### Summary

In this unit, you explored advanced concepts of delegates and events in C#, including:

- Using `EventHandler<T>` with custom event data.
- Using multicast delegates to notify multiple subscribers.
- Best practices for managing event subscriptions, avoiding memory leaks, and ensuring thread safety.

With these advanced techniques, you can build robust, maintainable, and scalable event-driven applications.
