In the previous units, you created and implemented an `IEquipable` interface for the `Armor` and `Weapon` classes. You might have considered the idea that an abstract class could be used instead. Why use interfaces at all, are they necessary? Let's take a moment to consider the benefits that using interfaces provide.

## Benefits of using interfaces

Interfaces provide powerful features. Here are just a few reasons why interfaces in C# are useful:

**Multiple Inheritance**<br/>
C# doesn't support multiple inheritance, but interfaces provide a way to achieve similar functionality. A class can't inherit multiple abstract classes, but it can implement multiple interfaces, which allows it to inherit behavior from different sources. Because of this flexibility, the `Armor` and `Weapon` classes are able to use both the `Item` abstract class and the `IEquipable` interface.

**Encapsulation**<br/>
Interfaces in C# provide a way to isolate and encapsulate behavior by defining a set of methods that a class must implement. This feature helps keep implementation details hidden, simplifying code and making it easier to manage and maintain.

**Polymorphism**<br/>
Interfaces in C# allow for polymorphism, meaning multiple classes can implement a single interface. Those classes can also be treated as the interface type. Polymorphism makes code more flexible and extensible, making it easier to group objects and add new functionality.

**Design Patterns**<br/>
Interfaces are commonly used in design patterns such as the Strategy pattern, where different implementations of an interface can be used interchangeably based on the needs of the application.

**Unit Testing**<br/>
Interfaces in C# are also useful for unit testing. By defining an interface for a class, you can create mock objects that simulate the behavior of the class. This function makes it easier to isolate and test specific functionality of the code.

While it's possible to build applications without using interfaces, it's a best practice to use them when applicable. Interfaces enable encapsulation, polymorphism, and multiple inheritance, improve project design and are useful in unit testing.