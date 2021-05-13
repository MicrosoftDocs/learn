When working with data, you'll likely need to convert string data into a numeric data type. As you learned in the previous unit, because the string data type can hold a non-numeric value, it's possible that performing a conversion from a `string` into a numeric data type will cause a runtime error.

For example, the following code listing:

```csharp-interactive
string name = "Bob";
Console.WriteLine(int.Parse(name));
```
causes the following exception.

```output
System.FormatException: 'Input string was not in a correct format.'
```

To guard against this, you should use the TryParse() method on the target data type.

## Use TryParse()

The TryParse() method does several things simultaneously:
- It attempts to parse a string into the given numeric data type.
- If successful, it will store the converted value in an **out parameter**.
- It returns a bool to indicate if it was successful.

We can use the bool to take action on the value (like performing some calculation), or display a message if the parse operation was unsuccessful.

> [!NOTE]
> In this exercise, we're using the `int` data type, but a similar `TryParse()` method is available on all numeric data types.

### What is an out parameter?

Methods can return a value upon completion or return "void", meaning they return no value. They can also, optionally, return values throughout parameters, which are defined just like any other input parameters but include the `out` keyword.

When calling a method with an out parameter, you must also use the keyword `out` before the variable, which will hold the value. So you have to define a variable before calling the method that will be used to store this out parameter value returned by the method. You can then use the value containing the out parameter throughout the rest of your code.

### Step 1 - TryParse() a string into an int

Delete or comment out all of the code in the .NET Editor from previous exercises, and add the following code.

```csharp-interactive
string value = "102";
int result = 0;
if (int.TryParse(value, out result))
{
    Console.WriteLine($"Measurement: {result}");
}
else
{
    Console.WriteLine("Unable to report the measurement.");
}
```
Let's focus on this line:

```
if (int.TryParse(value, out result))
```
The int.TryParse() method will return `true` if it successfully converted our `string` variable `value` into an `int`; otherwise, it will return `false`. So, surround the statement in an `if` statement, and then perform the decision logic, accordingly.

Note that the converted value will be stored in the `int` variable `result`. The `int` variable `result` is declared and initialized before this line of code, so it should be accessible both *inside* the code blocks that belong to the `if` and `else` statements, as well as *outside* of them.

The `out` keyword instructs the compiler that the `TryParse()` method will not only return a value the traditional way (as a return value), but also will communicate an output through this two-way parameter.

When you run the code, you should see the following output.

```output
Measurement: 102
```

### Step 2 - Use the parsed int later in code

To demonstrate that the `result` that was declared earlier, then populated by the `out` parameter, is also usable later in your code, add the following line of code below the code you wrote in Step 1.

```csharp
// Since it is defined outside of the if statement, 
// it can be accessed later in your code.
Console.WriteLine($"Measurement (w/ offset): {50 + result}");
```
The entire code passage should match the following code listing:

```csharp-interactive
string value = "102";
int result = 0;
if (int.TryParse(value, out result))
{
    Console.WriteLine($"Measurement: {result}");
}
else
{
    Console.WriteLine("Unable to report the measurement.");
}

// Since it is defined outside of the if statement, 
// it can be accessed later in your code.
Console.WriteLine($"Measurement (w/ offset): {50 + result}");
```
When you run the application, you should see the following result.

```output
Measurement: 102
Measurement (w/ offset): 152
```

### Step 3 - Modify the string variable to an unparseable value

Lastly, let's look at the other scenario - where we intentionally give `TryParse()` a bad value that can't be converted into an `int`.

Modify the first line of code reinitializing the variable `value` to a different value.

```csharp
string value = "bad";
```
Also, modify the last line of code to ensure that the result is greater than 0 before showing the second message.

```csharp
if (result > 0)
    Console.WriteLine($"Measurement (w/ offset): {50 + result}");
```

The entire code example should match the following code passage.

```csharp-interactive
string value = "bad";
int result = 0;
if (int.TryParse(value, out result))
{
    Console.WriteLine($"Measurement: {result}");
}
else
{
    Console.WriteLine("Unable to report the measurement.");
}

// Since it is defined outside of the if statement, 
// it can be accessed later in your code.
if (result > 0)
    Console.WriteLine($"Measurement (w/ offset): {50 + result}");
```

When you run the code, you should get the following result this time.

```output
Unable to report the measurement.
```

## Recap

The `TryParse()` method is a valuable tool. Here are few quick ideas to remember.

- Use `TryParse()` when converting a string into a numeric data type.
- `TryParse()` returns `true` if the conversion was successful, `false` if it's unsuccessful.
- An out parameter provides a secondary means of a method returning a value. In this case, the out parameter returns the converted value.
- Use the keyword `out` when passing in an argument to a method that has defined an out parameter.
