
Before your code can make a decision, it needs a way to ask a question and get a yes-or-no answer. C# answers this kind of question with **Boolean expressions** and comparison operators.

## Boolean expressions

A **Boolean expression** is any code that evaluates to `true` or `false`. The `bool` data type stores exactly one of these two values:

```csharp
bool isGameOver = true;
bool isWinner = false;
```

## Comparison operators

**Comparison operators** compare two values and produce a Boolean result:

| Operator | Meaning | Example | Result |
|---|---|---|---|
| `==` | Equal to | `5 == 5` | `true` |
| `!=` | Not equal to | `5 != 3` | `true` |
| `>` | Greater than | `10 > 3` | `true` |
| `<` | Less than | `3 < 10` | `true` |
| `>=` | Greater than or equal to | `5 >= 5` | `true` |
| `<=` | Less than or equal to | `4 <= 3` | `false` |

> [!NOTE]
> Don't confuse the equality operator (`==`) with the assignment operator (`=`). Use `==` to compare two values, and `=` to assign a value to a variable.

## The if statement

An `if` statement runs a block of code only when its Boolean expression is `true`. The block of code is defined by curly braces `{ }`:

```csharp
int total = 17;

if (total >= 15)
{
    Console.WriteLine("You win!");
}
```

If the expression `total >= 15` is `false`, C# skips the code block entirely and continues with the next line.

You can try this yourself in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor).
