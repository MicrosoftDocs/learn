The following code is one possible solution for the challenge from the previous unit:

```csharp-interactive
Random coin = new Random();
int flip = coin.Next(0, 2);
Console.WriteLine((flip == 0) ? "heads" : "tails");
```

This code is merely "*one possible solution*". You could've eliminated the temporary variable `flip` by calling the `Next()` inside of the Boolean expression like so:

```csharp-interactive
Random coin = new Random();
Console.WriteLine((coin.Next(0, 2) == 0) ? "heads" : "tails");
```

However, this code is packed densely and it would be more difficult to understand what the code is doing.

If you were successful, congratulations! Continue on to the second challenge in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, you should review the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.
