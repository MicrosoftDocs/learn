In C# programming, delegates provide a way to encapsulate methods and pass them as parameters, allowing for flexible and reusable code. However, traditional delegates can be cumbersome to work with because they require explicit definitions for each delegate type. If you need to create multiple delegate types for different method signatures, it can lead to a lot of boilerplate code and make the codebase harder to maintain.

Thankfully, the .NET framework provides a more flexible alternative to traditional delegates: strongly typed delegates. Strongly typed delegates simplify the process of working with delegates by allowing you to use generic types instead of defining custom delegate types for each method signature.

Strongly typed delegates enable you to create a single delegate type that can work with multiple method signatures.

The following strongly typed delegates are commonly used by C# developers:

- `Action`: Use `Action` when you need to perform an operation that does not return a value.
- `Func`: Use `Func` when you need to perform an operation that returns a value.
- `Predicate`: Use `Predicate` for methods that perform a test and return true or false.
- `Comparison`: Use `Comparison` for methods that compare two objects and return an integer indicating their relative order.
- `Converter`: Use `Converter` for methods that convert an object from one type to another.

This training focuses on the `Action` and `Func` delegates.

## Examine the `Action` and `Func` delegates

The `Action` and `Func` delegates are generic types that can be used to define methods with different signatures without the need for custom delegate types. These delegates offer the following benefits:

- Ease of use: With `Action` and `Func`, you can quickly create delegates without worrying about defining custom types. This makes your code more concise and easier to understand.
- Consistency: Using predefined delegate types ensures consistency across the codebase, as developers use the same delegate types for similar tasks.
- Improved readability: Code that uses `Action` and `Func` is generally more readable because the delegate types clearly indicate the number and types of parameters, as well as the return type.
- Enhanced maintainability: When the code is easier to read and consistent, it becomes easier to maintain and debug. Enhanced maintainability is important in large projects with multiple developers.

### Examine the `Action` delegate

An `Action` delegate represents a method that takes up to 16 parameters and does not return a value. It's used when you want to perform an operation but don't need to return a result.

The following code demonstrates how to define an `Action` delegate with no parameters, one parameter, and two parameters:

```csharp

Action action;
Action<int> actionWithOneParameter;
Action<int, string> actionWithTwoParameters;

```

In this code, `action` is a delegate that takes no parameters, `actionWithOneParameter` is a delegate that takes one integer parameter, and `actionWithTwoParameters` is a delegate that takes an integer and a string as parameters.

An `Action` delegate can be used to replace a custom delegate type that's used to perform a similar operation. This ability is useful when you want to pass methods as parameters or assign them to variables without defining a custom delegate. `Action` delegates can reduce the amount of boilerplate code and make the code more concise and easier to read.

Consider the following code that defines and implements a custom delegate type named `PrintMessageDelegate` to print a message:

```csharp

public delegate void PrintMessageDelegate(string message);

public class TestClass
{

    static void Main()
    {
        PrintMessageDelegate printMessage = PrintMessage;
        printMessage("Hello, World!"); // Output: Hello, World!
    }

    static void PrintMessage(string message)
    {
        Console.WriteLine(message);
    }
}

```

This code defines a `PrintMessage` method that takes a string parameter (`message`) and prints it to the console. The `PrintMessageDelegate` delegate type is defined to match the signature of the `PrintMessage` method. In the `Main` method, an instance of the `PrintMessageDelegate` is created and assigned to the `PrintMessage` method. When `printMessage("Hello, World!")` is called, it prints "Hello, World!" to the console.

Instead of defining a custom delegate type, you can use an `Action` delegate to achieve the same result with less code:

```csharp

public class TestClass
{
    static void Main()
    {
        Action<string> printMessage = delegate(string message)
        {
            Console.WriteLine(message);
        };
        printMessage("Hello, World!"); // Output: Hello, World!
    }
}

```

This code defines an `Action` delegate called `printMessage` that takes a single string parameter. The delegate is assigned an anonymous method that prints the message to the console. When `printMessage("Hello, World!")` is called, it prints "Hello, World!" to the console.

