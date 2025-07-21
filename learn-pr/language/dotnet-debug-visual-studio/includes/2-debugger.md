During your journey as a developer, there's always *that* moment when you end up asking yourself:

> Why isn't my code working?

Asking this question is a normal part of any developer's day. The trick is to get comfortable with finding and fixing your bugs with a minimum of time and frustration. When there's a bug in your program, do you deal with it in one of these ways?

- Run the program again because it *should* work.
- Explain your issue to a rubber duck.
- Read through your code again to find the issue.
- Take a walk outside.
- Spam a few `Console.WriteLine("here")` messages in your code.

You might have various degrees of success with these methods, but one approach is commonly regarded as being the most successful. Using a debugger. But what exactly is a debugger?

A debugger is a software tool you can use to observe and control the execution flow of your program with an analytical approach. Its design goal is to help you find the root cause of a bug and help you resolve it. It works by hosting your program in its own execution process. Or, by running as a separate process attached to your program, like .NET.

Debuggers come in different flavors. Some work directly from the command line while others come with a graphical user interface. In this module, we use Visual Studio's integrated graphical debugger.

## Why use a debugger?

If you're not running your code through a debugger, it means you're probably *guessing* what's happening in your program. The primary benefit of using a debugger is that you can *watch* your program running. You can follow your program execution one line of code at a time. In this way, you avoid the chance of guessing wrong.

Every debugger has its own set of features. The two most important ones that come with almost all of them are:

- *Controlling your program execution*. You can pause your program and run it step by step, which allows you to see which code is executing and how it affects your program's state.
- *Observing of your program's state*. For example, you can look at the value of your variables and function parameters at any point during your code execution.

Using a debugger effectively is an important but overlooked skill for a developer. It makes you more efficient at hunting bugs in your code and can help you quickly understand how a program works.

Let's discover that in the next unit.
