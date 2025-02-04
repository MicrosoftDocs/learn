In addition to class properties and methods, class definitions include constructors that are used to initialize new objects (class instances).

## Class constructors

A class constructor is a method with the same name as its type (constructor methods use the same name as the class).

There are two types of class constructors:

- Instance constructors. Instance constructors are used to create and initialize any instance field variables when an object is created.
- Static constructors. Static constructors are used to initialize any static data, or to perform a particular action that needs to be performed only once. Static constructors are called automatically before the first instance is created or any static members are referenced.

Class constructors are instance constructors by default.

### Instance constructor syntax

An instance constructor is declared using the same name as the class and doesn't include a return type. The constructor's method signature can include an optional access modifier, the method name, and its parameter list. A constructor's method signatures doesn't include a return type.

The following example shows a simple constructor for a class named `Person`:

```csharp

public class Person
{
    public Person()
    {
        // Field initialization and constructor logic goes here.

    }

    // Remaining implementation of Person class.
}

```

Classes can have more than one constructor. When a class has more than one constructor, the constructors usually take different arguments.

The following example shows a class named `Person` with two constructors.

```csharp

public class Person
{

    public Person()
    {
        // Field initialization and constructor logic goes here.
        string name = "John Doe";
        Console.WriteLine($"Person created: {name}");

    }

    public Person(string fName, string lName)
    {
        string name = fName + " " + lName;

        Console.WriteLine($"Person created: {name}");
   }

   // Remaining implementation of Person class.
}

```

## Instantiate objects using class constructors

When an object is instantiated using the `new` keyword, the .NET runtime calls the associated instance constructor in the class definition, and allocates memory for the object.

In the following code snippet, the `Person` class defines a simple instance constructor. The `Program` class includes a `Main` method that uses the `new` operator to create an instance of `Person` named `person1`. The runtime invokes the `Person` constructor immediately after memory is allocated for the new object.

```csharp

public class Person
{
    public Person()
    {
        // Field initialization and constructor logic goes here.

    }
}

static class Program
{
    // the Main method is the entry point of the program.
    static void Main()
    {
        Person person1 = new Person();
    }
}

```

### Constructors with and without parameters

A constructor that takes no parameters is called a parameterless constructor. The runtime invokes the parameterless constructor when an object is instantiated using the `new` operator and no arguments are provided to the constructor.

> [!NOTE]
> Unless the class is static, classes without constructors are given a public parameterless constructor by the C# compiler in order to enable class instantiation.

Classes often define constructors that take parameters. Constructors that take parameters must be called using the `new` operator or a base statement. Classes can also define multiple constructors.

The following code snippet shows a class named `Person` with three constructors:

```csharp

public class Person
{

    public Person()
    {
        // Field initialization and constructor logic goes here.

        Console.WriteLine("An instance of the Person class is being instantiated without name or age parameters.");
    }

    public Person(string name)
    {
        // Field initialization and constructor logic goes here.

        Console.WriteLine($"An instance of the Person class is being instantiated using a name ({name}) parameter.");
    }

    public Person(string name, int age)
    {
        // Field initialization and constructor logic goes here.

        Console.WriteLine($"An instance of the Person class is being instantiated using name ({name}) and age ({age}) parameters.");
    }
}

static class Program
{
    // the Main method is the entry point of the program.
    static void Main()
    {
        Person person1 = new Person();
        Person person2 = new Person("Jane Doe");
        Person person3 = new Person("John Doe", 30);
    }
}

```

### Classes with no constructors

If a class has no explicit instance constructors, C# provides a parameterless constructor that you can use to instantiate an instance of that class, as the following example shows:

``` csharp

public class Person
{
    public int age;
    public string name = "unknown";
}

class Example
{
    static void Main()
    {
        var person = new Person();
        Console.WriteLine($"Name: {person.name}, Age: {person.age}");
        // Output:  Name: unknown, Age: 0
    }
}

```

This constructor initializes instance fields and properties according to the corresponding initializers. If a field or property has no initializer, its value is set to the default value of the field's or property's type. If you declare at least one instance constructor in a class, C# doesn't provide a parameterless constructor.

### Initialize class data using constructor parameters

The parameters passed to a constructor are local to the constructor. Parameters are often used to initialize the data fields of a class.

The following code snippet shows a class named `Person` with constructors that initialize the `personName` and `personAge` fields:

```csharp

public class Person
{
    public string personName;
    public string personAge;

    public Person()
    {
        // Field initialization and constructor logic goes here.
        personName = "unknown";
        personAge = "unknown";
    }

    public Person(string name)
    {
        // Field initialization and constructor logic goes here.
        personName = name;
        personAge = "unknown";
    }

    public Person(string name, int age)
    {
        // Field initialization and constructor logic goes here.
        personName = name;
        personAge = age.ToString();
    }
}

static class Program
{
    // the Main method is the entry point of the program.
    static void Main()
    {
        Person person1 = new Person();
        Person person2 = new Person("Jane Doe");
        Person person3 = new Person("John Doe", 30);

        Console.WriteLine($"Person 1 Name: {person1.personName} Age: {person1.personAge}");
        Console.WriteLine($"Person 2 Name: {person2.personName} Age: {person2.personAge}");
        Console.WriteLine($"Person 3 Name: {person3.personName} Age: {person3.personAge}");
    }
}

```

In the preceding example, the `Person` class is defined with three constructors. The first constructor initializes the `personName` and `personAge` fields to `"unknown"`. The second constructor initializes the `personName` field to the value passed in the `name` parameter and the `personAge` field to `"unknown"`. The third constructor initializes the `personName` and `personAge` fields to the values passed in the `name` and `age` parameters, respectively.

