
A **variable** is a container that holds a value. Unlike hard-coded literals, variables can change as your program runs. Variables let you store information from users, calculations, or other sources, then use that information later in your code.

## Declaring a variable

To create a variable, you declare its data type and give it a name:

```csharp
string name;
```

This creates a variable called `name` that can only hold string values. Once you declare a variable with a type, it can never hold a different type.

## Assigning a value

To put a value into a variable, use the assignment operator (`=`):

```csharp
string name;
name = "Alice";
```

Assignment flows from right to left: the value on the right (`"Alice"`) gets stored in the variable on the left (`name`).

You can declare and assign in one line:

```csharp
string name = "Alice";
int age = 25;
decimal temperature = 98.6;
bool isRaining = true;
```

## Using your variables

Once you've assigned a value, you can use the variable anywhere you'd use the literal:

```csharp
string greeting = "Hello";
Console.WriteLine(greeting);           // Output: Hello

int messageCount = 5;
Console.WriteLine(messageCount + 1);   // Output: 6
```

## Variable naming

Keep these conventions in mind when naming variables:

- Use **camelCase**: Start with a lowercase letter, then capitalize the first letter of each word after that (`firstName`, `totalPrice`, `isActive`)
- Use **descriptive names** that clearly show what the variable holds (`userName` instead of `u`)
- Use **full words**, not abbreviations (`name` instead of `nm`)

Good variable names make your code easier to read and understand.
