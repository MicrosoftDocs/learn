Creating and deleting new files and directories programmatically is a common requirement for line-of-business applications.

So far, you've learned how to work with files and directories by using the `Directory` class. You can also use the `Directory` class to create, delete, copy, move, and otherwise manipulate directories on a system programmatically. You can use an analogous class, `File`, to do the same on files.

Here, you'll learn how to use the `Directory` and `File` classes to create directories and files.

## Create directories

You use the `Directory.CreateDirectory` method to create directories. The following method creates a new folder called *newDir* inside the *201* folder.

```csharp
Directory.CreateDirectory(Path.Combine(Directory.GetCurrentDirectory(), "stores","201","newDir"));
```

If */stores/201* doesn't already exist, it will be created automatically. The `CreateDirectory` method won't fail. It will create any directories and subdirectories passed to it.

## Make sure directories exist

Sometimes you'll need to check if a directory already exists. For example, you might need to check before you create a file in a specified directory to avoid an exception that could cause your program to stop abruptly.

To see if a directory exists, you use the `Directory.Exists` method.

```csharp
bool doesDirectoryExists = Directory.Exists(filePath);
```

## Create files

You can create files by using the `File.WriteAllText` method. This method takes in a path to the file and the data you want to write to the file. If the file already exists, it will be overwritten.

For instance, this code creates a file called *greeting.txt* with the text "Hello World!" inside.

```csharp
File.WriteAllText(Path.Combine(Directory.GetCurrentDirectory(), "greeting.txt"), "Hello World!");
```

In the next exercise, you'll use your knowledge of how to create files and directories to extend the program to create a directory that will store the total of all sales files.
