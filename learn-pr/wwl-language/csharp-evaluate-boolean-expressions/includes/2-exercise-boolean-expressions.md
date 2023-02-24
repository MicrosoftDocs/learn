"Decision logic" and "branching logic" are terms programmers use to describe the change in execution path based on the evaluation of some expression. For example, we may write code that evaluates user input. If the value the user inputs is equal to the string value "a", execute one code block. If the value the user inputs is equal to the string value "b", execute a different code block. Here, we're changing the execution path of our application based on user input. This is what programmers mean by the terms "branching" and "decision".

Before we work with the logic statements, let's start by talking about how to evaluate an expression.

## What's an expression?

An expression is any combination of values (literal or variable), operators, and methods that return a single value. A statement is a complete instruction in C#, and statements are composed of one or more expressions.

There are many different categories of expressions, but when working with decision statements, we're interested in Boolean expressions. In a Boolean expression, the runtime evaluates the values, operators, and methods to return a single true or false value.

Boolean expressions are important because the decision statements we'll learn about next use these to decide which code block to execute.

There are many different operators we can use depending on what we want to express in our code.

## Evaluating equality and inequality

Many times, you'll want to check to see if two values are equal or not. You can use the equality operator `==` between two values to evaluate equality. If the two values on either side of the equality operator are equivalent, then the expression will return `true`.  Otherwise, it will return `false`.

Other times, you may want to check to see if two values aren't equal. You can use the inequality operator `!=` between two values evaluate equality.

You may wonder why you need both equality and inequality operators. The reason will become clearer as you learn how to create branching statements and begin to write real-world code. Two operators that perform opposite tasks allow you to be more expressive and compact.

### Step 1 - Use the equality operator

Type the following code into the code editor on the right:

```csharp-interactive
Console.WriteLine("a" == "a");
Console.WriteLine("a" == "A");
Console.WriteLine(1 == 2);

string myValue = "a";
Console.WriteLine(myValue == "a");
```

Now run the code. You should get the following output:

```output
True
False
False
True
```

### Step 2 - Improve the check for string equality using the string's built-in helper methods

You may be surprised that the line `Console.WriteLine("a" == "A");` outputs `false`. When comparing strings, case matters.

Also, consider this line of code:

```csharp-interactive
Console.WriteLine("a" == "a ");
```

Here, we add a blank space at the end of the string. This, too, outputs `false`.

In some cases, this might be perfectly acceptable. However, if you need to accept a match that is inexact, you can "massage" the data first. "Massaging" the data means that you need to perform some cleanup before you perform a comparison for equality.

To massage two strings before checking for equality, you should:

- Make sure both strings are all upper-case or all lower-case using the `ToUpper()` or `ToLower()` helper method on any string value.
- Remove leading or trailing blank spaces using the `Trim()` helper method on any string value.

Let's improve the previous check for equality by chaining these two methods on both values in the following code listing:

```csharp-interactive
string value1 = " a";
string value2 = "A ";
Console.WriteLine(value1.Trim().ToLower() == value2.Trim().ToLower());
```

When you run the code this time, the output will be `true`.

### Step 3 - Use the inequality operator

Use the line comment operator `//` to comment out all of the code from the previous step. Then, add the following code underneath it in the code editor:

```csharp-interactive
Console.WriteLine("a" != "a");
Console.WriteLine("a" != "A");
Console.WriteLine(1 != 2);

string myValue = "a";
Console.WriteLine(myValue != "a");
```

Now, run the code. You should get the following output:

```output
False
True
True
False
```

## Evaluating comparisons

When working with numeric data types, you'll want to determine if one value is larger, smaller, or equal to another value. Use the following operators to perform these types of comparisons.

- Greater than `>`
- Less than `<`
- Greater than or equal to `>=`
- Less than or equal to `<=`

### Step 4 - Use the Comparison operators

Use the line comment operator `//` to comment out all of the code from the previous step. Then add, the following code underneath it in the code editor:

```csharp-interactive
Console.WriteLine(1 > 2);
Console.WriteLine(1 < 2);
Console.WriteLine(1 >= 1);
Console.WriteLine(1 <= 1);
```

Now, run the code. You should get the following output.

```output
False
True
True
True
```

## Methods that return a Boolean value

Some methods return a Boolean value. You can think of these types of methods as queries. In the following exercise, we'll use a built-in method on the `String` class to determine whether or not a larger string contains a specific word or phrase that may be interesting to us.

> [!NOTE]
> Some data types have methods that perform helpful utility tasks. The String data type has many of these. Several return a Boolean value, including `Contains()`, `StartsWith()`, and `EndsWith()`. You can learn more about them in the Microsoft Learn module [Format alphanumeric data for presentation in C#](/training/modules/csharp-format-strings/).

### Step 5 - Use a method invocation expression

Use the line comment operator `//` to comment out all of the code from the previous steps. Then, add the following code underneath it in the code editor:

```csharp-interactive
string pangram = "The quick brown fox jumps over the lazy dog.";
Console.WriteLine(pangram.Contains("fox"));
Console.WriteLine(pangram.Contains("cow"));
```

Now, run the code. You should get the following output:

```output
True
False
```

## What is logical negation?

The term "Logical Negation" refers to the `!` operator. Some people simply call this the "not operator". Adding the `!` operator before a conditional expression like a method call checks to ensure the expression is false.

And just to hopefully help you learn the connections between these ideas, the following two lines of code do the same thing. The second line is more compact.

```csharp
// These two lines of code do the same thing:

Console.WriteLine(pangram.Contains("fox") == false);
Console.WriteLine(!pangram.Contains("fox"));
```

### Step 6 - Use the Logical Negation operator

Update the code from Step 4 to include not operators before the invocation of the method calls.

```csharp-interactive
string pangram = "The quick brown fox jumps over the lazy dog.";
Console.WriteLine(!pangram.Contains("fox"));
Console.WriteLine(!pangram.Contains("cow"));
```

Now, run the code. You should get the following output:

```output
False
True
```

## Recap

Here are the main takeaways you learned about evaluating Boolean expressions so far:

- There are many different kinds of expressions that evaluate to either `true` or `false`.
- Evaluate equality using the `==` operator.
- Evaluating equality of strings requires you consider the possibility that the strings have different case and leading or trailing spaces. Depending on your situation, use the `ToLower()` or `ToUpper()` helper methods, and the `Trim()` helper method to improve the likelihood that two strings are equal.
- Evaluate inequality using the `!=` operator.
- Evaluate greater than, less than, and similar operations using comparison operators like `>`, `<`, `>=`, and `<=`.
- If a method returns a bool, you can use it as a Boolean expression.
- Use the logical negation operator `!` to evaluate the opposite of a given expression.
