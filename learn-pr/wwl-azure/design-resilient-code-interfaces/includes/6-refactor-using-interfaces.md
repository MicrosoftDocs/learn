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

## Introducing Interfaces

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

## Refactoring the BorrowableBook Class

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

## Refactoring the Library Class

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

## Adding New Borrowable Items

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

## Testing the System

Here’s a program to demonstrate the refactored system:

```csharp
using System;

class Program
{
    static void Main()
    {
        // Create borrowable items
        IBorrowable book = new BorrowableBook("The Great Gatsby");
        IBorrowable dvd = new BorrowableDVD("Inception");

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
You have borrowed "The Great Gatsby".
"The Great Gatsby" is already borrowed.

You have borrowed the DVD "Inception".
The DVD "Inception" is already borrowed.
```

This refactored example demonstrates how interfaces reduce dependencies and improve modularity:
1. **Separation of Concerns**: The `IBorrowable` interface isolates borrowing behavior, ensuring the `Library` class doesn't depend on specific implementations.
2. **Improved Flexibility**: You can add new types of borrowable items (for example, DVDs) without modifying the `Library` class.
3. **Simplified Maintenance**: The system is easier to understand, test, and extend because responsibilities are clearly divided.
1. 