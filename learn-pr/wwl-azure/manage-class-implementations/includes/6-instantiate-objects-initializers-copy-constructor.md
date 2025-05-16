Object initializers and copy constructors are two ways to instantiate objects in C#. Object initializers allow you to assign values to any accessible fields or properties of an object at creation time without having to invoke a constructor followed by lines of assignment statements. Copy constructors allow you to create a new object by copying the values of an existing object.

Using object initializers and copy constructors can help you write more concise and readable code.

## Object initializers

Object initializers let you assign values to any accessible fields or properties of an object at creation time without having to invoke a constructor followed by lines of assignment statements. The object initializer syntax enables you to specify arguments for a constructor or omit the arguments (and parentheses syntax).

You can use object initializers to initialize type objects in a declarative manner without explicitly invoking a constructor for the type.

The compiler processes object initializers by first accessing the parameterless instance constructor and then processing the member initializations. Therefore, if the parameterless constructor is declared as private in the class, object initializers that require public access will fail.

The following example demonstrates how to use an object initializer.

The first code sample shows the class definition for a class named `Cat`. The definition includes two constructors, one of which is a parameterless constructor. The second code sample shows how to instantiate a `Cat` object using an object initializer. The object initializer assigns values to the `Age` and `Name` properties of the `Cat` object.

```csharp

public class Cat
{
    // Automatically implemented properties.
    public int Age { get; set; }
    public string? Name { get; set; }

    public Cat()
    {
    }

    public Cat(string name)
    {
        this.Name = name;
    }
}

```

```csharp

public class Program
{
    public static void Main()
    {
        // Declare and instantiate a new Cat object by using an object initializer.
        Cat cat = new Cat { Age = 10, Name = "Fluffy" };

        // Declare and instantiate a new Cat object by using an object initializer.
        Cat sameCat = new Cat("Fluffy") { Age = 10 };
    }
}

```

Here's another example that shows how to initialize a new `StudentName` type by using object initializers. This example sets properties in the `StudentName` type:

```csharp

public class HowToObjectInitializers
{
    public static void Main()
    {
        // Declare a StudentName by using the constructor that has two parameters.
        StudentName student1 = new StudentName("Lisa", "Yeh");

        // Make the same declaration by using an object initializer and sending
        // arguments for the first and last names. The parameterless constructor is
        // invoked in processing this declaration, not the constructor that has
        // two parameters.
        StudentName student2 = new StudentName
        {
            FirstName = "Sandy",
            LastName = "Zoeng"
        };

        // Declare a StudentName by using an object initializer and sending
        // an argument for only the ID property. No corresponding constructor is
        // necessary. Only the parameterless constructor is used to process object
        // initializers.
        StudentName student3 = new StudentName
        {
            ID = 183
        };

        // Declare a StudentName by using an object initializer and sending
        // arguments for all three properties. No corresponding constructor is
        // defined in the class.
        StudentName student4 = new StudentName
        {
            FirstName = "Thomas",
            LastName = "Margand",
            ID = 116
        };

        Console.WriteLine(student1.ToString());
        Console.WriteLine(student2.ToString());
        Console.WriteLine(student3.ToString());
        Console.WriteLine(student4.ToString());
    }
    // Output:
    // Lisa  0
    // Sandy  0
    //   183
    // Thomas  116

    public class StudentName
    {
        // This constructor has no parameters. The parameterless constructor
        // is invoked in the processing of object initializers.
        // You can test this by changing the access modifier from public to
        // private. The declarations in Main that use object initializers will
        // fail.
        public StudentName() { }

        // The following constructor has parameters for two of the three
        // properties.
        public StudentName(string first, string last)
        {
            FirstName = first;
            LastName = last;
        }

        // Properties.
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public int ID { get; set; }

        // Override the ToString method of the Object class.
        public override string ToString() => FirstName + "  " + ID;
    }
}

```

The object initializers syntax allows you to create an instance, and after that it assigns the newly created object, with its assigned properties, to the variable in the assignment.

In addition to assigning fields and properties, object initializers can set indexers. Consider this basic `Matrix` class:

```csharp

public class Matrix
{
    private double[,] storage = new double[3, 3];

    public double this[int row, int column]
    {
        // The embedded array will throw out of range exceptions as appropriate.
        get { return storage[row, column]; }
        set { storage[row, column] = value; }
    }
}

```

You could initialize the identity matrix with the following code:

```csharp

var identity = new Matrix
{
    [0, 0] = 1.0,
    [0, 1] = 0.0,
    [0, 2] = 0.0,

    [1, 0] = 0.0,
    [1, 1] = 1.0,
    [1, 2] = 0.0,

    [2, 0] = 0.0,
    [2, 1] = 0.0,
    [2, 2] = 1.0,
};

```

The following example defines a `BaseballTeam` class that uses an indexer to get and set players at different positions. The initializer can assign players, based on the abbreviation for the position, or the number used for each position on a baseball scorecard:

