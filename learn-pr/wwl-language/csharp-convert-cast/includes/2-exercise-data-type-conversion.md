There are multiple techniques you can use to perform a data type conversion or cast. Which technique you choose depends on your answer to two important questions:

- Question 1: Is it possible, depending on the value, that attempting to change the value's data type would throw an exception at runtime?
- Question 2: Is it possible, depending on the value, that attempting to change the value's data type would result in a loss of information?

In this exercise, we'll work our way through these questions, the implications of their answers, and which technique you should use when you need to change the data type.

## Question 1: Is it possible, depending on the value, that attempting to change the value's data type would throw an exception at runtime?

The C# compiler will try to accommodate your code, but will always avoid an operation that could result in an exception. When you understand the C# compiler's primary concern, understanding why it functions a certain way will be easier.

### Step 1 - Write code that attempts to add an int and a string and save the result in an int

Add the following code to the .NET Editor:

```csharp-interactive
int first = 2;
string second = "4";
int result = first + second;
Console.WriteLine(result);
```

Here, we're attempting to add the values `2` and `4`. The value `4` is of type `string`. Will this work?

Run the code and you should get the following output.

```output
(3,14): error CS0029: Cannot implicitly convert type 'string' to 'int'
```

The error message tells us the problem is with our use of the `string` data type. But why can't the C# Compiler just handle this? After all, we can do the *opposite* to concatenate a number to a `string` and save it in a string variable. Here, we'll merely change the data type of the `result` variable from `int` to `string`:

```csharp-interactive
int first = 2;
string second = "4";
string result = first + second;
Console.WriteLine(result);
```

This will produce the following output:

```output
24
```

Let's return to our first code example where the `result` variable is of type `int`. Why can't the C# compiler figure out that we want to treat the variable `second` containing `4` as a number, not a `string`?

The C# compiler sees a potential problem in the making. The variable `second` is of type `string`, so it might be set to a different value, like `"hello"`. If the C# compiler attempted to convert `"hello"` to a number, that would cause an exception at runtime. To avoid this possibility, the C# compiler won't implicitly perform the conversion from `string` to `int` for you.

From the C# compiler's perspective, the safer operation would be to convert `int` into a `string` and perform concatenation instead.

If you intend to perform addition using a string, the C# compiler requires you to take more explicit control of the data-conversion process. In other words, it forces you to be more involved so that you can put the proper precautions in place to handle the possibility that the conversion could throw an exception.

If you need to change a value from the original data type to a new data type and the change could produce an exception at runtime, you must perform a **data conversion**.

To perform data conversion, you can use one of several techniques:

- Use a helper method on the data type
- Use a helper method on the variable
- Use the Convert class' methods

We'll look at a few examples of these techniques for data conversion later in this unit.

## Question 2: Is it possible, depending on the value, that attempting to change the value's data type would result in a loss of information?

The term *widening conversion* means that you're attempting to convert a value **from** a data type that could hold *less* information **to** a data type that can hold *more* information. In this case, you'll lose no information. So, an example would be converting a value stored in a variable of type `int`, and now converting that value into a variable of type `decimal`.

If you were to print out the two values, you'd likely notice no difference.

When you know you'll be performing a widening conversion, you can rely on **implicit conversion**. The compiler handles implicit conversion.

### Step 2 - Modify the code in the .NET Editor to perform an implicit conversion

Delete or comment out the code from the previous exercise step and add the following code in the .NET Editor:

```csharp-interactive
int myInt = 3;
Console.WriteLine($"int: {myInt}");

decimal myDecimal = myInt;
Console.WriteLine($"decimal: {myDecimal}");
```

When you run the code, you should get the following output:

```output
int: 3
decimal: 3
```

The key to this example is this line of code:

```csharp
decimal myDecimal = myInt;
```

Because any `int` value can easily fit inside of a `decimal`, the compiler performs the conversion.

The term **narrowing conversion** means that you're attempting to convert a value from a data type that can hold more information to a data type that can hold less information. In this case, you may lose information like precision (that is, the number of values after the decimal point). An example would be converting value stored in a variable of type `decimal`, and now converting that value into a variable of type `int`. If you were to print out the two values, you'd possibly notice the loss of information.

When you know you'll be performing a narrowing conversion, you'll need to perform a **cast**. Casting is an instruction to the C# compiler that you know precision may be lost, but you're willing to accept it.

### Step 3 - Modify the code in the .NET Editor to perform a cast

To perform a cast, you'll use the casting operator `()` to surround a data type, then place it next to the variable you want to convert.

Delete or comment out the code from the previous exercise step and add the following code in the .NET Editor:

```csharp-interactive
decimal myDecimal = 3.14m;
Console.WriteLine($"decimal: {myDecimal}");

int myInt = (int)myDecimal;
Console.WriteLine($"int: {myInt}");
```

If you run the code example, you should get the following output:

```output
decimal: 3.14
int: 3
```

The key to this example is this line of code:

```csharp
int myInt = (int)myDecimal;
```

The variable `myDecimal` holds a value that has two places of precision. By adding the casting instruction `(int)`, we're telling the C# compiler that we understand it's possible we'll lose that precision, and in this situation, it's fine.

## How do I know if a conversion is a "widening conversion" or a "narrowing conversion"?

If you're not sure whether you'll lose data or not, you can do one of two things.

The definitive resource is the following article:

[Type Conversion Tables in .NET](/dotnet/standard/base-types/conversion-tables?azure-portal=true)

This article uses the .NET Class Library name for types, not the C# keyword for the data types, so it might be a bit confusing at first. Use the following article to map between the C# keyword and the .NET Class Library type:

