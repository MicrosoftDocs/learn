Large retailers often write data to files so that it can be processed later in batches.

Tailwind Traders has each of its stores write its sales total to a file and send that file to a central location. To use those files, the company needs to create a batch process that can work with the file system.

Here, you'll learn how to use C# and .NET to read the file system to discover files and directories.

## Include the System.IO namespace

In the .NET Framework, `System.IO` namespaces contain types to interact with files and directories. For example, you can get and set properties for files and directories, and retrieve collections of files and directories based on search criteria.

You can also use the types in the `System.IO` namespaces to read and write, both synchronously and asynchronously, data streams and files.

For now, we're going to focus on what you need to know to work with directories by using `Directory` class contained in the `System.IO` namespace.

## List all directories

One task that you'll often do with the `Directory` class is list out or *enumerate* directories. For instance, Tailwind Traders has a root folder called *stores*. In that folder are subfolders organized by store number. Inside those folders are the sales-total and inventory files. The structure looks like this:

```
📂 stores
    📄 sales.json
    📄 totals.txt
    📂 201
       📄 sales.json
       📄 inventory.txt
    📂 202
```

To read through and list the top-level directories, you can use the `Directory.EnumerateDirectories` function.

```csharp
IEnumerable<string> listOfDirectories = Directory.EnumerateDirectories("stores");

foreach (var dir in listOfDirectories) {
    Console.WriteLine(dir);
}

// Outputs:
// stores/201
// stores/202
```

## List files in a specific directory

To read all the files in a directory, you can use the `Directory.EnumerateFiles` function.

```csharp
IEnumerable<string> files = Directory.EnumerateFiles("stores");

foreach (var file in files)
{
    Console.WriteLine(file);
}

// Outputs:
// stores/totals.txt
// stores/sales.json
```


## List all content in a directory and all sub-directories

Both the `Directory.EnumerateDirectories` and `Directory.EnumerateFiles` functions have an overload that accepts a parameter to specify a search pattern files and/or directories must match and to indicate whether to recursively traverse a specified folder and all of its sub-folders.

```csharp
// Find all *.txt files in the stores folder and its sub-folders
IEnumerable<string> allFilesInAllFolders = Directory.EnumerateFiles("stores", "*.txt", SearchOptions.AllDirectories);

foreach (var file in allFilesInAllFolders)
{
    Console.WriteLine(file);
}

// Outputs:
// stores/totals.txt
// stores/201/inventory.txt
```

In the next exercise, you'll use the `Directory` class to dynamically read through Tailwind Traders' main *stores* directory to find all of the sales.json files.
