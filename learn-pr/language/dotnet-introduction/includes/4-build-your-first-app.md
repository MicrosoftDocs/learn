At the outset of this module, we assumed that you've already written a "Hello World" application with C#.  If not, you may want to take a moment to review the first module in this Learning Path titled [Write your first C# code](https://docs.microsoft.com/en-us/learn/modules/csharp-write-first/?azure-portal=true).

For simplicity, we'll re-write the "Hello World" application, this time with a focus of what's happening behind the scenes from a .NET perspective.

## Build a simple app using C#

Earlier, we talked about how Try .NET provides a quick and easy way to experiment with C# and .NET without installing any software on your local computer.

> [!Note]
> In this module, we're using a built-in version of Try .NET which you can access at the URL: https://try.dot.net.  Try .NET is a great way to try out small code examples without installing anything on your local computer.

### Step 1 - Write the code

On the .NET Editor on the right hand pane of this web page, either:

- type the code in the listing, below.
- copy and paste the code from the listing to the .NET Editor.

This is the code listing you should duplicate:

```csharp-interactive
Console.WriteLine("Hello world!");
```
As discussed in the pre-requisite module, "Hello world" is a simple and canonical code example that most developers write to understand the basic syntax of new programming languages. While there's a lot to learn about the C# syntax from this simple example, in our case, we'll use it to learn more about .NET specifically.

### Step 2 - Run the code

Press the green **Run** on the right of the .NET Editor. Assuming you typed (or copied and pasted) the C# code correctly, this time the words `Hello World!` are displayed in our Output pane at the bottom.

> [!IMPORTANT]
> If you got any errors while running this code, please copy and paste it from the code provided above.

### What happens to the code you write?

First off, our in-browser version of Try .NET hides some of the code that you would see when building a full application using Try .NET, Visual Studio 2019, or Visual Studio Code.

In fact, here's what your code example really looks like:

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

Nevertheless, the in-browser Try .NET environment uses the same steps we talked about earlier. The only difference is that this is hidden from you to simplify  the experience.

The code you write in the in-browser editor is inserted into the `public static void Main()` code block automatically. 

Focusing on that code listing, you can see a series of curly braces `{ }`. A **code block** is defined in C# by using a pair of curly braces.  There are different kinds of code blocks for different purposes.

The code `public static void Main()` along with the associated set of curly braces define a type of code block called a **method**, and a method simply contains a grouping of code that works together for a single purpose or responsibility in your software system. In this case, the method only contains one line of code and the purpose is to display a simple message. Larger programs can have hundreds or thousands of methods.

Methods are organized inside of other code blocks called classes.  A **class** can contain one or more methods. Ideally, all of the methods in a class have a related purpose in the system. This class has a name, called simply, `Program`.

Your line of code, `Console.WriteLine()` is calling, or executing, the method `WriteLine()` that is contained in the class `Console`.  

Where is this code?  It's part of the Base Class Library.  Actually, its full name full name is `System.Console.WriteLine()`.  If you look at the listing above, the first line is:

```csharp
using System;
```

The word `System` was omitted in your call to `Console.WriteLine()`, but the first line of code `using System;` will tell the C# compiler to look in the Base Class Library if it can't find the method defined anywhere else in your code.

> [!NOTE]
> Don't worry about terms like method, class, System, using, and the other C# specific terms. You can learn about those later.  The focus right now is the process of compiling and executing your code.

### What happens to your code once it is inserted into the Main() method?

The most important part of this exercise is what happens after the code you write is injected into a `Main()` method.  Keep in mind that all of this is happening on a server on your behalf.

First, the C# compiler is invoked with a command to compile your newly formed code.

The C# compiler will ensure that your code can be compiled and is free from syntax errors. If it cannot compile your code, compiler will stop and will send an error message back to the Output pane.

If the C# compiler succeeds, the .NET runtime will open the newly compiled .NET assembly.  It knows that, by default, it should look in a class named `Program` to find a method named `Main()` to begin executing the instructions.

Then, instruction by instruction, the .NET runtime evaluates each line of code, executes the instruction, and moves on the to next line of code.

In this case, once the instruction to print the words "Hello world!" has finished, the path of execution will continue to the next line, but finds nothing, and so it will end, and the .NET runtime will remove the program from its memory.  Meanwhile, the output from the `WriteLine()` instruction will be captured and  delivered the output back to your web browser.

Just understanding this sequence of events, and the basic delineation of responsibilities between a programming language, a compiler, and a runtime, means that you've already overcome one of the most important concepts as you're getting started!