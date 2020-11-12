The `File` and `Directory` classes in .NET let you create new files and directories programmatically.

So far, you've created a robust command-line application in .NET that can read any folder structure to find files with a .json extension. You'll need to read those files to summarize the data in them. You'll then write the totals to a new file in a new directory called *salesTotals*.

In this exercise, you'll create the *salesTotalsDir* directory and *totals.txt* file where the sales totals will eventually go.

## Create the SalesTotals directory

1. In the `Main` function, remove the `foreach` loop that iterates and write to the *Console* output each file name returned from the `FindFiles` function.

1. In the `Main` function, create a variable called `salesTotalsDir`, which holds the path to the *salesTotals* directory.

    ```csharp
    static void Main(string[] args)
    {
        var currentDirectory = Directory.GetCurrentDirectory();
        var storesDirectory = Path.Combine(currentDirectory, "stores");
        
        var salesTotalDir = Path.Combine(currentDirectory, "salesTotalDir");
        
        var salesFiles = FindFiles(storesDirectory);
    }
    ```

1. In the `Main` function, add code to create the directory.

    ```csharp
    static void Main(string[] args)
    {
        var currentDirectory = Directory.GetCurrentDirectory();
        var storesDirectory = Path.Combine(currentDirectory, "stores");
        
        var salesTotalDir = Path.Combine(currentDirectory, "salesTotalDir");
        Directory.CreateDirectory(salesTotalDir);
        
        var files = FindFiles(storesDirectory);
    }
    ```

## Write the totals.txt file

1. In the `Main` function, add the code to create an empty file called *totals.txt* inside the newly created *salesTotalsDir* directory. Use an empty string for the file's contents for now.

    ```csharp
    static void Main(string[] args)
    {
        var currentDirectory = Directory.GetCurrentDirectory();
        var storesDirectory = Path.Combine(currentDirectory, "stores");
        
        var salesTotalDir = Path.Combine(currentDirectory, "salesTotalDir");
        Directory.CreateDirectory(salesTotalDir);
        
        var files = FindFiles(storesDirectory);
        
        File.WriteAllText(Path.Combine(salesTotalDir, "totals.txt"), String.Empty);
    }
    ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.
1. Run the program by entering the following code from the terminal prompt.

    ```bash
    dotnet run
    ```

1. Select the **Refresh** icon in the **Files** explorer.

    :::image type="content" source="../media/refresh-file-explorer.png" alt-text="Screenshot of the Refresh icon in the Files explorer of the Cloud Shell editor.":::

You're almost finished. The last step is to read the sales files, add up the totals, and write the grand total to the new *totals.txt* file. Next, you'll learn how to read and parse data inside files.

## Got stuck?

If you got stuck during this exercise, here's the full code up to this point.

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

            var salesTotalDir = Path.Combine(currentDirectory, "salesTotalDir");
            Directory.CreateDirectory(salesTotalDir);

            var files = FindFiles(storesDirectory);

            File.WriteAllText(Path.Combine(salesTotalDir, "totals.txt"), String.Empty);
        }

        static IEnumerable<string> FindFiles(string folderName)
        {
            List<string> salesFiles = new List<string>();

            var foundFiles = Directory.EnumerateFiles(folderName, "*", SearchOption.AllDirectories);

            foreach (var file in foundFiles)
            {
                var extension = Path.GetExtension(file);

                if (extension == ".json")
                {
                    salesFiles.Add(file);
                }
            }

            return salesFiles;
        }
    }
}
```