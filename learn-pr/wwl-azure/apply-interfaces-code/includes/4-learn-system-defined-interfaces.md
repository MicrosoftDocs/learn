Integration of system defined interfaces into C# applications is useful in many practical coding scenarios. System-defined interfaces in C#, allow you to apply predefined functionalities, making your applications consistent and stable.

## Common interfaces used in methods

Several common interfaces are frequently used in C# methods within the .NET framework. These interfaces provide standard functionalities implemented by various classes.

- `IComparable`: Used for comparing objects.
- `IEnumerable`: Used for iterating over collections.
- `IDisposable`: Used for releasing unmanaged resources.
- `IEquatable`: Used for defining equality comparisons.

## Implement system defined interfaces

To implement a system-defined interface member, the corresponding member of the implementing class must be public, not `static`, and have the same name and signature as the interface member. A class or struct that implements an interface must provide an implementation for all declared members without a default implementation provided by the interface.

System-defined interfaces in .NET often use a placeholder `T` to represent any type. For example, the `IEquatable` interface is defined in the .NET framework as follows:

```csharp
public interface IEquatable
{
    bool Equals(T other);
}
```

When you implement this interface in a class, you replace `T` with the type of the class.

For example, the following `Car` class implements the `IEquatable` interface:

```csharp
public class Car : IEquatable
{
    public string Make { get; set; }
    public string Model { get; set; }

    public bool Equals(Car other)
    {
        if (other == null) return false;
        return this.Make == other.Make && this.Model == other.Model;
    }
}
```

In this example, `Car` replaces `T` in `IEquatable`, making it `IEquatable`. The `Car` class provides its own implementation of the `Equals` method, which checks if the `Make` and `Model` properties of the current `Car` object are equal to the properties of the `other` `Car` object.

Properties and indexers of a class can define extra accessors for a property or indexer defined in an interface. For example, an interface might declare a property that has a `get` accessor. The class that implements the interface can declare the same property with both a `get` and `set` accessor. Here's an example:

```csharp
public interface IExampleInterface
{
    string Name { get; }
}

public class ExampleClass : IExampleInterface
{
    public string Name { get; set; }
}
```

In this example, `IExampleInterface` declares a property `Name` with a `get` accessor. `ExampleClass` implements the interface and declares the same property with both a `get` and `set` accessor.

## Use of common system defined interfaces

Common system-defined interfaces such as `IEnumerable`, `IDisposable`, and `IComparable` are frequently used in .NET applications. These interfaces provide standard methods that can be implemented to ensure consistent behavior across different types.

### IEnumerable

The `IEnumerable` interface is used to define a collection that can be enumerated. It contains a single method, `GetEnumerator`, which returns an enumerator that iterates through the collection.

```csharp
public class MyCollection : IEnumerable
{
    private int[] _items = { 1, 2, 3, 4, 5 };

    public IEnumerator GetEnumerator()
    {
        for (int i = 0; i < _items.Length; i++)
        {
            yield return _items[i];
        }
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }
}
```

### IDisposable

The `IDisposable` interface is used to release unmanaged resources. Unmanaged resources are resources that aren't handled with the .NET runtime, such as file handles, network connections, etc. It's important to release these resources after use to prevent memory leaks and other issues. It contains a single method, `Dispose`, which is called to free resources.

```csharp
public class ResourceHolder : IDisposable
{
    private bool _disposed = false;

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this); // Prevents the garbage collector from calling the finalizer if Dispose has already been called.
    }

    protected virtual void Dispose(bool disposing)
    {
        if (!_disposed)
        {
            if (disposing)
            {
                // Free managed resources
            }
            // Free unmanaged resources
            _disposed = true;
        }
    }

    ~ResourceHolder()
    {
        Dispose(false);
    }
}
```

### IComparable

The `IComparable` interface is used to define a method for comparing instances of a class. It contains a single method, `CompareTo`, which compares the current instance with another object of the same type.

```csharp
public class Person : IComparable
{
    public string Name { get; set; }
    public int Age { get; set; }

    public int CompareTo(Person other)
    {
        if (other == null) return 1; // If 'other' is null, this instance is considered greater
        return this.Age.CompareTo(other.Age); // Returns negative value if  precedes 'other', 0 if same position, or postive value if follows 'other'.
    }
}
```

In this example, if `other` is null, we return 1, indicating that the current instance is considered greater than a null reference.

System-defined interfaces in C# play a crucial role in creating efficient, stable, and consistent applications. They provide standard methods that can be implemented across different types, ensuring uniformity and predictability in behavior. By understanding and effectively implementing these interfaces, you can use predefined functionalities and reduce the amount of repetitive code, making your applications more maintainable and robust.
