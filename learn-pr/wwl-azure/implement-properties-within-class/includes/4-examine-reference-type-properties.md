

A property isn't restricted to getting and setting what are called primitive types, such as integers and strings. When you create a class, you're also defining a type. It's that type, essentially the name of your class that identifies the kind of variable you're passing into or out of, a method or property. Any type can be passed into or returned by a property, including ones that you create. 

The following class called `HousingZoneDwellings` has a property that returns a `House` object. Notice that the previously defined `House` class is the type that our property `SingleDwelling` is returning.

```csharp
public class HousingZoneDwellings
{
   private House _house;
   public House SingleDwelling
   {
       get { return _house; }
       set { _house = value; }
   }

}
```

As you can see in the line that defines the name of the property, `public House SingleDwelling`, the classes you define can also define a return type. In this case, House is the type that is returned when the property is being used to “get” or “set” a value. Methods similarly define the types of input parameters they accept and return, albeit they work a little differently.

It's helpful to understand here that we're only talking about using the classes you define to indicate the return type for a property or method. When declaring variables or passing objects into a method you put the name of your type before the variable name, thus defining the variable being passed in to be of that type.

The following example of the SingleDwelling property demonstrates a House object setting the SingleDwelling property:

```csharp
HousingZoneDwellings.SingleDwelling = house;
```

In the above statement, our House class is being passed into the SingleDwelling property. If you look at the preceding definition of the property you can see that the House type is used to define the property and the type of value that can be passed into or out of the property. You do the same thing when declaring variables:

```csharp
private House house;
```

## Reference Types

Finally, there are two kinds of types in C#, reference types and value types. Variables called reference types store references to their objects, meaning that they point (or reference) the location or “bucket” in memory that has the data. Reference type variables allow you to modify and otherwise use the variable in the bucket. Variables called "value types" store a copy of the data they hold, but don’t allow you to modify it.

With reference types, two variables can reference the same object; therefore, operations on one variable can affect the object referenced by the other variable. With value types, each variable has its own copy of the data, and it's not possible for operations on one variable to affect the other. It's helpful to know that when you're passing a value into a property or method that they can be passed in either by reference or by value. By default they're passed by value. Indeed, you may never have a need to pass a value by reference, but it's good to know that you can, should you need to.

When you pass a house from one method or property to another, by default, you are doing it by value. When you pass an object this way, you get a copy of the value that can't be changed. As with properties, you can define methods that similarly take parameters of the types you specify and that return the value types you specify. The difference between a property versus a method, however, is that a property’s main purpose it life it to set and/or get values from an object. While methods can do the same thing, they're much more powerful and do much more than simply get or set values in an object.