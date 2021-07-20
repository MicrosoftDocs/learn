Build your first F# console application

## Create F# console application

1. Open the terminal
1. In the terminal, enter the following .NET CLI command

    ```dotnetcli
    dotnet new console -o MyFSharpApp -lang F#
    ```

The `dotnet new console` command uses .NET Templates to scaffold a new console application.

A directory *MyFSharpApp* appears containing the code for your F# application

## Project Structure

In the *MyFSharpApp* directory you'll find two files.

- **Program.fs** - The entrypoint for your application
- **MyFSharpApp.fsproj** - MSBuild project file that contains build information and instructions.

Open the *Program.fs* application.

The file contains the following code:

```fsharp
// Learn more about F# at http://docs.microsoft.com/dotnet/fsharp

open System

// Define a function to construct a message to print
let from whom =
    sprintf "from %s" whom

[<EntryPoint>]
let main argv =
    let message = from "F#" // Call the function
    printfn "Hello world %s" message
    0 // return an integer exit code
```

This application uses the `System` class library which is imported using the `open` keyword.

The `from` function uses the `whom` string parameter to create and format a string message.

The `main` function is the entry point of the application. It uses the `from` function to create the message "from F#" and binds the value to `message`. Then, using the `printfn` function, it prints out "Hello world from F#" to the console.

## Run your application

In the terminal, enter the following .NET CLI command from inside your *MyFSharpApp* directory

```dotnetcli
dotnet run
```

The console output looks like the following:

```console
Hello world from F#
```

Congratulations! You've built and run your first F# console application.