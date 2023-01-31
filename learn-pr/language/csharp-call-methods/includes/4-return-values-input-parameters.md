In the previous unit, we used the dice-roll code to illustrate the two different methods: stateful (instance) and stateless (static) methods. However, that same code example can help us understand other critical ideas about calling methods like handling return values, accepting input parameters and choosing an overloaded version of a method.

## Return values

Some methods are designed to complete their function and end "quietly." In other words, they don't return values when they finish. They're referred to as **void methods**.

Methods designed to return a value upon completion are typically the result of an operation. A return value is a primary way a method can communicate back to the code that calls the method.

A method can be designed to return any data type, even another class. In this case, the `Random.Next()` method returns an `int` value of the randomly generated number. We save the return value into a variable for use later in our code. We could've ignored the return value like so:

```csharp
dice.Next(1, 7);
```

However, this would be pointless. The reason we're calling this method is so that we can retrieve the next random value from the Random object.

## Input parameters

Some methods are designed to accept no input parameters. These methods need no additional input to complete their task.

Other methods are designed to accept one or more input parameters. The input parameters might configure how the method performs its work, or the input parameters might be operated on directly. We can see both cases in our example.

When calling methods, separate each input parameter with a `,` symbol.

In the following line of code, the two input parameters define the lower and upper boundaries, respectively, for the `Next()` method as it generates a new random number:

```csharp
int roll = dice.Next(1, 7);
```

And in the following line of code, the input parameters are what the `WriteLine()` operates on to display to the console:

```csharp
Console.WriteLine(roll);
```

Input parameters are defined using a data type. We can't pass values of a different data type as input parameters and expect the method to work. Instead, the C# compiler will catch a mistake and force a code modification before it compiles and runs the code. Type checking is one way C# and .NET users check data types to prevent end users from experiencing exceptions.

A **method signature** is the number of input parameters defined for each input parameter and the data type.

## Overloaded methods

Many methods in the .NET Class Library have *overloaded* method signatures.

An **overloaded method** is defined with multiple method signatures. Overloaded methods provide different ways to call the method or provide different types of data.

In some cases, overloaded versions of a given method allow you to send values of different data types into the method. For example, the `Console.WriteLine()` method has 19 different overloaded versions. Most of those overloads allow sending of different types of data to be printed to the console. Consider the following code:

```csharp-interactive
int number = 7;
string text = "seven";

Console.WriteLine(number);
Console.WriteLine();
Console.WriteLine(text);
```

In this example, you're invoking three separate overloaded versions of the `WriteLine()` method.

In other cases, overloaded versions of a given method allow sending additional configuration details to the method about the result desired. For example, the `Random.Next()` method has three different overloaded versions. The three versions allow setting constraints on the randomly generated number.

The following code example calls the `Random.Next()` using three different overloaded versions.

```csharp-interactive
Random dice = new Random();
int roll1 = dice.Next();
int roll2 = dice.Next(101);
int roll3 = dice.Next(50, 101);

Console.WriteLine($"First roll: {roll1}");
Console.WriteLine($"Second roll: {roll2}");
Console.WriteLine($"Third roll: {roll3}");
```

The first version of the `Next()` method doesn't set an upper and lower boundary, so the method will return values ranging from `0` to `2,147,483,647`, which is the maximum value an `int` can store.

The second version of the `Next()` method specifies the maximum value as an upper boundary, so in this case, we can expect a random value between `0` and `100`.

The third version of the `Next()` method specifies both the minimum and maximum values, so in this case, we can expect a random value between `50` and `100`.

Here, we've described:

- What a method can do.
- Whether a method has overloaded versions.
- Which data types a method accepts as input parameters.
- Whether a method has a return value, and if so, what it returns.

### Use Intellisense

First, the code editor's *Intellisense* may tell us a lot about a method without leaving the coding environment. **Intellisense** is a feature of code editors from Microsoft. It provides hints and brief reference information in a popup window under the caret as you enter your code. When typing code, the Intellisense popup window will change its contents depending on the context.

For example, as you enter the word `dice` slowly, Intellisense will show all C# keywords, identifiers (or rather, variable names in the code), and classes in the .NET Class Library that match the letters being entered. Autocomplete features of the code editor can finish typing the word that is the top match in the Intellisense popup.

