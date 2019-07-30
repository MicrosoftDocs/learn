This is an introduction paragraph.

## How did our code work?

Previously we wrote this line of code:

```csharp
Console.WriteLine("Hello World!");
```
When we ran the code, we saw that the output printed the message ```Hello World!```.  That phrase ```Hello World!``` is called a literal string because it was surrounded in double-quotation marks.  In other words, we literally wanted the characters H, e, l, l, o, and so on printed to the output.

The `WriteLine()` part is called a method.  You can always spot a method because it has a set of parenthesis after it.  Each method has one job.  The `WriteLine()` method's job is to write a line to the output window.  The line that is printed is sent in between the opening and closing parenthesis as an input parameter.  Some methods need input parameters, some do not, but if you want to invoke a method you must always use the parenthesis after the method's name.  The parentheses are known as the "method invocation operator".

The `Console` part is called a class.  Classes "own" methods, or perhaps a better way to say it is that methods live inside of a class.  To visit the method, you must know which class it lives inside of.  For now, think of a class as a way to store and organize all of the methods that do similar things.  In this case, all of the methods that work with textual output in a console like our Output window are defined inside of the Console class.

There was also a dot, or period, that separated the class name `Console` and the method name `WriteLine()`.  The period is the "member access operator".  In other words, the dot is how you navigate from the class to it's methods.

Finally, there was a semi-colon at the end of the line.  This is the "end of statement operator".  A statement is a complete instruction in C#, and the semi-colon tells the compiler that we're finished typing the command.

Don't worry if all of these ideas and terms don't make sense just yet.  For now, all you really need to remember is that if you want to print a message to an output window like a console:

- use `Console.WriteLine("Your message here");`
- capitalize `Console`, `Write`, and `Line`
- use the correct *punctuation* since they have a special role in C#
- if you make a mistake, just spot it, fix it and re-run ... you can't really fail

## Exercise: Greet the user

We can improve our application by asking the user for their name, then use that in our greeting.

First, we need a way to capture what the user types on their keyboard into our application.  Second, we'll need to store their input temporarily somewhere until we're ready to display it.  And third, we'll need a way to combine literal strings with the input they typed.  The following exercise shows how to accomplish this.

### Step 1: Type the code into the .NET Editor

```csharp-interactive
Console.WriteLine("Please type your name, then press the Enter key");
string name = Console.ReadLine();
Console.WriteLine("Hello " + name + "!");
```

### Step 2: Run the application

Use the green Run button.  You should see the following (assuming your name is Bob):

```output

```