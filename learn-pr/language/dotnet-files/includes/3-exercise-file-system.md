You can use .NET to find and return information about files and folders.

Tailwind Traders has many physical stores all over the world. Each night, these stores create a file called *sales.json* that contains the total for all their sales for the previous day. These files are organized in folders by store ID.

In this exercise, you'll write a .NET program that can search for files called *sales.json* in a folder.

## Sign into the sandbox

Activate the Microsoft Learn sandbox by selecting the **Activate Sandbox** at the top of this page.

## Clone the project

1. Run the following command to clone the example project for this module:

    ```bash
    git clone https://github.com/codemillmatt/dotnet-files && cd dotnet-files
    ```

1. Create a new .NET Console project by typing the following commands in Cloud Shell.

    ```bash
    dotnet new console -n files-module -o .
    ```

1. Open the Cloud Shell editor by typing the following command in Cloud Shell and selecting the Enter key.

    ```bash
    code .
    ```

1. Expand the *stores* folder and each of the numbered folders inside.

    :::image type="content" source="../media/folder-structure.png" alt-text="Screenshot that shows the project folder structure.":::

## Find the sales.json files

You need to find all the sales.json files in all folders.

### Include the System.IO namespace

1. Select the `Program.cs` file to open it in the editor.
1. Import the `System.IO` namespace at the top of the file.

    ```csharp
    using System.IO;
    ```

1. Add the `System.Collections.Generic` namespace as well.

    ```csharp
    using System.Collections.Generic;
    ```

### Write a function to find the sales.json files

1. Create a new function called `FindFiles` that takes a `folderName` parameter.

    ```csharp
    static IEnumerable<string> FindFiles(string folderName)
    {
        List<string> salesFiles = new List<string>();

        var foundFiles = Directory.EnumerateFiles(folderName, "*", SearchOptions.AllDirectories);

        foreach (var file in foundFiles)
        {
            if (file == "sales.json")
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

You may have noticed the path to the *stores* directory was rather simple and within the working directory of the program.

In the next section, you'll learn how to construct complex paths that work across operating systems using the `Path` class.

### Got stuck?

If you got stuck at any point in this exercise, here's the completed code. Remove everything in `Program.cs` and replace it with this:

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
    
            var foundFiles = Directory.EnumerateFiles(folderName, "*", SearchOptions.AllDirectories);
    
            foreach (var file in foundFiles)
            {
                if (file == "sales.json")
                {
                    salesFiles.Add(file);
                }
            }
    
            return salesFiles;
        }
    }
}
```
