Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

## Challenge instructions

In this challenge, you'll use the techniques you learned in this module. Your goal is to make improvements to some poorly formatted and commented code to increase its readability.

### Step 1 - Delete all of the code in the .NET Editor from the earlier exercise

Select all of the code in the .NET Editor, then select the <kbd>Del</kbd> or <kbd>Backspace</kbd> key to delete it.

### Step 2 - Start with the following unreadable code in the .NET Editor

Run, copy, or type the following code listing so that it appears in the .NET Editor:

```csharp-interactive
string str = "The quick brown fox jumps over the lazy dog.";
// convert the message into a char array
char[] charMessage = str.ToCharArray();
// Reverse the chars
Array.Reverse(charMessage);
int x = 0;
// count the o's
foreach (char i in charMessage) { if (i == 'o') { x++; } }
// convert it back to a string
string new_message = new String(charMessage);
// print it out
Console.WriteLine(new_message);
Console.WriteLine($"'o' appears {x} times.");
```

The high-level purpose of this code is to reverse a string and count the number of times a particular character appears.

The code suffers from many issues that dramatically decrease its readability.

### Step 3 - Modify the code to make it more readable

Using the techniques you learned in this module, make improvements to the code to increase its readability.

In the next unit, we'll provide a possible description of the kinds of improvements you can make.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
