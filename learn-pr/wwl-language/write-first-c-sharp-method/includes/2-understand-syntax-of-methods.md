You may already be familiar with some methods, such as `Console.WriteLine()` or `random.Next()`. You might have appreciated how these methods simplify tasks and allow you to build your code more easily. In this unit, you'll learn how to create your own methods.

## How methods work

The process of developing a method begins with creating a method signature. The method signature declares the method's return type, name, and input parameters. For example, consider the following method signature:

```c#
void SayHello();
```

The method name is `SayHello`. Its return type is `void`, meaning the method returns no data. However, methods can return a value of any data type, such as `bool`, `int`, `double`, and arrays as well. Method parameters, if any, should be included in the parenthesis `()`. Methods can accept multiple parameters of any data type. In this example, the method has no parameters.

Before you can run a method, you need to add a definition. The method definition uses brackets `{}` to contain the code that executes when the method is called. For example:

```c#
void SayHello() 
{
    Console.WriteLine("Hello World!");
}
```

Now the method will print `Hello World!` whenever it's called.

## Calling a method

A method is called by using its name and including any required arguments. Consider the following:

```c#
Console.Write("Input!");
```

The string `"Input!"` is the argument provided to the `Write` method.

A method can be called before or after its definition. For example, the `SayHello` method can be defined and called using the following syntax:

```c#
SayHello();

void SayHello() 
{
    Console.WriteLine("Hello World!");
}
```

Notice that it isn't necessary to have the method defined before you call it. This flexibility allows you to organize your code as you see fit. It's common to define all methods at the end of a program. For example:

```c#
int[] a = {1,2,3,4,5};

Console.WriteLine("Contents of Array:");
PrintArray();

void PrintArray()
{
    foreach (int x in a)
    {
        Console.Write($"{x} ");
    }
    Console.WriteLine();
}
```

## Method execution

When you call a method, the code in the method body will be executed. This means execution control is passed from the method caller to the method. Control is returned to the caller after the method completes its execution. For example, consider the following code:

```c#
Console.WriteLine("Before calling a method");
SayHello();
Console.WriteLine("After calling a method");

void SayHello() 
{
    Console.WriteLine("Hello World!");
}
```

This code displays the following output:

```Output
Before calling a method
Hello World!
After calling a method
```

Once a method is defined, it can be called any time, as many times as you need to use it. You can use methods inside of `if-else` statements, for-loops, `switch` statements, even to initialize variables, and so much more!

## Best practices

When choosing a method name, it's important to keep the name concise and make it clear what task the method performs. Method names should be Pascal case and generally shouldn't start with digits. Names for parameters should describe what kind of information the parameter represents. Consider the following method signatures:

```c#
void ShowData(string a, int b, int c);
void DisplayDate(string month, int day, int year);
```

The second method describes what kind of data is displayed and provides descriptive names for parameters.

Now that you have the basics down, you're ready to begin writing your own methods!