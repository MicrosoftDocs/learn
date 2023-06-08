

When you create an object in code, you must ensure that you also initialize it. The easiest way to guarantee that an object is initialized is to define one or more constructors in the class. When you create an object, the common language runtime (CLR) automatically calls a constructor to initialize the object, even if you have not explicitly put a constructor in your code!

Constructors are methods used to initialize your object with any initial values required by your object. Although most objects have constructors, they aren't required to create an object. Even when you haven't defined a constructor in your class, C# calls an implicit constructor that behaves differently than an explicit constructor method you define. Typically you define a constructor for the objects you create, especially as a person just getting started with programming.

## Defining constructors

A constructor is a method that the CLR calls automatically, whenever you create an object. They have the same name as the class in which they're defined.
The general syntax for constructors is as follows:
```CSharp
access-modifier class-name(parameter-list)
{

}
```

The following example shows how to define three constructors in the House class:

- The first constructor is a default constructor that sets the house style name and square feet to meaningful default values

- The second constructor takes a string parameter. It initializes the house style name with this parameter, and sets the initial balance to zero

- The third constructor takes two parameters, and initializes both the house style name and the square footage with these parameters
```CSharp

public class House
{
    private string houseStyle;
    private int sqrFootage;

    public House()
    {
        houseStyle = "[Unknown]";
        sqrFootage = 0;
    }

    public House(string style)
    {
        houseStyle = style;
        sqrFootage = 0;
    }

    public House(string style, int footage)
    {
        houseStyle = style;
        sqrFootage = footage;
    }
}
```

&nbsp;
## Check your knowledge

## Multiple choice
When might you have multiple constructor methods in your class?
( ) You would never have multiple constructors. {{Incorrect. This is untrue, you may at some point want to have multiple constructors for an object.}}
( ) When you want to make your code more readable. {{Incorrect. Having multiple constructor is not done for the purpose of making your code more readable.}}
(x) When you want to initialize your object for different purposes. {{Correct! As constructors are used to initialize an object, having an overloaded constructor allows you to initialize your object for different use cases.}}

Which of these scenarios is a good reason to possibly add a second (overloaded) constructor?
( ) You want more than one way to create your object. {{Incorrect. Although perhaps partially correct, this answer is too vague and does not provide any reasoning for the answer given.}}
( ) When the main constructor no longer works. {{Incorrect. Constructors are not added to a class as backup for another constructor.}}
(x) You want an option to initialize your object with limited basic information, and an option for initializing it with a full set of information. {{Correct! While there can be various reasons for having more than one constructor, this is a good answer for this scenario.}}
