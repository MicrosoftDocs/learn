

## Assign a value to a variable

To assign a value to a variable, you use the *assignment operator*, which is a single equals character `=`.

Here's an example:

```csharp
string firstName;
firstName = "Bob";
```
Assigning a value is also referred to as "setting the variable", or simply, a "set" operation.

It's important to notice that assignment happens from left to right.  If you were to reverse the order, you would confuse the C# compiler:

```csharp
string firstName;
"Bob" = firstName;
```
The first error you would see:

```output
(2,1): error CS0131: The left-hand side of an assignment must be a variable, property or indexer
```

### You must assign a value of the correct data type to the variable

Ealier we said that C# was designed to enforce types.  When working with variables, this means you cannot assign a value of one data type to a variable declared to hold a different data type.

This will not work:

```csharp
int value;
value = "Bob";
```

Output:

```output
(2,9): error CS0029: Cannot implicitly convert type 'string' to 'int'
```

The error message hints at what the C# compiler tries to do behind the scenes.  It tried to "implicitly convert" the string "Bob" to be an int value, however that is impossible.  In other words, you cannot put a square peg into a round hole.  Even so, C# tried to force the square peg to fit into the round hole, but there's no numeric equivalent for the word "Bob", so it failed.

You'll learn more about implicit and explicit type conversion in other modules.

## Retrieve a value from a variable

To retrieve a value from a variable, you just use the name of the variable.  This example will set a variable's value, then retrieve that value and print it to the console.

```csharp-interactive
string firstName;
firstName = "Bob";
Console.WriteLine(firstName);
```

The output:

```output
Bob
```

Retrieving a value from a variable is also referred to as "getting the variable", or simply, a "get" operation.

### Re-assigning the value of a variable

You can re-use and re-assign the variable as many times as you want.  This example illustrates that idea:

```csharp-interactive
string firstName;
firstName = "Bob";
Console.WriteLine(firstName);
firstName = "Beth";
Console.WriteLine(firstName);
firstName = "Conrad";
Console.WriteLine(firstName);
firstName = "Grant";
Console.WriteLine(firstName);
```

## Initializing variables

You must set a value to a variable before you can get the value from the variable.  Otherwise, you will see an error.

```csharp-interative
string value;
Console.WriteLine(value);
```

Output:

```
(2,19): error CS0165: Use of unassigned local variable 'value'
```

To avoid this, it's recommended that you set the value as soon as possible after you declare it.

In fact, you can perform both the declaration and setting the value of the variable in one line of code.  This technique is called *initializing* the variable.

Here's an example using `string`:

```csharp-interactive
string value = "Bob";
Console.WriteLine(value);
```

Here's another example using `int`:

```csharp-interactive
int value = 123;
Console.WriteLine(123);
```