To understand how your code works, we need to talk about a few things. Like what a _program_ is, what
a _programming language_ is, and how it communicates commands to your computer.

## What is a program?

A program is a set of instructions that complete computing tasks. The instructions are compiled into
a format the computer can understand and then run by a _user_. A _user_ can be a person or another
program. The computer executes the instructions in order. One line at a time until there are no
more lines to execute or the program is explicitly told to stop.

Even the most basic programs do one or more of the following tasks:

- **Accepting Input** - Input includes information:
  - From a user typing on a keyboard or clicking on an interface
  - Retrieved from a file
  - Called from another program or network connection
- **Processing** - Processing includes:
  - Performing logic
  - Mathematical calculation
  - Manipulation of data input to produce new data
- **Output** - Output includes information:
  - Displayed on a screen to a user
  - Saved to a file
  - Sent to another program

A program can take different forms for different purposes. A program can be:

- A standalone application like a game, a text editor, billing software, and so on.
- A script like an advanced macro that executes inside another program to automate some
  functionality.
- A combination of live code, equations, and data visualizations.

Some programs, including ones you'll write, only need a few lines of code. But complex
programs like operating systems need tens of thousands, sometimes millions of lines of code.

## What is a programming language?

The job of a programming language is to enable a person to write instructions for a computer in a
human-readable and understandable way. Computers understand things in a very different way than what
we can easily understand. Programming languages give people a less complicated way of
interfacing with computers to give them instructions. The instructions you write in a programming
language is called "code".

There are many programming languages and they all have different syntax. However, once you learn
your first programming language, many of the concepts you learn can be carried into other languages
making them easier to learn.

## What is syntax?

Like any language, programming languages have their own grammatical rules to use the language
effectively called **syntax**. The syntax of a programming language includes **keywords**,
**operators**, and grammar rules that may be specific to each language.

**Keywords** are specific words reserved by the language that have special meaning and behavior. In
PowerShell, many of the keywords read like English. `if`, `while`, and `return` are some of the
keywords you see while programming in PowerShell and in many other languages.

**Operators** are special characters like parenthesis (`()`) or equal signs (`=`). These characters tell
the computer to perform specific mathematical, relational, or logical operations to produce a
result.

When you typed your code into the Cloud Shell terminal, you may have noticed small changes to the
color of text and symbols. This is called **syntax highlighting**. It's helpful in reading what your
code is doing and spotting mistakes in the syntax of your code. This feature is available and even
more robust in many code editors like Visual Studio Code.

## Compiling code in PowerShell

Computers aren't good at reading our programs in the way we write them. Programming languages need
to be translated into something the computer can understand. Different programming languages have a
few ways of doing this.

Many programming languages **compile** as an individual step. The user writes their code, run it
through a special program called a compiler, and the compiler produces an executable package to
run. Other languages like Python have what's called an interpreter that interpret the code for the
computer and execute the code one line at a time as it's interpreting it. PowerShell works a little
differently and a little similarly to both of these.

PowerShell is compiled into an **AST** (abstract syntax tree) first in memory and then run. You
don't need to do a deep dive here to use PowerShell. All you need to know is that the computer
checks your code first in the AST looking for major issues. Then, if everything is ok, your program
is run by the computer without the need for a a compiled executable program. This is useful as it
checks to make sure your code should run correctly before it tries to run in the computer itself
where it could make changes and stop halfway due to a syntax error. As opposed to an interpreted
language like Python that starts running the code until it finds something wrong in your syntax.

## Should I learn PowerShell first?

With so many programming languages out there, you might wonder if PowerShell is a good language to
learn programming. PowerShell is a great language to learn and very beginner-friendly. It's easily
readable and PowerShell handles much of the heavy lifting. This allows you to focus on learning
many of the core concepts of programming found in most languages including:

- Using basic programming logic.
- Creating program structure.
- Building expressions and statements.
- Working with data.
- Programmatic problem solving.

Many programming languages use the same elements and concepts to accomplish different goals.
Learning these concepts with a beginner friendly language is a great first step. Later, you can
learn other languages and focus on the parts that are different from PowerShell while already
understanding many of the core concepts.

Another of PowerShell's features that make it great for beginners is it's help system. The
PowerShell help system gives you easy access to information about PowerShell commands. You can look
up help for commands or PowerShell concepts using the `Get-Help` command. For example, If you want
to see all details about the `Write-Output` command, you can type and run the following command:

```powershell
Get-Help -Name 'Write-Output' -Full
```

`Get-Help` is the command to run and `Write-Output` is the **Name** of the command to get help
for. The `-Full` switch tells PowerShell to get all help information for the specified command
including a command description, parameter information, examples, and more. This is all
accessible in any PowerShell terminal including the Azure Cloud Shell terminal.

Another great thing about PowerShell is that it comes with an integrated shell. The shell allows you
to test your code and interact with the objects without having to run your code every time you want
to test something. If you want to see if something works, you can type it right into the terminal to
make sure your code works as expected.

PowerShell is also a useful tool in managing large-scale infrastructure. Since it's cross platform,
you can use it in most environments.

All of this together makes you PowerShell a great language to learn and very fun to use from the
start.
