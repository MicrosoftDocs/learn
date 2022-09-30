A code block is one or more C# statements that define an execution path. Typically, the statements outside of the code block affect when, if, and how often that block of code is executed at run time.

Code blocks also affect variable scope, and the following exercise will help you understand how this affects your code.

## Code blocks impact the scope of a variable declaration

*Variable scope* is the visibility of the variable to the other code in your application. A locally scoped variable is only accessible inside of the code block in which it's defined. If you attempt to access the variable outside of the code block, you'll get a compiler error.

### Step 1 - Create a variable inside of a code block

Add the following code into the .NET Editor:

```csharp-interactive
bool flag = true;
if (flag)
{
    int value = 10;
    Console.WriteLine($"Inside of code block: {value}");
}
```

Now, run the code.  You should get the following output.

```output
Inside of code block: 10
```

This is as expected.  But what if we want to access the variable `value` outside of the `if` statement's code block?

### Step 2 - Attempt to access the variable outside of the code block in which it was defined

Below the `if` statement's code block, add the following line of code:

```csharp
Console.WriteLine($"Outside of code block: {value}");
```

So, the entire code example should look like this:

```csharp-interactive
bool flag = true;
if (flag)
{
    int value = 10;
    Console.WriteLine("Inside of code block: " + value);
}
Console.WriteLine($"Outside of code block: {value}");
```

This time, when you attempt to run the application, you'll get a compilation error:

```output
error CS0103: The name 'value' does not exist in the current context
```

The problem is that a variable defined in a code block is only accessible (or rather, visible) within that code block. The variable isn't accessible outside of the code block in which it's defined.

A *local variable* is a variable defined in a method code block. We'll talk about method code blocks in the next unit.

### Step 3 - Move the variable outside

To access a variable from both an outer and inner code block (like the `if` statement's code block), you'll need to move the variable declaration outside of the `if` statement's code block so that all the code has visibility to that variable.

Modify your code so that it matches the following code:

```csharp-interactive
bool flag = true;
int value;

if (flag)
{
    value = 10;
    Console.WriteLine("Inside of code block: " + value);
}
Console.WriteLine("Outside of code block: " + value);
```

This time, when you attempt to run the application, you'll get a compilation error:

```output
error CS0165: Use of unassigned local variable 'value'
```

This is a simple problem to fix; however, it gives us another insight into working with code blocks.

If the line of code `value = 10;` was outside of the `if` statement's code block, the compiler would compile our application. However, since that line of code is inside the `if` statement's code block, there's a possibility that the variable will never be assigned a value, which the compiler won't allow.

### Step 4 - Initialize the variable with a value

To fix the "unassigned local variable" issue, we need to initialize the variable with a value. Update the variable declaration to include an initialization.

```csharp
int value = 0;
```

So, the entire code example should look like this:

```csharp-interactive
bool flag = true;
int value = 0;

if (flag)
{
    value = 10;
    Console.WriteLine("Inside of code block: " + value);
}
Console.WriteLine("Outside of code block: " + value);
```

Now, when you run the application, you should get the following output.

```output
Inside of code block: 10
Outside of code block: 10
```

## Recap

Here are a few important things to remember about code blocks:

- When you define a variable inside of a code block, its visibility is local to that code block and inaccessible outside of that code block.
- To make a variable visible inside and outside of a code block, you must define the variable outside of the code block.
- Don't forget to initialize any variables whose value is set in a code block, such as an `if` statement.