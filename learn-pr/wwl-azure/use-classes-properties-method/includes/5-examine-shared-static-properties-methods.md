

All of the members introduced in this lesson so far have been instance members. Instance members belong to individual instances of a class. For example, each House instance perhaps holds an array of Rooms. Rooms are then instance members of the House class. Any methods, properties, variables, and classes declared in the House class are also considered instance members of the House class.

A class can also contain class members, as opposed to instance members. Class members pertain to the class itself, rather than to a particular instance of a class. For example, the House class might have a buiderID field that defines a shared builder identification number that all houses must have. By using static (often referred to as global) members you can access these methods globally, or outside of the context of a specific instance, by any object in your application.

## Defining static members

In object oriented-programming, you call the accessibility or "visibility" of objects and their members scope. A program consists of objects that contain other objects that can have varying levels of accessibility. The accessibility or visibility of objects is based on their access modifier (public, private, etcetera), objects may not always be accessible.

When you define a class or class member as static you are immediately loading that class or class member into memory when the application starts, before your code has instantiated the object. Another effect of declaring a class or member static is that it can be accessed from any other object in your code, regardless of scope. 

When you define a class as static, you're creating what is called a global variable that can be accessed from any object in your code. It is global. The creation and use of global, or static, classes is limited to specific use cases and their creation isn't recommended as a common practice.

When it comes to defining class-wide members in a class, you use the keyword static in the member declaration. You must place the static keyword immediately after the access modifier in the declaration. The following rules and guidelines apply when you define static members:

- Static fields are shared across instances, meaning they're global and can be accessed by any other object in your code, regardless of scope. The value in a static field is stored only once, regardless of how many instances of the class you create.
- Static properties and methods can only access static class members; they can't access instance members.

The following example shows how to define a static field, property, and method in the House class:

- All instances of the Houses class share a common housing development builder.
- developmentBuilder is a static field that represents the name of the builder for all houses in a housing development. The developmentBuilder field is initialized to “American Builders” in the declaration.
- HousingDevelopmentBuilder is a static property that gets and sets the developmentBuilder field.
- AddHouseToDevProject is a static method that increases the numberOfHouses field by one, incrementing the number of houses in the development project.

```CSharp
public class House
{
    private static string developmentBuilder = “American Builders”;
    private static int numberOfHouses = 0;

    public static string HousingDevelopmentBuilder
    {
        get {return developmentBuilder;}
        set {developmentBuilder = value;}
    }


    public static void AddHouseToDevProject()
    {
        numberOfHouses += 1;
    }

    // Plus other members.
}
```

## Accessing Static Members

The way you access static members is different from the way you access instance members.

To access a static member on a class, you use the name of the class, followed by a period, followed by the name of the member. You can access static members even if no instances of the class exist, because static members don't contain any instance-specific data or behavior.

The following example shows how to access static properties and methods on the Houses class. The example performs the following tasks:

- Uses the HousingdevelopmentBuilder property to set the housing development builder’s name that applies for all houses.
- Calls the AddHouseToDevProject method to increase the number of houses in the development by one in the numberOfHouses field.
- Uses the GetNumberOfHouses property to get the number of houses in the development and display it.

#### Static example

```CSharp
House.HousingdevelopmentBuilder = “American Builders”;

House.AddHousesToDevProject();
```

The important thing to remember here is that in this code the House class hasn't been instantiated. Previously, you have been used to working with classes by instantiating them as described here.

#### Instantiate example

```CSharp

House house = new House();

house.HousingDevelopmentBuilder = "American Builder";

house.AddHouseToDevProject();
```

As you can see, in the static example the House class isn't "newing" or creating an instance of the House object. It only uses the class name followed by the static method name to access the property or method. The House class isn't being instantiated.
