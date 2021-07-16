F# Interactive (FSI) is used to run F# code interactively at the console, or to execute F# scripts.

F# Interactive is built into the .NET SDK and can be run with the .NET CLI `dotnet fsi` command. Starting FSI launches you into a read-evaluate-print-loop (REPL) terminal session where you can write your F# code and immediately evaluate its output. 

As you write more code expected to run sequentially, you can save your code in a *fsx* script file. Instead of compiling source code and then later running the compiled assembly, you can just run dotnet fsi and specify the name of your script file containing your F# code, and F# interactive reads the code and executes it in real time.