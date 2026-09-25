
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=f0119d96-be1f-4d29-bc6c-3846a098c90c]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Programs become truly powerful when they can interact with the people using them. C#'s `Console.ReadLine()` method lets you pause your program, wait for the user to type something, and capture that information.

## Using Console.ReadLine()

Think of the `Console.ReadLine()` method as a question prompt. When your program hits this line, it waits until the user types their answer and presses the **Enter** key before continuing.

To save the user's answer, you must "catch" it using a variable:

```csharp
string favoriteColor = Console.ReadLine();
Console.WriteLine("Oh, I love " + favoriteColor + " too!");
```

In this code, `favoriteColor` is a variable (a container that holds a value). When you run this program, it waits for input. If the user types `Orange` and presses **Enter**, the output is:

```output
Orange
Oh, I love Orange too!
```

You can try running this code yourself in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor).

### Add a space at the end of your prompt

To make the user input more readable, combine `Console.Write()` with `Console.ReadLine()`:

```csharp
Console.Write("What is your favorite color? ");
string favoriteColor = Console.ReadLine();
Console.WriteLine("Oh, I love " + favoriteColor + " too!");
```

Notice the space at the end of the prompt: `"What is your favorite color? "`. Without it, the user's input would look glued to your text: `What is your favorite color?Orange`. Adding a space makes it clearer.

## Understanding data types

Every value in C# has a **data type**, which tells the computer what kind of value it is. Some common data types are:

- **String (`string`)**: Text wrapped in quotes, like `"Blue"` or `"25"`. Even a number becomes text when it's inside quotes.
- **Integer (`int`)**: A whole number without quotes, like `25` or `100`. You can do math with these.

Why does this matter? C# treats these types differently. You can add numbers together (`25 + 1` equals `26`), but you can't directly add a number to text without special handling.

## Console.ReadLine() always returns a string

An essential rule to remember is that `Console.ReadLine()` *always* returns text (a string), even if the user types a number. For example:

```csharp
string age = Console.ReadLine();
Console.WriteLine(age + 1); // This causes an error!
```

If you run this code and type `25`, the program won't print `26`. Instead, it tries to add `1` to the text `"25"`, which C# doesn't allow. This is a common beginner mistake!

To do math with user input, you'd need to convert the text to a number first—but we'll cover that later. For now, remember: whatever the user types is always treated as text.

::: zone-end

