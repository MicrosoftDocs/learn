In this exercise, continue working on the calculator program that you created in the first exercise. Take all that hard-earned knowledge and implement the remaining functionality like user input and apply an arithmetic operator.

## Read from the console

In this part, you add support for reading from the console.

1. Go to the directory _Variables_, and open the `Program.fs` file.
1. Locate the following code:

   ```fsharp
   printfn "Welcome to the calculator program"
   // read input from the console and assign to `sum`
   let sum = 0
   printfn "The sum is %i" sum
   ```

1. Replace the commented line with the following code:

   ```fsharp
   printfn "Type the first number"
   let firstNo = System.Console.ReadLine()
   printfn "Type the second number"
   let secondNo = System.Console.ReadLine()
   printfn "First %s, Second %s" firstNo secondNo
   ```

   Save the file and run the program next.

1. Run the command `dotnet run`.

   ```bash
   dotnet run
   ```

1. Fill in **1** and **2** when asked for input.

   Your output looks similar to:

   ```output
   Welcome to the calculator program
   Type the first number
   1
   Type the second number
   2
   First 1, Second 2
   The sum is 0
   ```

   At this point, you're supporting user input, but you need the program to actually calculate, so let's do that next.

## Perform a calculation

To add the calculation part of the program, convert the user input to numbers and apply an arithmetic operator.

1. Locate the row that looks like so:

   ```fsharp
   let sum = 0
   ```

   Change it to the following code:

   ```fsharp
   let sum = (int firstNo) + (int secondNo)
   ```

   Save your changes and rerun the program.

1. Run the command `dotnet run`.

   ```bash
   dotnet run
   ```

1. Enter **1** and **2** when asked for input.

   You see output similar to:

   ```output
   Welcome to the calculator program
   Type the first number
   1
   Type the second number
   2
   First 1, Second 2
   The sum is 3
   ```

Congratulations! Your calculator program works as it should.
