We previously said that source code must be compiled before it can run. In this unit, you'll work on understanding compilation a little better. You'll also learn how Python's compilation and execution differ from that of other traditional programming languages and execution models.

## What is compilation?

After you finish writing your source code, you often use a special program called a _compiler_. This program converts source code into a format that a computer's CPU can run.

Why do you need to compile your source code? Most programming languages seem cryptic at first. But a programming language is actually intended to bridge a gap between humans and computers.  Humans speak using a human language, but a computer needs instructions that can be converted into a binary language that it processes by turning on and off thousands of tiny switches. Compilers bridge these two worlds by translating instructions readable by humans into instructions understood by computers.

Those instructions are collected and compacted together into a single file, which can be run by a user.

With many programming languages, each time you change the source code, you must recompile the app to create an executable file. However, each time a user wants to run a program, that user merely opens the compiled executable file. No additional compilation is necessary.

You often must use a compiler for your specific computing platform. For example, to run your program on a Windows computer, you must compile using a Windows compiler. To run your program on a macOS computer, you must compile using a macOS compiler.

## How does Python work?

Python has features similar to many programming languages, but it functions differently in a few key ways.

Python has a compiler. But the compiler doesn't translate the source code directly into a format that computers can understand. Instead, the compiler produces code in a special format that a Python interpreter can interpret and run.

An _interpreter_ is a program that runs each instruction. It tracks where it stores values in RAM. An interpreter also knows how to interact with external resources like a file system or a network.

In other words, an interpreter is an execution environment that manages complex interactions between your intent and the computer's inner workings.

Furthermore, each time you run your program, its Python source code is recompiled.

There are several benefits to this approach.

First, a Python interpreter is available for many computer platforms. For example, if you write Python code on Linux, it will also run on macOS and Windows. You can run a program without needing to compile your source code for a specific computing platform.

Second, you can write and execute one line of Python at a time. As you learn, you might want to experiment with a new idea without having to create a new project or file. Instead, you merely run Python in interactive mode and begin entering Python code in a terminal or command line. This code is lost when you exit Python's interactive mode. But for a quick experiment, it works well.

Finally, you can use a special software tool called a _debugger_ to:

- Edit your program as it's running.
- Pause the execution of your program.
- Step through each line of Python code to watch as it runs.
- Observe changes your code makes to values stored in RAM.

You can edit the code that will be run next during program execution. Such edits usually can't be done with programming languages that aren't interpreted. This editing is just another reason why Python is considered to be friendly to beginners.
