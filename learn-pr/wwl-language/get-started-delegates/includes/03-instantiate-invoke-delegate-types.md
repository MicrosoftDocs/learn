Delegate types are implemented using the following process:

1. Declare the delegate: Define a delegate type with a specific signature, which includes the return type and parameters.
1. Instantiate the delegate: Create an instance of the delegate type, specifying the method to be called.
1. Invoke the delegate: Call the delegate instance, passing any required arguments.

Once a named delegate is declared, you can create instances of that delegate type and use them to call methods that match the delegate's signature. Each delegate instance can point to a different method, allowing for flexible and dynamic method invocation. In addition, delegates can be combined to create multicast delegates, which allow multiple methods to be invoked in a single call.

When a delegate is invoked, it calls the method(s) it points to, passing any arguments specified in the delegate's signature.

## Instantiate and invoke delegates

Delegates can be instantiated using named methods, method group conversion, anonymous methods, or lambda expressions. The choice of instantiation method depends on the specific use case and the desired level of readability and maintainability.

### Instantiate delegates with named methods

Named methods are defined with a specific name and can be reused. Using named methods is useful when you want to create a delegate instance that points to a specific method. Named methods are typically defined in a class or struct and can be static or instance methods.

```csharp

public delegate void Notify(string message);

public class Program
{
    public static void Main()
    {
        // Create an instance of the delegate using a named method
        Notify notify = new Notify(NotificationService.SendNotification);

        // Invoke the delegate
        notify("Hello, World!");
    }
}

public static class NotificationService
{
    // Method that matches the delegate's signature
    public static void SendNotification(string message)
    {
        Console.WriteLine("Notification sent: " + message);
    }
}

```

This example demonstrates how to create a delegate type `Notify` that takes a string parameter and returns void. The `SendNotification` method matches the delegate's signature, allowing it to be assigned to the delegate instance. When the delegate is invoked, it calls the `SendNotification` method with the provided message.

### Instantiate delegates with method group conversion

Method group conversion is a shorthand way to create a delegate instance by directly referencing a method without explicitly creating a delegate instance. Using method group conversion is useful when you want to create a delegate instance that points to a specific method without the need for an explicit delegate constructor. Method group conversion enables you to assign a method directly to a delegate type without explicitly creating a delegate instance. This ability is useful when the method signature matches the delegate's signature, as it allows for cleaner and more concise code.

```csharp

public delegate void Notify(string message);

public class Program
{
    public static void Main()
    {
        // Create an instance of the delegate using a method group conversion for a named method
        Notify notifyMethodGroup = NotificationService.SendNotification;

        // Invoke the delegate
        notifyMethodGroup("Hello from Method Group!");

    }
}

public static class NotificationService
{
    // Method that matches the delegate's signature
    public static void SendNotification(string message)
    {
        Console.WriteLine("Notification sent: " + message);
    }
}


```

This example demonstrates how to create a delegate instance using a method group conversion. The `SendNotification` method is assigned directly to the delegate instance `notifyMethodGroup`, allowing it to be invoked with a message. When the delegate is invoked, it calls the `SendNotification` method with the provided message.

### Instantiate delegates with anonymous methods

Anonymous methods allow you to define a method inline without explicitly naming it. This ability is useful for short-lived operations or when you want to define the behavior directly at the point of use. Anonymous methods can be used to create delegate instances without defining a separate method. Using anonymous methods allows for more concise code and can improve readability in certain scenarios.

```csharp

public delegate void Notify(string message);

public class Program
{
    public static void Main()
    {
        // Create an instance of the delegate using an anonymous method
        Notify notifyAnonymous = delegate (string message) { Console.WriteLine("Anonymous notification: " + message); };

        // Invoke the delegate
        notifyAnonymous("Hello from Anonymous Method!");

    }
}

```

This example demonstrates how to create a delegate instance using an anonymous method. The anonymous method `delegate (string message) { Console.WriteLine("Anonymous notification: " + message); }` defines the behavior of the delegate inline, allowing it to be invoked with a message. When the delegate is invoked, it executes the code defined in the anonymous method.

### Instantiate delegates with lambda expressions

Lambda expressions are a concise way to define anonymous methods. They allow you to create delegate instances without explicitly defining a method. This ability is useful for short-lived operations or when you want to define the behavior directly at the point of use.

```csharp

public delegate void Notify(string message);

public class Program
{
    public static void Main()
    {
        // Create an instance of the delegate using a lambda expression
        Notify notifyLambda = (message) => Console.WriteLine("Lambda notification: " + message);

        // Invoke the delegate
        notifyLambda("Hello from Lambda!");
    }
}

```

This example demonstrates how to create a delegate instance using a lambda expression. The lambda expression `(message) => Console.WriteLine("Lambda notification: " + message)` defines the behavior of the delegate inline, allowing it to be invoked with a message. When the delegate is invoked, it executes the code defined in the lambda expression.

