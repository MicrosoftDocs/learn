A class can specify how accessible each of its members is to code outside of the class. Methods and variables that aren't intended to be used from outside of the class or assembly can be hidden to limit the potential for coding errors or malicious exploits.

Some methods and properties are meant to be called or accessed from code outside a class, known as client code. Other methods and properties might be only for use in the class itself. It's important to limit the accessibility of your code so that only the intended client code can reach it. You specify how accessible your types and their members are to client code by using the following access modifiers:

- `public`: The type or member is accessible by any other code in the same assembly or another assembly that references it.
- `protected`: The type or member is only accessible by code in the same class or a derived class.
- `internal`: The type or member is accessible by any code in the same assembly, but not from another assembly.
- `protected internal`: The type or member is accessible by any code in the same assembly, or by any derived class in another assembly.
- `private`: The type or member is only accessible by code in the same class or struct.
- `private protected`: The type or member is only accessible by code in the same assembly, and only by code in the same class or a derived class.

Class members are assigned `private` access by default.

## Access modifiers on properties and accessors

Up to this point in the module, we focused on properties that include both `get` and `set` accessors. These properties are referred to as read-write properties. In addition to read-write properties, you can create read-only properties, or give different accessibility to the `set` and `get` accessors.

By default, `get` and `set` accessors have the same accessibility level as the property to which they belong. However, you can restrict the accessibility of either the `get` or `set` accessor. Access modifiers are useful when you want to restrict access to the property itself, but still allow access to the property's value through a `get` accessor.

Suppose you have a `Person` class that should only enable changing the value of the `FirstName` property from other methods in the class. You could give the `set` accessor private accessibility instead of internal or public:

```csharp

public class Person
{
    public string? FirstName { get; private set; }

    // Omitted for brevity.
}

```

The `FirstName` property can be read from any code, but it can only be assigned from code in the `Person` class.

You can add any restrictive access modifier to either the `set` or `get` accessors. An access modifier on an individual accessor must be more restrictive than the access of the property. The preceding code is legal because the `FirstName` property is `public`, but the `set` accessor is `private`. You couldn't declare a `private` property with a `public` accessor. Property declarations can also be declared `protected`, `internal`, `protected internal`, or, even `private`.

There are two special access modifiers for `set` accessors:

- A `set` accessor can have `init` as its access modifier. That `set` accessor can be called only from an object initializer or the type's constructors. It's more restrictive than `private` on the `set` accessor.
- An automatically implemented property can declare a `get` accessor without a `set` accessor. In that case, the compiler allows the `set` accessor to be called only from the type's constructors. It's more restrictive than the `init` accessor on the `set` accessor.

Consider the following updates to the Person class:

```csharp

public class Person
{
    public Person(string firstName) => FirstName = firstName;

    public string FirstName { get; }

    // Omitted for brevity.
}

```

The preceding example requires callers to use the constructor that includes the `FirstName` parameter. Callers can't use object initializers to assign a value to the property. To support initializers, you can make the `set` accessor an `init` accessor, as shown in the following code:

```csharp

public class Person
{
    public Person() { }
    public Person(string firstName) => FirstName = firstName;

    public string? FirstName { get; init; }

    // Omitted for brevity.
}

```

These modifiers are often used with the `required` modifier to force proper initialization.

## Restrict accessor accessibility

In some cases, it's useful to restrict access to either the `get` or `set` accessor. Typically, you restrict the accessibility of the `set` accessor, while keeping the `get` accessor publicly accessible.

For example:

```csharp

private string _name = "Hello";

public string Name
{
    get
    {
        return _name;
    }
    protected set
    {
        _name = value;
    }
}

```

In this example, a property called `Name` defines a `get` and `set` accessor. The `get` accessor receives the accessibility level of the property itself, `public` in this case, while the `set` accessor is explicitly restricted by applying the `protected` access modifier to the accessor itself.

### Restrictions on access modifiers on accessors

Using the accessor modifiers on properties or indexers is subject to these conditions:

- You can use accessor modifiers only if the property has both `set` and `get` accessors. In this case, the modifier is permitted on only one of the two accessors.
- The accessibility level on the accessor must be more restrictive than the accessibility level on the property or indexer itself.

### Read-only static properties

The following example demonstrates the use of instance and static properties in a class.

