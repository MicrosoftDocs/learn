Your last edit was our first look at what you can do with strings. Let's explore more.

The `+` is called an operator in C#. When applied to strings like `firstString + secondString`, a new string is created with the text from the first followed by the text from the second. This is referred to as *string concatenation*. You can combine any number of strings, including string variables.  Try this:

```csharp
string firstFriend = "Maria";
string secondFriend = "Sage";
Console.WriteLine($"My friends are {firstFriend} and {secondFriend}");
```

As you explore more with strings, you can find the length of a string using `Length`. `Length` is a **property** of a string and it returns the number of characters in that string. Add the following code at the bottom of the interactive window:

```csharp
Console.WriteLine($"The name {firstFriend} has {firstFriend.Length} letters.");
Console.WriteLine($"The name {secondFriend} has {secondFriend.Length} letters.");
```

> [!TIP]
> This is a good time to explore on your own. You've learned that `Console.WriteLine()`
> writes text to the screen. You've learned how to declare variables and
> concatenate strings together. Experiment in the interactive window. Write
> some more messages yourself. Build strings using the `+` operator.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).