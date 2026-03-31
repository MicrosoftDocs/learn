Storing data locally involves managing files and directories on the local file system. This includes creating, deleting, moving, reading, writing, copying, and manipulating files and directories. The .NET framework provides a rich set of classes in the `System.IO` namespace to facilitate these operations. The `Directory`, `File`, and `Path` classes are essential for performing file and directory operations in .NET applications. Understanding how to use these classes is crucial for managing local data storage in your applications.

## Examine the Path class

The `Path` class in .NET is used for manipulating file and directory paths. It provides methods to retrieve and modify path information.

Here are some of the most commonly used methods in the `Path` class:

- `Combine`: The `Combine` method is used to combine multiple strings into a single path.
- `GetDirectoryName`: The `GetDirectoryName` method is used to get the directory information from a path.
- `GetFileName`: The `GetFileName` method is used to get the file name and extension from a path.
- `GetFileNameWithoutExtension`: The `GetFileNameWithoutExtension` method is used to get the file name without the extension.
- `GetExtension`: The `GetExtension` method is used to get the extension of a file.
- `GetFullPath`: The `GetFullPath` method is used to get the fully qualified path of a file.
- `GetTempPath`: The `GetTempPath` method is used to get the path of the current system's temporary folder.
- `GetTempFileName`: The `GetTempFileName` method is used to create a temporary file and return its path.

Here's an example of how to use the `Path` class to combine paths and get file information:

```csharp
using System;
using System.IO;
class Program
{
    static void Main()
    {
        string directoryPath = @"C:\ExampleDirectory";
        string fileName = "example.txt";

        // Combine directory and file name to create a full path
        string fullPath = Path.Combine(directoryPath, fileName);
        Console.WriteLine("Full Path: " + fullPath);

        // Get the file name without extension
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fullPath);
        Console.WriteLine("File Name Without Extension: " + fileNameWithoutExtension);

        // Get the file extension
        string fileExtension = Path.GetExtension(fullPath);
        Console.WriteLine("File Extension: " + fileExtension);
    }
}

```

> [!NOTE]
> The Path class methods are static and can be used without creating an instance of the class.

## Examine the Directory class

The `Directory` class in .NET provides methods for creating, deleting, moving, and enumerating directories. These methods are useful for managing directories in your applications.

Here are some of the most commonly used methods in the `Directory` class:

- `Exists`: The `Exists` method is used to check if a directory exists.
- `CreateDirectory`: The `CreateDirectory` method is used to create a new directory.
- `GetCurrentDirectory`: The `GetCurrentDirectory` method is used to get the current working directory.
- `GetFiles`: The `GetFiles` method is used to get an array of file names in a specified directory.
- `Delete`: The `Delete` method is used to delete an existing directory.
- `Move`: The `Move` method is used to move or rename a directory.
- `EnumerateDirectories`: The `EnumerateDirectories` method is used to list all directories within a specified path.
- `EnumerateFiles`: The `EnumerateFiles` method is used to list all files within a specified path.
- `GetDirectories`: The `GetDirectories` method is used to get an array of directory names in a specified directory.
- `GetParent`: The `GetParent` method is used to get the parent directory of a specified path.

The following example demonstrates how to use the `Directory` class to create a directory, check if it exists, and enumerate its files:

```csharp

using System;
using System.IO;

class Program
{
    static void Main()
    {
        string directoryPath = @"C:\ExampleDirectory";

        // Create a new directory
        Directory.CreateDirectory(directoryPath);

        // Check if the directory exists
        if (Directory.Exists(directoryPath))
        {
            Console.WriteLine("Directory exists.");

            // Enumerate files in the directory
            foreach (string file in Directory.EnumerateFiles(directoryPath))
            {
                Console.WriteLine(file);
            }
        }
        else
        {
            Console.WriteLine("Directory does not exist.");
        }
    }
}

```

> [!NOTE]
> When enumerating the files in a directory, you might encounter `UnauthorizedAccessException` errors. To handle these errors, first enumerate directories and then enumerate files.

## Examine the File class

The `File` class in .NET provides methods for performing various file operations such as reading, writing, copying, and deleting files.

Here are some of the most commonly used methods in the `File` class:

- `Exists`: The `Exists` method is used to check if a file exists.
- `Create`: The `Create` method is used to create a new file.
- `Delete`: The `Delete` method is used to delete a file.
- `Copy`: The `Copy` method is used to copy a file to a new location.
- `Move`: The `Move` method is used to move or rename a file.
- `ReadAllText`: The `ReadAllText` method is used to read all text from a file.
- `WriteAllText`: The `WriteAllText` method is used to write text to a file.
- `AppendText`: The `AppendText` method is used to append text to a file.
- `ReadAllLines`: The `ReadAllLines` method is used to read all lines from a file into a string array.
- `WriteAllLines`: The `WriteAllLines` method is used to write an array of strings to a file.
- `ReadAllBytes`: The `ReadAllBytes` method is used to read all bytes from a file into a byte array.
- `WriteAllBytes`: The `WriteAllBytes` method is used to write a byte array to a file.
- `Open`: The `Open` method is used to open a file for reading or writing.
- `OpenRead`: The `OpenRead` method is used to open a file for reading.
- `OpenWrite`: The `OpenWrite` method is used to open a file for writing.
- `OpenText`: The `OpenText` method is used to open a file for reading text.
- `GetAttributes`: The `GetAttributes` method is used to get the attributes of a file.
- `SetAttributes`: The `SetAttributes` method is used to set the attributes of a file.

The following example demonstrates how to use the `File` class to create a file, write text to it, and read the text back:

```csharp
using System;
using System.IO;
class Program
{
    static void Main()
    {
        string filePath = @"C:\ExampleFile.txt";

        // Create a new file and write text to it
        File.WriteAllText(filePath, "Hello, World!");

        // Read the text from the file
        string text = File.ReadAllText(filePath);
        Console.WriteLine(text);
    }
}

```

> [!NOTE]
> The `File` class also provides methods for checking if a file exists (`File.Exists`) and getting or setting file attributes (`File.GetAttributes`, `File.SetAttributes`).

## Combine the use of Directory, File, and Path classes

Applications often require a combination of file and directory operations. The `Directory`, `File`, and `Path` classes can be used together to perform complex file I/O operations.

The following example demonstrates how to create a directory, create a file within that directory, write text to the file, and read the text back:

```csharp
using System;
using System.IO;
class Program
{
    static void Main()
    {
        string directoryPath = @"C:\ExampleDirectory";
        string fileName = "example.txt";
        string filePath = Path.Combine(directoryPath, fileName);

        // Create a new directory
        Directory.CreateDirectory(directoryPath);

        // Create a new file and write text to it
        File.WriteAllText(filePath, "Hello, World!");

        // Read the text from the file
        string text = File.ReadAllText(filePath);
        Console.WriteLine(text);
    }
}

```

## Summary

In this unit, you learned how to manage local directories and files using the `Directory`, `File`, and `Path` classes in .NET. You explored the methods provided by these classes for creating, deleting, moving, reading, writing, and manipulating files and directories. Understanding these classes is essential for effective file I/O operations in your applications.
