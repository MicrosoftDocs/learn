

When it comes to planning an application, you start by thinking about what you want to build, then plan the design and build it out from there. You think about what you want to build, then identify the classes/objects that it will consist of. This process of identifying the classes/objects that your program consists of is often referred to as abstraction. Abstraction is the idea of taking what you want to build and then "abstracting" it out into classes that represent the various pieces of your application. For example, in your house building application those pieces might be rooms, plumbing, etcetera.

>[!NOTE] 
>As mentioned previously, classes are the design or blueprint for an object, detailing the members of an object. Objects are the “live” embodiment, so to speak, of that class in your computers Random Access Memory or RAM. They're the blueprint for what is called the “in-memory” object that actually does what the class blueprint or design has specified.

To tell it another way, each object represents a class. The class is the building block of an object-oriented application. And, in order to use a class in a completed application, you must create an object based on the class, as it's the live, in-memory, representation of that class. The purpose of this lesson is to differentiate between a class and an object, and to create a class. This module explains the differences between a class and an object, and shows you how to create a class.

## Types

In addition to classes being the blueprint for objects, each class also defines what is called a *type*. Types are another word for object, just used in a slightly different way. They're used to describe like things, much like in a game of cards each card belongs to a suit, hearts for example. This means that your class can represent a specific type of data called a *data type* or just *type*, such as strings (text), integers (numbers), and doubles (numbers that have a decimal), among others.

You can also create custom types that don’t represent any of the previously mentioned built-in or what are called native types, but rather represent the custom classes you create. The concept of type is important here, as they define the type of data your object can return when a method is called on that object. Return values and data type are discussed a little further on.

When you design an application, you identify new types that you require to build your application. If you're building an application that represents a house, you might have a house class that also can represent a house type. You use the house type to let the compiler know the type of variable you're passing into, or returning from, a method. The compiler needs to know whether the thing you're passing is in the suit of Diamonds or Clubs. 

## Properties

When you talk about classes and what they're composed of you're essentially talking about Properties and Methods. Properties help your object keep track of information, helping you “get” data, and “set” (input) data in your object. They're a mechanism to read, write, validate, or compute a value in your object, allowing data to be accessed easily. 

## Methods

Classes do things, or perform actions, using methods. A method is a block of code that contains a series of programming code statements. A program causes the statements to be executed by calling the method and specifying any required method arguments. Arguments are the data you pass into a method that your code processes. In C#, every executed instruction is performed in the context of a method.

## Creating a class

In order to create a class, you use the class keyword. Adding methods and properties to the class is covered later in this module.

```csharp
public class House
{

}
```

&nbsp;