An `Action` delegate can also be used to perform operations on parameters. For example, you can use an `Action` delegate to reverse a string and print it to the console:

```csharp

static void Main()
{
    Action<string> reversePrint = delegate (string input)
    {
        char[] charArray = input.ToCharArray();
        for (int i = charArray.Length - 1; i >= 0; i--)
        {
        Console.Write(charArray[i]);
        }
        Console.WriteLine();
    };
    reversePrint("CSharp"); // Output: prahSC
}

```

This code defines an `Action` delegate called `reversePrint` that takes a single string parameter (`input`). The delegate is assigned an anonymous method that reverses the string and prints it to the console. When `reversePrint("CSharp")` is called, it prints "`prahSC`" to the console.

The previous two examples can be simplified using lambda expressions, which provide a more concise syntax for defining delegates. Lambda expressions are a powerful feature of C# that allows you to define anonymous methods in a more readable way.

```csharp

static void Main()
{
    Action<string> printMessage = (message) => Console.WriteLine(message);
    printMessage("Hello, World!"); // Output: Hello, World!
}

```

```csharp

class TestClass
{
    static void Main()
    {
        Action<string> reversePrint = input =>
        {
            char[] charArray = input.ToCharArray();
            Array.Reverse(charArray);
            Console.WriteLine(new string(charArray));
        };
        reversePrint("CSharp"); // Output: prahSC
    }
}

```

An `Action` delegate with no parameters can also be defined using a lambda expression. The following code demonstrates an `Action` delegate with no parameters:

```csharp

Action sayHello = () => Console.WriteLine("Hello, World!");
sayHello(); // Output: Hello, World!

```

This example declares an `Action` with no parameters. The lambda expression `() => Console.WriteLine("Hello, World!")` defines the method that the `Action` points to. When `sayHello()` is called, it prints "Hello, World!" to the console.

The following code demonstrates an `Action` delegate with two integer parameters:

```csharp

Action<int, int> printSum = (a, b) => Console.WriteLine($"Sum: {a + b}");
printSum(5, 7); // Output: Sum: 12

```

This code defines an `Action` delegate called `printSum` that takes two integer parameters (`a` and `b`). The delegate is assigned a lambda expression that calculates the sum of the two integers and prints the result. When `printSum(5, 7)` is called, it prints "Sum: 12" to the console.

### Examine the `Func` delegate

A `Func` delegate represents a method that takes up to 16 parameters and returns a value. A `Func` delegate is used when you need to perform an operation and get a result back. 

The syntax for defining a `Func` delegate is similar to that of an `Action` delegate, but the last type parameter specifies the return type. The first 16 type parameters specify input parameters. 

The following code demonstrates how to define a `Func` delegate with no parameters, one parameter, and two parameters:

```csharp

Func<int> funcWithNoParameters;
Func<int, string> funcWithOneParameter;
Func<int, string, bool> funcWithTwoParameters;

```

This code defines a `Func` delegate with no parameters (`funcWithNoParameters` returns an `int`), one parameter (`funcWithOneParameter` returns a `string`), and two parameters (`funcWithTwoParameters` returns a `bool`). The last type parameter specifies the return type of the delegate.

Consider the following code that defines and implements a custom delegate type named `CompareCustomers`. The `CompareCustomers` delegate takes two `Customer` objects as parameters and returns an integer indicating their relative order. The criteria used for comparison are defined using a lambda expression when the delegate is instantiated.

