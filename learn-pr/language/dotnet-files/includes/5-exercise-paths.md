The .NET `Path` class and `Directory.GetCurrentDirectory` are two ways to define and compose file system paths.

In the previous exercise, you wrote a program that iterates through a folder to find any of the *sales.json* files inside.

In this exercise, you'll use the `Path` class and `Directory.GetCurrentDirectory` to improve the program so that it will find any file with a .json or .txt extension.

## Use the current directory and combine paths

In the current Program.cs code, you're passing the static location of the *stores* folder. We'll change that code to use the `Directory.GetCurrentDirectory` value instead of passing a static folder name.

1. In the `Main` method, create a variable to store a path to the current directory by using the `Directory.GetCurrentDirectory` method.

    ```csharp
    static void Main(string[] args)
    {
      var currentDirectory = Directory.GetCurrentDirectory();
      
      var salesFiles = FindFiles("stores");
    
      foreach (var file in salesFiles)
      {
        Console.WriteLine(file);
      }
    }
    ```

1. Still in the `Main` method, create another variable to store the full path to the *stores* directory by using the `Path.Combine` method. Pass that new variable to the `FindFiles` function.

    ```csharp
    static void Main(string[] args)
    {
        var currentDirectory = Directory.GetCurrentDirectory();
        
        var storesDirectory = Path.Combine(currentDirectory, "stores");
        
        var salesFiles = FindFiles(storesDirectory);
        
        foreach (var file in salesFiles)
        {
            Console.WriteLine(file);
        }
    }
    ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.
1. Run the program from the command line.

    ```bash
    dotnet run
    ```

  Notice that the path that's now listed for the files is the full system path. This path appears because the `Directory.GetCurrentDirectory` method returns the full path to the current location.

```bash
/home/username/dotnet-files/stores/sales.json  
/home/username/dotnet-files/stores/201/sales.json  
/home/username/dotnet-files/stores/202/sales.json  
/home/username/dotnet-files/stores/203/sales.json  
/home/username/dotnet-files/stores/204/sales.json  
```

## Find all .json files

Instead of looking for only *sales.json* files, the program needs to search for any file with an extension of .json. To do that, use the `Path.GetExtension` method to check the file name extension.

1. In the `foreach` loop in `FindFiles`, get the extension of each file by using the `Path.GetExtension` method.

    ```csharp
    foreach (var file in foundFiles)
    {
        var extension = Path.GetExtension(file);
        
        if (file.EndsWith("sales.json"))
        {
            salesFiles.Add(file);
        }
    }
    ```

1. Then change the `if` statement to check whether the file's extension is .json.

    ```csharp
    foreach (var file in foundFiles)
    {
        var extension = Path.GetExtension(file);
        
        if (extension == ".json")
        {
            salesFiles.Add(file);
        }
    }
    ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.
1. Run the program from the command line.

    ```bash
    dotnet run
    ```
  
  The output now shows all .json and .txt files in any of the store ID directories.

    ```bash
    /home/username/dotnet-files/stores/sales.json  
    /home/username/dotnet-files/stores/201/sales.json
    /home/username/dotnet-files/stores/201/salestotals.json  
    /home/username/dotnet-files/stores/202/sales.json
    /home/username/dotnet-files/stores/202/salestotals.json    
    /home/username/dotnet-files/stores/203/sales.json  
    /home/username/dotnet-files/stores/203/salestotals.json  
    /home/username/dotnet-files/stores/204/sales.json  
    /home/username/dotnet-files/stores/204/salestotals.json  
    ```

Great job! You've used the `Path` class and the `Directory.GetCurrentDirectory` method to make the program much more robust. In the next unit, you'll learn how to create directories and move files between locations.

### Got stuck?

If you got stuck at any point in this exercise, here's the completed code. Remove everything in *Program.cs*, and replace it with this solution.

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
            var currentDirectory = Directory.GetCurrentDirectory();
            var storesDirectory = Path.Combine(currentDirectory, "stores");

            var salesFiles = FindFiles(storesDirectory);

            foreach (var file in salesFiles)
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
                var extension = Path.GetExtension(file);

                if (extension == ".json")
                    salesFiles.Add(file);
            }

            return salesFiles;
        }
    }
}
```