In this module, you learned how to enable nullable context and act on build warnings/errors to avoid `NullReferenceException`. You began by defining nullability in C#. You learned that all reference types can be `null` and that `Nullable<T>` enables value types to also be assigned `null`.

Utilizing a nullable-enabled context, you identified code where `null` might have been errantly dereferenced. After reevaluating the code, you expressed your intent and adjusted the desired behavior of the code using various C# operators. You learned about the null-forgiving (`!`), null-coalescing (`??`), and null-conditional (`?.`) operators.

There are many possible ways to handle nullability within C#. In a nullable-enabled context, the C# compiler helps you have a better understanding of how your expressed intent flows through.

## Additional resources

- [Nullable reference types](/dotnet/csharp/nullable-references)
- [Nullable value types (C# reference)](/dotnet/csharp/language-reference/builtin-types/nullable-value-types)
- [Learn techniques to resolve nullable warnings](/dotnet/csharp/nullable-warnings)
- [Update a codebase with nullable reference types to improve null diagnostic warnings](/dotnet/csharp/nullable-migration-strategies)
- [?. and ?[] (null-conditional) operators](/dotnet/csharp/language-reference/operators/member-access-operators#null-conditional-operators--and-)
- [?? and ??= operators (C# reference)](/dotnet/csharp/language-reference/operators/null-coalescing-operator)
- [! (null-forgiving) operator (C# reference)](/dotnet/csharp/language-reference/operators/null-forgiving)
