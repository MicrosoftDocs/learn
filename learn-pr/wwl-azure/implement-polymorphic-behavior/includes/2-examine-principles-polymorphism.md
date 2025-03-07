Polymorphism allows objects of different classes to be treated as objects of a common base class. This behavior enables you to write code that works with objects of multiple types without knowing the specific type at compile time.

For example, consider a base class `Shape` with derived classes `Circle` and `Rectangle`. You can create a list of `Shape` objects and add instances of `Circle` and `Rectangle` to it. When you iterate over the list, you can call the `Draw` method on each object without knowing the specific type of the object. This process is an example of polymorphic behavior in action.

## Approaches to polymorphism in C#

C# developers can implement polymorphism using either of the following approaches:

- Inheritance-based polymorphism: Class inheritance in C# enables a derived class to inherit members from a base class. Members of the base class can be overridden in the derived class to provide specific implementations. Creating a class hierarchy is a common way to implement polymorphism in C#.

- Interface-based polymorphism: An interface in C# defines a contract that classes can implement. When a class implements an interface, the class receives a set of properties and methods that it's required to implement. This requirement allows for polymorphic behavior, where an interface reference can direct objects of different classes to implement the set of properties and methods.

## Method overloading versus method overriding

Method overloading and method overriding are two common techniques for implementing method calls that produce different behaviors. Here's a comparison of the two techniques:

- Method overloading: Method overloading allows you to define multiple methods with the same name but different parameters in the same class. The method to be called is determined at compile time based on the method signature. Method overloading is often referred to as compile-time polymorphism.

- Method overriding: Method overriding allows a derived class to provide a specific implementation of a method that is already defined in its base class. The method to be called is determined at runtime based on the actual type of the object. Method overriding is an example of runtime polymorphism.

This training focuses on method overriding, which is a key aspect of polymorphism in C#.

## Principles of polymorphism in C#

Polymorphism is based on the following principles:

- Method Overriding: Method overriding allows a derived class to provide a specific implementation of a method that's already defined in its base class. This capability is made possible by inheritance and is a key aspect of runtime polymorphism.
- Virtual and Abstract Methods: The virtual keyword is used to declare methods in the base class that can be overridden in derived classes. The abstract keyword is used for declaring methods that must be overridden in derived classes.
- Base Class References: Polymorphism allows a base class reference to point to objects of derived classes. This inheritance mechanism enables the invocation of overridden methods in derived classes through the base class reference.
- Interface-Based Polymorphism: Interfaces define a contract that classes can implement. This contract allows different classes to be treated uniformly through a common interface, promoting loose coupling and flexibility.

## Benefits of polymorphism

- Code Reusability: Polymorphism promotes code reusability by allowing the same code to work with different types of objects.

- Flexibility and Maintainability: Polymorphism enhances flexibility and maintainability by decoupling the code that uses objects from the code that defines the objects.

- Extensibility: Polymorphism makes it easier to extend the system by adding new classes that implement the same interface or inherit from the same base class.

## Summary

Polymorphism is a key concept in object-oriented programming that enables flexibility, reusability, and maintainability in code. By understanding the principles of polymorphism and its implementation in C#, you can create modular and extensible applications that are easier to maintain and evolve over time.
