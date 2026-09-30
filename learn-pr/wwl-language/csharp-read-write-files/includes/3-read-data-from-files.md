C# gives you several ways to read text from a file. The best choice depends on the size of the file and what you want to do with it.

## Read the entire file at once

`File.ReadAllText()` returns the entire file as a single string.

```csharp
string contents = File.ReadAllText("notes.txt");
Console.WriteLine(contents);
```

This approach works well for small files, but for very large files it loads everything into memory at once.

> [!NOTE]
> If the file doesn't exist, both File.ReadAllText() and StreamReader throw a FileNotFoundException. Be sure the file exists before you try to read it.

## Read the file as an array of lines

`File.ReadAllLines()` returns each line as a separate string in an array.

```csharp
string[] lines = File.ReadAllLines("notes.txt");

foreach (string line in lines)
{
    Console.WriteLine(line);
}
```

## Read one line at a time

The most memory-friendly way is to use a `StreamReader` and call `.ReadLine()` in a loop. It returns `null` once there are no more lines to read.

```csharp
using StreamReader reader = new StreamReader("notes.txt");
string line;

while ((line = reader.ReadLine()) != null)
{
    Console.WriteLine(line);
}
```

This pattern is recommended for large files because only one line is held in memory at a time.

## Choosing the right approach

| If you want to... | Use... |
|---|---|
| Work with the entire file as one string | File.ReadAllText() |
| Get an array of lines you can index into | File.ReadAllLines() |
| Process each line one at a time efficiently | StreamReader with ReadLine() |
