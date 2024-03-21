In this unit, you learn methods to format strings for efficient display, especially for cases using multiple variables.

### Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities help you to become more comfortable writing and running code in a developer environment used by professionals worldwide.

> [!NOTE]
> If you have completed other Microsoft Learn modules in this C# series, you may have already created a project folder for code samples. If that's the case, you can skip  the following section of steps, and delete the code in the `Project.cs` file used for a previous exercise.

1. Open Visual Studio Code.
   You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. On the Visual Studio Code **File** menu, select **Open Folder**.

1. In the **Open Folder** dialog, navigate to the Windows Desktop folder.
   If you have a different folder location where you keep code projects, you can use that folder location instead. For this training, the important thing is to have a location that's easy locate and remember.

1. In the **Open Folder** dialog, select **Select Folder**.
   If you see a security dialog asking if you trust the authors, select **Yes**.

1. On the Visual Studio Code **Terminal** menu, select **New Terminal**.
   Notice that a command prompt in the Terminal panel displays the folder path for the current folder. For example:  
   ```dos
   C:\Users\someuser\Desktop>
   ```

1. At the Terminal command prompt, to create a new console application in a specified folder, type **dotnet new console -o ./CsharpProjects/TestProject** and then press Enter.
   This .NET CLI command uses a .NET program template to create a new C# console application project in the specified folder location. The command creates the CsharpProjects and TestProject folders for you, and uses TestProject as the name of the `.csproj` file.

1. In the EXPLORER panel, expand the **CsharpProjects** folder.
   You should see the TestProject folder and two files, a C# program file named Program.cs and a C# project file named TestProject.csproj.

1. In the EXPLORER panel, to view your code file in the Editor panel, select **Program.cs**.

1. Delete the existing code lines.
   You use this C# console project to create, build, and run code samples during this module.

1. Close the Terminal panel.

### What is Composite Formatting?

*Composite formatting* uses numbered placeholders within a string. At run time, everything inside the braces is resolved to a value that is also passed in based on their position.

This example of composite formatting uses a built-in method `Format()` on the `string` data type keyword. Update your code in the Visual Studio Code Editor as follows:

```csharp
string first = "Hello";
string second = "World";
string result = string.Format("{0} {1}!", first, second);
Console.WriteLine(result);
```

If you run this code, you observe the following output.

```Output
Hello World!
```

There are a few important things to notice about this code.

- Data types and variables of a given data type have built-in "helper methods" to make certain tasks easy.
- The literal string `"{0} {1}!"` forms a template, parts of which are replaced at run time.
- The token `{0}` is replaced by the first argument after the string template, in other words, the value of the variable `first`.
- The token `{1}` is replaced by the second argument after the string template, in other words, the value of the variable `second`.

> [!NOTE]
> You may think it's odd to start with the number 0. Actually this is very common in software development. Whenever there's a sequence of items that can be identified using a number, the numbering will usually start at 0.

1. Update your code as follows:
   ```csharp
   string first = "Hello";
   string second = "World";
   Console.WriteLine("{1} {0}!", first, second);
   Console.WriteLine("{0} {0} {0}!", first, second);
   ```

1. Save your code file, and then use Visual Studio Code to run your code.
   You should see the following output:
   ```Output
   World Hello!
   Hello Hello Hello!
   ```

A few observations about these examples:

- For the first `Console.WriteLine()` statement, observe that the tokens can be arranged in any order. The sample code has `{1}` before `{0}`.
- For the second `Console.WriteLine()` statement, observe that the tokens can be reused with three instances of `{0}`. Also, the second variable argument, `second`, isn't used. Yet, the code still runs without error.

### What is string interpolation?

*String interpolation* is a technique that simplifies composite formatting.

Instead of using a numbered token and including the literal value or variable name in a list of arguments to `String.Format()` or `Console.WriteLine()`, you can just use the variable name inside of the curly braces.

1. In order for a string to be interpolated, you must prefix it with the `$` directive. Now, create the same examples from earlier using string interpolation instead of composite formatting. Update your code as follows:
   ```csharp
   string first = "Hello";
   string second = "World";
   Console.WriteLine($"{first} {second}!");
   Console.WriteLine($"{second} {first}!");
   Console.WriteLine($"{first} {first} {first}!");
   ```

1. Save your code file, and then use Visual Studio Code to run your code.
   You should see the following output:
   ```Output
   Hello World!
   World Hello!
   Hello Hello Hello!
   ```

> [!NOTE]
> If you look at code examples in books and online, you're likely to see both *composite formatting* and *string interpolation* used, but generally you should choose *string interpolation*.

### Formatting currency

Composite formatting and string interpolation can be used to format values for display given a specific language and culture. In the following example, the `:C` currency format specifier is used to present the `price` and `discount` variables as currency. Update your code as follows:

```csharp
decimal price = 123.45m;
int discount = 50;
Console.WriteLine($"Price: {price:C} (Save {discount:C})");
```

If you executed this code on a computer that has its Windows display language set to "English (United States)", you observe the following output.

```Output
Price: $123.45 (Save $50.00)
```

