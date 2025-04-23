Events in C# are a powerful mechanism that allows objects to communicate with each other by signaling when something of interest occurs. This concept is crucial for developers who want to build interactive and maintainable applications.

As you continue developing the retail store application, your team is now focused on improving the application's flexibility by using inheritance and event handling. For example, when a customer completes a purchase, you want both the inventory system and the sales reporting system to be notified automatically. By declaring events in a base class, derived classes can raise or handle these events, ensuring efficient communication between components while maintaining organized and reusable code.

## Declare events

Events enable a class or object to notify other classes or objects when something of interest occurs. The publisher is the class that defines and raises the event, while the subscribers are the classes that attach methods to handle the event. In C#, the event keyword is used to declare an event, ensuring that only the publisher class can raise it, while subscribers can attach executable code to respond to it.

**Example: Declaring and raising an event**

```csharp
public class Counter
{
    public event EventHandler ThresholdReached;

    protected virtual void OnThresholdReached(EventArgs e)
    {
        ThresholdReached?.Invoke(this, e);
    }

    public void Increment(int value, int threshold)
    {
        if (value >= threshold)
        {
            OnThresholdReached(EventArgs.Empty);
        }
    }
}

// Subscribing to the event
Counter counter = new Counter();
counter.ThresholdReached += (sender, e) => Console.WriteLine("Threshold reached!");

// Triggering the event
counter.Increment(10, 5); // Output: "Threshold reached!"
```

> [!NOTE]
> Events that have no subscribers are never raised.

## Use events in inheritance

In scenarios where you want to share event functionality across multiple classes, you can declare events in a base class and allow derived classes to raise or handle them. This approach promotes code reuse and simplifies maintenance.

**Example: Declaring and raising events in a base class**

```csharp
public class BaseCounter
{
    public event EventHandler ThresholdReached;

    protected virtual void OnThresholdReached(EventArgs e)
    {
        ThresholdReached?.Invoke(this, e);
    }

    public void Increment(int value, int threshold)
    {
        if (value >= threshold)
        {
            OnThresholdReached(EventArgs.Empty);
        }
    }
}

public class AdvancedCounter : BaseCounter
{
    protected override void OnThresholdReached(EventArgs e)
    {
        Console.WriteLine("AdvancedCounter: Threshold reached!");
        base.OnThresholdReached(e);
    }
}

// Usage
AdvancedCounter counter = new AdvancedCounter();
counter.ThresholdReached += (sender, e) => Console.WriteLine("Subscriber: Threshold reached!");
counter.Increment(10, 5);
// Output:
// AdvancedCounter: Threshold reached!
// Subscriber: Threshold reached!
```

This example demonstrates how a derived class can override the base class's event-raising logic while still notifying subscribers.

## Best practices for declaring events

- **Encapsulation**: Use the `protected` access modifier for event-raising methods to ensure events are raised only within the declaring class or its derived classes.
- **Virtual methods**: Use `protected virtual` methods to allow derived classes to customize event-raising logic.
- **Event naming**: Use meaningful names for events to clearly indicate their purpose.

By understanding how to declare and use events in practical scenarios, you can build flexible and maintainable applications that respond effectively to user actions and system changes.