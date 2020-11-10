.NET has a built-in mechanism for working with file system paths.

In the previous exercise, we didn't have many folders to find and look through. If you have many files or folders, manually building paths can get tedious. .NET provides some built-in constants and utility functions to make file paths easier.

Here, you'll learn about some of the constants and utility functions in the `System.IO` namespace and the `System.Environment` type so that you can make the program smarter and more resilient.

## Determine the current directory

Sometimes, you don't know the directory where your program will run. You need it to just use the path of the current directory. .NET exposes the full path to the current directory via the `Directory.GetCurrentDirectory` method.

```csharp
Console.WriteLine(Directory.GetCurrentDirectory());
```

If you run that code from the *sales* folder in the following folder structure, `Directory.GetCurrentDirectory()` will return `stores/201/sales`.

```
📂 stores
    📂 201
        📂 sales
```

## Work with special directories

.NET runs everywhere. It runs on Windows, macOS, Linux, and even on mobile operating systems like iOS and Android. Each of those operating systems might or might not have the concept of special system folders like a home directory that's dedicated for user-specific files, or a desktop directory, or a directory to store temporary files in.

Those directories are different on each operating system. It would be cumbersome to remember each operating system's directory structure and perform switches based on the current OS.

The `System.Environment.SpecialFolder` enumeration specifies constants to retrieve paths to special system folders.

The following code returns the current operating system's path to the equivalent of the Windows *My Documents* folder or the user's *HOME* directory if the code is running on Linux.

```csharp
string docPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
```

## Work with paths

Paths are a subject that comes up so frequently that .NET includes a class called `Path` specifically for working with paths.

The `Path` class is located in the `System.IO` namespace shipped with .NET and doesn't need to be installed.

### Special path characters

Different operating systems use different characters to separate directory levels.

For example, Windows uses the backslash `stores\201`, and macOS uses the forward slash `stores/201`.

To help you use the correct character, the `Path` class contains the `DirectorySeparatorChar` field.

.NET automatically interprets that field into the separator character that's specific to each operating system when you need to build a path manually.

```csharp
Console.WriteLine($"stores{Path.DirectorySeparatorChar}201");

// returns:
// stores\201 on Windows
//
// stores/201 on macOS
```

### Join paths

The `Path` class works with the concept of file and folder paths, which are just strings. You can use the `Path` class to build correct paths to specific operating systems for you.

For instance, if you want to get the path to the *stores/201* folder, you can use the `Path.Combine` function to do that.

```csharp
Console.WriteLine(Path.Combine("stores","201")); // outputs: stores/201
```

Remember, the reason why you would use the `Path.Combine` or `Path.DirectorySeparatorChar` class instead of hard-coding strings is that your program might be running on many different operating systems. The `Path` class will always format the paths correctly for whatever operating system it's running on.

> [!TIP]
> The `Path` class doesn't care whether or not things actually exist. Paths are conceptual, not physical. It's just building and parsing strings for you.

### Determine file name extensions

The `Path` class can also tell you what the extension of a file name is. If you have a file and you want to identify if it's a JSON file or not, you can use the `Path.GetExtension` function.

```csharp
Console.WriteLine(Path.GetExtension("sales.json")); // outputs: .json
```

### Get everything you need to know about a file or path

The `Path` class contains many different methods that do various things. You can get the most information about a directory or a file by using the `DirectoryInfo` or `FileInfo` classes, respectively.

```csharp
string fileName = $"stores{Path.DirectorySeparatorChar}201{Path.DirectorySeparatorChar}sales{Path.DirectorySeparatorChar}sales.json";

FileInfo info = new FileInfo(fileName);

Console.WriteLine($"Full Name: {info.FullName}{Environment.NewLine}Directory: {info.Directory}{Environment.NewLine}Extension: {info.Extension}{Environment.NewLine}Create Date: {info.CreationTime}"); // And many more
```

There are many more useful properties and utility methods on the `Path`, `DirectoryInfo`, and `FileInfo` classes. But these concepts are the core ones that you'll likely use most often. In the next exercise, you'll compose paths and identify .json files.
