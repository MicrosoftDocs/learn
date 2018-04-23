In the previous lesson, two poorly formatted strings were inserted into the result string. One was a date and time value for which only the date was appropriate. The second was a price that did not indicate its unit of currency. Both issues are easy to address. Interpolated expressions can include *format strings* that control the formatting of particular types. Modify the call to `Console.WriteLine` from the previous example to include the format specifier for the date and price fields as shown in the following line:

```csharp
Console.WriteLine($"On {date:d}, the price of {item} was {price:C2} per {unit}.");
```

You specify a format string by following the interpolated expression with a colon and the format string. "d" is a standard date and time format string that represents the short date format. "C2" is a standard numeric format string that represents a number as a currency value with two digits after the decimal point.

A number of types in the .NET Standard libraries support a predefined set of format strings. These include all the numeric types and the date and time types. For a complete list of types that support format strings, see Format Strings and .NET Class Library Types in the Formatting Types in .NET article. Any type can support a set of format strings, and you can also develop custom formatting extensions that provide custom formatting for existing types. For information on custom formatting by providing an <xref:System.ICustomFormatter> implementation, see Custom Formatting with ICustomFormatter in the Formatting Types in .NET article.

Try modifying the format strings in the **.NET Editor** to see how they affect the formatting of the date and time and the numeric value. Change the "d" in `{date:d}` to "t" (to display the short time format), "y" (to display the year and month), and "yyyy" (to display the year as a four-digit number). Change the "C2" in `{price:C2}` to "e" (for exponential notation) and "F3" (for a numeric value with three digits after the decimal point).

In addition to controlling formatting, you can also control the field width and alignment of the strings returned by an interpolated expression. In the next step, you'll learn how to do this.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).