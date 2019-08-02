Before we wrap up, let's work through an exercise that helps us understand how to communicate to humans and the C# compiler through comments and white space.

## Exercise - Using code comments and white space

In this exercise, we'll add notes to our code and temporarily disable certain lines of code from compilation.  Then, we'll also look at how the C# compiler understands our whitespace and how to utilize whitespace to increase the readability of the code.

## What is a code comment?

A code comment is an instruction to the compiler to ignore everything after the code comment symbols in the current line.

```csharp-interactive
// This is a code comment!
```

This may not seem useful at first, however it is useful in two situations:

- When you want to leave a note about the intent of a passage of code.  This is useful to describe the purpose or the thought process when you're writing a particularly challenging set of coding instructions.  Your future self will thank you.
- When you want to temporarily remove code from your application to try a different approach, but you're not yet convinced your new idea will work.  You can comment out the code, write the new code, and once you're convinced the new code will work the way you want it to, you can safely delete the old (commented code).

> [!NOTE]
> Code comments cannot be trusted.  Often, developers update their code but forget to update the code comments.  It's best to use comments for higher-level ideas and not to add comments about how C# works.

### Step 1: Make sure you have code from the previous exercise in the code window.

You should be able to see code that was typed in at the end of the previous exercise.  For reference, this is the last code example that you ran:

```csharp-interactive
string firstName = "Bob";
int widgetsSold = 7;
Console.WriteLine(firstName + " sold " + widgetsSold + " widgets.");
```
If you do not see that code in the code window, please click the Run button above the previous lines of code.  This will insert that code into the code window.

### Step 2: Comment out lines of code from the previous exercise.

Next, modify that code example as follows:

```csharp-interactive
string firstName = "Bob";
int widgetsPurchased = 7;
// Testing a change to the message.
// int widgetsSold = 7;
// Console.WriteLine(firstName + " sold " + widgetsSold + " widgets.");
Console.WriteLine(firstName + " purchased " + widgetsPurchased + " widgets.");
```

Now, run the application.  You'll see the following result in the output console:

```output
Bob purchased 7 widgets.
```

Notice that the code comments were used to document the potential change being made, and to temporarily disable the old message as we test the new message.  If we're satisfied with the new code, we can safely delete the old code that was commented out.  This is a safer, more methodical approach to modifying working code until we're convinced we're ready to permanently remove it.

### Step 3: Delete the commented code.


```csharp-interactive
string firstName = "Bob";
int widgetsPurchased = 7;
Console.WriteLine(firstName + " purchased " + widgetsPurchased + " widgets.");
```

The output should be unchanged.

### Step 4: Use multi-line comments.

If you need to write a long comment or remove many lines of code, you can comment multiple lines by adding a `/*` at the beginning of the code and a `*/` at the end.

```csharp
/* 
  This is a long comment 
  that spans multiple lines
  just to prove that it can
  be done.
*/
```

Modify the code you wrote in Step 3 to the following:

```csharp-interactive
/*
string firstName = "Bob";
int widgetsPurchased = 7;
Console.WriteLine(firstName + " purchased " + widgetsPurchased + " widgets.");
*/
```

If you run the code, you'll see nothing in the output console.  The C# compiler is now ignoring all of our code.

Using a multi-line comment is the quickest and easiest way to disable three or more lines of code.


## Step 6: Add code to illustrate how white space is ignored by the C# compiler

The C# compiler ignores white space.  The term "white space" refers to individual spaces produced by the space bar, tabs produced by the tab key, and new lines produced by the enter key.

To illustrate this idea in two very different ways, copy and paste the following lines to the bottom of the current code window (after the end-of-multi-line comment symbol in step 5):

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
string firstWord="Hello";string lastName="World";Console.WriteLine(firstName+" "+lastName+"!");
```

Output:

```output
Hello World!
Hello World!
```

These code examples illustrate two vital ideas:

- Whitespace does not matter to the compiler.  However ...
- Whitespace, when used properly, can increase your ability to read and comprehend the code.

You will likely write code once, but need to read the code multiple times.  Therefore, you should focus on readability of the code you write.  Over time, you'll get a feel for when using white space like the space character, tabs, and new lines.

Early guidance:

- Each complete command (a *statement*) belongs on a separate line.  
- If a single line of code becomes long, you can break it up.  However, you should avoid arbitrarily splitting up a single statement to multiple lines until you have a good reason to do so.
- Use a space to the left and right of the assignment operator.

We'll point out other ways to improve the readability of your code as we continue.

## Recap

The main takeaways from this exercise:

- Use code comments to leave meaningful notes to yourself about the problem you code solves.
- Use code comments when temporarily trying alternative solutions until you're ready to fully commit to the new code solution, at which point you can delete the old code.
- Use white space judiciously to improve the readability of your code.