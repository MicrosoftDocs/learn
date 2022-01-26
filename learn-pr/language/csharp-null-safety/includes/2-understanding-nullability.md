If you're a .NET developer, chances are you've encountered the <xref:System.NullReferenceException?displayProperty=fullName>. This occurs at run time when a `null` is dereferenced&mdash;that is, when an object is evaluated at runtime, but the object points to `null`. This exception is by far the most commonly occurring exception within the .NET ecosystem. The creator of `null` (Sir Tony Hoare) refers to `null` as the "billion dollar mistake".

In the following example, the `FooBar` object is assigned to `null` and immediately dereferenced, thus exhibiting the problem:

```csharp
// Declare variable and assign it as null.
FooBar fooBar = null;

// Dereference variable by calling ToString.
// This will throw a NullReferenceException.
_ = fooBar.ToString();

// The FooBar type definition.
record FooBar(int Id, string Name);
```

The preceding example is obvious, but when your apps grow in size and complexity, the problem becomes much more difficult to spot as a developer. This is a job for tooling, and the C# compiler platform (Rosyln) is here to help!

## Defining null safety

The term _null safety_ defines a set of features specific to [nullable types](#nullable-types) that help reduce the number of possible `NullReferenceException` occurrences.

> [!IMPORTANT]
> There is no _guaranteed_ null safety, even if you react to and eliminate all the warnings. There are some limited scenarios that will pass the compiler's analysis yet result in a runtime `NullReferenceException`.

Considering the previous `FooBar` example, the `NullReferenceException` could be avoided by simply checking if the `fooBar` variable was `null` before dereferencing it:

```csharp
// Declare variable and assign it as null.
FooBar fooBar = null;

// Check for null
if (fooBar is not null)
{
    _ = fooBar.ToString();
}

// The FooBar type definition for example.
record FooBar(int Id, string Name);
```

The compiler infers the intent of your code to help enforce behavior, but this is only when a _nullable context_ is enabled. Before discussing [nullable context](#nullable-context), let's describe the possible nullable types.

## Nullable types

Before C# 2.0, only reference types were nullable and value-types such as `int` or `DateTime` could _not_ be `null`. If these types are initialized without a value, they fallback to their `default` value. In the case of an `int`, this is `0`. For a `DateTime`, it's `DateTime.MinValue`.

Reference types instantiated without initial values work differently. The `default` value for all reference types is `null`.

Consider the following C# snippet:

```csharp
string first;                  // first is null
string second = string.Empty   // second is not null, instead it's an empty string ""
int third;                     // third is 0 because int is a value type
DateTime date;                 // date is DateTime.MinValue
```

In the preceding example:

- `first` is `null` because the reference type `string` was declared but no assignment was made.
- `second` is assigned `string.Empty` when it's declared. The object never had a `null` assignment.
- `third` is `0` despite not being assigned to. It's a `struct` (value-type) and has a `default` value of `0`.
- `date` is uninitialized but its `default` value is <xref:System.DateTime.MinValue?displayProperty=fullName>.

Starting with C# 2.0, you could define _nullable value types_ using `Nullable<T>` (or `T?` for shorthand). This allows value-types to be nullable. Consider the following C# snippet:

```csharp
int? first;            // first is implicitly null (uninitialized)
int? second = null;    // second is explicitly null
int? third = default;  // third is null as the default value for Nullable<Int32> is null
int? forth = new();    // forth is 0, since new calls the nullable constructor
```

In the preceding example:

- `first` is `null` because the nullable value type is uninitialized.
- `second` is assigned `null` when it's declared.
- `third` is `null` as the `default` value for `Nullable<int>` is `null`.
- `forth` is `0` as the `new()` expression calls the `Nullable<int>` constructor, and `int` is `0` by default.

C# 8.0 introduced _nullable reference types_, where you can express your intent that a reference type *might* be `null` or is *always* non-`null`. You may be thinking, "I thought they said all reference types are nullable!" You're not wrong, and they are. This feature allows you to express your *intent*, which the compiler then tries to enforce. The same `T?` syntax expresses that a reference type is intended to be nullable.

Consider the following C# snippet:

> [!IMPORTANT]
> In order to use the nullable reference types feature as shown below, it must be within a _nullable context_. This is detailed in [Enable nullable reference types](#enable-nullable-reference-types).

```csharp
#nullable enable

string first = string.Empty;
string second;
string? third;
```

Given the preceding example, the compiler infers your *intent* as follows:

- `first` is *never* `null` as it is definitely assigned.
- `second` *should never* be `null`, even though it's initially `null`. Evaluating `second` before assigning a value results in a compiler warning as it is uninitialized.
- `third` *might be* `null`. For example, it *might* point to a `System.String`, but it *might* point to `null`. Either is acceptable to you.

## Nullable context

Nullable contexts enable fine-grained control for how the compiler interprets reference type variables. There four possible nullable contexts:

- `disable`: The compiler behaves similarly to C# 7.3 and earlier.
- `enable`: The compiler enables all null reference analysis and all language features.
- `warnings`: The compiler performs all null analysis and emits warnings when code might dereference `null`.
- `annotations`: The compiler doesn't perform null analysis or emit warnings when code might dereference `null`.

This learn module is scoped to the either `disable` or `enable` nullable contexts. For more information, see [Nullable reference types: Nullable contexts](/dotnet/csharp/nullable-references#nullable-contexts).

### Enable nullable reference types

In the C# project file (_.csproj_), add a child node to the `<Project>` element (or append to an existing `<PropertyGroup>`). This will apply the `enable` nullable context to the entire project.

```xml
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net6.0</TargetFramework>
        <Nullable>enable</Nullable>
    </PropertyGroup>

    <!-- Omitted for brevity -->

</Project>
```

Alternatively, you can scope nullable context to a C# file using a compiler directive.

```csharp
#nullable enable
```

The preceding C# compiler directive is functionally equivalent to the project configuration, but is scoped to the file in which it resides.

> [!IMPORTANT]
> The nullable context is enabled in the _.csproj_ file by default in all C# project templates starting with .NET 6.0 and greater.

When the nullable context is enabled, you'll get new warnings. Consider the previous `FooBar` example&mdash;it has two warnings when analyzed in a nullable context:

1. The `FooBar fooBar = null;` line has a warning on the `null` assignment: _C# Warning CS8600: Converting null literal or possible null value to non-nullable type_.

    :::image type="content" source="../media/null-warning-cs8600.png" lightbox="../media/null-warning-cs8600.png" alt-text="C# Warning CS8600: Converting null literal or possible null value to non-nullable type.":::

1. The `_ = fooBar.ToString();` line also has a warning. This time the compiler is concerned that `fooBar` may be null: _C# Warning CS8602: Dereference of a possibly null reference_.

    :::image type="content" source="../media/null-warning-cs8602.png" lightbox="../media/null-warning-cs8602.png" alt-text="C# Warning CS8602: Dereference of a possibly null reference.":::

## Summary

 In this unit, you learned to enable a nullable context in C# to help guard against `NullReferenceException`. In the next unit, you'll learn more about explicitly expressing your intent in a nullable context.
