
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=0ae7b371-dbfc-45b4-9158-f39db7313aad]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Every value in C# has a **data type**. For numbers, C# provides several types depending on whether you need whole numbers, decimals, or a wider range of values. Choosing the right type helps you write accurate calculations.

## Common numeric types

| Type Name | C# Keyword | Description | Example |
|---|---|---|---|
| Integer | `int` | Whole numbers (positive or negative) | `42`, `-7`, `1000` |
| Decimal | `decimal` | Precise decimal numbers, great for money | `19.99m`, `3.14m` |
| Double | `double` | Larger decimal numbers, common for calculations | `3.14`, `2.71828` |

> [!NOTE]
> When you write a decimal literal, C# assumes it's a `double` by default. To create a `decimal` literal, add the letter `m` at the end: `19.99m`.

## Declaring numeric variables

Just like you learned before, you declare a variable by specifying its type:

```csharp
int score = 95;
decimal price = 19.99m;
double average = 87.5;
```

## C# is strongly typed

Unlike some other languages, C# is a **strongly typed** language. That means once you declare a variable as a certain type, it can only hold that type of value:

```csharp
int count = 10;
count = "ten";     // ERROR! Can't assign a string to an int
```

This might seem strict, but it helps catch mistakes early and makes your code more predictable.

## Why the type matters

The data type affects how C# performs calculations:

```csharp
int a = 7;
int b = 2;
Console.WriteLine(a / b);        // Output: 3 (integer division truncates)

decimal c = 7m;
decimal d = 2m;
Console.WriteLine(c / d);        // Output: 3.5 (keeps the decimal)
```

When both values are integers, C# performs integer division and drops the decimal portion. To keep decimal precision, you need to use a decimal type. You'll learn how to convert between types in a later section.

::: zone-end

