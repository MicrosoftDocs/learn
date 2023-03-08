

Every developer has to deal with code bugs, it's just a way of life for developers. Sometimes you can spot your bugs quickly. After all, you wrote the code, and besides, it feels pretty good to find and fix an issue quickly. Inevitably though, there will times when you find yourself searching for a bug that isn't quite so easy to spot.

## Code debugging process

When you notice a bug in your code, it can be tempting to try a direct approach. You know, that quick scan where you think the issue might be. If it pays off in the first 30 seconds, great, but don't let yourself be sucked in. Don't keep going to that next spot, and the next. Don't let yourself throw time against the following approaches:

- Reading through your code (just one more time) hoping that this time the issue will jump out at you.
- Breadcrumbing a few `Console.WriteLine("here")` messages in your code to the track progress through your app.
- Re-running your app with different data to see if something that does work will help you understand what doesn't.

You might have experienced various degrees of success with these methods, but don't be fooled. There is a better way.

The one approach that's commonly regarded as being the most successful is using a debugger. But what's a debugger exactly?

A debugger is a software tool used to observe and control the execution flow of your program with an analytical approach. Its design goal is to help find the root cause of a bug and help you resolve it. It works by either hosting your program in its own execution process or running as a separate process that's attached to your running program, like .NET.

Debuggers come in different flavors. Some work directly from the command line while others come with a graphical user interface. In this module, you'll use the integrated graphical debugger of Visual Studio Code.

## Why use a debugger

If you're not running your code through a debugger, that means you're probably guessing what's happening in your application at runtime. The primary benefit of using a debugger is that you can watch your program running. You can follow program execution one line of code at a time. This minimizes the chance of guessing wrong.

Visual Studio Code supports code debuggers that enable you to watch your code as it runs. The following image shows a running application, with execution paused on the line of code that's highlighted. The right side of the screen shows the program code, while the left side shows the current state of variables.

![Screenshot showing the Visual Studio Code debugger tools.](../media/visual-studio-code-debugger-runtime.png)

Every debugger has its own set of features. The two most important features that come with almost all debuggers are:

- Control of your program execution. You can pause your program and run it step by step, which allows you to see which code is executed and how it affects your program's state.

- Observation of your program's state. For example, you can look at the value of your variables and function parameters at any point during your code execution.

Mastering the use of a code debugger usage is an important skill. Unfortunately, it's a skill that developers often overlook. Effective use of a debugger helps you to be more efficient at hunting bugs in your code. Debuggers can also help you to understand how a program works.
