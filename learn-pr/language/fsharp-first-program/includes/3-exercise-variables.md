In this exercise you will be creating programs that outputs code to the console. You will build the start of a calculator program. Additionally you will also analyze a program that has errors in it and learn to fix the error.

## Create a project

Lets start by creating a project. You create a project from the command line using the `dotnet` executable.

1. Run the command `dotnet new` in the console:

   ```bash
   dotnet new console --language F# -o Variables
   cd Variables
   ```

   This command will create a new F# project in the directory _Variables_

1. Locate the `main` method in _Program.fs_ and add the following code:

   ```fsharp
   printfn "Welcome to the calculator progran"
   // read input from the console and assign to `sum`
   let sum = 0
   printfn "The sum is %i" sum
   ```

   The first line welcomes the user of the program. On the second line, there's a comment starting with "//" that shows code that we will implement in the next exercise unit. Then you have `let sum = 0`, you create a `sum` variable that will hold the calculation result.

1. Run the program by running `dotnet run`:

   ```bash
   dotnet run
   ```

   You should the following output:


   ```output
   Welcome to the calculator program
   The sum is 0
   ```  

Congratulations, you managed to scaffold a project, start on a larger project and get it to run.

## Correct the fault

Part of learning to program in any language is learning to recognize compilation errors and how to fix them. For this exercise, you will scaffold a new project. Make sure you are one level up in the directory structure, before proceeding.

1. Scaffold a new F# project by running `dotnet new`:

   ```bash
   dotnet new console --language F# -o Errors
   cd Errors
   ``` 

1. Make sure the `main` method has the following code:

   ```bash
   [<EntryPoint>]
   let main argv =
       let aNumber = 0
       printfn "Here's a number %s" aNumber
       0 // return an integer exit code
   ``` 

   > [!TIP]
   > Pause for a second, read the code above, do you think the code will compile, why or why not?

1. Run the project by running `dotnet run`:

   ```bash
   dotnet run
   ```

   You will get an error message resembling this text:

   ```output
   /<path>/Errors/Program.fs(8,34): error FS0001: This expression was expected to have type    'string'    but here has type    'int' [/<path>/Errors/Errors.fsproj]

   The build failed. Fix the build errors and run again.
   ```

   The error message is saying "expected string but here was type int". Do you understand what the problem is? The problem is the use of the formatter `%s` instead of `%i` as you are giving the `printfn()` function the variable `aNumber` that's of type `int`. Lets correct the code

1. Locate the row with the code "printfn "Here's a number %s" aNumber" and change it to:

   ```fsharp
   printfn "Here's a number %i" aNumber
   ```

   Save the file and run it again with `dotnet run`. You should now see the following output:

   ```output
   Here's a number 0
   ```

Congratulations you've managed to debug a program by reading the code, understand what was wrong and fix it. Being able to recognize error messages and correct them is an essential skill to have as a developer.

