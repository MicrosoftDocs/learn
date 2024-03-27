An interface is an abstract type that defines functionality. You can think of an interface a blueprint that describes the behaviors classes must support. Interfaces allow very different types of classes to function in the same way. 

For example, consider a vehicle, a person, and a dog that each need to move across a screen. An interface defining a "Move" function could allow the programmer to enforce that behavior across all of these different objects.

An interface is abstract and only defines method signatures. Classes that use the interface must define *how* the methods work. In our move example, *how* each object will "Move" is up to each class to define, but the interface establishes fact that they must move.

## Define an interface

Creating an interface is similar to creating a class. An interface is typically placed in its own file, with the file name matching the name of the interface. The interface contains a list of method signatures that classes define later. For example, here's a simplified definition of our `Move` interface:

```c#
interface IMoveable
{
    // The X coordinate of the object
    public int X { get; set; }

    // The Y coordinate of the object
    public int Y { get; set; }

    // Move the object to new coordinates
    public void Move(int x, int y);
}
```

Interface names typically begin with the letter "I". An interface doesn't contain fields, but can contain properties. In this example, `int X` and `int Y` are properties with getter and setter methods. 

## Implement an interface

To use an interface, you add it to the class definition using the `:` operator. Afterwards, you can define the methods specified by the interface. The class must define each of the methods included in the interface. When you add an interface to a class, you are "implementing" the interface.

```c#
class Ant : IMoveable
{
    public Ant(int x, int y) 
    {
        X = x;
        Y = y;
    }

    public int X { get; set; }

    public int Y { get; set; }
    
    public void Move(int x, int y)
    {
        X += x;
        Y += y;
    }
}
```

In addition to methods, interface properties are useful because they provide a standard for getting and setting data. Defining an interface property allows you to provide consistency across any code that uses that property. Interfaces make it simpler to write robust code that works with different types of objects, as long as they all implement the same interface.

Overall, an interface defines a contract between different parts of a program, making it easier to build large, complex programs that can be maintained and updated over time.