

If you have written any code in .NET, you have worked with classes. In addition to classes being the blueprint for objects, the building blocks of your application, each class also defines a type. This means that your class can represent a specific type data called a data type, such as strings (text), integers (numbers), and doubles (numbers that have a decimal), among others.

You can also create custom types that don’t represent any of the previously mentioned types, but rather represent the custom class that you create. The concept of type is important here, as they define the type of data your object returns when it's called.

When you design an application, you identify new types that you require to build your application. If you're building an application that represents a house, you might have a house class that represents a house. The house class would have a bedroom, living room, bathroom, dining room, etcetera. The user of your application can enter the rooms, perhaps turn on or off the light in the room, exit the room and so on.

## Properties

When we talk about classes and what they're composed of we're essentially talking about Properties and Methods. Properties help your object keep track of information, helping you “get” data, and “set” (input) data in your object. They're a mechanism to read, write, validate, or compute a value in your object, allowing data to be accessed easily. 

## Methods

Classes do things, or perform actions, using methods. A method is a block of code that contains a series of programming code statements. A program causes the statements to be executed by calling the method and specifying any required method arguments. Arguments are the data you pass into a method that your code processes. In C#, every executed instruction is performed in the context of a method.

## Creating a Class

In order to create a class, you use the class keyword. Adding methods and properties to the class is covered later in this module.

```CSharp
public class House
{

}
```

Question: What other classes might you create for an application that represents a house?

Question: How would you handle rooms?