Notice how adding the `:C` to the tokens inside of the curly braces formats the number as currency regardless of whether you use `int` or `decimal`.

> [!NOTE]
> What happens if your country/region and language isn't known? If you run the previous code in the "in-browser" .NET Editor, such as at [TrydotNet](https://dotnet.microsoft.com/en-us/platform/try-dotnet) you'll see the following output: **`Price: ¤123.45 (Save ¤50.00)`**.  The symbol **`¤`** is used instead of the symbol for your country/region's money. This is a generic symbol used to denote "currency" regardless of the *type* of currency. You see this symbol in the .NET Editor because it ignores your current location.

## How the user's country/region and language affect string formatting

What if you execute the previous code on a computer in France that has its Windows Display Language set to French? In that case you would see the following output.

```Output
Price: 123,45 € (Save 50,00 €)
```

The reason for the previous "€" output is that the string currency formatting feature is dependent on the local computer setting for *culture*. In this context, the term "culture" refers to the country/region and language of the end user. The *culture code* is a five character string that computers use to identify the location and language of the end user. The culture code ensures certain information like dates and currency can be presented properly.

For example:

- the culture code of an English speaker in the USA is `en-US`.
- the culture code of a French speaker in France is `fr-FR`.
- the culture code of a French speaker in Canada is `fr-CA`.

The culture affects the writing system, the calendar that's used, the sort order of strings, and formatting for dates and numbers (like formatting currency).

Unfortunately, making sure your code works correctly on all computers regardless of the country/region or the end user's language is challenging. This process is known as *localization* (or *globalization*). Localization depends on many factors not discussed in this module, but simply, the string formatting syntax might use a different format depending on the user's culture.

### Formatting numbers

When working with numeric data, you might want to format the number for readability by including commas to delineate thousands, millions, billions, and so on.

The `N` numeric format specifier makes numbers more readable. Update your code as follows:

```csharp
decimal measurement = 123456.78912m;
Console.WriteLine($"Measurement: {measurement:N} units");
```

If you're viewing this from the `en-US` culture, you observe the following output.

```Output
Measurement: 123,456.79 units
```

By default, the `N` numeric format specifier displays only two digits after the decimal point.

If you want to display more precision, you can do that by adding a number after the specifier. The following code will display four digits after the decimal point using the `N4` specifier. Update your code as follows:

```csharp
decimal measurement = 123456.78912m;
Console.WriteLine($"Measurement: {measurement:N4} units");
```

If you're viewing this from the `en-US` culture, you observe the following output.

```Output
Measurement: 123,456.7891 units
```

### Formatting percentages

Use the `P` format specifier to format percentages. Add a number afterwards to control the number of values displayed after the decimal point. Update your code as follows:

```csharp
decimal tax = .36785m;
Console.WriteLine($"Tax rate: {tax:P2}");
```

If you're viewing this from the `en-US` culture, you observe the following output.

```Output
Tax rate: 36.79 %
```

### Combining formatting approaches

String variables can store strings created using formatting techniques. In the following example, decimals and decimal math results are formatted and stored in the `yourDiscount` string using composite formatting.

Update your code as follows.

```csharp
decimal price = 67.55m;
decimal salePrice = 59.99m;

string yourDiscount = String.Format("You saved {0:C2} off the regular {1:C2} price. ", (price - salePrice), price);

Console.WriteLine(yourDiscount);
```

If you're viewing this from the `en-US` culture, you observe the following output.

```output
You saved $7.56 off the regular $67.55 price. 
```

You can combine multiple formatted strings. Build on the previous code concatenating the calculated percentage using the string interpolation instead of string concatenation by inserting `yourDiscount += $"A discount of {(price - salePrice)/price:P2}!";` into the code on the line before `Console.WriteLine()`.

> [!NOTE]
> You don't need to use `String.Format()` with this string interpolation approach.

Update your code as follows.

```csharp
decimal price = 67.55m;
decimal salePrice = 59.99m;

string yourDiscount = String.Format("You saved {0:C2} off the regular {1:C2} price. ", (price - salePrice), price);

yourDiscount += $"A discount of {((price - salePrice)/price):P2}!"; //inserted
Console.WriteLine(yourDiscount);
```

If you're viewing this unit from the `en-US` culture, you observe the following output.

```output
You saved $7.56 off the regular $67.55 price. A discount of 11.19%!
```

## Recap

Here are most important takeaways from this unit about string formatting:

- You can use composite formatting or string interpolation to format strings.
- With **composite formatting**, you use a string template containing one or more replacement tokens in the form `{0}`. You also supply a list of arguments that are matched with the replacement tokens based on their order. Composite formatting works when using `string.Format()` or `Console.WriteLine()`.
- With **string interpolation**, you use a string template containing the variable names you want replaced surrounded by curly braces. Use the `$` directive before the string template to indicate you want the string to be interpolated.
- Format currency using a `:C` specifier.
- Format numbers using a `:N` specifier. Control the precision (number of values after the decimal point) using a number after the `:N` like `{myNumber:N3}`.
- Format percentages using the `:P` format specifier.
- Formatting currency and numbers depend on the end user's culture, a five character code that includes the user's country/region and language (per the settings on their computer).