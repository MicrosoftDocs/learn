At this point, you've used the REPL and maybe even created an *fsx* script file. Now you're at the point where your application has grown so you need to include more files, and the ability to package and distribute your application. To do so, you need to create a project. The .NET SDK provides various project templates to help you get started building all types of applications.

## What are .NET Templates?

When you install the .NET SDK, you receive over a dozen built-in templates for creating projects and files, including:

- Console apps
- Class libraries
- Unit test projects
- ASP.NET Core web apps
- Configuration files

F# has support for various templates, everything from testing and web to class libraries. For a full list of supported projects, run `dotnet new -l` at the console.

## Create an application using templates

To create a new application, use the `dotnet new` .NET CLI command. For example, if you want to create an F# console application, you'd use the following command.

```fsharp
dotnet new console --language F# -o MyFSharpApp
```

Some shells interpret `#` as a special character. In that case, enclose the language in quotes as such `dotnet new console --language "F#" -o MyFSharpApp`.

The `dotnet new console` command uses the built-in console .NET template to scaffold a new console application.

After a few seconds, a directory called *MyFSharpApp* appears with the code for your F# application.

### Project Structure

There are two files in the *MyFSharpApp* directory:

- **Program.fs** - The entrypoint for your application.
- **MyFSharpApp.fsproj** - MSBuild project file that contains build information and instructions. MSBuild is a platform for building applications that provides an XML schema for a project file that controls how the build platform processes and builds software.

The *Program.fs* file contains the following code:

```fsharp
// Learn more about F# at https://learn.microsoft.com/dotnet/fsharp

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

This application uses the `System` class library, which is imported by using the `open` keyword.

The `from` function uses the `whom` string parameter to create and format a string message.

The `main` function is the entry point of the application. It uses the `from` function to create the message "from F#" and binds the value to `message`. Then, using the `printfn` function, it prints "Hello world from F#" to the console.

## Build an application

Now that you've created a console application, it's time to build it using the `dotnet build` command. The `dotnet build` command builds the project and its dependencies into a set of binaries. The binaries include the project's code in Intermediate Language (IL) files with a *.dll* extension. Depending on the project type and settings, other files might be included, such as:

- An executable that you can use to run the application, if the project type is an executable targeting .NET Core 3.0 or later.
- Symbol files used for debugging with a *.pdb* extension.
- A *.deps.json* file, which lists the dependencies of the application or library.
- A *.runtimeconfig.json* file, which specifies the shared runtime and its version for an application.
- Other libraries that the project depends on (via project references or NuGet package references).

Output files are written into the default location, which is *bin/\<configuration\>/\<target\>*. Debug is the default configuration, but you can override it using the `--configuration` option. The target refers to the target framework, which is specified in the `TargetFramework` property of the *fsproj* file. Target framework specifies the set of APIs that you'd like to make available to the app or library. For example if you have a .NET 5 application and you run `dotnet build`, the output is placed in *bin/Debug/net5.0*.

## Run your application

For applications that are executable, the `dotnet run` command provides a convenient option to run your application. The `dotnet run` command looks for the *.dll* or executable in your output directory and uses the `dotnet` driver to execute the code as defined in the application's entrypoint (*Program.fs*).

> [!TIP]
> When you use the `dotnet run` command, `dotnet build` is automatically run as well. Therefore, you're able to save yourself the step of explicitly building your application.