```csharp

public class HowToIndexInitializer
{
    public class BaseballTeam
    {
        private string[] players = new string[9];
        private readonly List<string> positionAbbreviations = new List<string>
        {
            "P", "C", "1B", "2B", "3B", "SS", "LF", "CF", "RF"
        };

        public string this[int position]
        {
            // Baseball positions are 1 - 9.
            get { return players[position-1]; }
            set { players[position-1] = value; }
        }
        public string this[string position]
        {
            get { return players[positionAbbreviations.IndexOf(position)]; }
            set { players[positionAbbreviations.IndexOf(position)] = value; }
        }
    }

    public static void Main()
    {
        var team = new BaseballTeam
        {
            ["RF"] = "Lisa Yeh",
            [4] = "Sandy Zoeng",
            ["CF"] = "Thomas Margand"
        };

        Console.WriteLine(team["2B"]);
    }
}

```

### Object initializers with the required modifier

You use the required keyword to force callers to set the value of a property or field using an object initializer. Required properties don't need to be set as constructor parameters. The compiler ensures all callers initialize those values.

```csharp

public class Person
{
    public string FirstName { get; set; } = string.Empty;
    public required string LastName { get; set; }

}

// The `FirstName` property is optional and has a default value of an empty string.        
// The `LastName` property is required and must be initialized during object creation.
// You can create a new instance of the Person class using both properties.
var friend1 = new Person() { FirstName = "Lisa", LastName = "Yeh" };
Console.WriteLine($"Hello, {friend1.FirstName} {friend1.LastName}!");

// You can create a new instance of the Person class using only the LastName property.
var friend2 = new Person() { LastName = "Yeh"};
Console.WriteLine($"Hello, {friend2.FirstName} {friend2.LastName}!");

// You can assign a different value to the properties after the object is created.
friend2.FirstName = "Sandy";
friend2.LastName = "Chen";
Console.WriteLine($"Hello, {friend2.FirstName} {friend2.LastName}!");

// Compiler error: Required property 'LastName' must be initialized.
//var friend3 = new Person() { FirstName = "Lisa"};
//var friend4 = new Person();

// Output:
// Hello, Lisa Yeh!
// Hello, Sandy Yeh!
// Hello,  Yeh!
// Hello,  Chen!
```

It's a typical practice to guarantee that your object is properly initialized, especially when you have multiple fields or properties to manage and don't want to include them all in the constructor.

### Object initializers with the init accessor

Making sure no one changes the designed object could be limited by using an init accessor. It helps to restrict the setting of the property value.

```csharp

public class Person
{
    public string FirstName { get; set; }
    public string LastName { get; init; }
}

// You can create a new instance of the Person class any combination of the properties.
var friend0 = new Person();
var friend1 = new Person() { FirstName = "Lisa" };
var friend2 = new Person() { LastName = "Yeh" };
var friend3 = new Person() { FirstName = "Lisa", LastName = "Yeh" };

Console.WriteLine($"Hello, {friend0.FirstName} {friend0.LastName}!");
Console.WriteLine($"Hello, {friend1.FirstName} {friend1.LastName}!");
Console.WriteLine($"Hello, {friend2.FirstName} {friend2.LastName}!");
Console.WriteLine($"Hello, {friend3.FirstName} {friend3.LastName}!");

// You can assign a different value to the FirstName property after the object is created, but not the LastName property.
friend3.FirstName = "Sandy";

// Compiler error:
// Error CS8852  Init - only property or indexer 'Person.LastName' can only be assigned in an object initializer,
//               or on 'this' or 'base' in an instance constructor or an 'init' accessor.
//friend3.LastName = "Chen";

Console.WriteLine($"Hello, {friend3.FirstName} {friend3.LastName}!");


// Output:
// Hello,  unknown!
// Hello, Lisa unknown!
// Hello,  Yeh!
// Hello, Lisa Yeh!
// Hello, Sandy Yeh!
```

Required init-only properties support immutable structures while allowing natural syntax for users of the type.

### Object initializers with class-typed properties

It's crucial to consider the implications for class-typed properties when initializing an object:

