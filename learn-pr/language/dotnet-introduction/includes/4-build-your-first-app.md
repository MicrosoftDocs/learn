At the outset of this module, we assumed that you've already written a "Hello World" application by using C#. If you haven't, you might want to review this learning path's first module, [Write your first C# code](/training/modules/csharp-write-first/?azure-portal=true).

For simplicity, we'll rewrite the "Hello World" application. This time, we'll take a .NET perspective and see what's happening behind the scenes.

## Build a simple app by using C#

Earlier, you learned that **Try .NET** provides an easy way to experiment with C# and .NET. You can use Try .NET without installing any software on your local computer.

> [!Note]
> In this module, you'll use a browser built-in version of Try .NET. If you want to experiment with the application after you finish this exercise, go to `https://try.dot.net`. Try .NET is a great way to try out small code examples without installing anything on your local computer.

### Step 1 - Write the code

In the .NET editor, on the right side of this web page, type the following code sample. Or copy the code sample and then paste it in the .NET editor.

```csharp-interactive
Console.WriteLine("Hello world!");
```
As you learned in the prerequisite module, "Hello world" is a simple and canonical code example that developers write to understand the basic syntax of new programming languages. You could learn a lot about the C# syntax from this simple example. For now, we'll use it to learn more about .NET specifically.

### Step 2 - Run the code

Select the green **Run** button in the .NET editor. If the entered C# code is correct, the words "Hello World!" appear in the **Output** pane.

> [!IMPORTANT]
> If you see any errors while running this code, copy the code and paste it in the .NET editor, then try running the code again.

### What happens to the code you write?

The browser version of Try .NET hides some of the code you see when you build a full application by using Try .NET, Visual Studio 2022, or Visual Studio Code.

When you include the hidden code, here's how the example looks:

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

The in-browser Try .NET environment uses the same steps you learned about earlier. The only difference is that some of the code is hidden to simplify the experience.

Focusing on that expanded view of the code, you can see a series of curly braces `{ }`. C# uses a pair of curly braces to define a *code block*. Different kinds of code blocks are used for different purposes.

The code `public static void Main()` and its set of curly braces define a type of code block called a *method*. A method contains a grouping of code that works toward a single purpose or responsibility in your software system.

In this case, the method contains only one line of code, and its purpose is to display a message. Larger programs can have hundreds or thousands of methods.

Methods are organized inside other code blocks called classes. A *class* can contain one or more methods. All of the methods in a class have a related purpose in the system. The class in the preceding code is named `Program`.

In your inserted line of code, `Console.WriteLine()` is *calling*, or running, the method `WriteLine()`. The method `WriteLine()` is contained in the class `Console`.  

Where is this code?  It's in the base class library. Actually, its full name is `System.Console.WriteLine()`.  In the preceding code, you see that the first line is:

```csharp
using System;
```

The word `System` is omitted in your call to `Console.WriteLine()`. But the first line of code `using System;` tells the C# compiler to look in the base class library if it can't find the method definition in your code.

> [!NOTE]
> Don't worry about C#-specific terms terms like method, class, System, and using. You can learn about those later. We'll focus right now on the process of compiling and executing your code.

### What happens to your code after it's inserted into the Main() method?

The most important part of this exercise is what happens after the code you write is inserted into a `Main()` method. Keep in mind that the following process happens on a server on your behalf.

1. A command to compile your new code invokes the C# compiler.

1. The C# compiler ensures your code can be compiled and is free from syntax errors. If it can't compile your code, the compiler stops and sends an error message back to the **Output** pane.

1. If the C# compiler succeeds, the .NET runtime opens the newly compiled .NET assembly. By default, it looks in a class named `Program` to find a method named `Main()` to begin running the instructions.

1. Instruction by instruction, the .NET runtime evaluates each line of code. It runs the instruction and moves to the next line of code.

1. In this case, when the instruction to print the words "Hello world!" finishes, the running path continues to the next line but finds nothing. The path ends, and the .NET runtime removes the program from its memory. Meanwhile, the output from the `WriteLine()` instruction is delivered back to your web browser.

This sequence of events, and the basic division of responsibilities between a programming language, a compiler, and a runtime, are the most important concepts to understand as you're getting started.
