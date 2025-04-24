In C#, methods are used to perform actions, such as performing a calculation or retrieving information. Your applications use methods to achieve intended outcomes, and call the methods when specific conditions are met. Applications often automate processes by having one method call another, which could call third method, and so on. Since the conditions are known at compile time, the executable code implements predefined workflows in a predictable manner. For example, you might have a method that generates a monthly customer report when a button is clicked. When the code runs and the button is clicked, the method is called, and the report is generated. This scenario is an example of early binding, where the method to be called is determined at compile time. Early binding is great for many scenarios, because it makes the code easy to read and understand. You can see the flow of the program by following the method calls. The code is predictable, and you know exactly which method is called when the button is clicked.

However, there are times when you don't know which method to call until the program is running. For example, suppose you're working on an app that relies on runtime dependencies to decide which method is needed to analyze customer data. This scenario is an example of late binding, where the method to be called is determined at runtime. In this case, the method to be called may depend on an external resource user input, or the current state of the application.

In C#, delegates are used to implement late binding.

## What is a delegate?

A delegate is a .NET type that's derived from the `Delegate` class and used to encapsulate methods. By encapsulating methods and instantiating them as objects, delegates enable you to store methods in variables, pass them as arguments to other methods, and invoke them at a later time.

The signature of a delegate defines the parameters and return type of the methods that can be assigned to it. This means that you can create a delegate type that matches the signature of a method, and then assign any method with that signature to the delegate. This capability allows you to call the method through the delegate, even if you don't know which method it is at compile time.

The following example shows how to define a delegate type:

```csharp

public delegate int PerformCalculation(int x, int y);

```

This example defines a delegate named `PerformCalculation`. The `PerformCalculation` delegate is defined to represent methods that take two `int` parameters (x and y) and return an `int`. This delegate can be used to encapsulate methods that perform different calculations, such as addition, subtraction, multiplication, division, or more complex equations that use the two parameters.

For example, this delegate could be used to encapsulate the following methods:

```csharp

public class Calculator
{
    public int Add(int x, int y)
    {
        return x + y;
    }

    public int Subtract(int x, int y)
    {
        return x - y;
    }

    public int Multiply(int x, int y)
    {
        return x * y;
    }

    public int Divide(int x, int y)
    {
        if (y == 0)
            throw new DivideByZeroException();
        return x / y;
    }
}

```

This example defines a `Calculator` class that contains methods that match the signature of the `PerformCalculation` delegate. You can create instances of the delegate and assign them to different methods, allowing you to call the appropriate method at runtime based on your needs.

The following code shows how to use the `PerformCalculation` delegate:

```csharp

public class Program
{
    public static void Main()
    {
        Calculator calculator = new Calculator();

        // Create delegate instances
        PerformCalculation add = new PerformCalculation(calculator.Add);
        PerformCalculation subtract = new PerformCalculation(calculator.Subtract);
        PerformCalculation multiply = new PerformCalculation(calculator.Multiply);
        PerformCalculation divide = new PerformCalculation(calculator.Divide);

        // Call the methods using the delegates
        Console.WriteLine("Addition: " + add(5, 3)); // Output: 8
        Console.WriteLine("Subtraction: " + subtract(5, 3)); // Output: 2
        Console.WriteLine("Multiplication: " + multiply(5, 3)); // Output: 15
        Console.WriteLine("Division: " + divide(5, 3)); // Output: 1
    }
}

```

This example creates an instance of the `Calculator` class and assigns the methods to instances of the `PerformCalculation` delegate. The methods are then called using the delegate instances, allowing you to perform different calculations based on the delegate assigned.

## Delegate type characteristics

Delegates are reference types, which means that they're stored on the heap and can be passed around like any other object. When you create a delegate instance, you're creating an object that encapsulates a method. This encapsulation allows you to treat the delegate as a first-class object, just like any other object in C#. You can create instances of delegates, assign them to variables, and pass them as arguments to methods. The process is similar to how you work with other objects in C#, such as strings or lists.

Delegate types are sealed, they can't be derived from, and it isn't possible to derive custom classes from the `Delegate` class. Delegates are also immutable, meaning that once a delegate is created, you can't change the method it encapsulates. However, you can create new delegate instances that point to different methods. This immutability ensures that the delegate always points to the same method, which is important for maintaining the integrity of your code.

You call a delegate instance like a method, and it invokes the method it encapsulates.

Delegates have the following characteristics:

- Delegates enable you to pass methods as arguments to other methods.
- Delegates can be chained together, such as calling multiple methods on a single event.
- Delegates are type-safe, meaning that the compiler checks that a method signature matches the delegate signature at compile time.

> [!NOTE]
> Methods don't have to match the delegate type exactly. If the method signature is compatible, the compiler allows the method to be assigned to the delegate. This behavior is known as covariance and contravariance. Covariance allows you to use a more derived type than originally specified, while contravariance allows you to use a less derived type. This capability is useful when working with inheritance and polymorphism, as it allows you to create more flexible and reusable code. Variance is examined in separate unit of this module.

## Why use delegates?

Delegates offer several advantages over direct method calls and solve several important problems related to code flexibility, dynamic method invocation, and type safety.

Delegates provide many benefits, including the following items:

- Flexibility: Delegates allow you to pass different methods as parameters, enabling dynamic behavior based on runtime conditions. This flexibility is useful when the exact operation to be performed is determined at runtime.
- Extensibility: With delegates, you can easily extend the functionality by adding new operations without modifying the existing code. You can pass any method that matches the delegate signature.
- Decoupling: Delegates decouple the method invocation from the method definition, making the code more modular and easier to maintain.

