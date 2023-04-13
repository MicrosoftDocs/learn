In this exercise, we write our first line of F# code, which prints the message **Hello World** to the console.

## Start F# Interactive

1. Open a command prompt
1. Enter the following .NET CLI command into the command prompt

    ```dotnetcli
    dotnet fsi
    ```

    When the F# Interactive terminal opens, you should see something similar to the following output:

    ```dotnetcli
    Microsoft (R) F# Interactive version 11.0.0.0 for F# 5.0
    Copyright (c) Microsoft Corporation. All Rights Reserved.
    
    For help type #help;;
    
    >
    ```

## Write your first line of code

Add the following line of code next to the `>` character in the F# Interactive terminal

```fsharp
printfn "Hello World!";;
```

The code is evaluated and similar output displays on the console:

```fsharp
Hello World!
val it : unit = ()
```

Congratulations! You've written your first line of F# code!

## (Optional) Write a script

1. Create a file called *hello-world.fsx* and open it in Visual Studio Code.
1. Add the following code to the *hello-world.fsx* file.

    ```fsharp
    printfn "Hello World!"
    ```

1. Run the script using the `dotnet fsi` command.

    ```dotnetcli
    dotnet fsi hello-world.fsx
    ```

    Running the script produces the following output:

    ```console
    Hello World!
    ```

Congratulations! You wrote your first script!