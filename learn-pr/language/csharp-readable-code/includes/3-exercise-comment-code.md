In this exercise, we'll add notes to our code and temporarily disable certain lines of code from compilation.  Then we'll look at how the C# compiler understands our whitespace and how to use whitespace to increase the readability of the code.

## What is a code comment?

A code comment is an instruction to the compiler to ignore everything after the code comment symbols in the current line.

```csharp-interactive
// This is a code comment!
```

This may not seem useful at first, however it's useful in three situations:

- When you want to leave a note about the intent of a passage of code.  This is useful to describe the purpose or the thought process when you're writing a particularly challenging set of coding instructions.  Your future self will thank you.
- When you want to temporarily remove code from your application to try a different approach, but you're not yet convinced your new idea will work.  You can comment out the code, write the new code, and once you're convinced the new code will work the way you want it to, you can safely delete the old (commented code).
- Adding a message like `TODO` to remind you to look at a given passage of code later.  While you should use this judiciously, it's a valid reason.  You may be working on another feature when you read a line of code that sparks a concern.  Rather than ignoring the new concern, you can mark it for investigation later.  The Visual Studio IDE even provides a window called the Task List to help you identify `TODO` messages you leave in your code.

> [!NOTE]
> Code comments cannot be trusted.  Often, developers update their code but forget to update the code comments.  It's best to use comments for higher-level ideas and not to add comments about how an individual line of code works.

### Step 1 - Add some code in the .NET Editor as a starting point for the exercise.

To demonstrate the use of code comments, you'll need to work with some code.  The following code was used in a previous module. Re-enter the code by copying / pasting or click the run button to add it to the .NET Editor.

```csharp-interactive
string firstName = "Bob";
int widgetsSold = 7;
Console.WriteLine($"{firstName} sold {widgetsSold} widgets.");
```


### Step 2 - Comment out lines of code from the previous exercise

Next, modify that code example as follows:

```csharp-interactive
string firstName = "Bob";
int widgetsPurchased = 7;
// Testing a change to the message.
// int widgetsSold = 7;
// Console.WriteLine($"{firstName} sold {widgetsSold} widgets.");
Console.WriteLine($"{firstName} purchased {widgetsPurchased} widgets.");
```

Now, run the application.  You'll see the following result in the output console:

```output
Bob purchased 7 widgets.
```

Notice that the code comments were used to document the potential change being made, and to temporarily disable the old message as we test the new message.  If we're satisfied with the new code, we can safely delete the old code that was commented out.  This is a safer, more methodical approach to modifying working code until we're convinced we're ready to permanently remove it.

### Step 3 - Delete the commented code

Remove every line of code from the previous step that starts with the code comment operator `//`.  Modify your code so it matches the following listing:

```csharp-interactive
string firstName = "Bob";
int widgetsPurchased = 7;
Console.WriteLine($"{firstName} purchased {widgetsPurchased} widgets.");
```

The output should be unchanged.

### Step 4 - Use multi-line comments

If you need to write a long comment or remove many lines of code, you can comment multiple lines by adding a `/*` at the beginning of the code and a `*/` at the end.

```csharp
/* 
  This is a long comment 
  that spans multiple lines
  just to prove that it can
  be done.
*/
```

Modify the code you wrote in Step 3 to the following code listing:

```csharp-interactive
/*
string firstName = "Bob";
int widgetsPurchased = 7;
Console.WriteLine($"{firstName} purchased {widgetsPurchased} widgets.");
*/
```

If you run the code, you'll see nothing in the output console.  The C# compiler is now ignoring all of our code.

Using a multi-line comment is the quickest and easiest way to disable three or more lines of code.

### Step 5 - Delete all of the code in the .NET Editor

Delete all of the code from the previous exercises and steps.  The .NET Editor should be blank.

### Step 6 - Add poorly commented code to the .NET Editor

Use the Run button, type or copy the following code into the .NET Editor:

```csharp-interactive
Random random = new Random();
string[] orderIDs = new string[5];
// Loop through each blank orderID
for (int i = 0; i < orderIDs.Length; i++)
{
    // Get a random value that equates to ASCII letters A through E
    int prefixValue = random.Next(65, 70);
    // Convert the random value into a char, then a string
    string prefix = Convert.ToChar(prefixValue).ToString();
    // Create a random number, padd with zeroes
    string suffix = random.Next(1, 1000).ToString("000");
    // Combine the prefix and suffix together, then assign to current OrderID
    orderIDs[i] = prefix + suffix;
}
// Print out each orderID
foreach (var orderID in orderIDs)
{
    Console.WriteLine(orderID);
}
```

> [!NOTE]
> There are many C# concepts in this code listing that may be new to you.  It's not necessary to understand what the code is doing in order to appreciate how comments can help readers understand the purpose of the code.

Given the comments, you might be able to figure out what the code is doing (assuming the comments accurately describe the current state and were updated as the code was updated).

But can you guess why this code exists?  Wouldn't it be helpful if there were some explanation as to its purpose above this code to provide some context?

There are two problems with this code:

- The code comments unnecessarily explain the obvious functionality of individual lines of code.  These are considered low-quality comments because they merely explain how C# or methods of the .NET Class Library work.  If the reader is unfamiliar with these ideas, they can look them up using docs.microsoft.com or Intellisense.
- The code comments don't provide any context to the problem being solved by the code. These are considered low-quality comments because the reader doesn't gain any insight into the purpose of this code, especially as it relates to the larger system.

### Step 7 - Remove the low-level descriptive comments

To improve this code, first let's remove the existing comments.

Select and delete each line of code that starts with the line comment operator `//`.  Your code should match the following code listing:

```csharp-interactive
Random random = new Random();
string[] orderIDs = new string[5];

for (int i = 0; i < orderIDs.Length; i++)
{
    int prefixValue = random.Next(65, 70);
    string prefix = Convert.ToChar(prefixValue).ToString();
    string suffix = random.Next(1, 1000).ToString("000");

    orderIDs[i] = prefix + suffix;
}

foreach (var orderID in orderIDs)
{
    Console.WriteLine(orderID);
}
```

### Step 8 - Add code comments to explain the higher-level purpose of your code

To further improve this code, add a comment that explains the higher-level purpose of the code.  Your code should match the following code listing:

```csharp-interactive
/*
  The following code creates five random OrderIDs
  to test the fraud detection process.  OrderIDs 
  consist of a letter from A to E, and a three
  digit number. Ex. A123.
*/
Random random = new Random();
string[] orderIDs = new string[5];

for (int i = 0; i < orderIDs.Length; i++)
{
    int prefixValue = random.Next(65, 70);
    string prefix = Convert.ToChar(prefixValue).ToString();
    string suffix = random.Next(1, 1000).ToString("000");

    orderIDs[i] = prefix + suffix;
}

foreach (var orderID in orderIDs)
{
    Console.WriteLine(orderID);
}
```

A comment's usefulness is subjective.  In all matters related to code readability, you should use your best judgment.  Do what you think is best to improve the clarity of your code.

## Recap

The main takeaways from this exercise:

- Use code comments to leave meaningful notes to yourself about the problem your code solves.
- Don't use code comments that explain how C# or the .NET Class Library works.
- Use code comments when temporarily trying alternative solutions until you're ready to commit to the new code solution, at which point you can delete the old code.
- Never trust comments.  They may not reflect the current state of the code after many changes and updates.