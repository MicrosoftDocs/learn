Explain the problem domain that we're looking to help alleviate

```csharp
FooBar fooBar = null;
_ = fooBar.ToString(); // throws NullReferenceException

record FooBar(int Id, string Name);
```

Before C# 2.0, value-types such as `int`, or `DateTime` could not be `null`. Starting with C# 2.0, the `Nullable<T>` type was introduced to allow value-types to be nullable. Before C# 8.0, reference types were implicitly nullable, as the `default` value for all reference types is `null`. 

## Heading

<!-- how null state analysis solves this problem in C# 8 and greater -->

> [!IMPORTANT]
> The nullable context is enabled by default in all C# project templates starting with .NET 6.0 and greater.

```Output
System.NullReferenceException: Object reference not set to an instance of an object.
   at <Program>$.<Main>$(String[] args)
```

:::image type="content" source="../media/possible-null-warning.png" lightbox="../media/possible-null-warning.png" alt-text="Visual Studio Code: Possible null warning.":::