The `Employee` class has a static property named `Counter` that tracks the number of class instances created. The `Counter` property is read-only, meaning that it can be accessed from outside the class but not modified. The `Counter` property is also `static`, meaning that you access the `Counter` value using the `Employee` class, not the `employee1` or `employee2` instances of the class.

```csharp

public class Employee
{
    public static int NumberOfEmployees;
    private static int _counter;
    private string _name;

    // A read-write instance property:
    public string Name
    {
        get => _name;
        set => _name = value;
    }

    // A read-only static property:
    public static int Counter => _counter;

    // A Constructor:
    public Employee() => _counter = ++NumberOfEmployees; // Calculate the employee's number:
}

public class Program
{
    static void Main(string[] args)
    {
        // Create an initial instance of the Employee class
        Employee employee1 = new Employee { Name = "NameOne" };
        
        // Display the name and counter values
        Console.WriteLine($"Employee 1: Name = {employee1.Name}, Counter = {Employee.Counter}");

        // Create a second instance of the Employee class
        Employee employee2 = new Employee { Name = "NameTwo" };

        // Display the name and counter values
        Console.WriteLine($"Employee 2: Name = {employee2.Name}, Counter = {Employee.Counter}");

        employee2.Name = "NameThree";

        // Display the name and counter values
        Console.WriteLine($"Employee 2: Name = {employee2.Name}, Counter = {Employee.Counter}");

        // Keep the console window open in debug mode.
        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}

```

The `Employee` class has the following members:

- `NumberOfEmployees`: A public static field that keeps track of the total number of Employee instances created. Being static, it's shared among all instances of the Employee class.
- `_counter`: A private static field that is used to assign a unique number to each Employee instance. It's also shared among all instances.
- `_name`: A private instance field that stores the name of the employee. It's specific to each instance of the Employee class.
- `Name`: A public read-write instance property that provides access to the _name field. The `get` accessor returns the value of `_name`, and the `set` accessor assigns a new value to `_name`.
- `Counter`: A public read-only static property that provides access to the `_counter` field. The `get` accessor returns the value of `_counter`. The `Counter` property is associated with the class rather than the objects because it's defined as a static property.

The two static fields are initialized when the class is first loaded into memory, before any instances of the class are created. In C#, static fields are initialized to their default values if not explicitly initialized. For `int` fields, the default value is 0.

Static properties and fields belong to the class itself, not to any particular instance of the class. All instances of the class share the same static properties and fields.

The constructor increments the `NumberOfEmployees` static field by 1 and assigns the new value to the `_counter` static field. This approach ensures that each `Employee` instance gets a unique number.

### Private accessors

Consider the following code that implements read-write properties:

```csharp

class Person
{
    private string _name = "N/A";
    private int _age = 0;

    // Declare a Name property of type string:
    public string Name
    {
        get
        {
            return _name;
        }
        set
        {
            _name = value;
        }
    }

    // Declare an Age property of type int:
    public int Age
    {
        get
        {
            return _age;
        }
        set
        {
            _age = value;
        }
    }
}

class TestPerson
{
    static void Main()
    {
        // Create a new Person object:
        Person person = new Person();

        // Print out the name and the age associated with the person:
        Console.WriteLine($"Person details - Name = {person.Name}, Age = {person.Age}");

        // Set some values on the person object:
        person.Name = "NameOne";
        person.Age = 99;
        Console.WriteLine($"Person details - Name = {person.Name}, Age = {person.Age}");

        // Increment the Age property:
        person.Age += 1;
        Console.WriteLine($"Person details - Name = {person.Name}, Age = {person.Age}");

        // Keep the console window open in debug mode.
        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}

/* Output:
Person details - Name = N/A, Age = 0
Person details - Name = NameOne, Age = 99
Person details - Name = NameOne, Age = 100
*/

```

In this example, the `Person` class includes `Name` and `Age` properties. The properties are public and they both include `get` and `set` accessors. Public accessors allow any object to read and write these properties.

Sometimes it's to exclude one of the accessors. You can omit the `set` accessor to make the property read-only:

```csharp

public string Name
{
    get
    {
        return _name;
    }
}


```

Alternatively, you can expose one accessor publicly but make the other private or protected.

```csharp

public string Name
{
    get
    {
        return _name;
    }
    private set
    {
        _name = value;
    }
}

```
