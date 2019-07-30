

## What is a code comment?

A code comment is an instruction to the compiler to ignore everything after the code comment symbols in the current line.

```csharp-interactive
// This is a code comment!
```

This may not seem useful at first, however it is very useful in two situations:

- When you want to leave a note about the intent of a passage of code.  This is useful to describe the purpose or the thought process when you're writing a particularly challenging set of coding instructions.  Your future self will thank you.
- When you want to temporarily remove code from your application to try a different approach, but you're not yet convinced your new idea will work.  You can comment out the code, write the new code, and once you're convinced the new code will work the way you want it to, you can safely delete the old (commented code).

> [!NOTE]
> Code comments cannot be trusted.  Often, developers update their code but forget to update the code comments.  It's best to use comments for higher-level ideas and not to add comments about how C# works.

### Multi-line comments

If you need to write a long comment or remove many lines of code, you can comment multiple lines by adding a `/*` at the begining of the code and a `*/` at the end.

```csharp-interactive
/* 
  This is a long comment 
  that spans multiple lines
  just to prove that it can
  be done.
*/
```

## White space is ignored

The C# compiler ignores white space.  Compare the following two examples (both of which are valid C# syntax):

```csharp-interactive
Console
.
WriteLine
(
"Hello World!"
)
;
```

Output:

```output
Hello World!
```

Compare that to:

```csharp-interactive
string firstName="Bob";string lastName="Tabor";Console.WriteLine(firstName+" "+lastName);
```

Output:

```
Bob Tabor
```

These code examples illustrate two vital ideas:

- Whitespace does not matter to the compiler.  However ...
- Whitespace, when used properly, can increase your ability to read and comprehend the code

You should focus on readability of the code you write.  Over time, you'll a feel for when using white space like the space character, tabs and new lines.

Generally speaking:

- Each command belongs on a separate line.
- Keep lines of code together that do similar things.  Separate code visually when you switch tasks or jobs.
- Use a space to the left and right of the assignment operator.