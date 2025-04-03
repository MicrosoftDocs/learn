The `FileStream` class is part of the System.IO namespace and is used for file input and output operations. The `FileStream` class allows you to work with files in a more granular way compared to higher-level abstractions like `StreamReader` and `StreamWriter`.

To create a `FileStream` object, you typically specify the file path, the mode in which to open the file (e.g., `FileMode.Open`, `FileMode.Create`), and the access level (e.g., `FileAccess.Read`, `FileAccess.Write`). The `FileStream` class provides methods for reading and writing bytes to and from files, as well as properties for controlling file access.

## Examine FileStream properties and methods

The `FileStream` class provides several properties and methods that allow you to control file access and perform read/write operations. Below are some of the key properties and methods of the `FileStream` class:

The `FileStream` class includes the following key properties:

- Length: Gets the length in bytes of the stream.
- Position: Gets or sets the current position within the stream.
- CanRead: Indicates whether the stream supports reading. This property returns `true` if the stream can be read from, and `false` otherwise.
- CanWrite: Indicates whether the stream supports writing. This property returns `true` if the stream can be written to, and `false` otherwise.
- CanSeek: Indicates whether the stream supports seeking. This property returns `true` if the stream supports seeking, and `false` otherwise.

> [!NOTE]
> Disk files always support random access. The `CanSeek` property value is set to `true` or `false` depending on the underlying file type.

The `FileStream` class includes the following key methods:

- Read: Reads a block of bytes from the stream and writes the data to a buffer. For example, `fs.Read(buffer, 0, buffer.Length)` reads data into the buffer.
- Write: Writes a block of bytes to the stream using data from a buffer. For example, `fs.Write(data, 0, data.Length)` writes data from the data array to the file.
- Seek: Sets the position within the current stream. For example, `fs.Seek(0, SeekOrigin.Begin)` moves the position to the beginning of the file.
- Flush: Clears all buffers for the current stream and causes any buffered data to be written to the file.
- Close: Closes the current stream and releases any resources associated with it.
- Dispose: Releases the resources used by the `FileStream` object. This method is called automatically when the `FileStream` object is disposed of, either directly or indirectly.

> [!IMPORTANT]
> When finished using the FileStream type, dispose of it either directly or indirectly. Use the `Dispose` method in a `try`/`catch` block or a language construct like `using` in C#.

## Examine file read and write operations using the FileStream class

The `FileStream` class in .NET allows you to read from, write to, open, and close files on a file system. You can perform synchronous operations using methods like `Read`, `Write`, `CopyTo`, and `Flush`. For resource-intensive file operations, use asynchronous methods such as `ReadAsync`, `WriteAsync`, `CopyToAsync`, and `FlushAsync` to avoid blocking the main thread.

- Use synchronous methods for simple file operations.
- Use asynchronous methods for performance-critical applications.

> [!NOTE]
> Asynchronous operations are covered in a separate training module.

Here's a simple example of how to use `FileStream` to write data to a file:

```csharp
using System;
using System.IO;

class Program
{
    static void Main()
    {
        string path = "example.txt";
        byte[] data = System.Text.Encoding.UTF8.GetBytes("Hello, FileStream!");

        using (FileStream fs = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write))
        {
            fs.Write(data, 0, data.Length);
        }

        Console.WriteLine("Data written to file.");
    }
}
```

In this example, we create a `FileStream` object to write data to a file named "example.txt". The `FileMode.OpenOrCreate` option opens the file if it exists or creates a new file if it doesn't. The `FileAccess.Write` option specifies that we want to write to the file. The `Write` method is then used to write the byte array to the file.

Here's how you can read data from a file using `FileStream`:

```csharp
using System;
using System.IO;

class Program
{
    static void Main()
    {
        string path = "example.txt";
        byte[] buffer = new byte[1024]; // Adjust buffer size as needed

        using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read))
        {
            int bytesRead = fs.Read(buffer, 0, buffer.Length);
            string readData = System.Text.Encoding.UTF8.GetString(buffer, 0, bytesRead);
            Console.WriteLine("Data read from file: " + readData);
        }
    }
}
```

In this example, we create a `FileStream` object to read data from the file "example.txt". The `FileMode.Open` option opens the file for reading, and the `FileAccess.Read` option specifies that we want to read from the file. The `Read` method is then used to read data into a buffer, which is subsequently converted back to a string.

The `FileStream` class also allows you to seek to a specific position in the file. The `Seek` method is used to set the current position within the stream. For example, you can use `fs.Seek(0, SeekOrigin.Begin)` to move the position to the beginning of the file.

Here's a more comprehensive coding example that demonstrates reading, writing, and seeking within a file:

```csharp

using System;
using System.IO;
using System.Threading.Tasks;

class Program
{
    static Task Main()
    {
        string path = "example.txt";
        byte[] data = System.Text.Encoding.UTF8.GetBytes("Hello, FileStream!");

        // Writing to the file
        using (FileStream fs = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write))
        {
            fs.Write(data, 0, data.Length);
            fs.Flush();
        }

        // Reading from the file
        using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read))
        {
            byte[] buffer = new byte[data.Length];
            fs.Seek(0, SeekOrigin.Begin);
            int bytesRead = fs.Read(buffer, 0, buffer.Length);
            string readData = System.Text.Encoding.UTF8.GetString(buffer, 0, bytesRead);
            Console.WriteLine("Data read from file: " + readData);
        }
    }
}

```

