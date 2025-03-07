In this exercise, you learn how to create programs that output code to the console. You build the start of a calculator program, and you also analyze a program that has errors in it and learn how to fix the errors.

## Create a project

Let's start by creating a project. You create a project from the command line by using the `dotnet` executable.

1. Run the command `dotnet new` in the console.

   ```bash
   dotnet new console --language F# -o Variables
   cd Variables
   ```

   This command creates a new F# project in the directory *Variables*.

1. Replace the code in *Program.fs* with the following code:

   ```fsharp
   [<EntryPoint>]
   let main argv =
       printfn "Welcome to the calculator program"
       // read input from the console and assign to `sum`
       let sum = 0
       printfn "The sum is %i" sum
       0
   ```

   The first `printfn` statement welcomes the user of the program. On the second line, there's a comment that starts with `//` showing code that you'll implement in the next exercise unit. Then you have `let sum = 0`. Finally, you create a `sum` variable that holds the calculation result.

1. Run the program by running `dotnet run`.

   ```bash
   dotnet run
   ```

   You should see the following output:

   ```output
   Welcome to the calculator program
   The sum is 0
   ```  

Congratulations! You managed to scaffold a project, start on a larger project, and get it to run.

## Correct the fault

Part of learning to program in any language is learning how to recognize compilation errors and fix them. For this exercise, you must scaffold a new project. Make sure you're one level up in the directory structure before you continue.

1. Scaffold a new F# project by running `dotnet new`.

   ```bash
   dotnet new console --language F# -o Errors
   cd Errors
   ```

1. Replace the code in *Program.fs* with the following code:

   ```bash
   [<EntryPoint>]
   let main argv =
       let aNumber = 0
       printfn "Here's a number %s" aNumber
       0 // return an integer exit code
   ```

   > [!TIP]
   > Pause for a second, and read the preceding code. Do you think the code will compile? Why or why not?

1. Run the project by running `dotnet run`.

   ```bash
   dotnet run
   ```

   An error message displays that's similar to this text:

   ```output
   /<path>/Errors/Program.fs(8,34): error FS0001: This expression was expected to have type    'string'    but here has type    'int' [/<path>/Errors/Errors.fsproj]

   The build failed. Fix the build errors and run again.
   ```

   The error message is saying "expected string but here was type int." Do you understand what the problem is? The problem is the use of the formatter `%s` instead of `%i` because you're giving the `printfn` function the variable `aNumber` that's of type `int`. Let's correct the code.

1. Locate the row with the code "printfn "Here's a number %s" aNumber" and change it to:

   ```fsharp
   printfn "Here's a number %i" aNumber
   ```

   Save the file, and run it again with `dotnet run`. You should now see the following output:

   ```output
   Here's a number 0
   ```

Congratulations! You debugged a program by reading the code, understanding what was wrong, and fixing it. Recognizing error messages and knowing how to correct the errors are essential skills to have as a developer.
