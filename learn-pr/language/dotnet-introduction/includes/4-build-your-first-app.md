If you've never written a line of code before, this exercise will help you discover the joy of seeing your code come to life.  You'll follow the basic steps of creating a .NET application that we talked about in the previous units.

## Build a simple app by using C#

Earlier, we mentioned that Try .NET provides an easy way to experiment with C# and .NET. You can use it without installing any software on your local computer.

> [!Note]
> In this module, we use a built-in version of [Try .NET](https://try.dot.net).  

### Step 1 - Write the code

In the .NET editor, on the right side of this web page, either type the following code sample or copy the code sample and then paste it in the .NET editor.

```csharp-interactive
Console.WriteLine("Hello world!");
```
"Hello world" is a simple and canonical code example that developers write to understand the basic syntax of new programming languages. You could learn a lot about the C# syntax from this code example. But for now, we'll use it to learn more about .NET.

### Step 2 - Run the code

Press the green **Run** button on the right side of the .NET editor. Assuming you inserted the C# code correctly, the words "Hello World!" appear in the **Output** pane below.

> [!IMPORTANT]
> If you see any errors while running this code, copy the code and then paste it in the .NET editor. Then try running the code again.


## How does it work?

Our browser version of Try .NET hides some of the code that you see when you build a full application by using Try .NET, Visual Studio 2019, or Visual Studio Code.

When we include the hidden code, here's how the example looks:

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

Nevertheless, the browser Try .NET environment uses the same steps we talked about earlier.  The only difference is that some of the steps are hidden to simplify  the experience. The code you wrote in the .NET editor was inserted into the `public static void Main()` code block automatically. 

Focusing on that expanded view of the code, you can see a series of curly braces `{ }`. C# uses a pair of curly braces to define a *code block*.  Different kinds of code blocks are used for different purposes.

The code `public static void Main()` and its set of curly braces define a type of code block called a *method*. A method contains a grouping of code that works toward a single purpose or responsibility in your software system. 

In this case, the method contains only one line of code. Its purpose is to display a message. Larger programs can have hundreds or thousands of methods.

Methods are organized inside other code blocks called classes.  A *class* can contain one or more methods. Ideally, all of the methods in a class have a related purpose in the system. The class in the preceding code is named `Program`.

In your inserted line of code, `Console.WriteLine()` is *calling*, or running, the method `WriteLine()`. The method `WriteLine()` is contained in the class `Console`.  

Where is this code?  It's in the base class library.  Actually, its full name is `System.Console.WriteLine()`.  In the preceding code, you see that the first line is:

```csharp
using System;
```

The word `System` is omitted in your call to `Console.WriteLine()`. But the first line of code `using System;` tells the C# compiler to look in the base class library if it can't find the method definition in your code.

> [!NOTE]
> Don't worry about C#-specific terms terms like method, class, System, and using. You can learn about those later.  The focus right now is the process of compiling and executing your code.

When you select the green **Run** button, your code is sent to a server. There, your code is compiled into a .NET assembly. Then the .NET runtime opens the .NET assembly and looks in a class named `Program` to find a method named `Main()` to begin running the instructions. When the instruction to print the words "Hello world!" finishes, the running path continues to the next line but finds nothing. So the path ends, and the .NET runtime removes the program from its memory.  Meanwhile, Try .NET delivers the output back to your web browser.

This sequence of events, and the basic division of responsibilities among a programming language, a compiler, and a runtime, are the most important concepts to understand as you're getting started.