In C#, a delegate is a special type of variable or member that references a method with a specific parameter list and return type.

For the change feed processor, the library expects a delegate of type **ChangesHandler\<\>** that takes in a generic type to represent your serialized individual items. The delegate includes two parameters; a read-only list of changes and a cancellation token.

You could create a method named **HandleChangesAsync** with the same method signature as the delegate in a verbose syntax.

```csharp
static async Task HandleChangesAsync(
    IReadOnlyCollection<Product> changes,
    CancellationToken cancellationToken
) 
{
    // Do something with the batch of changes
}
```

Once that is created, you can create a new variable of type **ChangesHandler\<\>**, and then reference the earlier method.

```csharp
ChangesHandler<Product> changeHandlerDelegate = HandleChangesAsync;
```

An even more concise syntax that accomplishes the same thing would use an anonymous function instead of a named method member.

```csharp
ChangesHandler<Product> changeHandlerDelegate = async (
    IReadOnlyCollection<Product> changes,
    CancellationToken cancellationToken
) => {
    // Do something with the batch of changes
};
```

Within the delegate, you can iterate over the list of changes and then implement any business logic that makes sense for your application. In this example, you can think of each change as a “snapshot” of the item at some point in time that is delivered at-least-once to the host client application.

A foreach loop is used to iterate through the current batch of changes, and then each item is printed to the console window

```csharp
ChangesHandler<Product> changeHandlerDelegate = async (
    IReadOnlyCollection<Product> changes,
    CancellationToken cancellationToken
) => {
    foreach(Product product in changes)
    {
        await Console.Out.WriteLineAsync($"Detected Operation:\t[{product.id}]\t{product.name}");
        // Do something with each change
    }
};
```
