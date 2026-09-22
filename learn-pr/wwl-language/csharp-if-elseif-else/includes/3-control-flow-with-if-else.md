
A single `if` statement can only handle one outcome. To handle alternative outcomes, C# provides the `else` and `else if` keywords.

## Adding an alternative path with else

Use `else` to run a different code block when the condition is `false`:

```csharp
int total = 12;

if (total >= 15)
{
    Console.WriteLine("You win!");
}
else
{
    Console.WriteLine("Sorry, you lose.");
}
```

## Chaining conditions with else if

When you have more than two possible outcomes, add `else if` blocks to check additional conditions:

```csharp
int total = 12;

if (total >= 16)
{
    Console.WriteLine("You win a new car!");
}
else if (total >= 10)
{
    Console.WriteLine("You win a new laptop!");
}
else if (total == 7)
{
    Console.WriteLine("You win a trip for two!");
}
else
{
    Console.WriteLine("You win a kitten!");
}
```

### First match wins

C# checks each condition in order and runs the first block whose condition is `true`. It skips every condition after that, even if more than one would otherwise be `true`. If none of the conditions match, the `else` block runs. The `else` is optional, but it must come last if you include it.

Since `total` is `12` in the example above, the output is:

```output
You win a new laptop!
```

Order your conditions from most specific to least specific so you don't accidentally skip the outcome you expect.

## Nesting if statements

You can place an `if` statement inside another `if` statement's code block. This is called **nesting**, and it's useful when one decision depends on another:

```csharp
bool hasTicket = true;
int age = 16;

if (hasTicket)
{
    if (age >= 18)
    {
        Console.WriteLine("Entry granted.");
    }
    else
    {
        Console.WriteLine("Minors must be accompanied by an adult.");
    }
}
```
