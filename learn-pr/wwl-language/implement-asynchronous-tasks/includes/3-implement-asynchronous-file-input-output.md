File input and output operations are essential for many applications, allowing them to read from and write to files on the hard drive. In C#, file input and output (file I/O) can be performed synchronously or asynchronously. Asynchronous file I/O is particularly useful for improving application performance and responsiveness, especially in scenarios where file operations may take a significant amount of time, such as reading large files or writing data to the hard drive.

## Creating async methods for reading and writing files

The `async` and `await` keywords in C# allow you to create asynchronous methods that can perform file I/O operations without blocking the main thread. This is particularly useful in applications with a user interface, where blocking the main thread can lead to a frozen or unresponsive UI. The `System.IO` and `System.Text.Json` namespaces provide classes and methods for performing file I/O operations asynchronously.

For example, the `File` class in the `System.IO` namespace provides methods for reading and writing files asynchronously. The `File.ReadAllTextAsync` method reads the contents of a file asynchronously, while the `File.WriteAllTextAsync` method writes text to a file asynchronously. These methods return a `Task<string>` or `Task` that represents the asynchronous operation, allowing you to use the `await` keyword to wait for their completion without blocking the calling thread.

In the `System.Text.Json` namespace, the `JsonSerializer` class provides asynchronous methods for serializing and deserializing JSON data. The `JsonSerializer.SerializeAsync` method serializes an object to a JSON string asynchronously, while the `JsonSerializer.DeserializeAsync` method deserializes a JSON string to an object asynchronously. These methods also return a `Task` that represents the asynchronous operation.

The following code sample demonstrates how to create asynchronous methods that serialize a C# object, write the JSON string to a file, read the file contents into a string, and deserialize the JSON string back into a C# object:

```csharp

using System;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;

public class Account
{
    public string Name { get; set; }
    public decimal Balance { get; set; }
}

public class Program
{
    public static async Task Main()
    {
        // Combine a directory and file name, then create the directory if it doesn't exist
        string directoryPath = @"C:\TempDir";
        if (!Directory.Exists(directoryPath))
        {
            Directory.CreateDirectory(directoryPath);
        }

        string fileName = "account.json";
        string filePath = Path.Combine(directoryPath, fileName);

        Account account = new Account { Name = "Elize Harmsen", Balance = 1000.00m };

        // Save account data to a file asynchronously
        await SaveAccountDataAsync(filePath, account);

        // Load account data from the file asynchronously
        Account loadedAccount = await LoadAccountDataAsync(filePath);
        Console.WriteLine($"Name: {loadedAccount.Name}, Balance: {loadedAccount.Balance}");
    }

    public static async Task SaveAccountDataAsync(string filePath, Account account)
    {
        string jsonString = JsonSerializer.Serialize(account);
        await File.WriteAllTextAsync(filePath, jsonString);
    }

    public static async Task<Account> LoadAccountDataAsync(string filePath)
    {
        string jsonString = await File.ReadAllTextAsync(filePath);
        return JsonSerializer.Deserialize<Account>(jsonString);
    }
}

```

In this example, the `SaveAccountDataAsync` method serializes an `Account` object to a JSON string and writes it to a file asynchronously. The `LoadAccountDataAsync` method reads the JSON string from the file and deserializes it back into an `Account` object asynchronously. The `Main` method demonstrates how to call these asynchronous methods using the `await` keyword.

This allows the application to perform file I/O operations without blocking the main thread, improving performance and responsiveness. The `Directory.CreateDirectory` method is used to create the directory if it does not exist, ensuring that the file can be written successfully.

## Summary

In this unit, you learned how to implement asynchronous file input and output operations in C#. You explored the use of the `async` and `await` keywords to create asynchronous methods for reading and writing files. By using these techniques, you can improve the performance and responsiveness of your applications when performing file I/O operations.

Key Points:

- File input and output operations can be performed synchronously or asynchronously in C#.
- Asynchronous file I/O improves application performance and responsiveness.
- The `async` and `await` keywords are used to create asynchronous methods for file I/O operations.
- The `System.IO` and `System.Text.Json` namespaces provide classes and methods for performing file I/O operations asynchronously.
- The `File` class and the `JsonSerializer` class are used in the provided example to demonstrate asynchronous file I/O operations.
