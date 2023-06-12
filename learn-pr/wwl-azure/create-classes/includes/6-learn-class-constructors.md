

When you create an object in code, you must ensure that you also initialize it. The easiest way to guarantee that an object is initialized is to define one or more constructors in the class. When you create an object, the common language runtime (CLR) automatically calls a constructor to initialize the object, even if you have not explicitly put a constructor in your code!

Constructors are methods used to initialize your object with any initial values required by your object. Although most objects have constructors, they aren't required to create an object. Even when you haven't defined a constructor in your class, C# calls an implicit constructor that behaves differently than an explicit constructor method you define. Typically you define a constructor for the objects you create, especially as a person just getting started with programming.

## Defining constructors

A constructor is a method that the CLR calls automatically, whenever you create an object. They have the same name as the class in which they're defined.
The general syntax for constructors is as follows:

```csharp
access-modifier class-name(parameter-list)
{

}
```

The following example shows how to define three constructors in the House class:

* The first constructor is a default constructor that sets the house style name and square feet to meaningful default values
* The second constructor takes a string parameter. It initializes the house style name with this parameter, and sets the initial balance to zero
* The third constructor takes two parameters, and initializes both the house style name and the square footage with these parameters

```csharp
public class House
{   private string houseStyle;   private int sqrFootage;
   public House()   {       houseStyle = "[Unknown]";       sqrFootage = 0;   }
   public House(string style)   {       houseStyle = style;       sqrFootage = 0;   }
   public House(string style, int footage)   {       houseStyle = style;       sqrFootage = footage;   }
}
```