Object-oriented programming (OOP) uses objects to model real-world entities.

For developers who are familiar with structured programming, a comparison between structured programming and object-oriented programming can help clarify the differences between the two approaches. In addition, growing your understanding of encapsulation and the class lifecycle can help you to develop secure and robust solutions.

## Compare Object-Oriented Programming with structured programming

Structured programming and object-oriented programming (OOP) are two distinct approaches to software development, each with its own set of principles and methodologies. Structured programming is based on a top-down approach where the program is divided into smaller, manageable functions or procedures. This approach emphasizes a clear and logical flow of control by using loops, conditionals, and subroutines. Object-oriented programming organizes software design around objects that encapsulate both data and behavior, promoting a more modular and reusable code structure. While structured programming focuses on the sequence of actions to be performed, object-oriented programming emphasizes the objects involved in the actions.

We can use real-world examples of construction projects as metaphors to illustrate the differences between structured programming and object-oriented programming.

### Object-Oriented Programming example

Imagine object-oriented programming as designing and building a city. In this metaphor, each building represents a class, and each building's rooms and facilities represent the properties and methods of that class. Just as a city is composed of various buildings, each serving a specific purpose (residential, commercial, industrial), an OOP program is composed of various classes, each designed to handle specific tasks. The buildings (classes) are constructed based on blueprints (class definitions), and each building can have multiple instances (objects) that share the same structure but can have different states (data).

In this city, encapsulation is like the walls of a building that protect its internal structure and only allow access through designated doors and windows (methods). Encapsulation ensures that the internal workings of a building (class) are hidden from the outside world, and interactions with the building are controlled and safe.

This city-building metaphor highlights the modular and reusable nature of OOP, where each class (building) can be developed, tested, and maintained independently, yet they all work together to form a cohesive and functional city (program). Just as a well-planned city allows for efficient management and scalability, a well-designed OOP program promotes maintainability, flexibility, and scalability.

### Structured programming example

Imagine structured programming as making a quilt. In this metaphor, each piece of fabric represents a function or procedure in your program. Just like a quilt is made up of many individual patches sewn together, a structured program is composed of various functions that are designed to perform specific tasks. Each function is like a patch that can be developed, tested, and maintained independently. When you sew these patches together in a specific order, you create a complete quilt, just as you combine functions to form a complete program.

In structured programming, the focus is on the logical flow of control, much like how a quilter plans the layout and sequence of patches to create a cohesive design. The quilter ensures that each patch fits perfectly with the others, maintaining a clear and organized pattern. Similarly, a structured programmer ensures that each function fits seamlessly into the overall program, maintaining a clear and logical flow of control through the use of loops, conditionals, and subroutines.

This quilting metaphor highlights the modular nature of structured programming, where each function (or patch) can be reused and rearranged as needed. Just as a quilter can replace or modify individual patches without disrupting the entire quilt, a programmer can update or refine individual functions without affecting the entire program. This modularity makes structured programming an effective approach for creating clear, maintainable, and reusable code. However, as the program grows in size and complexity, managing the interactions between functions can become more challenging. Just as a quilt with too many patches can become unwieldy and difficult to manage, a structured program with numerous functions and procedures can become cumbersome and hard to maintain. As the number of patches (functions) increases, it becomes more challenging to keep track of how they fit together and interact. This leads to issues such as code duplication, difficulty in debugging, and a lack of cohesion. In large applications, the linear and top-down approach of structured programming can result in a tangled web of interdependent functions, making it difficult to understand and modify the codebase. This complexity can hinder scalability and maintainability, ultimately affecting the overall quality and performance of the software.

## Examine the use of classes in Object-Oriented Programming

Classes are the building blocks of object-oriented programming (OOP) and are used to define the structure and behavior of objects in a program. Understanding the benefits provided by encapsulation and the lifecycle of classes helps you understand how object-oriented programming works.

### Encapsulation

Encapsulation is one of the fundamental principles of object-oriented programming (OOP). It refers to the bundling of data (fields) and methods (behaviors) that operate on the data into a single unit, typically a class. Encapsulation restricts direct access to some of an object's components, which can prevent the accidental modification of data.

Encapsulation provides the following benefits:

Data Hiding: Encapsulation allows the internal state of an object to be hidden from the outside. This means that the internal representation of an object can be changed without affecting the outside code that uses the object.
For example, by using private fields and providing public getter and setter methods, you can control how the data is accessed and modified.

Improved Maintainability: Encapsulation makes it easier to maintain and modify code. Changes to the internal implementation of a class do not affect the code that uses the class, as long as the public interface remains the same.
This separation of concerns allows developers to focus on specific parts of the code without worrying about unintended side effects.

