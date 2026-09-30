Writing to a file lets your program save results, keep logs, or persist data between runs. C# offers a few ways to put data into a file, split mainly between **overwriting** and **appending**.

## Writing to a file with File.WriteAllText()

`File.WriteAllText()` creates a new file, or completely overwrites an existing file with the same name.

```csharp
File.WriteAllText("greeting.txt", "Hello, world!\n");
```

> [!WARNING]
> File.WriteAllText() erases the file's existing content the moment it's called. Only use it when you're sure you want to replace the file's contents.

## Appending to a file with File.AppendAllText()

`File.AppendAllText()` adds to the **end** of the file, keeping anything that's already there. If the file doesn't exist yet, C# creates it.

```csharp
File.AppendAllText("log.txt", "New entry added.\n");
```

Appending is a good fit for log files, notes, and any data you want to build up over time.

## Writing multiple lines with StreamWriter

For more control, like writing many lines without building one giant string first, use a `StreamWriter` with `using`. Its constructor takes an optional second parameter that sets append mode.

```csharp
string[] tasks = { "Buy groceries", "Walk the dog", "Finish homework" };

using StreamWriter writer = new StreamWriter("tasks.txt", append: false);

foreach (string task in tasks)
{
    writer.WriteLine(task);
}
```

`.WriteLine()` adds a newline after each entry automatically, unlike `.Write()`.

## Choosing between write and append

| Use write when... | Use append when... |
|---|---|
| You want to start fresh each time | You want to keep the existing content |
| You're saving the final result of a process | You're recording new events or entries |
| Overwriting is intentional | Preserving history matters |
