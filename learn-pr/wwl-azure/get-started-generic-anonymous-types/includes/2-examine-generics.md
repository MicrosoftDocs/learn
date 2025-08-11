Imagine you have a box that can hold different items, like toys, books, or clothes. Instead of creating separate boxes for each type of item, you can use a single box with a label that specifies what it contains. Similar to how generics work in programming, they allow you to create a single class or method that can handle different types of data.

## Understand generics

Developers are enabled to define classes, methods, and interfaces with placeholders for data types by using generics. This placeholder behavior improves code reusability, ensures type safety by catching errors at compile time, and enhances performance by avoiding unnecessary type conversions.

- **Code reusability**: You can use the same code for different data types.

- **Type safety**: Errors related to incorrect data types are caught during compilation.

- **Performance**: Generics avoids unnecessary type conversions, making your code faster.

> [!NOTE]  
> Generics provides benefit when working with collections, such as lists or dictionaries, where the type of data stored can vary.

## How generics allow defining classes, methods, and interfaces with placeholders

Generics introduces type parameters, which act as placeholders for data types. For example, instead of creating a class that works only with integers, you can create a generic class that works with any type.

Here’s an example of a generic class:

```csharp
public class Box<T>
{
    public T Item { get; set; }

    public void AddItem(T item)
    {
        Item = item;
    }
}
```

In this example:

- `T` is the type parameter.

- You can create instances of `Box<T>` for different types, like `Box<int>` or `Box<string>`.

When you use generics, the compiler replaces the type parameter with the actual type during compilation, ensuring type safety and avoiding runtime errors.

> [!TIP]  
> Think of `T` as a "placeholder" for the type you want to use. It makes your code flexible and reusable.

## Create generic classes and methods

Generic classes and methods are commonly used with collections, such as `List<T>` and `Dictionary<TKey, TValue>`. These collections provide type-safe ways to store and manipulate data.

Using a generic list example:

```csharp
List<int> numbers = new List<int>();
numbers.Add(1);
numbers.Add(2);
numbers.Add(3);

foreach (int number in numbers)
{
    Console.WriteLine(number);
}
```

The generic list code demonstrates how to use a generic `List<int>` to store integers and iterate through them to print each number.

Creating a generic method example:

```csharp
public T GetFirstItem<T>(List<T> items)
{
    return items[0];
}

List<string> names = new List<string> {"Hannah", "Mario"};
string firstName = GetFirstItem(names);
Console.WriteLine(firstName);
```

This generic method retrieves the first item from a list of any type. For example, it gets the first name from a list of strings.

> [!TIP]  
> Use generics when you need to write reusable code that works with multiple data types while ensuring type safety.

Generics let you write flexible and reusable code using type parameters like `<T>`. They ensure type safety and simplify working with collections such as `List<T>` and `Dictionary<TKey, TValue>`. By learning generics, you can create adaptable and efficient code while avoiding common mistakes like forgetting to specify a type or using incompatible types.
