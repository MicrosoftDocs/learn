



Your goal was to use several different techniques to change the data type of a given value.

You used *implicit conversion*, relying on the C# compiler to perform *widening conversions*. When the compiler was unable to perform an implicit conversion, you used *explicit conversions*. You used the `ToString()` method to explicitly convert a numeric data type into a `string`.

When you needed to perform `narrowing conversions`, you used several different techniques. You used the casting operator `()` when the conversion could be made safely and were willing to accept truncation of values after the decimal. And you used the `Convert()` method when you wanted to perform a conversion and use common rounding rules when performing a narrowing conversion.

Finally, you used the `TryParse()` methods when the conversion from a `string` to a numeric data type could potentially result in a data type conversion exception.

Without this wealth of options, it would be difficult to work in a typed programming language. Fortunately, this well executed system of types, conversion, and casting can be harnessed to build error free applications.

## Resources

- [Casting and type conversions (C# programming guide)](/dotnet/csharp/programming-guide/types/casting-and-type-conversions)
- [Built-in types (C# reference)](/dotnet/csharp/language-reference/builtin-types/built-in-types)
- [Default values of C# types (C# reference)](/dotnet/csharp/language-reference/builtin-types/default-values)
