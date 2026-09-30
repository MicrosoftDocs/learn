To work with a file in C#, you first need to **open** it. Opening a file gives you a stream object, like a `StreamReader` or `StreamWriter`, that you read from or write to. When you're finished, you need to **close** the file so the operating system can release its resources and any pending writes are saved.

## The problem with forgetting to close a file

You can open a file with a `StreamReader` and close it with `.Close()`.

```csharp
StreamReader reader = new StreamReader("notes.txt");
string contents = reader.ReadToEnd();
Console.WriteLine(contents);
reader.Close();
```

The problem is that if an error happens after opening the file but before closing it, the file stays open, which can lead to lost data, locked files, or resource leaks.

## Using the using statement

The safer way to work with files in C# is the `using` statement. It automatically closes the file when the block finishes, even if an error occurs.

```csharp
using (StreamReader reader = new StreamReader("notes.txt"))
{
    string contents = reader.ReadToEnd();
    Console.WriteLine(contents);
} // File is automatically closed here
```

Modern C# also supports a shorter **using declaration** that closes the file at the end of the enclosing scope, without needing its own braces.

```csharp
using StreamReader reader = new StreamReader("notes.txt");
string contents = reader.ReadToEnd();
Console.WriteLine(contents);
// File is automatically closed at the end of this block
```

## The File class: an even simpler option

For many common tasks, the `File` class provides static methods that open, read or write, and close a file in a single call, without you needing an explicit `using` statement at all.

```csharp
string contents = File.ReadAllText("notes.txt");
Console.WriteLine(contents);
```

> [!NOTE]
> Behind the scenes, File.ReadAllText() still opens and closes the file safely. Reach for these File methods for straightforward reads and writes, and use StreamReader or StreamWriter with using when you need more control, like reading line by line.

## A safer default

Whichever approach you choose, avoid calling `.Close()` yourself. Use `using`, or a `File` method that handles it for you.