```csharp

public delegate int CompareCustomers(Customer c1, Customer c2);
public class TestClass
{
    static void Main()
    {
        Random random = new Random();
        List<Customer> customers = new List<Customer>();

        // Create 10 customers with random ages and IDs
        for (int i = 0; i < 10; i++)
        {
            string customerId = random.Next(10000000, 99999999).ToString();
            int age = random.Next(30, 51); // Random age between 30 and 50
            customers.Add(new Customer(customerId, age));
        }

        // Define the CompareCustomers delegate
        CompareCustomers compare = (c1, c2) => c2.Age.CompareTo(c1.Age);
        customers.Sort((c1, c2) => compare(c1, c2));

        // Print sorted customers
        foreach (var customer in customers)
        {
            Console.WriteLine($"ID: {customer.CustomerId}, Age: {customer.Age}");
        }
    }
}
public class Customer
{
    public string CustomerId { get; set; }
    public int Age { get; set; }

    public Customer(string custId, int age)
    {
        CustomerId = custId;
        Age = age;
    }
}

```

This code defines a `Customer` class with properties for `CustomerId` and `Age`. The `Main` method creates a list of 10 customers with random ages and IDs. A `CompareCustomers` delegate is defined at the top of the file and then instantiated using a lambda expression to define the sorting criteria. The lambda expression `(c1, c2) => c2.Age.CompareTo(c1.Age)` compares the `Age` properties of two `Customer` objects. The `CompareTo` method returns a positive number if `c2` is older than `c1`, a negative number if `c1` is older than `c2`, and zero if they're the same age. This means that the customers will be sorted in descending order based on their ages. The `customers.Sort` method is called with a lambda expression that uses the `compare` delegate to sort the customers based on their ages in descending order.

Using a delegate enables you to easily switch from sorting by `Age` to sorting by `CustomerId`. For example, the following lambda expression could be used to sort by `CustomerId`.

```csharp

CompareCustomers compare = (c1, c2) => string.Compare(c1.CustomerId, c2.CustomerId, StringComparison.Ordinal);

```

Instead of defining a custom delegate type, you can use an `Func` delegate to achieve the same result with less code:

```csharp
public class TestClass
{
    static void Main()
    {
        Random random = new Random();
        List<Customer> customers = new List<Customer>();

        // Create 10 customers with random ages and IDs
        for (int i = 0; i < 10; i++)
        {
            string customerId = random.Next(10000000, 99999999).ToString();
            int age = random.Next(30, 51); // Random age between 30 and 50
            customers.Add(new Customer(customerId, age));
        }

        // Define the Func delegate for comparison
        Func<Customer, Customer, int> compare = (c1, c2) => c2.Age.CompareTo(c1.Age);
        customers.Sort((c1, c2) => compare(c1, c2));

        // Print sorted customers
        foreach (var customer in customers)
        {
            Console.WriteLine($"ID: {customer.CustomerId}, Age: {customer.Age}");
        }
    }
}

public class Customer
{
    public string CustomerId { get; set; }
    public int Age { get; set; }

    public Customer(string custId, int age)
    {
        CustomerId = custId;
        Age = age;
    }
}

```

This code defines a `Func` delegate called `compare` that takes two `Customer` objects as parameters and returns an integer indicating their relative order. The delegate is assigned a lambda expression that compares the `Age` properties of the two `Customer` objects. The `customers.Sort` method is called with a lambda expression that uses the `compare` delegate to sort the customers based on their ages in descending order. When `customers.Sort` is called, it sorts the customers based on their ages in descending order. The sorted customers are then printed to the console.

To sort the customers by `CustomerId`, you can simply change the lambda expression assigned to the `compare` delegate:

```csharp

Func<Customer, Customer, int> compare = (c1, c2) => string.Compare(c1.CustomerId, c2.CustomerId, StringComparison.Ordinal);

```

## Key Points

- Strongly typed delegates, such as `Action` and `Func`, simplify the process of working with delegates by allowing you to use generic types instead of defining custom delegate types for each method signature.
- `Action` delegates are used for methods that don't return a value, while `Func` delegates are used for methods that return a value.
- Using `Action` and `Func` delegates reduces boilerplate code, improves readability, and enhances maintainability.
- Lambda expressions provide a concise syntax for defining delegates, making the code more readable and easier to understand.
- Strongly typed delegates can often be used to replace custom delegate types, making the code more concise and easier to read.
