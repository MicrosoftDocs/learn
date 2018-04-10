Your first program printed the `string` "Hello World!" on the screen.

> [!TIP]
> As you explore C# (or any programming language), you'll
> make mistakes when you write code. The **compiler** will
> find those errors and report them to you. When the output
> contains error messages, look closely at the example code,
> and the code in the interactive window to see what to fix.
> That exercise will help you learn the structure of C# code.

Your first program is limited to printing one message. You can write more
useful programs by using **variables**. A **variable** is a symbol you can
use to run the same code with different values. Let's try it! Replace the
code you've written in the interactive window with the following code:

```csharp
string aFriend = "Bill";
Console.WriteLine(aFriend);
```

The first line declares a variable, `aFriend` and assigns it a value, "Bill". The second line
prints out the name.

You can assign different values to any variable you declare. You can change
the name to one of your friends. Add these two lines in the interactive window
following the code you've already added:

```csharp
aFriend = "Maria";
Console.WriteLine(aFriend);
```

Notice that the same line of code prints two different messages, based on
the value stored in the `aFriend` variable.

You may have also noticed that the word "Hello" was missing in the last two messages. Let's fix
that now.  Modify the lines that print the message to the following:

```csharp
Console.WriteLine("Hello " + aFriend);
```

Click **Run** again to see the results.

As we progress, creating strings to print using `+` becomes cumbersome. String interpolation lets you piece together strings in a more concise and readable way.

If you add a `$` before the opening quotes of the string, you can then include string expressions, like the `aFriend` variable, inside the string in curly brackets.


```csharp
Console.WriteLine($"Hello {aFriend}");
```

Click **Run** again to see the results.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).