Increased Flexibility: Encapsulation allows for more flexible and modular code. By defining clear interfaces, you can easily replace or update parts of the code without affecting other parts.
This modularity makes it easier to reuse code and build complex systems from simpler components.

Enhanced Security: Encapsulation helps protect the integrity of an object's data by preventing unauthorized access and modification. By controlling access to the data through methods, you can enforce rules and constraints on how the data is used.
This enforcement helps prevent bugs and ensure that the object remains in a valid state.

Abstraction: Encapsulation supports the concept of abstraction by exposing only the necessary details of an object to the outside world. This simplifies the interface and makes it easier to understand and use the object.
Users of the object don't need to know the internal implementation, which reduces code complexity and improves readability.

> [!NOTE]
> Encapsulation is about hiding the data members that users of a class don't need. Data members are encapsulated, or hidden, using the `private' accessor keyword. Access to hidden field variables is controlled using properties and methods. Hidden data members aren't directly accessible.

```csharp

public class Person
{
    // Private fields
    private string firstName;
    private string lastName;
    private int age;

    // Public properties with getters and setters
    public string FirstName
    {
        get { return firstName; }
        set { firstName = value; }
    }

    public string LastName
    {
        get { return lastName; }
        set { lastName = value; }
    }

    public int Age
    {
        get { return age; }
        set
        {
            if (value >= 0)
            {
                age = value;
            }
            else
            {
                throw new ArgumentException("Age can't be negative");
            }
        }
    }

    // Public method
    public void Introduce()
    {
        Console.WriteLine($"Hi, I'm {FirstName} {LastName}, and I'm {Age} years old.");
    }
}

```

In this example:

- The fields `firstName`, `lastName`, and `age` are `private`, meaning they can't be accessed directly from outside the class.
- Public properties `FirstName`, `LastName`, and `Age` provide controlled access to the private fields.
- The `Age` property includes validation logic to ensure that the age can't be set to a negative value.
- The `Introduce` method provides a way to interact with the object's data without exposing the internal implementation details.

### Class lifecycle

In a C# application, the lifecycle of a class involves several stages from its definition to its eventual destruction. The lifecycle of a class includes the following steps:

1. Class Definition: Define the class with its members.
1. Compilation: Compile the class into IL code.
1. Loading: Load the assembly into memory.
1. Instantiation: Create an instance of the class.
1. Initialization: Initialize the object's fields and properties.
1. Usage: Use the object in the application.
1. Garbage Collection: Reclaim the object's memory when it's no longer needed.
1. Destruction: Execute cleanup logic and release memory.

Here's an example that includes as explanation of each step in the lifecycle of a class:

1. Class Definition

    Definition: A class is defined in the source code with its properties, methods, and other members.

    For example:

    ```csharp
    
    public class Person
    {
        // auto-implemented properties for name and age
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Age { get; set; }
    
        // method to introduce the person
        public void Introduce()
        {
            Console.WriteLine($"Hi, I'm {FirstName} {LastName}, and I'm {Age} years old.");
        }
    }
    
    ```

1. Compilation

    Compilation: The source code is compiled into an intermediate language (IL) by the C# compiler. The IL code is stored in an assembly (DLL or EXE file).

    For example: The `Person` class is compiled into IL code and included in the assembly.

1. Loading

    Loading: When the application runs, the Common Language Runtime (CLR) loads the assembly into memory.

    For example: The assembly containing the `Person` class is loaded into memory by the CLR.

1. Instantiation

    Instantiation: An instance of the class is created using the `new` keyword. The constructor of the class is called to initialize the object.

    For example:

    ```csharp
    
    Person person1 = new Person { FirstName = "Tim", LastName = "Shao", Age = 25 };
    
    ```

1. Initialization

    Initialization: The constructor initializes the object's fields and properties. Any initialization logic defined in the constructor is executed.

    Example: The `Person` object `person1` is initialized with the specified values for `FirstName`, `LastName`, and `Age`.

1. Usage

    Usage: The object is used in the application. Methods and properties of the object are accessed and modified as needed.

    For example:

    ```csharp
    
    person1.Introduce();
    
    ```

1. Garbage Collection

    Garbage Collection: When the object is no longer needed and there are no references to it, the garbage collector (GC) reclaims the memory used by the object. The destructor (finalizer) is called if it's defined.

    Example: If `person1` is no longer referenced anywhere in the code, the GC will eventually reclaim its memory.

1. Destruction

    Destruction: The object's memory is released, and any cleanup logic defined in the destructor (the finalizer if one is specified) is executed.

    Example: The `Person` object `person1` is destroyed, and its memory is reclaimed by the GC.
