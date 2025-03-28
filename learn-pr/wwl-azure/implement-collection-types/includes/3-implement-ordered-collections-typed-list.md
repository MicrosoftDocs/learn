Ordered collections in C#, such as the `List<T>` class, perform common operations like adding, removing, and iterating through items. An example where `List<T>` is managing a list of students or books.

## Use `List<T>` for managing ordered collections

`List<T>` is a generic collection designed for scenarios where you need to store and manage an ordered sequence of elements of a specific type (`T`). It provides type safety, better performance, and flexibility compared to non-generic collections like `ArrayList`, eliminating the need for type casting when accessing elements.

> [!NOTE]
> The `<T>` in `List<T>` is a placeholder for the type of elements the list stores. For example, `List<string>` defines a list of strings, while `List<int>` defines a list of integers. You specify the type when declaring the list.

- Use `List<T>` when you need:
  - Indexed access to elements.
  - Dynamic resizing of the collection.
  - Efficient enumeration using `foreach` loops.
- Avoid using `List<T>` in public APIs; instead, consider more specialized collection types for better abstraction and flexibility.

> [!NOTE]
> `List<T>` automatically expands its capacity when needed, but this expansion can affect performance. To optimize, set an initial capacity based on the estimated size of the collection.

## Add, remove, and iterate through items in a `List<T>`

`List<T>` provides methods for adding, removing, and iterating through items efficiently. These operations are straightforward and commonly used in application development.

- **Adding items:**  To append elements to the list, use the `Add` method.
- **Removing items:** To delete elements, use methods like `Remove`, `RemoveAt`, or `Clear`.
- **Iterating through items:** For enumeration, use a `foreach` loop or LINQ (Language Integrated Query).

```csharp
// Example: Adding, removing, and iterating through a List<T>

// Define the type T as string for this list
List<string> books = new List<string>(); // T is string
books.Add("Book A"); // Add a string to the list
books.Add("Book B");
books.Add("Book C");
books.Remove("Book A"); // Remove a specific string from the list

foreach (string book in books) // Iterate through the list
{
    Console.WriteLine(book);
}

// Expected output:
// Book B
// Book C
```

This example demonstrates how to add items to a `List<T>` while preserving existing elements, remove items from specific locations in the list, and iterate through the list to display its contents.

> [!TIP]
> LINQ queries can simplify filtering, ordering, and grouping operations on `List<T>`.

## Manage a list of students or books by using `List<T>`

`List<T>` is ideal for managing collections of objects, such as students or books. You can define a custom class for the items and apply `List<T>` to store and manipulate them.

```csharp
// Example: Managing a list of students
public class Student
{
    public string Name { get; set; }
    public int Age { get; set; }
}

List<Student> students = new List<Student>
{
    new Student { Name = "Haneul", Age = 20 },
    new Student { Name = "Magda", Age = 22 }
};

students.Add(new Student { Name = "Dale", Age = 23 });
students.RemoveAt(0); // Remove Haneul

foreach (Student student in students)
{
    Console.WriteLine($"Name: {student.Name}, Age: {student.Age}");
}

// Expected output:
// Name: Magda, Age: 22
// Name: Dale, Age: 23
```

> [!NOTE]
> For dynamic data binding in UI applications, consider using `ObservableCollection<T>` instead of `List<T>` to automatically update the UI when the collection changes.

`List` in C# is used for managing ordered collections, offering type safety, dynamic resizing, and efficient enumeration, with operations like adding, removing, and iterating through items.