```csharp

public class HowToClassTypedInitializer
{
    public class EmbeddedClassTypeA
    {
        public int I { get; set; }
        public bool B { get; set; }
        public string S { get; set; }
        public EmbeddedClassTypeB ClassB { get; set; }

        public override string ToString() => $"{I}|{B}|{S}|||{ClassB}";

        public EmbeddedClassTypeA()
        {
            Console.WriteLine($"Entering EmbeddedClassTypeA constructor. Values are: {this}");
            I = 3;
            B = true;
            S = "abc";
            ClassB = new() { BB = true, BI = 43 };
            Console.WriteLine($"Exiting EmbeddedClassTypeA constructor. Values are: {this})");
        }
    }

    public class EmbeddedClassTypeB
    {
        public int BI { get; set; }
        public bool BB { get; set; }
        public string BS { get; set; }

        public override string ToString() => $"{BI}|{BB}|{BS}";

        public EmbeddedClassTypeB()
        {
            Console.WriteLine($"Entering EmbeddedClassTypeB constructor. Values are: {this}");
            BI = 23;
            BB = false;
            BS = "BBBabc";
            Console.WriteLine($"Exiting EmbeddedClassTypeB constructor. Values are: {this})");
        }
    }

    public static void Main()
    {
        var a = new EmbeddedClassTypeA
        {
            I = 103,
            B = false,
            ClassB = { BI = 100003 }
        };
        Console.WriteLine($"After initializing EmbeddedClassTypeA: {a}");

        var a2 = new EmbeddedClassTypeA
        {
            I = 103,
            B = false,
            ClassB = new() { BI = 100003 } //New instance
        };
        Console.WriteLine($"After initializing EmbeddedClassTypeA a2: {a2}");
    }

    // Output:
    //Entering EmbeddedClassTypeA constructor Values are: 0|False||||
    //Entering EmbeddedClassTypeB constructor Values are: 0|False|
    //Exiting EmbeddedClassTypeB constructor Values are: 23|False|BBBabc)
    //Exiting EmbeddedClassTypeA constructor Values are: 3|True|abc|||43|True|BBBabc)
    //After initializing EmbeddedClassTypeA: 103|False|abc|||100003|True|BBBabc
    //Entering EmbeddedClassTypeA constructor Values are: 0|False||||
    //Entering EmbeddedClassTypeB constructor Values are: 0|False|
    //Exiting EmbeddedClassTypeB constructor Values are: 23|False|BBBabc)
    //Exiting EmbeddedClassTypeA constructor Values are: 3|True|abc|||43|True|BBBabc)
    //Entering EmbeddedClassTypeB constructor Values are: 0|False|
    //Exiting EmbeddedClassTypeB constructor Values are: 23|False|BBBabc)
    //After initializing EmbeddedClassTypeA a2: 103|False|abc|||100003|False|BBBabc
}

```

The next example shows the order of execution of constructor and member initializations using constructors with and without parameters:

```csharp

public class ObjectInitializersExecutionOrder
{
    public static void Main()
    {
        new Person { FirstName = "Lisa", LastName = "Yeh", City = "unknown" };
        new Dog(2) { Name = "Oscar" };
    }

    public class Dog
    {
        private int age;
        private string name;

        public Dog(int age)
        {
            Console.WriteLine("Hello from Dog's non-parameterless constructor");
            this.age = age;
        }

        public required string Name
        {
            get { return name; }

            set
            {
                Console.WriteLine("Hello from setter of Dog's required property 'Name'");
                name = value;
            }
        }
    }

    public class Person
    {
        private string firstName;
        private string lastName;
        private string city;

        public Person()
        {
            Console.WriteLine("Hello from Person's parameterless constructor");
        }

        public required string FirstName
        {
            get { return firstName; }

            set
            {
                Console.WriteLine("Hello from setter of Person's required property 'FirstName'");
                firstName = value;
            }
        }

        public string LastName
        {
            get { return lastName; }

            init
            {
                Console.WriteLine("Hello from setter of Person's init property 'LastName'");
                lastName = value;
            }
        }

        public string City
        {
            get { return city; }

            set
            {
                Console.WriteLine("Hello from setter of Person's property 'City'");
                city = value;
            }
        }
    }

    // Output:
    // Hello from Person's parameterless constructor
    // Hello from setter of Person's required property 'FirstName'
    // Hello from setter of Person's init property 'LastName'
    // Hello from setter of Person's property 'City'
    // Hello from Dog's non-parameterless constructor
    // Hello from setter of Dog's required property 'Name'
}

```

## Copy constructors

In the following example, the `Person` class defines a copy constructor that takes, as its argument, an instance of `Person`. The values of the properties of the argument are assigned to the properties of the new instance of `Person`. The code contains an alternative copy constructor that sends the `Name` and `Age` properties of the instance that you want to copy to the instance constructor of the class. The `Person` class is sealed, so no derived types can be declared that could introduce errors by copying only the base class.

```csharp

public sealed class Person
{
    // Copy constructor.
    public Person(Person previousPerson)
    {
        Name = previousPerson.Name;
        Age = previousPerson.Age;
    }

    //// Alternate copy constructor calls the instance constructor.
    //public Person(Person previousPerson)
    //    : this(previousPerson.Name, previousPerson.Age)
    //{
    //}

    // Instance constructor.
    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }

    public int Age { get; set; }

    public string Name { get; set; }

    public string Details()
    {
        return Name + " is " + Age.ToString();
    }
}

class TestPerson
{
    static void Main()
    {
        // Create a Person object by using the instance constructor.
        Person person1 = new Person("Lisa", 40);

        // Create another Person object, copying person1.
        Person person2 = new Person(person1);

        // Change each person's age.
        person1.Age = 39;
        person2.Age = 41;

        // Change person2's name.
        person2.Name = "Sandy";

        // Show details to verify that the name and age fields are distinct.
        Console.WriteLine(person1.Details());
        Console.WriteLine(person2.Details());

        // Keep the console window open in debug mode.
        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}
// Output:
// Lisa is 39
// Sandy is 41

```
