## Multiple Choice
How can you access explicit interface members in C#?
(x) By casting the class instance to the interface type. {{Correct. Explicit interface members are only accessible through the interface instance, so you need to cast the class instance to the interface type.}}
( ) By using the 'this' keyword within the class. {{Incorrect. Explicit interface members cannot be accessed using the 'this' keyword within the class; they are only accessible through the interface instance.}}
( ) By using reflection to invoke the members. {{Incorrect. While reflection can be used to invoke members, it is not the standard way to access explicit interface members. The correct approach is to cast the class instance to the interface type.}}

## Multiple Choice
What is a key benefit of using interfaces to reduce code dependencies?
(x) Interfaces promote loose coupling and easier testing. {{Correct. Interfaces define a set of methods and properties that implementing classes must provide, promoting loose coupling and making the code easier to test and maintain.}}
( ) Interfaces provide default implementations for all methods. {{Incorrect. Interfaces do not provide default implementations for methods; they only define the contract that implementing classes must follow.}}
( ) Interfaces allow for multiple inheritance of classes. {{Incorrect. C# does not support multiple inheritance of classes. Interfaces allow a class to inherit behavior from multiple sources without multiple inheritance.}}

## Multiple Choice
You're developing a home automation application with different types of lights. Which approach allows you to mix and match capabilities in a single class?
(x) Implement multiple interfaces in the class. {{Correct. Implementing multiple interfaces in a class allows you to mix and match capabilities, providing a common API supported by various types.}}
( ) Use multiple inheritance of classes. {{Incorrect. C# does not support multiple inheritance of classes. Implementing multiple interfaces is the correct approach.}}
( ) Define all functionalities within a single interface. {{Incorrect. Defining all functionalities within a single interface can lead to a bloated interface. Implementing multiple interfaces is a better approach.}}
