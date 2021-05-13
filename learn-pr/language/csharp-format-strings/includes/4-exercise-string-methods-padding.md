Previously, we used the `string.Format()` method to perform composite formatting.  It may have seemed a bit strange that a key word that represents a data type has methods you can call in the same way that you call methods on the `Console` class.  The fact is that there are many similar methods on the `string` data type as well as any literal string or variable of type string.

Here's a brief list of categories of these built-in methods so you can get an idea of what's possible.

- Methods that either add blank spaces for formatting purposes (`PadLeft()`, `PadRight()`)

- Methods that either compare two strings or facilitate comparison (`Trim()`, `TrimStart()`, `TrimEnd()`, `GetHashcode()`, the `Length` property)

- Methods that help you determine what's inside of a string, or even retrieve just a part of the string (`Contains()`, `StartsWith()`, `EndsWith()`, `Substring()`)

- Methods that change the content of the string by replacing, inserting, or removing parts (`Replace()`, `Insert()`, `Remove()`)

- Methods that turn a string into an array of strings or characters (`Split()`, `ToCharArray()`)

We'll use these methods in other modules as we find a use for their functionality.


## Formatting strings by adding whitespace before or after

The `PadLeft()` method will add blank spaces to the left-hand side of the string so that the total number of characters equals the argument you send it.  In this case, we want to total length of the string to be 12 characters.

```csharp-interactive
string input = "Pad this";
Console.WriteLine(input.PadLeft(12));
```
When you run the code, you'll see four characters are prefixed to the left of the string so that it is 12 characters long.

```output
    Pad this
```

To add space or characters to the right side of your string, use the `PadRight()` method instead.

```csharp-interactive
Console.WriteLine(input.PadRight(12));
```

When you run the code, you won't see any characters added to the end of the string, but they are there.

### What is an overloaded method?

In C#, an *overloaded method* is another version of a method with different or additional arguments that modify the functionality of the method slightly, as is the case with our overloaded version of the `PadLeft()` method.  We'll learn how to create methods and overloaded methods in other modules.

You can also call a second *overloaded* version of the method and pass in whatever character you want to use instead of a space.  In this case, we'll fill the extra space with the dash character.

```
Console.WriteLine(input.PadLeft(12, '-'));
Console.WriteLine(input.PadRight(12, '-'));
```
When you run the code, you'll see four dashes prefixing the left of the string that is 12 characters long.

```output
----Pad this
Pad this----
```
Let's apply this newfound knowledge to another real world scenario.

## Exercise - Working with padded strings

Suppose we work for a payment processing company that still supports legacy mainframe systems.  Often, those systems require data to be input in specific columns.  For example, the Payment ID should be stored in columns 1 through 6, the payee's name in columns 7 through 30, and the Payment Amount in columns 31 through 40.  Also, importantly, the Payment Amount should be right-aligned.

We are asked to build an application that will convert data in our relational database management system to the legacy file format.  To ensure that the integration will work correctly, our first step is to confirm the file format by giving the legacy system maintainers a sample of our output.  Later, we'll build on this work to send hundreds or thousands of payments to be processed via an ASCII text file.

### Step 1 - Add the OrderId to the output

To get started, let's just print out the Payment ID in the first six columns.  We'll pick some random payment data that should be adequate for our purposes.

```csharp-interactive
string paymentId = "769";

var formattedLine = paymentId.PadRight(6);

Console.WriteLine(formattedLine);
```
We'll reuse the `formattedLine` variable to build our output string.  When you run the code, you should see the following output.

```output
769   
```

There are three additional blank spaces to the right that not visible.  We'll confirm that they exist in the next step.

### Step 2 - Add the payee name to the output

Next, we'll add a fictitious Payee Name, padding it appropriately.

Modify the code from Step 1 in the .NET Editor to match the following code.

```csharp-interactive
string paymentId = "769";
string payeeName = "Mr. Stephen Ortega";

var formattedLine = paymentId.PadRight(6);
formattedLine += payeeName.PadRight(24);

Console.WriteLine(formattedLine);
```

The `+=` operator performs a string concatenation, taking the previous value of the variable `formattedLine` and adding the new value to it.  It's a shortened equivalent to doing this:

```csharp
formattedLine = formattedLine + payeeName.PadRight(24);
```

When we run the code, we'll see the following output.

```output
769   Mr. Stephen Ortega      
```

Again, there are quite a few blank spaces after the Payee's Name.  Also, we can see the three blank spaces after the Payment ID from Step 1.

### Step 3 - Add the payment amount to the output

Next, let's add a fictitious Payment Amount and make sure to use `PadLeft()` to right-align the output.

Modify the code from Steps 1 and 2 in the .NET Editor to match the following passage.

```csharp-interactive
string paymentId = "769";
string payeeName = "Mr. Stephen Ortega";
string paymentAmount = "$5,000.00";

var formattedLine = paymentId.PadRight(6);
formattedLine += payeeName.PadRight(24);
formattedLine += paymentAmount.PadLeft(10);

Console.WriteLine(formattedLine);
```

When we run the code, we'll see the following output.

```output
769   Mr. Stephen Ortega       $5,000.00
```

This is pretty close to what we understood the legacy system maintainers were looking for.

### Step 4 - Add a line of numbers above the output to more easily confirm the result

Since it's difficult to count the exact columns where each data element appears, let's add a line directly above our output that helps us count the columns.

```csharp
Console.WriteLine("1234567890123456789012345678901234567890");
```
Modify the code from Steps 1 through 3 in the .NET Editor to match the following.

```csharp-interactive
string paymentId = "769";
string payeeName = "Mr. Stephen Ortega";
string paymentAmount = "$5,000.00";

var formattedLine = paymentId.PadRight(6);
formattedLine += payeeName.PadRight(24);
formattedLine += paymentAmount.PadLeft(10);

Console.WriteLine("1234567890123456789012345678901234567890");
Console.WriteLine(formattedLine);
```
When you run the application, we have the following output that we can send off to the maintainers of the legacy system to confirm our new integration will work correctly.

```output
1234567890123456789012345678901234567890
769   Mr. Stephen Ortega       $5,000.00
```

Success!

## Recap

There's a few important takeaways from this unit.

- The `string` data type, literal strings, and variables of type string each implement many helper methods to format, modify, and perform other operations on strings.
- The `PadLeft()` and `PadRight()` methods add white space (or optionally, another character) to the total length of a string.  
- Use `PadLeft()` to right-align a string.
- Some methods are overloaded, meaning they have multiple versions of the method with different arguments that affect their functionality.
- The `+=` operator concatenates a new string on the right to the existing string on the left.