Delegates are a powerful feature of C# that solve several common problems in programming. They provide a flexible and type-safe way to encapsulate methods, enabling dynamic method invocation, callback methods, and multicast invocation. By using delegates, you can write more reusable and maintainable code that can adapt to changing requirements.

### Dynamic method invocation

The ability to dynamically invoke methods at runtime is a powerful feature of delegates. Dynamic method invocation allows you to write more flexible and reusable code, as you can pass different methods as parameters without knowing their exact implementation at compile time.

Scenario: Imagine you have a list of customers and you need to sort them by different criteria, such as name, account type, or customer ID. Without delegates, you would need to write separate sorting methods for each criterion, leading to repetitive and less maintainable code.

Solution: Delegates allow you to pass methods as parameters, enabling dynamic method invocation. You can define a delegate that matches the signature of the sorting method and pass different comparison functions at runtime. This makes your code more flexible and reusable.

### Callback methods

The need for callback methods arises in scenarios where you want to perform an action after a certain operation is completed. The callback pattern is common in asynchronous programming, where you might want to notify the user or perform other actions once a long-running task is finished.

Scenario: In asynchronous programming, you often need to perform other actions once an operation is completed. Without delegates, you would have to tightly couple the asynchronous operation with the follow-up actions, reducing flexibility and making the code harder to maintain.

Solution: Delegates enable the implementation of callback methods, allowing you to specify the follow-up actions dynamically. This decouples the asynchronous operation from the callback logic, enhancing flexibility and maintainability.

### Type safety

Type safety is a crucial aspect of programming that ensures that the methods you're invoking match the expected signatures. This prevents runtime errors and makes your code more robust.

Scenario: When passing methods as parameters or storing them for later invocation, you need to ensure that the method signatures match. Without delegates, you would lack type safety, leading to potential runtime errors and less robust code.

Solution: Delegates provide type-safe method references, ensuring that the method signatures match the delegate signature. This prevents runtime errors and makes the code more robust.

### Multicast invocation

Multicast invocation is a feature of delegates that allows you to invoke multiple methods with a single delegate. This feature is useful in event handling scenarios where you want to notify multiple event subscribers about an occurrence.

Scenario: In event handling, you often need to notify multiple subscribers about an occurrence. Without delegates, you would have to manually manage the list of subscribers and invoke their methods, leading to complex and error-prone code.

Solution: Delegates support multicast invocation, allowing a single delegate to reference multiple methods. This simplifies event handling by automatically managing the list of subscribers and invoking their methods in sequence.

## Best practices for declaring delegates in C#

When adding delegates to a class, it's important to follow best practices to ensure your code is organized, readable, and maintainable. Here are some guidelines on where to define delegates:

### Define delegates at the top of a class file

It's common practice for developers to declare delegates at the top of a file, typically within the namespace but outside any class. This approach makes it easy to locate the delegate definitions and understand their purpose. It also allows you to define delegates that can be used by multiple classes within the same namespace.

The following code shows how to implement a delegate that's defined outside of a class:

```csharp

namespace MyNamespace

// Define the delegate outside the class
public delegate void MyDelegate(string message);

public class Publisher
{
    // Method that uses the delegate
    public void PublishMessage(MyDelegate del)
    {
        del("Hello from Publisher!");
    }
}

public class Subscriber
{
    public void Subscribe()
    {
        // Create an instance of the Publisher class
        Publisher publisher = new Publisher();

        // Create an instance of the delegate and pass a method to it
        MyDelegate del = new MyDelegate(PrintMessage);

        // Call the method of the Publisher class and pass the delegate
        publisher.PublishMessage(del);
    }

    // Method that matches the delegate signature
    public void PrintMessage(string message)
    {
        Console.WriteLine(message);
    }
}

```

### Define delegates within a class

If a delegate is specific to a class and not intended to be used outside of the class, you can define the delegate within the class. This encapsulates the delegate within the class, which is useful when the delegate is closely related to the class's functionality and isn't intended for use outside of that context. If the delegate is public, other classes within the same namespace can access the delegate using an instance of the class.

```csharp

namespace MyNamespace

public class Publisher
{
    // Define a public delegate
    public delegate void MyDelegate(string message);

    // Method that uses the delegate
    public void PublishMessage(MyDelegate del)
    {
        del("Hello from Publisher!");
    }
}

public class Subscriber
{
    public void Subscribe()
    {
        // Create an instance of the Publisher class
        Publisher publisher = new Publisher();

        // Create an instance of the delegate and pass a method to it
        Publisher.MyDelegate del = new Publisher.MyDelegate(PrintMessage);

        // Call the method of the Publisher class and pass the delegate
        publisher.PublishMessage(del);
    }

    // Method that matches the delegate signature
    public void PrintMessage(string message)
    {
        Console.WriteLine(message);
    }
}


```

## Key points

- Delegates are .NET types derived from the `Delegate` class that encapsulate methods.
- Delegates allow you to pass methods as parameters, store them in variables, and invoke them at runtime.
- Delegates are type-safe, meaning that the compiler checks that the method signatures match the delegate signature at compile time.
- Delegates can be used for dynamic method invocation, callback methods, type safety, and multicast invocation.
- Delegates are the foundation for event handling in C#.
- Delegates can be chained together, allowing multiple methods to be invoked with a single delegate.
- Delegates are typically defined outside of a class to enable access from other classes without needing to instantiate the class.
