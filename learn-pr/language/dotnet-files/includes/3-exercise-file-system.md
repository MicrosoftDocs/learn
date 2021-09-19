You can use .NET to find and return information about files and folders.

Tailwind Traders has many physical stores all over the world. Each night, these stores create a file called *sales.json* that contains the total for all their sales for the previous day. These files are organized in folders by store ID.

> [!NOTE]
> This module uses the [.NET CLI (Command Line Interface)](/dotnet/core/tools) and [Visual Studio Code](https://code.visualstudio.com/) for local development. After completing this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

## Clone the project

In this exercise, you'll write a .NET program that can search for files called *sales.json* in a folder.

A starter project has already been created and you'll clone it using the integrated terminal in Visual Studio Code.

1. Open Visual Studio Code.
1. Open the Terminal window by selecting the **Terminal** option from the **View** menu.
1. (Optional) Change to a directory you want to copy the files to, such as `c:\MyProjects`.
1. Run the following command to clone the example project for this module.

    > [!IMPORTANT]
    > Make sure you use the **Bash** shell in VS Code for this command.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-dotnet-files && cd mslearn-dotnet-files
    ```

1. Create a new .NET Console project by running the following commands in the terminal window.

    ```bash
    dotnet new console -n files-module -o .
    ```

1. Open the new .NET project in the same instance of Visual Studio Code by typing in the following command in the terminal window.

    ```bash
    code -a .
    ```

   > [!TIP]
   > At this point Visual Studio Code will prompt you to that required assets to build and run the project are missing. And it asks whether you want to install them.    Select **Yes**. These files allow Visual Studio Code to run the debug the project.

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

1. Press <kbd>Ctrl+S</kbd> / <kbd>Cmd+S</kbd> to save the file.

## Run the program

1. Run the following command into Visual Studio Code's terminal window to run the program.

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