## Invoke single and multicast delegates

Delegates can be invoked like regular methods. When a delegate is invoked, it calls the method(s) it points to, passing any arguments specified in the delegate's signature. The invocation of a delegate is similar to calling a method directly.

Delegates can be combined to create multicast delegates, which allow multiple methods to be invoked in a single call. The ability to multicast is useful when you want to perform multiple actions, such as notifying multiple event subscribers or executing multiple methods in a specific order.

Multiple objects can be assigned to one delegate instance by using the `+` operator. The multicast delegate contains a list of the assigned delegates. When the multicast delegate is called, it invokes the delegates in the list, in order. Only delegates of the same type can be combined.

The `-` operator can be used to remove a component delegate from a multicast delegate.

The following example demonstrates how to combine delegates using the `+` operator and remove a delegate using the `-` operator:

```csharp

using System;

namespace DelegateExamples;

// Define a custom delegate that has a string parameter and returns void.
delegate void CustomCallback(string s);

class TestClass
{
    // Define two methods that have the same signature as CustomCallback.
    static void Hello(string s)
    {
        Console.WriteLine($"  Hello, {s}!");
    }

    static void Goodbye(string s)
    {
        Console.WriteLine($"  Goodbye, {s}!");
    }

    static void Main()
    {
        // Declare instances of the custom delegate.
        CustomCallback hiDel, byeDel, multiDel, multiMinusHiDel;

        // Initialize the delegate object hiDel that references the
        // method Hello.
        hiDel = Hello;

        // Initialize the delegate object byeDel that references the
        // method Goodbye.
        byeDel = Goodbye;

        // The two delegates, hiDel and byeDel, are combined to
        // form multiDel.
        multiDel = hiDel + byeDel;

        // Remove hiDel from the multicast delegate, leaving byeDel,
        // which calls only the method Goodbye.
        multiMinusHiDel = (multiDel - hiDel)!;

        Console.WriteLine("Invoking delegate hiDel:");
        hiDel("Elize Harmsen");

        Console.WriteLine("Invoking delegate byeDel:");
        byeDel("Mattia Trentini");

        Console.WriteLine("Invoking delegate multiDel:");
        multiDel("Peter Zammit");

        Console.WriteLine("Invoking delegate multiMinusHiDel:");
        multiMinusHiDel("Lennart Kangur");
    }
}

/* Output:
Invoking delegate hiDel:
  Hello, Elize Harmsen!
Invoking delegate byeDel:
  Goodbye, Mattia Trentini!
Invoking delegate multiDel:
  Hello, Peter Zammit!
  Goodbye, Peter Zammit!
Invoking delegate multiMinusHiDel:
  Goodbye, Lennart Kangur!
*/

```

This example demonstrates how to create a multicast delegate by combining two delegates (`hiDel` and `byeDel`) using the `+` operator. The combined delegate (`multiDel`) invokes both methods when called. The `-` operator is used to remove one of the delegates from the multicast delegate, leaving only the other delegate to be invoked.

The output shows the results of invoking each delegate, demonstrating how the multicast delegate works.

## Common scenarios for using delegates

Delegates are versatile and can be used in various scenarios to enhance code flexibility and maintainability. They're useful in situations where you need to pass methods as parameters, implement callback mechanisms, or create event handlers.

Here are some common scenarios where delegates are used:

- Sorting and filtering: Delegates can be used to pass comparison functions to sorting and filtering methods. This process allows you to dynamically specify the criteria for sorting or filtering a collection of objects. For example, sorting a list of bank customers by different criteria like name, account balance, or customer ID.

- Callback methods: Delegates are often used to implement callback methods. This capability is useful in scenarios where a method needs to call another method once a certain operation is completed. For instance, you might use a delegate to notify the completion of a data processing task.

- Asynchronous programming: Delegates are used to invoke asynchronous methods. This capability is useful for performing tasks that might take a long time to complete, such as file I/O operations or network requests. Delegates enable you to specify the method to be called once the asynchronous operation is finished.

- Event handling: Delegates are the foundation for events in C#. They allow you to define event handlers that can be invoked when an event occurs. For example, in a banking application, you might use delegates to notify customers when a transaction is completed.

- Implementing design patterns: Delegates are used in various design patterns, such as the Strategy pattern, where you can dynamically change the behavior of a method at runtime by passing different delegate implementations.

> [!NOTE]
> The event handling scenario is covered in a separate module along with an introduction to using events in C# apps.

## Key Points

- Delegate instances can be created using named methods, method group conversion, anonymous methods, or lambda expressions.
- Delegates can be invoked like regular methods and can be combined to create multicast delegates.
- Delegates are used in various scenarios including sorting and filtering, callback methods, asynchronous programming, event handling, and implementing design patterns.
