Sometimes you don't want to go through the process of creating, packaging, and distributing an application. F# Interactive is an interactive programming and scripting environment. It makes it simple to go from idea to code by letting you write and evaluate code in real time through the console or standalone script files.

## Starting F# Interactive

F# Interactive is built into the .NET SDK. You can start it with the .NET CLI `dotnet fsi` command.

```dotnetcli
dotnet fsi
```

## Read-Evaluate-Print-Loop (REPL)

Starting F# Interactive launches you into a read-evaluate-print-loop (REPL) session where you can write your F# code and immediately evaluate its output in the console.

```fsharp
Microsoft (R) F# Interactive version 11.4.2.0 for F# 5.0 
Copyright (c) Microsoft Corporation. All Rights Reserved.

For help type #help;;

>
```

## Run and evaluate expressions

To evaluate your input, you must enter it after the `>` character.

```fsharp
> #help;;
```

For example, if you run the `#help` command, the output shows the F# Interactive help menu.

```console
F# Interactive directives:

    #r "file.dll";;                               // Reference (dynamically load) the given DLL
    #i "package source uri";;                     // Include package source uri when searching for packages
    #I "path";;                                   // Add the given search path for referenced DLLs
    #load "file.fs" ...;;                         // Load the given file(s) as if compiled and referenced
    #time ["on"|"off"];;                          // Toggle timing on/off
    #help;;                                       // Display help
    #r "nuget:FSharp.Data, 3.1.2";;               // Load Nuget Package 'FSharp.Data' version '3.1.2'
    #r "nuget:FSharp.Data";;                      // Load Nuget Package 'FSharp.Data' with the highest version
    #quit;;                                       // Exit
    
F# Interactive command line options:

    See 'dotnet fsi --help' for options
```

The end of an expression is delimited by the `;;` characters. No code is evaluated until you input the `;;` characters. This structure is useful when writing multi-line expressions since your code isn't delimited by new line characters.

Evaluating F# code works the same way. The following code prints a message to the console.

```fsharp
> printfn "Hello World!";;
```

The evaluated output is:

```console
Hello World!
val it : unit = ()
```

The first line displays the output from the evaluated code while the second line displays output's type information. In this case, the value output to the console is of type `unit`, which is represented by the `()` token and bound to the `it` name. You can access the `it` value later on in your program if you want to perform more operations.

## Exiting the REPL

After you use the F# Interactive REPL, use the `#q` or `#quit` commands to exit.

```fsharp
> #q;;
```

## fsx script files

As you write more code, you can save your code in a script with the *fsx* file extension.

If you use the same example of printing a message to the console, you can create a file called *my-script.fsx* to write your code in.

```fsharp
printfn "Hello World!"
```

One thing to note though is that in *fsx* files, you don't need to use `;;` at the end of your expressions. You don't need it because in script files, F# Interactive is able to use standard F# code formatting guidelines like indentation and new lines.

Instead of compiling source code and then later running the compiled assembly, you can just run `dotnet fsi` and specify the name of your script file containing your F# code, and F# interactive reads the code and executes it in real time.

```dotnetcli
dotnet fsi my-script.fsx
```

Running this script produces the following output.

```console
Hello World!
```
