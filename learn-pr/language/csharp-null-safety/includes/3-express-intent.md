In the previous unit, you learned how the C# compiler can perform static analysis to help guard against `NullReferenceException`. You also learned how to enable a nullable context. In this unit, you'll learn more about explicitly expressing your intent within a nullable context.

## Declaring variables

With a nullable context enabled, you have more visibility into how the compiler sees your code. You can act upon the warnings generated from a nullable-enabled context, and in doing so, you're explicitly defining your intentions. For example, let's continue examining the `FooBar` code and scrutinize the declaration and assignment:

```csharp
// Define as nullable
FooBar? fooBar = null;
```

Note the `?` added to `FooBar`. This tells the compiler that you explicitly intend for `fooBar` to be nullable. If you don't intend for `fooBar` to be nullable, but you still want to avoid the warning, consider the following:

```csharp
// Define as non-nullable, but tell compiler to ignore warning
// Same as FooBar fooBar = default!;
FooBar fooBar = null!;
```

This example adds the null-forgiving (`!`) operator to `null`, which instructs the compiler that you're explicitly initializing this variable as null. The compiler won't issue warnings about this reference being null.

A good practice is to assign your non-nullable variables non-`null` values when they're declared, if possible:

```csharp
// Define as non-nullable, assign using 'new' keyword
FooBar fooBar = new(Id: 1, Name: "Foo");
```

## Operators

As discussed in the previous unit, C# defines several operators to express your intent around nullable reference types.

### Null-forgiving (`!`) operator

You were introduced to the null-forgiving operator (`!`) in the previous section. It tells the compiler to ignore the [CS8600 warning](/dotnet/csharp/language-reference/compiler-messages/nullable-warnings#possible-null-assigned-to-a-nonnullable-reference). This is one way to tell the compiler that you know what you're doing, but it comes with the caveat that you should *actually know what you're doing*!

When you initialize non-nullable types while a nullable context is enabled, you may need to explicitly ask the compiler for forgiveness. For example, consider the following code:

```csharp
#nullable enable

using System.Collections.Generic;

var fooList = new List<FooBar>
{
    new(Id: 1, Name: "Foo"),
    new(Id: 2, Name: "Bar")
};

FooBar fooBar = fooList.Find(f => f.Name == "Bar");

// The FooBar type definition for example.
record FooBar(int Id, string Name);
```

In the preceding example, `FooBar fooBar = fooList.Find(f => f.Name == "Bar");` generates a CS8600 warning, because `Find` might return `null`. This possible `null` would be assigned to `fooBar`, which is non-nullable in this context. However, in this contrived example, we know that `Find` will never return `null` as written. You can express this intent to the compiler with the null-forgiving operator:

```csharp
FooBar fooBar = fooList.Find(f => f.Name == "Bar")!;
```

Note the `!` at the end of `fooList.Find(f => f.Name == "Bar")`. This tells the compiler that you know that the object returned by the `Find` method might be `null`, and it's okay.

You can apply the null-forgiving operator to an object inline prior to a method call or property evaluation, too. Consider another contrived example:

```csharp
List<FooBar>? fooList = FooListFactory.GetFooList();

// Declare variable and assign it as null.
FooBar fooBar = fooList.Find(f => f.Name == "Bar")!; // generates warning

static class FooListFactory
{
    public static List<FooBar>? GetFooList() =>
        new List<FooBar>
        {
            new(Id: 1, Name: "Foo"),
            new(Id: 2, Name: "Bar")
        };
}

// The FooBar type definition for example.
record FooBar(int Id, string Name);
```

In the preceding example:

- `GetFooList` is a static method that returns a nullable type, `List<FooBar>?`.
- `fooList` is assigned the value returned by `GetFooList`.
- The compiler generates a warning on `fooList.Find(f => f.Name == "Bar");` because the value assigned to `fooList` might be `null`.
- Assuming `fooList` isn't `null`, `Find` *might* return `null`, but we know it won't, so the null-forgiving operator is applied.

You can apply the null-forgiving operator to `fooList` to disable the warning:

```csharp
FooBar fooBar = fooList!.Find(f => f.Name == "Bar")!;
```

> [!NOTE]
> You should use the null-forgiving operator judiciously. Using it simply to dismiss a warning means that you're telling the compiler not to help you discover possible null mishaps. Use it sparingly, and only when you are certain.

For more information, reference [! (null-forgiving) operator (C# reference)](/dotnet/csharp/language-reference/operators/null-forgiving).

### Null-coalescing (`??`) operator

When working with nullable types, you may need to evaluate whether they're currently `null` and take certain action. For example, when a nullable type has either been assigned `null` or they're uninitialized, you may need to assign them a non-null value. That's where the null-coalescing operator (`??`) is useful.

Consider the following example:

```csharp
public void CalculateSalesTax(IStateSalesTax? salesTax = null)
{
    salesTax ??= DefaultStateSalesTax.Value;

    // Safely use salesTax object.
}
```

In the preceding C# code:

- The `salesTax` parameter is defined as being a nullable `IStateSalesTax`.
- Within the method body, the `salesTax` is conditionally assigned using the null-coalescing operator.
  - This ensures that if `salesTax` was passed in as `null` that it will have a value.

> [!TIP]
> This is functionally equivalent to the following C# code:
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

Here's an example of another common C# idiom where the null-coalescing operator can be useful:

```csharp
public sealed class Wrapper<T> where T : new()
{
    private T _source;

    // If given a source, wrap it. Otherwise, wrap a new source:
    public Wrapper(T source = null) => _source = source ?? new T();
}
```

The preceding C# code:

- Defines a generic wrapper class, where the generic type parameter is constrained to `new()`.
- The constructor accepts a `T source` parameter that is defaulted to `null`.
- The wrapped `_source` is conditionally initialized to a `new T()`.

For more information, check out [?? and ??= operators (C# reference)](/dotnet/csharp/language-reference/operators/null-coalescing-operator).

### Null-conditional (`?.`) operator

When working with nullable types, you may need to conditionally perform actions based on the state of a `null` object. For example: in the previous unit, the `FooBar` record was used to demonstrate `NullReferenceException` by dereferencing `null`. This was caused when its `ToString` was called. Consider this same example, but now applying the null-conditional operator:

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

- Conditionally dereferences `fooBar`, assigning the result of `ToString` to the `str` variable.
  - The `str` variable is of type `string?` (nullable string).
- It writes the value of `str` to standard output, which is nothing.
- Calling `Console.Write(null)` is valid, so there's no warnings.
- You would get a warning if you were to call `Console.Write(str.Length)` because you'd be potentially dereferencing null.

> [!TIP]
> This is functionally equivalent to the following C# code:
>
> ```csharp
> using System;
>
> // Declare variable and assign it as null.
> FooBar fooBar = null;
>
> // Conditionally dereference variable.
> string str = (fooBar is not null) ? fooBar.ToString() : default;
> Console.Write(str);
>
> // The FooBar type definition.
> record FooBar(int Id, string Name);
> ```

You can combine operator to further express your intent. For example, you could chain the `?.` and `??` operators:

```csharp
FooBar fooBar = null;
var str = fooBar?.ToString() ?? "unknown";
Console.Write(str); // output: unknown
```

For more information, reference [?. and ?[] (null-conditional) operators](/dotnet/csharp/language-reference/operators/member-access-operators#null-conditional-operators--and-).

## Summary

In this unit, you learned about expressing your nullability intent in code. In the next unit, you'll apply what you've learned to an existing project.
