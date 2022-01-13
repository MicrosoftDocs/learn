If you're a .NET developer, chances are you've encountered the <xref:System.NullReferenceException?displayProperty=fullName>. This occurs at runtime when a `null` is dereferenced. This exception is by far the most commonly occuring exception within the .NET ecosystem. Tony Hoare (the creator of `null`) refers to `null` as the "billion dollar mistake".

In the following example, the `FooBar` object is assigned to `null` and immediately dereferenced, thus exhibiting the problem:

```csharp
FooBar fooBar = null;
_ = fooBar.ToString(); // throws NullReferenceException

record FooBar(int Id, string Name);
```

The preceding example is obvious, but when your applications grow in size and complexity, it's much less obvious whether or not a variable is ever `null`.

## Nullable types

Before C# 2.0, value-types such as `int`, or `DateTime` could _not_ be `null`. Starting with C# 2.0, the `Nullable<T>` type was introduced to allow value-types to be nullable. Before C# 8.0, reference types were implicitly nullable. The `default` value for all reference types is `null`.

```csharp
string first;                  // first is null
string second = string.Empty   // second is not null
int third;                     // third is 0 because int is a value type
DateTime date;                 // date is DateTime.MinValue
```

In the preceding example:

- `first` is `null` because the reference type `string` was declared but no assignment was made.
- `second` is assigned `string.Empty` when it's declared. The object never had a `null` assignment.
- `third` is `0` despite not being assigned to. It's a `struct` (value-type) and has a `default` value of `0`.

C# 8.0 introduced the nullable reference types, where you as the developer can express explicit intent that a reference type might be `null` or is always non-`null`. This is possible within a nullable context.

## Nullable context



<!-- how null state analysis solves this problem in C# 8 and greater -->

> [!IMPORTANT]
> The nullable context is enabled by default in all C# project templates starting with .NET 6.0 and greater.

```Output
System.NullReferenceException: Object reference not set to an instance of an object.
   at <Program>$.<Main>$(String[] args)
```

:::image type="content" source="../media/possible-null-warning.png" lightbox="../media/possible-null-warning.png" alt-text="Visual Studio Code: Possible null warning.":::
