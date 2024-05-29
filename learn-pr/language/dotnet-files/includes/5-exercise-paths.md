The .NET `Path` class and `Directory.GetCurrentDirectory` are two ways to define and compose file-system paths.

In the previous exercise, you wrote a program that iterates through a folder to find any of the *sales.json* files in it or any subfolders.

In this exercise, you use the `Path` class and `Directory.GetCurrentDirectory` to improve the program so it finds *any* file with a .json extension.

## Use the current directory and combine paths

In the current Program.cs code, you're passing the static location of the *stores* folder. Now, we change that code to use the `Directory.GetCurrentDirectory` value instead of passing a static folder name.

1. In the editor, insert the following code above the first line of `Program.cs` file. This code uses the `Directory.GetCurrentDirectory` method to obtain the path for the current directory and store it in a new variable `currentDirectory`:

    ```csharp
    var currentDirectory = Directory.GetCurrentDirectory();
    ```

1. Insert the following code after the one that you just added. This code uses the `Path.Combine` method to create the full path to the *stores* directory and store it in a new variable `storesDirectory`:

    ```csharp
    var storesDirectory = Path.Combine(currentDirectory, "stores");
    ```

1. Replace the string `stores` in the `FindFiles` function call with the new variable `storesDirectory`:

     ```csharp
     var salesFiles = FindFiles(storesDirectory);
     ```

    The top of your file should now look similar to the following snippet:

    ```csharp
    var currentDirectory = Directory.GetCurrentDirectory();
    var storesDirectory = Path.Combine(currentDirectory, "stores");
    var salesFiles = FindFiles(storesDirectory);
    
    foreach (var file in salesFiles)
    {
        Console.WriteLine(file);
    }
    ```

1. Press <kbd>Ctrl+S</kbd> (or <kbd>Cmd+S</kbd> macOS) to save the file.

1. Run the program from the command line:

    ```bash
    dotnet run
    ```

1. The program should show the following output:

    ```output
    /home/username/dotnet-files/stores/sales.json  
    /home/username/dotnet-files/stores/201/sales.json  
    /home/username/dotnet-files/stores/202/sales.json  
    /home/username/dotnet-files/stores/203/sales.json  
    /home/username/dotnet-files/stores/204/sales.json  
    ```

    Notice that the file names returned include the full system path. This path is included because `Directory.GetCurrentDirectory` method returns the full path to the current location.

## Find all .json files

Instead of looking for only *sales.json* files, the program needs to search for any file with a .json extension. To do that, you can use the `Path.GetExtension` method to check the extension for each file.

1. In the `foreach` loop that iterates through `foundFiles`, insert the following line of code above the `if` statement to define a new variable `extension`. This code uses the `Path.GetExtension` method to get the extension of each file.

    ```csharp
        var extension = Path.GetExtension(file);
    ```

1. Change the `if` statement to look like the following line of code. This statement checks whether the file's extension is equal to .json.

    ```csharp
           if (extension == ".json")
    ```

    The `foreach` loop should look similar to the following code:
  
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

1. Press <kbd>Ctrl+S</kbd> / <kbd>Cmd+S</kbd> to save the file.

1. Run the program from the command line:

    ```bash
    dotnet run
    ```
  
    The output now shows all .json files in each of the store ID directories:

    ```output
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

If you got stuck at any point in this exercise, here's the completed code. Remove everything in *Program.cs* and replace it with this solution:

```csharp
var currentDirectory = Directory.GetCurrentDirectory();
var storesDirectory = Path.Combine(currentDirectory, "stores");

var salesFiles = FindFiles(storesDirectory);
    
foreach (var file in salesFiles)
{
    Console.WriteLine(file);
}

IEnumerable<string> FindFiles(string folderName)
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
```