To experiment with Intellisense, enter the letters `d`, `i` then `c`. When Intellisense pops up, the identifier `dice` should appear. Select the <kbd>Tab</kbd> key on the keyboard, and the entire word will be completed. You can also use the up and down arrow keys to change the selection.

> [!NOTE]
> If the Intellisense window disappears, you can get it back by using the <kbd>Backspace</kbd> key on the keyboard, then re-entering the last symbol to re-open Intellisense.

Next, enter the member access operator. The Intellisense popup reappears and shows all of the methods (and other members of the class) that are available. If you enter the letter `N`, the list will be filtered, and the word `Next` should be the top selection. Again, select the <kbd>Tab</kbd> key on the keyboard to autocomplete the entire word.

Next, enter the *opening* parenthesis. The closing parenthesis is automatically added.

More importantly, two areas appear in the Intellisense popup. On the right, you should see `int Random.Next()`. The `int` is the return type. In other words, when executed, this version of the method will return a value of type `int`.

On the left of the Intellisense popup, it displays `1/3`, indicating you're looking at the first version of the `Next()` method, which accepts no input parameters. There's also a tiny arrow above and below the `1/3`. Select the keyboard's up and down arrow keys to navigate to the second and third overloaded versions of the method. When you do, you'll see `2/3` and `3/3` appear on the left side of Intellisense, respectively.

The second overloaded version of the method `2/3` informs you that the `Next()` method can accept an input parameter `int maxValue`. The third version of the method `3/3` informs you that the `Next()` method can accept both `int minValue` and `int maxValue` as input parameters.

What is `maxValue` and `minValue`? Usually, we can derive the meaning of the parameter through its name. However, if it's not apparent, we may need to consult the method's documentation. In this case, the `maxValue` is the maximum, or "upper boundary" that we want the `Next()` method to generate. The `minValue` is the minimum or "lower boundary" that we want the `Next()` method to generate.

### Use Microsoft Learn for information about overloaded methods

The second way to learn about overloaded versions of the methods is to consult the method's documentation. The documentation will also help in understand exactly what each input parameter is intended for.

To begin, use a search engine and search for the class name and method name. You may also want to include the term `C#` to make sure not to accidentally get results for other programming languages. In this case, try searching for: `C# Random.Next()`.

One of the top search results should lead to a URL that begins with `https://learn.microsoft.com`. In our case, the link's title should appear as **Random.Next Method (System) | Microsoft Learn**.

Here's the link in case you have a problem finding it using a search engine:

[Random.Next Method](/dotnet/api/system.random.next?azure-portal=true)

The documentation follows a standard format for each class and method in the .NET Class Library.

Near the top of the web page, you'll have a section called "Overloads". There are three versions of the method listed there with hyperlinks deeper into the page. Select the `Next(Int32)` link and review the documentation for that specific overloaded version of the method.

Each version of the method displays:

- Brief description of the method's functionality
- Method's definition
- Input parameters that the method accepts
- Return values
- Exceptions that can be raised
- Examples of the method in use
- Additional remarks about the method

In the *Parameters* section, we learn that the `maxValue` input parameter is the "exclusive upper bound of the random number to be generated." An *exclusive upper bound* means that if we want numbers no larger than `10`, we must pass in the value `11`.

We can also learn in the next line: "`maxValue` must be greater than or equal to 0." What happens if we ignore this statement? We can find in the *Exceptions* section that the method will return an `ArgumentOutOfRangeException` when `maxValue` is less than 0.

Like we described earlier, Microsoft Learn is the source of truth for the .NET Class Library. It's important to take the time to read the documentation to understand how a given method will work.

## Recap

- Methods may accept no parameters or multiple parameters, depending on how they were designed and implemented. When passing in multiple input parameters, separate them with a `,` symbol.
- Methods may return a value when they complete their task, or they may return nothing (void).
- Overloaded methods support several implementations of the method, each with a unique method signature (the number of input parameters and the data type of each input parameter).
- Intellisense can help write code more quickly. It provides a quick reference to methods, their return values, their overloaded versions, and the types of their input parameters.
- Microsoft Learn is the "source of truth" when you want to learn how methods in the .NET Class Library work.
