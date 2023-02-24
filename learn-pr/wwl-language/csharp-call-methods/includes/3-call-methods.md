We've been calling methods since our first lines of code when using the `Console.WriteLine()` method. Not all classes and methods are implemented the same way. This unit will cover some of the most popular variants you'll need to understand when using methods from the .NET Class Library. More importantly, you'll learn how to find and use the documentation to better understand more about each method.

## How to call methods in the .NET Class Library

From your previous experience with the `Console.WriteLine()` method, you should already know the basics:

- Start by typing the class name, `Console`.
- Add the member access operator, the `.` symbol.
- Add the method's name, `WriteLine`.
- Add the method invocation operator, which is a set of parentheses `()`.
- Finally, add the value you want the `Console.WriteLine()` method to print as an input parameter between the opening and closing parentheses (for example, `"Hello World!"`).

Optionally, depending on how the developers designed and implemented the given method, you may also need to:

- Pass additional values as input parameters.
- Accept a return value.

We'll cover input parameters and return values in the next unit.

While we can call some methods the same way we called `Console.WriteLine()`, there are other methods in the .NET Class Library that require a different approach.

## Calling different kinds of methods in the .NET Class Library

The following example simulates a dice roll by generating a random number and printing it to the console:

```csharp-interactive
Random dice = new Random();
int roll = dice.Next(1, 7);
Console.WriteLine(roll);
```

If you run the code multiple times, different numbers from 1 to 6 are displayed in the console output.

First, let's walk through what each line of code accomplishes, then we'll ask some important questions and make some observations about working with classes and methods in the .NET Class Library.

The first line of code creates a new instance of the `System.Random` class in the .NET Class Library and stores the reference to the new object in a variable named `dice`.

The second line of code calls the `dice` object's `Next()` method passing in two parameters: the minimum and maximum value of the random number. The `Next()` method returns the value, which we'll save into a variable named `roll`.

The third line of code calls the `WriteLine()` method to print the value of `roll` to the console.

In this code example, we're calling a method of the Random class and the Console class. However, the *way* we're calling these methods is different. The reason they're called using different techniques is because some methods are stateful and others are stateless.

### Stateful versus stateless methods

In computing, **state** describes the condition of the execution environment at a specific moment in time. As your code executes line by line, values are stored in variables. At any moment during execution, the current state of the application is the collection of all values stored in memory.

Some methods don't rely on the current state of the application to work properly. In other words, **stateless methods** are implemented so that they can work without referencing or changing any values already stored in memory. Stateless methods are also known as **static methods**.

For example, the `Console.WriteLine()` method doesn't rely on any values stored in memory. It performs its function and finishes without impacting the state of the application in any way.

Other methods, however, must have access to the state of the application to work properly. In other words, **stateful methods** are built in such a way that they rely on values stored in memory by previous lines of code that have already executed, or they modify the state of the application by updating values or storing new values in memory. They're also known as **instance methods**.

Stateful (instance) methods keep track of their state in *fields*, which are variables defined on the class. Each new instance of the class gets its own copy of those fields in which to store state.

A single class can support both stateful and stateless methods. However, when you need to call stateful methods, you must first create an *instance* of the class so that the method can access state.

### Creating an instance of a class

An instance of a class is called an *object*. To create a new instance of a class, you'll use the `new` operator. Consider the following line of code that creates a new instance of the `Random` class to create a new object called `dice`:

```csharp
Random dice = new Random();
```

The `new` operator does several important things:

- It first requests an address in the computer's memory large enough to store a new object based on the `Random` class.
- It creates the new object and stores it at the memory address.
- It returns the memory address so that it can be saved in the `dice` variable.

From that point on, when the `dice` variable is referenced, the .NET Runtime performs a lookup behind the scenes to give the illusion that you're working directly with the object itself.

### Why is the Next() method stateful?

You might be wondering why the `Next()` method was implemented as a stateful method? Couldn't the .NET Class Library designers figure out a way to generate a random number without requiring state? And what exactly is being stored or referenced by the `Next()` method?

These are fair questions. At a high level, computers are good at following specific instructions to create a reliable and repeatable outcome. To create the illusion of randomness, the developers of the `Next()` method decided to capture the date and time down to the fraction of a millisecond and use that to seed an algorithm that produces a different number each time. While not entirely random, it suffices for most applications. The state that's captured and maintained through the life time of the `dice` object is the seed value. Each subsequent call to the `Next()` method is rerunning the algorithm, but ensures that the seed changes so that the same value isn't (necessarily) returned.

To use the `Random.Next()` method, however, you don't have to understand *how* it works. The important thing to know is that some methods require you to create an instance of a class before you call them, while others don't.

### How can you determine whether you need to create an instance of a class before calling its methods?

One way to learn how to call the method is to consult the documentation. You'll find examples that show whether the method must be called from the object instance or directly from the class.

> [!NOTE]
> One of the most useful parts of the documentation is the code examples, which demonstrate how to use the method you're researching. Sometimes you'll need to scroll down on the page to find the code examples.

Alternatively, you can attempt to access the method directly from the class itself. The worst that can happen is that you'll get a compilation error.

If you type the following line of code into the .NET Editor:

```csharp-interactive
int result = Random.Next();
```

A red squiggly line will appear, which indicates you have a compilation error. Hovering over the red squiggly line with your mouse cursor, you'll get a popup with the following message:

```

(1,14): error CS0120: An object reference is required for the non-static field, method, or property 'Random.Next()'
```

## Recap

- To call methods of a class in the .NET Class Library, you'll use the format `ClassName.MethodName()`, where the `.` symbol is the member access operator to access a method defined on the class and the `()` symbols are the method invocation operators.
- When calling a stateless method, you don't need to create a new instance of its class first.
- When calling a stateful method, you need to create an instance of the class and access the method on the object.
- Use the `new` operator to create a new instance of a class.
- An instance of a class is called an *object*.
