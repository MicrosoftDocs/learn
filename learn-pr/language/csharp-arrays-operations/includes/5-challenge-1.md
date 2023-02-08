Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

## Word reversal challenge

You'll often need to combine several of the ideas we covered in this module into a single solution. This challenge will force you to decompose a larger problem into many mini-problems, then use the various ideas in this module to solve each mini-problem.

### Step 1: Delete all of the code in the .NET Editor from the earlier exercise

Select all of the code in the .NET Editor, then select the <kbd>Del</kbd> or <kbd>Backspace</kbd> key to delete it.

### Step 2: Write code in the .NET Editor to reverse each word in a message

Begin with the following line of code:

```csharp-interactive
string pangram = "The quick brown fox jumps over the lazy dog";
```

Write the code necessary to reverse the letters of each word in place and display the result. In other words, don't just reverse every letter in the variable `pangram`. Instead, you'll need to reverse just the letters in each word, but print the reversed word in its original position in the message.

If you're successful, you should get the following output:

```output
ehT kciuq nworb xof spmuj revo eht yzal god
```

> [!IMPORTANT]
> This is a particularly difficult challenge. You'll need to combine many of the concepts you learned in this exercise, including the use of the `Split()`, `ToCharArray()`, `Array.Reverse()`, and `String.Join()`. You'll also need to create multiple arrays and at least one iteration statement.  

Good luck! You can do it! Just keep decomposing the problem into baby steps, then solve that particular step before moving to the next.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