[Built-in types table](/dotnet/csharp/language-reference/keywords/built-in-types-table?azure-portal=true)

However, you can also write some code to perform a conversion in two different ways and observe the changes. Developers frequently write small tests to better understand the propensities of two similar techniques. For example, you might do something like this:

```csharp-interactive
decimal myDecimal = 1.23456789m;
float myFloat = (float)myDecimal;

Console.WriteLine($"Decimal: {myDecimal}");
Console.WriteLine($"Float: {myFloat}");
```

This code produces the following output:

```output
Decimal: 1.23456789
Float: 1.234568
```

From this example, you can see that casting a `decimal` into a `float` is a narrowing conversion, because you're losing precision.

## Performing Data Conversions

Earlier, we said that when you need to change a value from one data type into another, and that change could cause a runtime exception, you should perform data conversion, and there are three techniques you can use:

- Use a helper method on the variable
- Use a helper method on the data type
- Use the Convert class' methods

### Use ToString() to convert a number to a string

Every data type variable has a `ToString()` method. What the `ToString()` method does depends on how it's implemented on a given type. However, on most primitives, it performs a widening conversion. While this isn't strictly necessary (because we can rely on implicit conversion in most cases), it can communicate to other developers that you understand what you're doing and that it's intentional.

### Step 4 - Modify the code in the .NET Editor to convert a number to a string using the ToString() helper method

Here's a quick example of using the `ToString()` method to explicitly convert `int` values into `string`s.

Delete or comment out the code from the previous exercise step and add the following code in the .NET Editor:

```csharp-interactive
int first = 5;
int second = 7;
string message = first.ToString() + second.ToString();
Console.WriteLine(message);
```
If you run the command, you'll get the following output, which is a concatenation of the two values:

```output
57
```

## Explicitly converting a string to a number

Most of the numeric data types have a `Parse()` method, which will convert a string into the given data type. In this case, we'll use the `Parse()` method to convert two strings into `int` values, then add them together.

### Step 5 - Modify the code in the .NET Editor to convert a string to an int using the Parse() helper method

Delete or comment out the code from the previous exercise step and add the following code in the .NET Editor:

```csharp-interactive
string first = "5";
string second = "7";
int sum = int.Parse(first) + int.Parse(second);
Console.WriteLine(sum);
```

If you run the code example, you should get the following output:

```output
12
```

Can you spot the potential problem with the code example above? What if either of the variables `first` or `second` are set to values that can't be converted to an `int`? An exception will be thrown at runtime. This is exactly what the C# compiler and runtime expects us to plan for ahead of time. Fortunately, we can mitigate this in several ways.

 The easiest way to mitigate this situation is through the use of `TryParse()`, which is a better version of the `Parse()` method. We'll discover that in the next unit.

## Data Conversion using the `Convert` class

The `Convert` class has many helper methods to convert a value from one type into another. In the following code example, we'll convert a couple of strings into values of type `int`.

## Step 6 - Modify the code in the .NET Editor to convert a string to a number using the Convert class

Delete or comment out the code from the previous exercise step and add the following code in the .NET Editor:

```csharp-interactive
string value1 = "5";
string value2 = "7";
int result = Convert.ToInt32(value1) * Convert.ToInt32(value2);
Console.WriteLine(result);
```

If you run the code example, you should get the following output:

```output
35
```

> [!NOTE]
> Why is the method name `ToInt32()`? Why not `ToInt()`? `System.Int32` is the name of the underlying data type in the .NET Class Library that the C# programming language maps to the keyword `int`. Because the `Convert` class is also part of the .NET Class Library, it's called by its full name, not its C# name. By defining data types as part of the .NET Class Library, multiple .NET languages like Visual Basic, F#, IronPython, and others can share the same data types and the same classes in the .NET Class Library. At the end of this module, we'll post some links so you can learn more about .NET's Common Type System.

The `ToInt32()` method has 19 overloaded versions, which allows it to accept virtually every data type, as we'll see in a moment.

We used the `Convert.ToInt32()` method with a string here, but you should probably use `TryParse()` when possible.

So, when should we use the `Convert` class? The `Convert` class is best for converting fractional numbers into whole numbers (`int`) because it rounds up the way you would expect.

### Casting versus Conversion

The following example demonstrates what happens when you attempt to cast a `decimal` into an `int` (a narrowing conversion) versus using the `Convert.ToInt32()` method to convert the same `decimal` into an `int`.

## Step 7 - Modify the code in the .NET Editor to compare casting and converting a decimal into an int

Delete or comment out the code from the previous exercise step and add the following code in the .NET Editor:

```csharp-interactive
int value = (int)1.5m; // casting truncates
Console.WriteLine(value);

int value2 = Convert.ToInt32(1.5m); // converting rounds up
Console.WriteLine(value2);
```

When you run the code, you'll get the following output:

```output
1
2
```

When casting, the value of the float is truncated, meaning the value after the decimal is ignored completely. We could change the literal float to `1.999m`, and the result of casting would be the same.

When converting using `Convert.ToInt32()`, the literal float value is properly rounded up to `2`. If we changed the literal value to `1.499m`, it would be rounded down to `1`. Try it out by changing the values in the .NET editor.

## Recap

We covered several important concepts of data conversion and casting:

- Perform a data conversion when it's possible that doing so could cause a runtime error.
- Perform an explicit cast to tell the compiler you understand the risk of losing data.
- Rely on the compiler to perform an implicit cast when performing an expanding conversion.
- Use the () cast operator and the data type to perform a cast (for example, `(int)myDecimal`).
- Use the `Convert` class when you want to perform a narrowing conversion, but want to perform rounding, not a truncation of information.
