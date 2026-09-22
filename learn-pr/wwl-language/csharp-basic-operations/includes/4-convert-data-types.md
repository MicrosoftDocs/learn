Since C# is strongly typed, you sometimes need to explicitly convert a value from one data type to another. This is especially important when working with user input, because `Console.ReadLine()` always returns text (a `string`)—even when the user types a number.

## Why conversion matters

Consider this common scenario:

```csharp
Console.Write("Enter your age: ");
string ageInput = Console.ReadLine();
int nextYear = ageInput + 1;    // ERROR! Can't add int to string
```

To do math with user input, you need to convert the string to a number first.

## Convert methods

C# provides `Convert` methods to change values between data types:

| Method | Converts to | Example | Result |
|---|---|---|---|
| `Convert.ToInt32()` | int | `Convert.ToInt32("42")` | `42` |
| `Convert.ToDecimal()` | decimal | `Convert.ToDecimal("19.99")` | `19.99m` |
| `Convert.ToDouble()` | double | `Convert.ToDouble("3.14")` | `3.14` |
| `Convert.ToString()` | string | `Convert.ToString(42)` | `"42"` |

Here's how to fix the earlier scenario:

```csharp
Console.Write("Enter your age: ");
string ageInput = Console.ReadLine();
int age = Convert.ToInt32(ageInput);
int nextYear = age + 1;
Console.WriteLine($"Next year you'll be {nextYear}");
```

You can try running this code yourself in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor).

## Parse methods

Another way to convert strings to numbers is with the `Parse` methods:

```csharp
int age = int.Parse("25");
decimal price = decimal.Parse("19.99");
double average = double.Parse("87.5");
```

Both `Convert.ToInt32()` and `int.Parse()` do similar things—use whichever style you prefer.

## Casting between numeric types

To convert between numeric types (like `decimal` to `int`), use a **cast** by placing the target type in parentheses:

```csharp
decimal price = 19.99m;
int wholePrice = (int)price;         // Casts to int: 19 (decimal dropped)
Console.WriteLine(wholePrice);       // Output: 19
```

You can also cast to keep decimal precision during division:

```csharp
int first = 7;
int second = 2;
decimal result = (decimal)first / (decimal)second;
Console.WriteLine(result);           // Output: 3.5
```

## What happens with invalid conversions?

If you try to convert a value that can't be interpreted as a number, C# throws an error:

```csharp
int number = Convert.ToInt32("hello");    // ERROR: Input string was not in a correct format
```

For now, just make sure the value can be converted before you try. Later, you'll learn how to handle errors gracefully.
