When you create an object in code, you can initialize it with any data the object will need to do its job. The way you initialize an object is to define one or more constructors in the class, passing data into it as parameters. It is interesting to note that when you create an object, if you have not explicitly put a constructor in your code, the Common Language Runtime (CLR) automatically calls an implicit constructor!

The important thing to remember here is that constructors are methods used to initialize your object with any initial values required by your object. Although most objects have constructors, they aren't required to create an object. If you don't defined a constructor in your class, C# calls an implicit for its own housekeeping purposes. Typically, however, you define a constructor for the objects you create.

## Defining constructors

A constructor is a method that the CLR calls automatically, whenever you create an object. They have the same name as the class in which they're defined.
The general syntax for constructors is as follows:

```csharp
access-modifier class-name(parameter-list)
{

}
```

The following example shows how to define three constructors in the House class:

* The first constructor sets the house style name and square feet to meaningful default values
* The second constructor takes a string parameter. It initializes the house style name with this parameter, and sets the initial `sqrFootage` value to zero
* The third constructor takes two parameters, and initializes both the house style name and the square footage with these parameters

```csharp
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