This is an introduction paragraph.

## What is a literal value?

A literal value is a hard-coded value that never changes.  Previously, we displayed a literal string to the Output pane.  In other words, we literally wanted that string of alphanumeric characters `H`, `e`, `l`, `l`, `o` and so on outputted.

What other kinds of literal data can we print to the Output pane?


## C# allows you to work with lots of different literal data types

There are 15 basic data types in C#, but as you're getting started you only need to know about five or six.  Each of these data types can be represented as literals in your code.

### char

If we only wanted a single alphanumeric character printed to screen, we could create a **char literal** by surrounding one alphanumeric character in single-quotes like so:

```csharp-interactive
Console.WriteLine('b');
```

This would explain why you got that mysterious error message previously if you used single-quotation marks around `Hello World!`.  The C# compiler was expecting a single character (since you used the character literal syntax) but you supplied twelve characters instead!

The term *char* is short for *character*.  In C#, they're officially referred to as "char", but frequently referred to as a "character".

### int

If you want to print a numeric whole number (no fractions) value to Output, you can use an **int literal** like so:

```csharp-interactive
Console.WriteLine(123);
```

The term *int* is short for integer which you may recognize from studying math.  In C#, they're officially referred to as "int", but frequently known by their alter ego "integer".

### float

If we wanted to print a number that includes values after the decimal point we could use a **float literal** like so:

```csharp-interactive
Console.WriteLine(12.3f);
```

This will produce the following output.

```output
12.3
```

Note the letter `f` is called a *literal suffix*.  The literal suffix tells the compiler you wish to work with a value of type float.

> [!NOTE]
> You can use either a lower-case `f` or upper-case `F` as the literal suffix for a float.


### bool

If we wanted to print a value representing either `true` or `false`, we could use a **bool literal** like so:

```csharp-interactive
Console.WriteLine(true);
Console.WriteLine(false);
```

This will produce the following output:

```output
true
false
```

It's important to know that these values may look like their string literal equivalents.  In other words, you may think that this is the same as:

```csharp-interactive
Console.WriteLine("true");
Console.WriteLine("false");
```

However, the bool literals represent the concept of truthhood and falsehood.  We'll use bool values extensively when we start to add decision logic to our applications.  We'll evaluate expressions to see whether the expression is true or false.

The term *bool* is short for boolean which you may also recognize from studying math.  In C#, they're officially referred to as "bool", but often developers use the term "boolean".

### Why emphasize data types?

Data types play a central role in C#.  In fact, the emphasis on data types is one of the key distinguishing features of C# compared to other languages like Python and JavaScript.  The designers of C# believed that they can help developers avoid common software bugs by "enforcing data types".  You'll see this concept unfold as you learn more about C#.

## Recap

The main take away is that there are many types, but we'll focus on just a few for now:

- string
- char
- int
- float
- bool