In this example, we use `FileStream` to write data to a file and then read the data back. We also demonstrate the use of the `Seek` method to move the position within the file. By understanding these properties and methods, you can effectively control file operations using `FileStream` in C#.

## Implement file access control using FileStream properties

The `FileStream` class provides additional properties to control file access. These properties include:

- `CanRead`: Indicates whether the stream supports reading. This property returns `true` if the stream can be read from, and `false` otherwise.
- `CanWrite`: Indicates whether the stream supports writing. This property returns `true` if the stream can be written to, and `false` otherwise.
- `CanSeek`: Indicates whether the stream supports seeking. This property returns `true` if the stream supports seeking, and `false` otherwise.
- `FileAccess`: Specifies the access level for the file. It can be set to `Read`, `Write`, or `ReadWrite`.
- `FileShare`: Specifies the level of access other threads have to the file. It can be set to `None`, `Read`, `Write`, or `ReadWrite`.
- `FileMode`: Specifies how the operating system should open a file. It can be set to `Append`, `Create`, `CreateNew`, `Open`, `OpenOrCreate`, or `Truncate`.
- `FileOptions`: Specifies options for opening the file. It can be set to `None`, `Asynchronous`, `SequentialScan`, `RandomAccess`, or `WriteThrough`.

Here's an example of how to implement access control using `FileStream` properties:

```csharp
using System;
using System.IO;
using System.Threading.Tasks;
class Program
{
    static Task Main()
    {
        string path = "example.txt";
        byte[] data = System.Text.Encoding.UTF8.GetBytes("Hello, FileStream!");

        // Writing to the file
        using (FileStream fs = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write, FileShare.None, 4096, false))
        {
            fs.Write(data, 0, data.Length);
            fs.Flush();
        }
        {
            await fs.Write(data, 0, data.Length);
            await fs.Flush();
        }

        // Reading from the file
        using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.None, 4096, false))
        {
            byte[] buffer = new byte[data.Length];
            fs.Seek(0, SeekOrigin.Begin);
            int bytesRead = await fs.Read(buffer, 0, buffer.Length);
            string readData = System.Text.Encoding.UTF8.GetString(buffer, 0, bytesRead);
            Console.WriteLine("Data read from file: " + readData);
        }
    }
}
```

This code demonstrates the use of `FileStream` properties to control file access. The `FileAccess` property is set to `Write` when writing to the file, and `Read` when reading from it. The `FileShare` property is set to `None`, which means that no other threads can access the file while it is being used.

## Demonstrate error handling during file operations

Error handling is crucial during file operations to manage exceptions that may occur. The `FileStream` class performs checks on methods that access the cached buffer to ensure the operating system's handle position matches the cached position used by the `FileStream` object.

If an unexpected change in the handle position is detected:

- During a `Read` operation, the buffer contents are discarded, and the stream is read from the file again.
- During a `Write` operation, the buffer contents are discarded, and an `IOException` exception is thrown.

> [!NOTE]
> A `FileStream` object will not have an exclusive hold on its handle when the `SafeFileHandle` property is accessed or given in its constructor.

Here's an example of how to implement error handling during file operations:

```csharp
using System;
using System.IO;
using System.Threading.Tasks;
class Program
{
    static Task Main()
    {
        string path = "example.txt";
        byte[] data = System.Text.Encoding.UTF8.GetBytes("Hello, FileStream!");

        try
        {
            // Writing to the file
            using (FileStream fs = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write))
            {
                fs.Write(data, 0, data.Length);
                fs.Flush();
            }

            // Reading from the file
            using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                byte[] buffer = new byte[data.Length];
                fs.Seek(0, SeekOrigin.Begin);
                int bytesRead = fs.Read(buffer, 0, buffer.Length);
                string readData = System.Text.Encoding.UTF8.GetString(buffer, 0, bytesRead);
                Console.WriteLine("Data read from file: " + readData);
            }
        }
        catch (IOException ex)
        {
            Console.WriteLine("An error occurred: " + ex.Message);
        }
    }
}
```

In this example, we use a `try`/`catch` block to handle any `IOException` exceptions that may occur during file operations. If an error occurs, the exception message is printed to the console. This ensures that the program does not crash and provides useful information about the error. By implementing error handling, you can gracefully manage exceptions and ensure that your application remains robust and user-friendly.

## Summary

In this unit, you learned about the `FileStream` class in .NET, which provides low-level control over file input and output operations. You explored the properties and methods of the `FileStream` class, including how to read from and write to files, and how to seek specific positions within a file. You also learned how to implement file access control using `FileStream` properties, such as `FileAccess`, `FileShare`, and `FileMode`, and how to handle errors during file operations using `try`/`catch` blocks. By understanding these concepts, you can effectively manage file operations in your C# applications and ensure that they are robust and user-friendly.
