
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=a9d3650c-2782-4dbc-94c6-a488fbbb64be]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

At their core, computers are incredibly fast calculators. C# supports all the standard math operations you'd expect, allowing you to perform calculations and save the results in variables.

## Arithmetic operators

C# uses standard symbols for basic math:

| Operator | Action | Example | Result |
|---|---|---|---|
| `+` | Addition | `10 + 3` | `13` |
| `-` | Subtraction | `10 - 3` | `7` |
| `*` | Multiplication | `10 * 3` | `30` |
| `/` | Division | `10 / 3` | `3` (integer division) |
| `%` | Modulus (remainder) | `10 % 3` | `1` |

You can try running this code yourself in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor).

### Understanding modulus (`%`)

The modulus operator `%` returns whatever is left over after division. It's useful for checking whether a number divides evenly:

```csharp
Console.WriteLine(10 % 2);   // Output: 0 (10 is even)
Console.WriteLine(11 % 2);   // Output: 1 (11 is odd)
```

## Order of operations

C# follows standard math order of operations (PEMDAS): Parentheses, then Multiplication/Division, then Addition/Subtraction. Use parentheses to control the order:

```csharp
int standard = 2 + 3 * 4;      // Multiplication first: 14
int forced = (2 + 3) * 4;      // Parentheses first: 20
```

## Compound assignment operators

A common pattern is updating a variable using its own value—like adding to a score or subtracting from a balance. C# has shorthand operators for this:

```csharp
int score = 50;
score = score + 10;    // Standard way: score is 60
score += 10;           // Shorthand: score is 70
```

The same shorthand works for other operations:

| Operator | Meaning | Example | Result (starting at 10) |
|---|---|---|---|
| `+=` | Add and assign | `x += 5` | `15` |
| `-=` | Subtract and assign | `x -= 5` | `5` |
| `*=` | Multiply and assign | `x *= 5` | `50` |
| `/=` | Divide and assign | `x /= 5` | `2` |

## Increment and decrement operators

For adding or subtracting `1`, C# has even shorter operators—`++` and `--`:

```csharp
int count = 5;
count++;                       // Same as count = count + 1
Console.WriteLine(count);      // Output: 6

count--;                       // Same as count = count - 1
Console.WriteLine(count);      // Output: 5
```

### Position matters: pre-increment vs. post-increment

The `++` and `--` operators behave differently depending on whether they appear **before** or **after** the variable:

- **Post-increment** (`value++`): Uses the current value first, then increments
- **Pre-increment** (`++value`): Increments first, then uses the new value

```csharp
int a = 5;
Console.WriteLine(a++);   // Output: 5 (uses old value, then increments)
Console.WriteLine(a);     // Output: 6 (a was incremented)

int b = 5;
Console.WriteLine(++b);   // Output: 6 (increments first, then uses new value)
Console.WriteLine(b);     // Output: 6
```

The same rules apply to `--` (decrement).

## Division with integers vs. decimals

When you divide two integers, C# truncates (drops) the decimal portion:

```csharp
int result = 7 / 2;
Console.WriteLine(result);     // Output: 3 (not 3.5)
```

To keep the decimal, at least one of the numbers must be a decimal type:

```csharp
decimal result = 7m / 2m;
Console.WriteLine(result);     // Output: 3.5
```

This is why choosing the right data type matters for your calculations. In the next section, you learn how to convert between types when you need to.

::: zone-end

