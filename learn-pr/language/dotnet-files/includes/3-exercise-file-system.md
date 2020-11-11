You can use .NET to find and return information about files and folders.

Tailwind Traders has many physical stores all over the world. Each night, these stores create a file called *sales.json* that contains the total for all their sales for the previous day. These files are organized in folders by store ID.

## Sign in to the sandbox

Activate the Microsoft Learn sandbox by selecting **Activate Sandbox** at the top of this page.

## Clone the project

In this exercise, you'll write a .NET program that can search for files called *sales.json* in a folder.

1. Run the following command to clone the example project for this module.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-dotnet-files && cd mslearn-dotnet-files
    ```

1. Create a new .NET Console project by entering the following commands in Azure Cloud Shell.

    ```bash
    dotnet new console -n files-module -o .
    ```

1. Open the Cloud Shell editor by entering the following command in Cloud Shell and selecting the <kbd>Enter</kbd> key.

    ```bash
    code .
    ```

1. Expand the *stores* folder and each of the numbered folders inside.

    :::image type="content" source="../media/folder-structure.png" alt-text="Screenshot that shows the project folder structure.":::

## Find the sales.json files

You need to find all the sales.json files in all folders.

### Include the System.IO namespace

1. Select the `Program.cs` file to open it in the editor.
1. Import the `System.IO` and `System.Collections.Generic` namespaces at the top of the file.

    ```csharp
    using System.IO;
    using System.Collections.Generic;
    ```

### Write a function to find the sales.json files

1. Create a new function called `FindFiles` that takes a `folderName` parameter.

    ```csharp
    static IEnumerable<string> FindFiles(string folderName)
    {
        List<string> salesFiles = new List<string>();

        var foundFiles = Directory.EnumerateFiles(folderName, "*", SearchOption.AllDirectories);

        foreach (var file in foundFiles)
        {
            // The file name will contain the full path, so only check the end of it
            if (file.EndsWith("sales.json"))
            {
                salesFiles.Add(file);
            }
        }

        return salesFiles;
    }
    ```

1. Call this new `FindFiles` function from the `Main` function. Pass in the *stores* folder name as the location to search for files.

    ```csharp
    static void Main(string[] args)
    {
        var salesFiles = FindFiles("stores");
    
        foreach (var file in salesFiles)
        {
            Console.WriteLine(file);
        }
    }
    ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.

## Run the program

1. Enter the following command into Cloud Shell to run the program.
    
    ```bash
    dotnet run
    ``` 

1. The program should show the following output.

    ```bash
    stores/sales.json
    stores/201/sales.json
    stores/202/sales.json
    stores/203/sales.json
    stores/204/sales.json
    ```

Excellent! You've successfully written a command-line program that will traverse any directory and find all the *sales.json* files inside.

You might have noticed the path to the *stores* directory was rather simple and within the working directory of the program.

In the next unit, you'll learn how to construct complex paths that work across operating systems by using the `Path` class.

### Got stuck?

If you got stuck at any point in this exercise, here's the completed code. Remove everything in `Program.cs` and replace it with this code:

```csharp
using System;
using System.IO;
using System.Collections.Generic;

namespace files_module
{
    class Program
    {
        static void Main(string[] args)
        {
            var files = FindFiles("stores");

            foreach (var file in files)
            {
                Console.WriteLine(file);
            }
        }

        static IEnumerable<string> FindFiles(string folderName)
        {
            List<string> salesFiles = new List<string>();
    
            var foundFiles = Directory.EnumerateFiles(folderName, "*", SearchOption.AllDirectories);
    
            foreach (var file in foundFiles)
            {
                if (file.EndsWith("sales.json"))
                {
                    salesFiles.Add(file);
                }
            }
    
            return salesFiles;
        }
    }
}
```
