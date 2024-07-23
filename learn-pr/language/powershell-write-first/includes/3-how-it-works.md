To help you understand how code works, we need to talk about what a _program_ is, what a
_programming language_ is, and how that language communicates commands to your computer.

## What is a program?

A program is a set of instructions that complete computing tasks. The instructions are compiled
into a format the computer can understand and then run by a _user_. A _user_ can be a person or
another program. The computer executes the instructions in order, one line at a time, until there
are no more lines to execute or the program is explicitly told to stop.

Even the most basic programs do one or more of the following tasks:

- **Accepts input** from a source. Input includes information that:
  - Comes from a user who's typing on a keyboard or selecting controls on an interface.
  - Is retrieved from a file.
  - Is called from another program or network connection.
- **Processes** information, which includes:
  - Performing logic.
  - Performing mathematical calculations.
  - Manipulating data input to produce new data.
- **Outputs** results, which include information that's:
  - Displayed on a screen to a user.
  - Saved to a file.
  - Sent to another program.

A program can take different forms for different purposes. A program can be:

- A standalone application, such as a game, a text editor, billing software, and so on.
- A script, such as an advanced macro that executes inside another program to automate certain functionality.
- A combination of live code, equations, and data visualizations.

Some programs, including the examples in this module, need only a few lines of code. But complex
programs such as operating systems need tens of thousands or sometimes millions of lines of code.

## What is a programming language?

The job of a programming language is to allow a person to write instructions for a computer in a
human-readable and understandable way. Computers understand language in a different way than humans
ordinarily do. Programming languages give program writers a specific and less complicated way of
interfacing with computers to give them instructions. The instructions you write in a programming
language are called _code_.

There are many programming languages, each with a different syntax. However, after you've learned
your first programming language, you can apply many of its concepts to each new language you learn.

## What is syntax?

Like any spoken or written language, programming languages have their own grammatical rules, known
as _syntax_. The syntax of any programming language includes _keywords_, _operators_, or other
types of rules that might be specific to that language.

_Keywords_ are specific words reserved by a programming language that have special meaning and
behavior. In PowerShell, many of the keywords read like English. For example, `if`, `while`, and
`return` are keywords you can use to write code in PowerShell and many other languages.

_Operators_ are special characters, such as parentheses (`()`) or equal signs (`=`). These
characters tell the computer to perform specific mathematical, relational, or logical operations to
produce a result.

When you typed your code in the Cloud Shell terminal in the preceding unit, you might have noticed
small changes to the color of the text and symbols. This color coding is called _syntax
highlighting_. As you're reading your code, syntax highlighting can help you spot any mistakes you
might have made. This feature is available and even more robust in many code editors, such as
Visual Studio Code.

## Compiling code in PowerShell

Computers aren't good at reading our programs in the way we write them. Programming languages need
to be translated into a form that the computer can understand. Programming languages have various
ways of doing this.

Many programming languages _compile_ code as an individual step. You write your code, run it
through a special program called a compiler, and the compiler produces an executable package to
run.

Other languages, such as Python, have what's called an _interpreter_, which interprets the code for
the computer and executes the code one line at a time as it's interpreting it.

PowerShell works both a little differently and a little similarly to the compiled and interpreted
approaches.

PowerShell is compiled into an abstract syntax tree (AST), first in memory, and then run. But you
don't need to do a deep dive here to use PowerShell. All you need to know is that the computer
checks your code first in the AST as it looks for major issues. Then, if everything is okay, your
program is run by the computer without the need for a compiled executable program. This approach is
useful, because it ensures that your code runs correctly before it's run by the computer, where it
might otherwise make changes and stop because of a syntax error. By contrast, an interpreted
language such as Python runs the code until it finds something wrong in the syntax.

## Exploring PowerShell

An important feature of PowerShell is its built-in help system, which gives you quick access to
information about PowerShell commands. If you get stuck as you're writing, you can look up help for
commands or PowerShell concepts by using the `Get-Help` command. For example, to see all the
details about the `Write-Output` command, you can type and run the following command:

```powershell
Get-Help -Name 'Write-Output' -Full
```

`Get-Help` is the command to run and `Write-Output` is the name of the command to get help for. The
`-Full` switch tells PowerShell to get all information for the specified command, including a
command description, parameter information, examples, and more. This help information is accessible
in any PowerShell terminal, including the Azure Cloud Shell terminal.

If you want to explore all the commands that PowerShell has to offer, you can use `Get-Command *`
to view the full list. The asterisk (`*`) is a _wildcard_ character in PowerShell. It allows you to
match patterns to find information more dynamically. In this case, you use the `*` to filter for
all available commands. For example, to get all commands that have `User` in them, run
`Get-Command *User*`.

Another great thing about PowerShell is that it comes with an integrated shell. By using the shell,
you can test your code and interact with the output without having to run your code every time you
want to test something. To ensure that your code works as expected, you can type it right in the
terminal.
