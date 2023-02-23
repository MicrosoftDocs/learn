In this unit, we'll learn how to format strings to display this information accurately and more succinctly than string concatenation.

### What is Composite Formatting?

*Composite formatting* uses numbered placeholders within a string. At run time, everything inside the braces will be resolved to a value that's also passed in based on their position.

Here's an example of composite formatting using a built-in method `Format()` on the `string` data type keyword:

```csharp-interactive
string first = "Hello";
string second = "World";
string result = string.Format("{0} {1}!", first, second);
Console.WriteLine(result);
```

We'll talk about the different kinds of built-in methods that are available on the `string` data type and on variables of type `string`.

If you run this code, you'll get the following output:

```output
Hello World!
```

There are a few important things to notice about this code.

- Data types and variables of a given data type have built-in "helper methods" to make certain tasks easy.
- The literal string `"{0} {1}!"` forms a template, parts of which will be replaced at run time.
- The token `{0}` is replaced by the first argument after the string template; in other words, the value of the variable `first`.
- The token `{1}` is replaced by the second argument after the string template; in other words, the value of the variable `second`.

> [!NOTE]
> You may think it's odd to start with the number 0. Actually, this is very common in software development. Whenever there's a sequence of items that can be identified using a number, the numbering will usually start at 0.

To exercise this idea a bit more, consider the following code:

```csharp-interactive
string first = "Hello";
string second = "World";
Console.WriteLine("{1} {0}!", first, second);
Console.WriteLine("{0} {0} {0}!", first, second);
```

If you run this code, you should get the following output:

```output
World Hello!
Hello Hello Hello!
```

A few observations about these examples:

- In the case of the first `Console.WriteLine()` statement, you can see that the tokens can be arranged in any order. Here, we have `{1}` before `{0}`.
- In the case of the second `Console.WriteLine()` statement, you can see that the tokens can be reused, and even omit the variable arguments that are passed in.

### What is string interpolation?

*String interpolation* is a newer technique that simplifies composite formatting. If you look at code examples in books and online, you're likely to see both techniques used, but generally you should prefer string interpolation.

Instead of using a numbered token and including the literal value or variable name in a list of arguments to `String.Format()` or `Console.WriteLine()`, you can just use the variable name inside of the curly braces.

In order for a string to be interpolated, you must prefix it with the `$` directive. Here's the same examples from earlier, using string interpolation instead of composite formatting:

```csharp-interactive
string first = "Hello";
string second = "World";
Console.WriteLine($"{first} {second}!");
Console.WriteLine($"{second} {first}!");
Console.WriteLine($"{first} {first} {first}!");
```

If you run the code, you'll get the following output:

```output
Hello World!
World Hello!
Hello Hello Hello!
```

### Formatting currency

You can use composite formatting and string interpolation to format values for display, given a specific language and culture. In the following example, the `:C` currency format specifier is used to present the `price` and `discount` variables as currency.

```csharp-interactive
decimal price = 123.45m;
int discount = 50;
Console.WriteLine($"Price: {price:C} (Save {discount:C})");
```

When you run the code in the .NET Editor, you'll get the following output:

```output
Price: ¤123.45 (Save ¤50.00)
```

The symbol `¤` is used instead of the symbol for your country's/region's currency. This is a generic symbol used to denote "currency" regardless of the *type* of currency. You'll see this symbol in the .NET Editor because it ignores your current location.

However, if you executed this code on a computer in the United States that has its Windows Display Language set to English, you'll get the following output:

```output
Price: $123.45 (Save $50.00)
```

Notice how adding the `:C` to the tokens inside of the curly braces formats the number as currency regardless of whether you use `int` or `decimal`.

## How the user's country/region and language impact string formatting

What if you execute the preceding code on a computer in France that has its Windows Display Language set to French? In that case, you would get the following output:

```output
Price: 123,45 € (Save 50,00 €)
```

This happens because using these string-formatting features is dependent on the computing *culture*. In this context, the term "culture" refers to the country/region and language of the end user. The *culture code* is a five-character string that computers use to identify the location and language of the end user to ensure certain information, like dates and currency, can be presented properly.

For example:

- The culture code of an English speaker in the USA is `en-US`.
- The culture code of a French speaker in France is `fr-FR`.  
- The culture code of a French speaker in Canada is `fr-CA`.

The culture affects the writing system, the calendar that's used, the sort order of strings, and formatting for dates and numbers (like formatting currency).

Unfortunately, making sure your code works correctly on all computers regardless of the country/region or the end user's language is challenging. This process is known as *localization* (or *globalization*). Localization depends on many factors that we can't discuss in this module. For now, just be aware that the string formatting syntax may use a different format depending on the user's culture.

### Formatting numbers

When working with numeric data, you may want to format the number for readability by including commas to delineate thousands, millions, billions, and so on.

The `N` numeric format specifier will do this.

```csharp-interactive
decimal measurement = 123456.78912m;
Console.WriteLine($"Measurement: {measurement:N} units");
```

If you're viewing this from the `en-US` culture, you'll get the following output:

```output
Measurement: 123,456.79 units
```

By default, the `N` numeric format specifier displays only two digits after the decimal point.  

If you want to display more precision, you can add a number after the specifier. The following code will display four digits after the decimal point using the `N4` specifier:

```csharp-interactive
decimal measurement = 123456.78912m;
Console.WriteLine($"Measurement: {measurement:N4} units");
```

If you're viewing this from the `en-US` culture, you'll get the following output:

```output
Measurement: 123,456.7891 units
```

### Formatting percentages

You can use the `P` format specifier to format percentages. Add a number afterwards to control the number of values displayed after the decimal point.

```csharp-interactive
decimal tax = .36785m;
Console.WriteLine($"Tax rate: {tax:P2}");
```

```output
Tax rate: 36.79 %
```

## Recap

Here are most important takeaways from this unit about string formatting:

- You can use composite formatting or string interpolation to format strings.
- With **composite formatting**, you'll use a string template containing one or more replacement tokens in the form `{0}`. You'll also supply a list of arguments that are matched with the replacement tokens based on their order.  Composite formatting works when using `string.Format()` or `Console.WriteLine()`.
- With **string interpolation**, you'll use a string template containing the variable names you want replaced surrounded by curly braces. You can use the `$` directive before the string template to indicate you want the string to be interpolated.
- You can format currency using a `:C` specifier.
- You can format numbers using a `:N` specifier. You can control the precision (number of values after the decimal point) by using a number after the `:N`, like `{myNumber:N3}`.
- Formatting currency and numbers depends on the end user's culture, a five-character code that includes the user's country/region and language (per the settings on their computer).
