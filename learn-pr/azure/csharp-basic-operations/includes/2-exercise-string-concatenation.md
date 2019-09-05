Now that we can store values in variables, let's combine literal and variable data using concatenation and addition.

## Exercise - Performing basic operations on string data

Often we'll want to combine strings together, or rather, perform *string concatenation*.  Or perhaps we'll want to perform mathematical operations on numeric data, like addition.  This exercise will allow you to work with both literal and variable data to perform these basic operations on your data.

### Step 1: Concatenate a literal string and a variable.

To concatenate two strings together, you use the *string concatenation operator*, which is the plus symbol `+`.

Add the following code to the .NET Editor:

```csharp-interactive
string firstName = "Bob";
string message = "Hello " + firstName;
Console.WriteLine(message);
```

Now, run the code.  You'll see the following result in the output console:

```output
Hello Bob
```

### Step 2: Concatenate a literal string and a variable.

You can perform multiple concatenation operations in the same line of code.

Modify the code you wrote in Step 2 to the following:

```csharp-interactive
string firstName = "Bob";
string greeting = "Hello";
string message = greeting + " " + firstName;
Console.WriteLine(message);
```

Here we concatenate two variables along with a literal string -- an empty space character -- to separate the values stored in the two variables when presenting a full name.

Now, run the code.  You'll see the following result in the output console:

```output
Hello Bob
```

### Step 3: Avoiding intermediate variables.

In steps 1 and 2, we used an extra variable to hold the new string that resulted from the concatenation operation.  Unless you have a good reason to do so, you can (and should) avoid adding another variable and instead perform the concatenation operation as you need it.

Modify the code you wrote in Step 3 to match the following code:

```csharp-interactive
string firstName = "Bob";
string greeting = "Hello";
Console.WriteLine(greeting + " " + firstName);
```

Now, run the code.  The result in the output console should be the same, however we were able to simplify the code:

```output
Hello Bob
```

## Recap

The primary ideas you should take away from this exercise:

- String concatenation allows you to combine smaller literal and variable strings into a single string.
- Avoid creating intermediate variables if adding them doesn't increase readability.