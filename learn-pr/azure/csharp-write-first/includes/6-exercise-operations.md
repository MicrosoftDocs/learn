

## Performing string concatenation

Often we'll want to combine strings together.  This is called *concatenation*.

To concatenate two strings together, you use the *string concatenation operator* which is the plus sign `+`.

Here's an example:

```csharp-interactive
string firstName = "Bob";
string greeting = "Hello" + firstName;
Console.WriteLine(greeting);
```
Here's another example:

```csharp-interactive
string firstName = "Bob";
string lastName = "Tabor";
string fullName = firstName + " " + lastName;
Console.WriteLine(fullName);
```

### Avoid intermediate variables

In both of the examples above, we used an extra variable to hold the new string that resulted from the concatenation operation.  Unless you have a good reason to do so, you can (and should) avoid this by performing the concatenation operation as you need it.  

Here's the first example re-written to avoid the use of an intermediate variable:

```csharp-interactive
string firstName = "Bob";
Console.WriteLine("Hello" + firstName);
```

And the second example re-written:

```csharp-interactive
string firstName = "Bob";
string lastName = "Tabor";
Console.WriteLine(firstName + " " + lastName);
```

## Adding two numeric values

Often we'll want to add values (and perform other mathematical operations).

To add two numbers together, we'll use the *addition operator* which is the plus sign `+`.  Yes, the same `+` symbol can be used for both purposes.  The re-use of one symbol for multiple purposes is sometimes called "overloading the operator".

In this instance, the C# compiler understands what you're attempting to do given the context of the variable types that are used.

Here, we'll add two numbers:

```csharp-interactive
int firstNumber = 12;
int secondNumber = 7;
Console.WriteLine(firstNumber + secondNumber);
```

### Mixing types to force implicit type conversion

What happens if we try to use the `+` symbol with both `string` and `int` values?  Let's experiment:

```csharp-interactive
string firstName = "Bob";
int position = 1;
Console.WriteLine(firstName + " is number " + position);
```

Output:

```output
Bob is number 1
```
In this case, the C# compiler understands that we want to use the `+` symbol to concatenate, not add.  So, it attempts to implicitly convert the `int position` into a string temporarily so it can concatenate it to the rest of the string.  The C# compiler tries to help you when it can, but ideally, you would be explicit about your intentions.  Again, explicit type conversion will be discussed later in other modules.

## Understanding the flow of execution

Now that we're writing multiple lines of code, it's important to notice that when your application is executed each line of code is executed from top to bottom until there are no more lines of code to execute, at which point the application ends and returns control back to the operating system.  This is called the *flow of execution*.  Later we'll learn how to modify the flow of execution to bypass certain lines of code in certain situations, or loop through the same code until a condition is met.