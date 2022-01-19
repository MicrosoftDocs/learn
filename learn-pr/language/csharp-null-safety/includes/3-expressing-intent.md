In the previous unit, you learned how the C# compiler can perform static analysis to help guard against `NullReferenceException`. You also learned how to enable a nullable context. In this unit, you'll learn more about explicitly expressing your intent within a nullable context.

## Enforcing behavior

With a nullable context enabled, you now have more visibility into how the compiler sees your code. The warnings generated from a nullable-enabled context can be acted upon, and in doing so you're explicitly defining your intentions. For example, let's continuing examining the `FooBar` code and scrutinize the declaration and assignment:

```csharp
// Define as nullable
FooBar? fooBar = null;
```

This tells the compiler that you explicitly intend for `fooBar` to be nullable. If you do not intend for the `fooBar` to be nullable, but you still want to avoid the warning, consider the following:

```csharp
// Define as non-nullable, but tell compiler to ignore warning
// Same as FooBar fooBar = default!;
FooBar fooBar = null!;
```

This is the null-forgiving (`!`) operator and it tells the compiler to ignore the CS8600 warning. This is one way to tell the compiler that you know what you're doing, but it comes with the caveat that you should _actually know what you're doing_!

> [!TIP]
> The null-forgiving operator is colloquially referred to as the "dammit" operator. _I know what I'm doing, dammit!_

## Operators

### null-forgiving (`!`) operator

You were introduced to the null-forgiving operator (`!`) in the previous section. When you initialize non-nullable types while a nullable context is enabled, you may need to explicitly ask the compiler for forgiveness.

For example, consider the following code:

```csharp
#nullable enable

FooBarFactory factory = new FooBarFactory();
FooBar fooBar = factory.GetFooBar();

Console.WriteLine(fooBar.Name);
```

In the preceding example, assume `fooBar` is 

### null-coalescing (`??`) operator

When working with nullable types, you may need to evaluate whether they're currently `null` and take certain action. For example, when a nullable type has either been assigned `null` or they're uninitialized you may need to assign them a non-null value.

```csharp
public void CalculateSalesTax(IStateSalesTax? salesTax = null)
{
    salesTax ??= DefaultStateSalesTax.Value;

    // Safely use salesTax object.
}
```

In the preceding C# code:

- The `salesTax` parameter is defined as being nullable.
- Within the method body, the `salesTax` is conditionally assigned using the null-coalescing operator.
  - This ensures that if `salesTax` was passed in as `null` that it will have a value.

> [!TIP]
> This is functionally equivalent as the following C# code:
>
> ```csharp
> public void CalculateSalesTax(IStateSalesTax? salesTax = null)
> {
>     if (salesTax is null)
>     {
>         salesTax = DefaultStateSalesTax.Value;
>     }
> 
>     // Safely use salesTax object.
> }
> ```

### null-conditional (`?.`) operator

When working with nullable types, you may need to conditionally perform actions based on the state of a `null` object. For example, from the previous unit the `FooBar` record exemplified the `NullReferenceException` by dereferencing `null`. This was caused when its `ToString` was called. Consider this same example, but now applying the null-conditional operator:

```csharp
using System;

// Declare variable and assign it as null.
FooBar fooBar = null;

// Conditionally dereference variable.
var str = fooBar?.ToString();
Console.Write(str);

// The FooBar type definition.
record FooBar(int Id, string Name);
```

The preceding C# code:

- Declares and assigns a variable named `fooBar` (of type `FooBar`) to `null`.
- It conditionally dereferences `fooBar`, assigning the result of `ToString` to the `str` variable.
- It writes the value of `str` to standard output which is nothing.
