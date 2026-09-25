
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=34e18c08-4fe9-4a6c-98b1-7c5cfa6d5b1b]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Sometimes a single condition isn't enough to make a decision. You might want to check whether two things are both true, or whether at least one of them is true. C#'s **logical operators** let you combine multiple conditions into one expression.

## The three logical operators

| Operator | What it does | Example | Result |
|---|---|---|---|
| `&&` | `true` **only** if **both** sides are `true` | `true && false` | `false` |
| `&#124;&#124;` | `true` if **at least one** side is `true` | `true &#124;&#124; false` | `true` |
| `!` | Flips a Boolean value | `!true` | `false` |

## Using && (all conditions must be met)

Use `&&` when every condition must be met to run a block of code:

```csharp
int age = 20;
bool hasTicket = true;

if (age >= 18 && hasTicket)
{
    Console.WriteLine("Entry granted.");
}
else
{
    Console.WriteLine("Entry denied.");
}
```

## Using || (at least one condition must be met)

Use `||` when any one condition is enough to run a block of code:

```csharp
bool isWeekend = false;
bool isHoliday = true;

if (isWeekend || isHoliday)
{
    Console.WriteLine("The office is closed.");
}
```

## Using ! (reverse a condition)

The `!` operator reverses a Boolean value. It's useful for checking the absence of a condition:

```csharp
bool isLoggedIn = false;

if (!isLoggedIn)
{
    Console.WriteLine("Please log in to continue.");
}
```

## Combining operators

You can combine `&&`, `||`, and `!` in a single expression. Use parentheses to group conditions and make your code easier to read:

```csharp
int roll1 = 6, roll2 = 6, roll3 = 5;

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3))
{
    Console.WriteLine("You rolled doubles!");
}
```

Here, three comparisons are combined with `||`, so the message displays if **any** two of the three dice match. In the next unit, you use this expression to build a dice game.

::: zone-end

