Print and web designers understand that putting too much information in a small space will overwhelm the reader, so they strategically use whitespace, or negative space, to break up information to maximize the reader's ability to consume the primary message of their work.

Developers can use a similar strategy when writing code in an editor. By using white space to convey meaning, developers can increase the clarity of their code's intent.

## What's whitespace?

The term "whitespace" refers to individual spaces produced by the <kbd>Space bar</kbd>, tabs produced by the <kbd>Tab</kbd> key, and new lines produced by the <kbd>Enter</kbd> key.

The C# compiler ignores whitespace. To understand how whitespace is ignored, and how to maximize clarity using whitespace, let's work through the following exercise.

### Step 1 - Add code to illustrate how whitespace is ignored by the C# compiler

Add the following code in the .NET Editor:

```csharp-interactive
// Example 1:
Console
.
WriteLine
(
"Hello World!"
)
;

// Example 2:
string firstWord="Hello";string lastWord="World";Console.WriteLine(firstWord+" "+lastWord+"!");
```

### Step 2 - Run the code to view the output

Run the code. You should get the following output:

```output
Hello World!
Hello World!
```

These two code examples illustrate two vital ideas:

- Whitespace doesn't matter to the compiler; however...
- Whitespace, when used properly, can increase your ability to read and comprehend the code.

You'll likely write code once, but need to read the code multiple times. Therefore, you should focus on readability of the code you write. Over time, you'll get a feel for when using whitespace like the space character, tabs, and new lines.

Early guidance:

- Each complete command (a *statement*) belongs on a separate line.  
- If a single line of code becomes long, you can break it up. However, you should avoid arbitrarily splitting up a single statement to multiple lines until you have a good reason to do so.
- Use a space to the left and right of the assignment operator.

### Step 3 - Delete all of the code in the .NET Editor

Delete all of the code from the previous exercises and steps. The .NET Editor should be blank.

### Step 4: Add code as a starting point for the next part of the exercise

Let's illustrate how to add whitespace to create visual phrasing to help you comprehend what a code passage is doing. We'll start by adding code without any whitespace.

> [!NOTE]
> The code in this step is from the [Add decision logic to your code using the if-elseif-else statement in C#](/training/modules/csharp-if-elseif-else/) module. It's heavily modified here to make a point about how to increase the readability of your code. If you don't understand what this is code is doing, don't worry, it'll be covered in other modules. For now, focus on how we've removed the whitespace, and how that makes it difficult to read the code.

Use the **Run** button or type the following code into the .NET Editor.

```csharp-interactive
Random dice = new Random();
int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);
int total = roll1 + roll2 + roll3;
Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");
if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3)) {
    if ((roll1 == roll2) && (roll2 == roll3)) {
        Console.WriteLine("You rolled triples!  +6 bonus to total!");
        total += 6; 
    } else {
        Console.WriteLine("You rolled doubles!  +2 bonus to total!");
        total += 2;
    }
}
```

The output of this code isn't important. We want to focus on the readability of the code.

There are two features of this code to note:

- There's no vertical whitespace in this code example. In other words, there's no empty lines separating the lines of code. It all runs together into one dense code listing.
- The code blocks as defined by the opening and closing curly brace symbols `{ }` are compressed together, making their boundaries difficult to visually discern.

### Step 5 - Add whitespace to create phrasing and improve readability

Generally speaking, to improve readability, you'll introduce a blank line by using the <kbd>Enter</kbd> key on the keyboard between two, three, or four lines of code that do similar or related things.

Phrasing your code using vertical whitespace is subjective. It's possible two developers will not agree on what's readable, or when to add whitespace. Use your best judgment.

Add three line feeds into the code in the previous step as follows:

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;
Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3)) {
    if ((roll1 == roll2) && (roll2 == roll3)) {
        Console.WriteLine("You rolled triples!  +6 bonus to total!");
        total += 6; 
    } else {
        Console.WriteLine("You rolled doubles!  +2 bonus to total!");
        total += 2;
    }
}
```

The first line feed separates the declaration and initialization of the `dice` variable. Again, don't worry what the `Random` class is, nor what the `new` keyword does. This is covered in another module.

The next three lines create three variables of type `int`, each with a similar name. They are initialized to a value returned by calling the `dice.Next(1, 7)` method. It's obvious that these lines look alike and do similar things.  

Since the first line and the next four lines seem like they do different things, it makes sense to separate them with a space.

Next, another variable called `total` is declared and initialized to the sum of the previous three variables of type `int`. Then, all four variables are output using `Console.WriteLine()`. These two lines can be part of a phrase since they "work together" to accomplish a task.

Some might argue that you should add an empty line in between the previous two lines of code. Again, this is your judgment call. You should see which is more readable to you and use that style consistently.

This leaves the `if` statement.  Let's tackle that in the next step.

### Step 6 - Move opening and closing curly braces to their own line to improve spacing

Focusing on the lines of code below the keyword `if`, modify the code from the previous step as follows:

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;
Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3)) 
{
    if ((roll1 == roll2) && (roll2 == roll3)) 
    {
        Console.WriteLine("You rolled triples!  +6 bonus to total!");
        total += 6; 
    } 
    else 
    {
        Console.WriteLine("You rolled doubles!  +2 bonus to total!");
        total += 2;
    }
}
```

The `{` and `}` symbols create code blocks. Many C# constructs require code blocks. These symbols should be placed on a separate line so that their boundaries are clearly visible and readable.

Furthermore, it's important to use the `tab` key to line up the code block symbols under the keyword they belong to. For example, notice the line of code that starts with the keyword `if`.  Below that line is the `{` symbol.  This makes it easy to understand that the `{` "belongs to" the `if` statement. Furthermore, the last `}` symbol lines up with these as well. This is especially helpful to understand where the code block ends.

The contents of this code block are indented, indicating that they "belong" to this outer code block.

We follow a similar pattern with the inner `if` statement and `else` statement, and the code inside of those code blocks.

Not everyone agrees with this style, but as a starting point, use this guidance when writing code. Then, you can be purposeful when deciding when you don't want to follow it in the future.

## Recap

Here are the main takeaways from this exercise:

- Use whitespace judiciously to improve the readability of your code.
- Use line feeds to create empty lines to separate phrases of code. A phrase is composed of lines of code that are similar, or work together.
- Use line feeds to separate code block symbols so that they are on their own line of code.
- Use the `tab` key to line up a code block with the keyword with which they're associated.
- Indent code inside of a code block to show ownership.
