You've been using a **method**, <xref:System.Console.WriteLine%2A?displayProperty=nameWithType>, to print messages. A **method** is a block of code that implements some action. It has a name, so you can access it.

The `string` type has many useful methods. Let's explore the <xref:System.String.Trim%2A> method, and related methods <xref:System.String.TrimStart%2A> and <xref:System.String.TrimEnd%2A>. These methods remove leading and trailing spaces:

```csharp
string greeting = "      Hello World!       ";
Console.WriteLine($"[{greeting}]");

string trimmedGreeting = greeting.TrimStart();
Console.WriteLine($"[{trimmedGreeting}]");

trimmedGreeting = greeting.TrimEnd();
Console.WriteLine($"[{trimmedGreeting}]");

trimmedGreeting = greeting.Trim();
Console.WriteLine($"[{trimmedGreeting}]");
```

This sample reinforces a couple of important concepts for working with strings. The methods that manipulate strings return new string objects rather than making modifications in place. You can see that each call to any of the `Trim` methods returns a new string, but does not change the original message.

There are other methods available to work with a string. For example, you've probably used a search and replace command in an editor or word processor. The <xref:System.String.Replace%2A> method does something similar in a `string`. It searches for a substring, and replaces it with different text. The <xref:System.String.Replace%2A> method takes two **parameters**. These are the strings between the parentheses. The first string is the text to search for. The second string is the text to replace it with. Try it for yourself. Add this code:

```csharp
string sayHello = "Hello World!";
Console.WriteLine(sayHello);
sayHello = sayHello.Replace("Hello", "Greetings");
Console.WriteLine(sayHello);
```

Two other useful methods make a string ALL CAPS or all lower case. Try the following code:

```csharp
Console.WriteLine(sayHello.ToUpper());
Console.WriteLine(sayHello.ToLower());
```

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).
