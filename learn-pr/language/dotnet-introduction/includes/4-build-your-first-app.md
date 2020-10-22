If you've never written a line of code before, this exercise will help you get your feet wet and discover the joy of seeing your code come to life.

## Build a simple app using Try .NET

Earlier, we talked about how Try .NET provides a quick and easy way to experiment with C# and .NET without installing any software on your local computer.

### Step 1 - Navigate to Try.NET

Open another tab on your web browser and navigate to:

[https://try.dot.net/](https://try.dot.net/)

By default, Try .NET displays some C# code in the top pane of the web page that demonstrates its functionality.  Specifically, it's a program that displays the first 20 values in a Fibonacci sequence.  A Fibonacci sequences is simply a list of numbers where each number is the sum of the two preceding ones, starting from 0 and 1. Developers often create an algorithm featuring the Fibonacci sequence since the logic is fairly simple and straightforward.  Think of it as a warm-up exercise for some developers when they work with a new programming language.

Select the blue run button beneath the code listing to view the result.

### Step 2 - Write the code

Back in the top pane of the web page, delete all the code, and either write or copy the following code to replace it:

```csharp
using System;

public class Program
{
  public static void Main()
  {
    Console.WriteLine("Hello world!");
  }
}
```

### Step 3 - Run the code

Press the blue run button once again. Assuming you typed (or copied and pasted) the C# code correctly, this time the words `Hello World!` are displayed in the bottom pane.

> [!IMPORTANT]
> If you got any errors while running this code, please copy and paste it from the code 

"Hello world" is even a more simple and cannonical code example that most developers write to understand the basic syntax of a new programming languages.  While there's a lot to learn about the C# syntax, more relevant to learning about .NET.

## How does Try .NET work?

Fundamentally, the sames steps we talked about before are true here.

First, you wrote code (or copied it).  The code you wrote references a method whose full name is `System.Console.WriteLine()` which is compiled into in a .NET library.  The word `System` was omitted in your call to the method, but the first line of code `using System;` will tell the C# compiler to look there if it can't find the method anywhere else.

> [!NOTE]
> Don't worry about terms like method, System, using, and the other C# specific terms. You can learn about those later.  The focus right now is the process of compiling and executing your code.

Secondly, you selected the blue Run button.  Behind the scenes, the Run button sent your code to a server where your code could be compiled into an assembly.  Once compiled, the .NET Core Runtime knows to look in a class named `Program` to find a method named `Main()` to begin executing the instructions.  Once the instruction to print the words "Hello world!" to the output has finished, the path of execution will continue to the next line, but find nothing, and so it will end, and the .NET Core Runtime will remove the program from its memory.  Meanwhile, Try .NET will deliver the results back to your web browser.

Just understanding this sequence of events, and the basic dileneation of responsibilities between a programming language, a compiler, and a runtime means that you've already overcome one of the most important concepts as you're getting started!