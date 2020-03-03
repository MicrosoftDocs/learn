Previously, we said that the source code must be compiled in order to be executed.  In this unit, we'll work on understanding this process a little better and how Python's compilation and execution is different from other traditional programming languages and execution models.

## What is compilation?

In many programming languages, Once you finish writing your source code, you use a special program called a **compiler** to convert your source code into a different format that is executable by the computer's CPU.

Why is it necessary to compile your source code?  Even though most programming languages seem cryptic at first, they can be more easily understood by humans than the computer's preferred form of communication, which is expressed by turning thousands of tiny switches either on or off. Compilers bridge these two worlds by translating your human-readable instructions into a computer-understandable set of instructions.

Those instructions are collected and compacted together into a single file, which can be executed when invoked by a user.  

In many programming languages, each time a programmer makes a change to the source code, they must recompile the application to create an executable file.  However, each time a user wants to run the program, they merely need to launch the compiled executable file.  No additional compilation is necessary.

Finally, in many programming languages, you use a compiler for the specific computing platform you want your code to run on.  In other words, to run your program on a Windows computer, you must compile your source code using a Windows compiler for your particular programming language.  To run your program on a macOS computer, you must compile your source code using a macOS compiler for your particular programming language.

## How does Python work?

Python has similar features to many programming languages, but it functions differently in a few key ways.

Python has a compiler, but the Python compiler does not translate the code directly into a computer understandable format.  Instead, it compiles the code into a special format that can then be interpreted and executed by the Python **interpreter**.  The interpreter is a program that executes each instruction, tracking where it stores values in memory, knowing how to interface with external resources like the file system and the network, and so on.  In other words, it is an execution environment that takes care of complex interactions between your intent and the computer's inner workings.

Furthermore, each time you want to execute your program, the Python source code is recompiled.

There are several benefits to this approach.

First, a version of the Python interpreter is available on many computer platforms.  So, if you write Python code on Linux, it will run on macOS and Windows, and vice versa.  You would not need to compile your source code to target a specific computing platform to execute your program.

Second, you can write and execute a single line of Python at a time.  So, as you're learning, you may want to experiment with a new idea without going through the process of creating a new project, a new file, and so on.  You merely run Python in _interactive mode_ and begin typing Python code at a terminal or command prompt.  This code will be lost when you exit Python's _interactive mode_, but for a quick experiment, it works well.

Furthermore, you can edit a program as it's running.  Using a special software tool called a **debugger**, you can pause the execution of your program, step through each line of Python code and watch as it executes, observe changes your code makes to values stored in memory, and more.  You can also edit code that will be executed next as the program is running, which is usually something that can't be done using other programming languages that are not interpreted.  It's just another reason why Python is considered to be beginner-friendly.