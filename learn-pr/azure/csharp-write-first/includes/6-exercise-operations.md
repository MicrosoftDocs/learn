Now that we can store values in variables, let's combine literal and variable data using concatenation and addition.

## Exercise - Performing basic operations on data

Often we'll want to combine strings together.  This is called *concatenation*.  Or, we'll want to perform mathematical operations on numeric data, like addition.  This exercise will allow you to work with both literal and variable data to perform these basic operations on your data.

### Step 1: Delete all of the code in the code editor.

Use your mouse to highlight all of the text in the code editor, then select the `backspace` or `del` key to remove everything.

Later, we'll learn a different, less destructive technique for disabling the lines of code you no longer want to execute.

### Step 2: Concatenate a literal string and a variable.

To concatenate two strings together, you use the *string concatenation operator*, which is the plus symbol `+`.

Add the following code to the code window:

```csharp-interactive
string firstName = "Bob";
string greeting = "Hello " + firstName;
Console.WriteLine(greeting);
```

Now, run the code.  You'll see the following result in the output console:

```output
Hello Bob
```

### Step 3: Concatenate a literal string and a variable.

You can perform several concatenation operations in the same line of code.

Modify the code you wrote in Step 2 to the following:

```csharp-interactive
string firstName = "Bob";
string lastName = "Tabor";
string fullName = firstName + " " + lastName;
Console.WriteLine(fullName);
```

Here we concatenate two variables along with a literal string -- an empty space character -- to separate the values stored in the two variables when presenting a full name.

Now, run the code.  You'll see the following result in the output console:

```output
Bob Tabor
```


### Step 4: Avoiding intermediate variables.

In steps 2 and 3, we used an extra variable to hold the new string that resulted from the concatenation operation.  Unless you have a good reason to do so, you can (and should) avoid this by performing the concatenation operation as you need it.  

Modify the code you wrote in Step 3 to the following:

```csharp-interactive
string firstName = "Bob";
string lastName = "Tabor";
Console.WriteLine(firstName + " " + lastName);
```

Now, run the code.  The result in the output console should be the same, however we were able to simplify the code:

```output
Bob Tabor
```

## Step 5: Add two numeric values.

Often we'll want to add values (and perform other mathematical operations).

To add two numbers together, we'll use the *addition operator, which is the plus sign `+`.  Yes, the same `+` symbol can be used for both purposes.  The reuse of one symbol for multiple purposes is sometimes called "overloading the operator".

In this instance, the C# compiler understands what you're attempting to do given the context of the variable types that are used.

Modify the code you wrote in Step 4 to the following:

```csharp-interactive
int firstNumber = 12;
int secondNumber = 7;
Console.WriteLine(firstNumber + secondNumber);
```

Now, run the code.  You'll see the following result in the output console:

```output
19
```

### Step 6: Mix data types to force implicit type conversion.

What happens if we try to use the `+` symbol with both `string` and `int` values?

Modify the code you wrote in Step 5 to the following:

```csharp-interactive
string firstName = "Bob";
int widgetsSold = 7;
Console.WriteLine(firstName + " sold " + widgetsSold + " widgets.");
```

Now, run the code.  You'll see the following result in the output console:

```output
Bob sold 7 widgets.
```

In this case, the C# compiler understands that we want to use the `+` symbol to concatenate, not add.  So, it attempts to implicitly convert the `int position` into a string temporarily so it can concatenate it to the rest of the string.  The C# compiler tries to help you when it can, but ideally, you would be explicit about your intentions.  Again, explicit type conversion will be discussed later in other modules.

## Understanding the flow of execution

Now that we're writing multiple lines of code, it's important to notice that when your application is executed each line of code is executed from top to bottom until there are no more lines of code to execute, at which point the application ends and returns control back to the operating system.  This is called the *flow of execution*.  Later we'll learn how to modify the flow of execution to bypass certain lines of code in certain situations, or loop through the same code until a condition is met.

## Recap

The primary ideas you should take away from this exercise:

- String concatenation allows you to combine smaller literal and variable strings into a single string.
- You can perform mathematical like addition operations on numbers.
- Both string concatenation and addition use the plus symbol.  This is called *overloading an operator* and the compiler infers the proper use based on the data types its operating on.
- When it can, the C# compiler will implicitly convert an `int` into a `string` if it's obvious that the developer is trying to concatenate the string representation of a number for presentation purposes.