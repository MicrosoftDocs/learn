In this exercise, we'll write our first line of F# code which prints out **Hello World** to the console. 

## Start F# Interactive

1. Open a command prompt
1. Enter the following .NET CLI command into the command prompt

```dotnetcli
dotnet fsi
``` 

When the F# Interactive terminal opens, you should see something like the following:

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

`printfn` is a function which takes a value as input and prints out its string representation out to the console. In this case, the value is the string **Hello World!**.

`;;` represents the end of an expression.

The code is evaluated and output similar to the following is displayed on the console:

```fsharp
Hello World!
val it : unit = ()
```

Congratulations! You've written your first line of F# code!

## (Optional) Write a script

1. Create a file called *script.fsx* and open it in a text editor.
1. Add the following code to the *script.fsx* file.

```fsharp
printfn "Hello World!"
```

Note that because this is inside a script file, there's no need to include `;;`

1. Run the script `dotnet fsi script.fsx`.

The script is evaluated and output similar to that from the REPL should appear on the console.