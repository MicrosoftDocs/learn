In the previous lesson, you learned about the challenges of tightly coupled code and how it violates the **Open/Closed Principle**. Now, let’s refactor the `Library` and `BorrowableBook` example to make the system more flexible and easier to maintain.

Here’s the original code that demonstrates the problem:

```csharp
public class BorrowableBook
{
    public string Title { get; set; }
    public bool IsAvailable { get; private set; } = true;

    public BorrowableBook(string title)
    {
        Title = title;
    }

    public void Borrow()
    {
        if (IsAvailable)
        {
            IsAvailable = false;
            Console.WriteLine($"You have borrowed \"{Title}\".");
        }
        else
        {
            Console.WriteLine($"\"{Title}\" is already borrowed.");
        }
    }
}

public class Library
{
    private BorrowableBook _book;

    public Library(BorrowableBook book)
    {
        _book = book;
    }

    public void BorrowBook()
    {
        if (_book.IsAvailable)
        {
            _book.Borrow();
        }
        else
        {
            Console.WriteLine("The book is not available.");
        }
    }
}
```

This design tightly couples the `Library` class to the `BorrowableBook` class, making it difficult to add new types of borrowable items (for example, DVDs) without modifying the `Library` class. To fix the tight coupling, we introduce an interface to decouple the borrowing behavior.

## Introducing interfaces

An interface sets a contract for behavior without detailing its implementation. Introducing an interface abstracts the borrowing functionality and increases the system's flexibility.

Here’s the `IBorrowable` interface:

```csharp
public interface IBorrowable
{
    bool IsAvailable { get; }
    void Borrow();
}
```

This interface introduces two members:
- **`IsAvailable`**: A property indicating if the item is available for borrowing.
- **`Borrow`**: A method to borrow the item.

By defining this interface, we decouple the borrowing behavior from any specific implementation.

## Refactoring the BorrowableBook class

Next, we update the `BorrowableBook` class to implement the `IBorrowable` interface:

```csharp
public class BorrowableBook : IBorrowable
{
    public string Title { get; set; }
    public bool IsAvailable { get; private set; } = true;

    public BorrowableBook(string title)
    {
        Title = title;
    }

    public void Borrow()
    {
        if (IsAvailable)
        {
            IsAvailable = false;
            Console.WriteLine($"You have borrowed \"{Title}\".");
        }
        else
        {
            Console.WriteLine($"\"{Title}\" is already borrowed.");
        }
    }
}
```

Now, the `BorrowableBook` class adheres to the `IBorrowable` interface, making it interchangeable with other classes that implement the same interface.

## Refactoring the Library class

We also update the `Library` class to depend on the `IBorrowable` interface instead of the concrete `BorrowableBook` class:

```csharp
public class Library
{
    private IBorrowable _item;

    public Library(IBorrowable item)
    {
        _item = item;
    }

    public void BorrowItem()
    {
        if (_item.IsAvailable)
        {
            _item.Borrow();
        }
        else
        {
            Console.WriteLine("The item is not available.");
        }
    }
}
```

Now, the `Library` class can work with any object that implements the `IBorrowable` interface, making it more flexible and easier to extend.

## Using Dependency Injection

Imagine you’re setting up a home entertainment system. Instead of permanently attaching a specific brand of speakers to your stereo, you use speaker "jacks" that can accept multiple types of compatible speaker plugs. This design allows you to easily replace or upgrade the speakers without having to change the entire stereo system.

In software, **Dependency Injection** works similarly. It allows a class to depend on an abstract interface rather than a specific implementation. Dependency Injection makes the system more flexible and easier to maintain because you can "plug in" different implementations without modifying the class itself.

The **constructor** in programming is like the technician connecting the speaker jacks during the setup of your stereo system. For the `Library` class, the constructor (`public Library(IBorrowable item)`) is where the dependency is provided. The constructor allows the `Library` class to work with any compatible implementation, such as `BorrowableBook` or `BorrowableDVD`, without needing to change its internal structure. Just as the speaker jack enables flexibility in choosing different speakers, the constructor facilitates flexibility in using various borrowable items.

Here’s how it works in code:

```csharp
public class Library
{
    private IBorrowable _item;

    public Library(IBorrowable item) // Dependency is injected here
    {
        _item = item;
    }

    public void BorrowItem()
    {
        if (_item.IsAvailable)
        {
            _item.Borrow();
        }
        else
        {
            Console.WriteLine("The item is not available.");
        }
    }
}
```

In this example:

- The **constructor** is where the "connection" (the `IBorrowable` dependency) is made, similar to how the speaker plug connects to the "jack."
- The `IBorrowable` interface acts like the "stereo jack," defining the standard connection point.
- The `BorrowableBook` and `BorrowableDVD` are like different types of stereo speakers with unique connectors that get connected to the "jack."

By using Dependency Injection, the `Library` class can work with any implementation of `IBorrowable`. This approach provides:

- **Flexibility**: You can easily switch or add new implementations without modifying the `Library` class.
- **Testability**: You can "plug in" mock implementations for testing purposes.
- **Maintainability**: The `Library` class doesn’t need to know the details of the specific implementation, making it easier to extend and maintain.

This design ensures that the `Library` class is no longer tightly coupled to specific implementations, making the system more modular and adaptable.

## Adding new borrowable items

With the interface in place, we can easily add new types of borrowable items without modifying the `Library` class. For example, here’s a `BorrowableDVD` class:

```csharp
public class BorrowableDVD : IBorrowable
{
    public string Title { get; set; }
    public bool IsAvailable { get; private set; } = true;

    public BorrowableDVD(string title)
    {
        Title = title;
    }

    public void Borrow()
    {
        if (IsAvailable)
        {
            IsAvailable = false;
            Console.WriteLine($"You have borrowed the DVD \"{Title}\".");
        }
        else
        {
            Console.WriteLine($"The DVD \"{Title}\" is already borrowed.");
        }
    }
}
```

The `BorrowableDVD` class implements the same `IBorrowable` interface, so it can be used seamlessly with the `Library` class.

## Testing the system

Here’s a program to demonstrate the refactored system:

```csharp
using System;

class Program
{
    static void Main()
    {
        // Create borrowable items
        IBorrowable book = new BorrowableBook("Adventure Works Cycles");
        IBorrowable dvd = new BorrowableDVD("Graphic Design Institute");

        // Create libraries
        Library bookLibrary = new Library(book);
        Library dvdLibrary = new Library(dvd);

        // Borrow items
        bookLibrary.BorrowItem();
        bookLibrary.BorrowItem(); // Try borrowing again

        Console.WriteLine();

        dvdLibrary.BorrowItem();
        dvdLibrary.BorrowItem(); // Try borrowing again
    }
}
```

The output demonstrates the flexibility of the refactored system:

```code
You have borrowed "Adventure Works Cycles".
"Adventure Works Cycles" is already borrowed.

You have borrowed the DVD "Graphic Design Institute".
The DVD "Graphic Design Institute" is already borrowed.
```

This refactored example demonstrates how interfaces reduce dependencies and improve modularity:

- **Separation of Concerns**: The `IBorrowable` interface isolates borrowing behavior, ensuring the `Library` class doesn't depend on specific implementations.
- **Improved Flexibility**: You can add new types of borrowable items (for example, DVDs) without modifying the `Library` class.
- **Simplified Maintenance**: The system is easier to understand, test, and extend because responsibilities are clearly divided.
