In this first hands-on exercise, you'll use C# to print a hallowed programmer's phrase to the Output window.

## Write your first line of code

There's a long standing tradition amongst software developers to print the phrase "Hello World!" to a command line or console window.  As you'll see, you can learn a lot about act of programming and the C# programming language from this simple exercise.

### Step 1: Type the code into the .NET Editor

> [!NOTE] 
> You might be tempted to use the `Copy` or `Run` button below and skip all the typing.  However, we encourage you to experience the _pride and accomplishment_ of typing this line of code yourself.  Typing the code yourself builds muscle memory and helps you gain insights that you wouldn't get otherwise.

Type this code into the .NET Editor on the right:

```csharp-interactive
Console.WriteLine("Hello World!");
```

We'll explain how and why it works soon.  But first, you should see it running and ensure you didn't type it incorrectly.  To do that, you'll run your code.

### Step 2: Press the green Run button 

The green Run button performs two tasks:

- It compiles your code into an executable format that a computer can understand
- It runs your compiled application and outputs the desired command

### Step 3: In the output window, observe the result

You should see the following output:

```output
Hello World!
```

### What to do if you got an error

Writing C# code is an *exercise in precision*.  If you type just one character incorrectly, you will see an error message in the Output area.

For example, if you were to incorrectly use a lower-case `c` in `console` like so:

```csharp-interactive
console.WriteLine("Hello World!");
```

We would see the following error message:

```output
(1,1): error CS0103: The name 'console' does not exist in the current context
```

The key is the `(1,1)` which indicates the line and column where the error occurred.  C# is a case-sensitive language, meaning that the C# compiler considers the words `console` and `Console` as different as the words `cat` and `dog`.  Sometimes the error message can be a bit misleading, so you'll need to understand the true reason why the error exists, and that comes through learning more about C#'s syntax.

Similarly, if you used single-quotation marks to surround the literal string `Hello World!` like so:

```csharp-interactive
console.WriteLine('Hello World!');
```

You would see the following error message:

```output
(1,19): error CS1012: Too many characters in character literal
```
Again, line 1, character 19 points us to the culprit.  But what does the error message mean?  What exactly is a "character literal"?  While we will discuss literals of various data types (including character literals) in other lessons, our advice for now is to be extremely careful when you are typing code.

Fortunately, errors are never permanent.  You merely spot the error, fix it, and re-run your application.

If you got an error, please take your time, look closely, and examine each character and make sure you typed exactly this line of code.

Common mistakes new programmers make:

- You didn't capitalize the `C` in `Console`, or the letters `W` or `L` in `WriteLine`
- You used a comma instead of a period between `Console` and `WriteLine`
- You didn't use double-quotation marks to surround the phrase `Hello World!`
- You forgot semi-color at the end of the command

Each of these mistakes prevent your code from compiling successfully.

## What is compilation?

Compilation takes source code (the code you've written) and converts it into an executable format.

Programming languages like C# allow you to write instructions that you want the computer to carry out.  Even though most higher-level programming languages seem cryptic, they can be more easily understood than the a computer's preferred lower-level language which is expressed by turning millions of switches either on or off.  Compilers bridge these two worlds by translating your human-readable instructions into a computer-understandable set of instructions.

## What is syntax?

The syntax is the keywords, the operators (those special keyboard characters like the semicolon or parenthesis), and the rules of a programming language.  The single line of code you typed followed about a dozen different syntax rules and used at least four operators.  There's a lot of syntax to learn, but fortunately each concept is simple.  Don't give up!  You can learn it!

## How did your code work?

When you ran your code, you saw that the message ```Hello World!``` was printed to the output pane.  That phrase ```Hello World!``` is called a literal string because it was surrounded in double-quotation marks.  In other words, we literally wanted the characters H, e, l, l, o, and so on printed to the output.

The `WriteLine()` part is called a method.  You can always spot a method because it has a set of parenthesis after it.  Each method has one job.  The `WriteLine()` method's job is to write a line of data to the output window.  The data that's printed is sent in between the opening and closing parenthesis as an input parameter.  Some methods need input parameters, some do not, but if you want to invoke a method you must always use the parenthesis after the method's name.  The parentheses are known as the "method invocation operator".

The `Console` part is called a class.  Classes "own" methods, or perhaps a better way to say it is that methods live inside of a class.  To visit the method, you must know which class it lives inside of.  For now, think of a class as a way to store and organize all of the methods that do similar things.  In this case, all of the methods that work with textual output in a console like our Output window are defined inside of the Console class.

There was also a dot, or period, that separated the class name `Console` and the method name `WriteLine()`.  The period is the "member access operator".  In other words, the dot is how you navigate from the class to it's methods.

Finally, there was a semi-colon at the end of the line.  This is the "end of statement operator".  A statement is a complete instruction in C#, and the semi-colon tells the compiler that we're finished typing the command.

Don't worry if all of these ideas and terms don't make sense just yet.  For now, all you really need to remember is that if you want to print a message to an output window like a console:

- use `Console.WriteLine("Your message here");`
- capitalize `Console`, `Write`, and `Line`
- use the correct *punctuation* since they have a special role in C#
- if you make a mistake, just spot it, fix it and re-run ... you can't really fail

> [!TIP]
> Create a cheat sheet for yourself until you've memorized certain key commands.