Since the fields are public, they can be accessed directly from the `Main` method. When the code runs, the following output is generated:

```plaintext

Person 1 Name: unknown Age: unknown
Person 2 Name: Jane Doe Age: unknown
Person 3 Name: John Doe Age: 30

```

### Expression body definitions

If a constructor can be implemented as a single statement, you can use an *expression body definition* to assign a parameter to a class member when the constructor is implemented.

For example, the following constructor initializes the `modelName` field with the value passed to the `model` parameter:

```csharp

public class Car
{
    public string modelName;

    public Car(string model) => modelName = model;
    
}

```

The `Car` class has a single public field, `modelName`, which is of type `string`. The `modelName` field is intended to store the name of the car model.

The `Car` class also includes a constructor that takes a single string parameter named `model`. The constructor uses an expression body definition (denoted by the `=>` syntax) to initialize the `modelName` field with the value passed to the `model` parameter. This means that when a new `Car` object is instantiated, the `modelName` field is set to the value provided as an argument to the constructor.

As the term *expression* implies, the right side of the `=>` operator is an expression and isn't limited to a simple assignment statement. The expression can be any valid C# expression that returns a value.

The following code snippet demonstrates how to implement an expression body definition that performs a simple calculation:

```csharp

public class Employee
{
    public int Salary;

    public Employee() { }

    public Employee(int annualSalary) => Salary = annualSalary;

    public Employee(int weeklySalary, int numberOfWeeks) => Salary = weeklySalary * numberOfWeeks;
}

```

This class can be created by using either of the following statements:

```csharp

Employee e1 = new Employee(30000);
Employee e2 = new Employee(500, 52);

```

## Static constructors

A static constructor is used to initialize any static data, or to perform a particular action that needs to be performed only once. It's called automatically before the first instance is created or any static members are referenced. A static constructor is called at most once.

The following code snippet shows an updated version of the `Person` class that implements static fields and a static constructor:

```csharp

public class Person
{
    public string personName;
    public string personAge;

    // Static field
    public static string defaultName;
    public static string defaultAge;

    // Static constructor
    static Person()
    {
        // Static field initialization
        defaultName = "unknown";
        defaultAge = "unknown";
    }

    public Person()
    {
        // Field initialization and constructor logic goes here.
        personName = defaultName;
        personAge = defaultAge;
    }

    public Person(string name)
    {
        // Field initialization and constructor logic goes here.
        personName = name;
        personAge = defaultAge;
    }

    public Person(string name, int age)
    {
        // Field initialization and constructor logic goes here.
        personName = name;
        personAge = age.ToString();
    }
}

```

The updated `Person` class has two instance fields, `personName` and `personAge`, both of which are of type `string`. These fields store the name and age of a person, respectively.

The class also defines two static fields, `defaultName` and `defaultAge`, also of type `string`. Static fields are shared among all instances of the class and are initialized only once. In this case, the static fields are used to provide default values for the `personName` and `personAge` fields.

The static constructor `static Person()` is responsible for initializing the static fields. It sets `defaultName` to "unknown" and `defaultAge` to `"unknown"`. The static constructor is called automatically before any instances of the class are created or any static members are accessed.

The `Person` class includes three instance constructors:

The parameterless constructor `public Person()` initializes the `personName` and `personAge` fields with the values of the static fields `defaultName` and `defaultAge`. This means that if no arguments are provided when creating a `Person` object, the default values "unknown" is used for both the name and age.

The constructor `public Person(string name)` takes a single parameter, `name`, and initializes the `personName` field with this value. The `personAge` field is initialized with the value of the static field `defaultAge`. This constructor allows for the creation of a `Person` object with a specified name while using the default age.

The constructor `public Person(string name, int age)` takes two parameters, `name` and `age`. It initializes the `personName` field with the value of the `name` parameter and the `personAge` field with the string representation of the age parameter. This constructor allows for the creation of a `Person` object with both a specified `name` and `age`.

### Properties of static constructors

Static constructors have the following properties:

- A static constructor doesn't take access modifiers or have parameters.

- A class can only have one static constructor.

- Static constructors can't be inherited or overloaded.

- A static constructor can't be called directly and is only meant to be called by the common language runtime (CLR). It's invoked automatically.

- The user has no control on when the static constructor is executed in the program.

- A static constructor is called automatically. It initializes the class before the first instance is created or any static members declared in that class (not its base classes) are referenced. A static constructor runs before an instance constructor. If static field variable initializers are present in the class of the static constructor, they run in the textual order in which they appear in the class declaration. The initializers run immediately before the static constructor.

- If you don't provide a static constructor to initialize static fields, all static fields are initialized to their default value.

- If a static constructor throws an exception, the runtime doesn't invoke it a second time, and the type remains uninitialized for the lifetime of the application domain. Most commonly, a `TypeInitializationException` exception is thrown when a static constructor is unable to instantiate a type or for an unhandled exception occurring within a static constructor. For static constructors that aren't explicitly defined in source code, troubleshooting might require inspection of the intermediate language (IL) code.

- The presence of a static constructor prevents the addition of the `BeforeFieldInit` type attribute. This limits runtime optimization.

- A field declared as `static readonly` can only be assigned as part of its declaration or in a static constructor. When an explicit static constructor isn't required, initialize static fields at declaration rather than through a static constructor for better runtime optimization.

- The runtime calls a static constructor no more than once in a single application domain. That call is made in a locked region based on the specific type of the class. No extra locking mechanisms are needed in the body of a static constructor.

> [!NOTE]
> Though not directly accessible, the presence of an explicit static constructor should be documented to assist with troubleshooting initialization exceptions.
