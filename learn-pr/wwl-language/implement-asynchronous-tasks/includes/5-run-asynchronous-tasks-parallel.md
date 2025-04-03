Parallel programming is a powerful technique that allows you to execute multiple tasks simultaneously, improving the performance and responsiveness of your applications.

In C#, you can use the Task Parallel Library (TPL) to simplify the process of writing parallel code. The TPL is a set of public types and APIs in the `System.Threading` and `System.Threading.Tasks` namespaces. The purpose of the TPL is to make developers more productive by simplifying the process of adding parallelism and concurrency to applications. The TPL dynamically scales the degree of concurrency to use all the available processors most efficiently. In addition, the TPL handles the partitioning of the work, the scheduling of threads on the ThreadPool, cancellation support, state management, and other low-level details. By using TPL, you can maximize the performance of your code while focusing on the work that your program is designed to accomplish.

The TPL provides support in the following areas:

- Data parallelism: The TPL provides methods for performing data parallelism, allowing you to perform the same operation on multiple data elements simultaneously. This is particularly useful when you have large datasets and want to perform computations or transformations on each element independently.
- Task-based asynchronous programming: The TPL provides the `Task` class, which represents an asynchronous operation. You can use the `async` and `await` keywords to simplify the process of writing asynchronous code. This allows you to write code that is easier to read and maintain while still taking advantage of parallelism.
- Dataflow: The TPL provides a dataflow programming model that allows you to create complex data processing pipelines. This model is based on the concept of "blocks" that can process data asynchronously and communicate with each other using messages.

> [!IMPORTANT]
> Parallel programming and multithreading are advanced topics that require a good understanding of concurrency and synchronization. Although the TPL simplifies multithreaded scenarios, we recommend that you have a basic understanding of threading concepts, for example, locks, deadlocks, and race conditions, so that you can use the TPL effectively. This training provides a limited introduction to parallel programming using the TPL.

## Data parallelism

Data parallelism is a form of parallel programming that focuses on performing the same operation on multiple data elements simultaneously. This is particularly useful when you have large datasets and want to perform computations or transformations on each element independently. In C#, you can use the `Parallel.For` and `Parallel.ForEach` methods to achieve data parallelism easily. These methods allow you to iterate over collections or ranges of data in parallel, distributing the workload across multiple threads.

The Task Parallel Library supports data parallelism through the `System.Threading.Tasks.Parallel` class. This class provides method-based parallel implementations of `for` and `foreach` loops. You write the loop logic for a `Parallel.For` or `Parallel.ForEach` loop much as you would write a sequential loop. The TPL handles all the low-level work for you,

The following code example shows a simple foreach loop and its parallel equivalent.

```csharp

// Sequential version
foreach (var item in sourceCollection)
{
    Process(item);
}

// Parallel equivalent
Parallel.ForEach(sourceCollection, item => Process(item));

```

The TPL also provides a set of data structures that are optimized for concurrent access, such as `ConcurrentBag`, `ConcurrentQueue`, and `ConcurrentDictionary`. These data structures allow you to safely add, remove, and access elements from multiple threads without the need for explicit locking.

The following code example demonstrates how to use a `ConcurrentBag` to store results from multiple tasks running in parallel:

```csharp

using System;
using System.Collections.Concurrent;
using System.Threading.Tasks;

class Program
{
    static void Main()
    {
        var results = new ConcurrentBag<int>();
        Parallel.For(0, 100, i =>
        {
            // Simulate some work
            Task.Delay(100).Wait();
            results.Add(i);
        });

        Console.WriteLine($"Processed {results.Count} items in parallel.");
    }
}

```

In this example, the `ConcurrentBag` is used to store the results of the parallel processing. Each task adds its result to the bag without needing explicit locks, ensuring thread safety.

## Use `Task.WhenAll` and `Task.WhenAny` for running tasks in parallel

The `Task.WhenAll` and `Task.WhenAny` methods are part of the Task Parallel Library in C#. These methods allow you to run multiple tasks in parallel and wait for their completion.

`Task.WhenAll` is used when you want to wait for all the tasks to complete before proceeding. It takes an array of tasks as input and returns a single task that represents the completion of all the input tasks. This is useful when you have multiple independent tasks that can be executed concurrently, such as making multiple API calls or processing multiple files at the same time.

`Task.WhenAny` is used when you want to wait for any of the tasks to complete. It takes an array of tasks as input and returns a task that represents the first task that completes. This is useful when you want to perform some action as soon as any of the tasks finish, without waiting for all of them to complete.

The following code example demonstrates how to use `Task.WhenAll` to run multiple tasks in parallel and wait for their completion:

```csharp

using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Collections.Generic;

class Program
{
    static async Task Main(string[] args)
    {
        var urls = new List<string>
        {
            "https://example.com",
            "https://example.org",
            "https://example.net"
        };

        var tasks = new List<Task<string>>();

        foreach (var url in urls)
        {
            tasks.Add(FetchDataAsync(url));
        }

        // Wait for all tasks to complete
        var results = await Task.WhenAll(tasks);

        foreach (var result in results)
        {
            Console.WriteLine(result);
        }
    }

    static async Task<string> FetchDataAsync(string url)
    {
        using (var client = new HttpClient())
        {
            return await client.GetStringAsync(url);
        }
    }
}

```

In this example, the `FetchDataAsync` method fetches data from multiple URLs in parallel using `Task.WhenAll`. The results are printed to the console once all tasks have completed.

## Performing multiple file I/O operations concurrently

In many cases, file iteration is an operation that can be easily parallelized.

The following example iterates the directories sequentially, but processes the files in parallel. This is probably the best approach when you have a large file-to-directory ratio. It's also possible to parallelize the directory iteration, and access each file sequentially. It's probably not efficient to parallelize both loops unless you're specifically targeting a machine with a large number of processors. However, as in all cases, you should test your application thoroughly to determine the best approach.

```csharp

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Security;
using System.Threading;
using System.Threading.Tasks;

class Program
{
    static void Main()
    {
        try
        {
            TraverseTreeParallelForEach(@"C:\Program Files", (f) =>
            {
                // Exceptions are no-ops.
                try
                {
                    // Do nothing with the data except read it.
                    byte[] data = File.ReadAllBytes(f);
                }
                catch (FileNotFoundException) { }
                catch (IOException) { }
                catch (UnauthorizedAccessException) { }
                catch (SecurityException) { }
                // Display the filename.
                Console.WriteLine(f);
            });
        }
        catch (ArgumentException)
        {
            Console.WriteLine(@"The directory 'C:\Program Files' does not exist.");
        }

        // Keep the console window open.
        Console.ReadKey();
    }

    public static void TraverseTreeParallelForEach(string root, Action<string> action)
    {
        //Count of files traversed and timer for diagnostic output
        int fileCount = 0;
        var sw = Stopwatch.StartNew();

        // Determine whether to parallelize file processing on each folder based on processor count.
        int procCount = Environment.ProcessorCount;

        // Data structure to hold names of subfolders to be examined for files.
        Stack<string> dirs = new Stack<string>();

        if (!Directory.Exists(root))
        {
            throw new ArgumentException(
                "The given root directory doesn't exist.", nameof(root));
        }
        dirs.Push(root);

        while (dirs.Count > 0)
        {
            string currentDir = dirs.Pop();
            string[] subDirs = { };
            string[] files = { };

            try
            {
                subDirs = Directory.GetDirectories(currentDir);
            }
            // Thrown if we do not have discovery permission on the directory.
            catch (UnauthorizedAccessException e)
            {
                Console.WriteLine(e.Message);
                continue;
            }
            // Thrown if another process has deleted the directory after we retrieved its name.
            catch (DirectoryNotFoundException e)
            {
                Console.WriteLine(e.Message);
                continue;
            }

            try
            {
                files = Directory.GetFiles(currentDir);
            }
            catch (UnauthorizedAccessException e)
            {
                Console.WriteLine(e.Message);
                continue;
            }
            catch (DirectoryNotFoundException e)
            {
                Console.WriteLine(e.Message);
                continue;
            }
            catch (IOException e)
            {
                Console.WriteLine(e.Message);
                continue;
            }

            // Execute in parallel if there are enough files in the directory.
            // Otherwise, execute sequentially.Files are opened and processed
            // synchronously but this could be modified to perform async I/O.
            try
            {
                if (files.Length < procCount)
                {
                    foreach (var file in files)
                    {
                        action(file);
                        fileCount++;
                    }
                }
                else
                {
                    Parallel.ForEach(files, () => 0,
                        (file, loopState, localCount) =>
                        {
                            action(file);
                            return (int)++localCount;
                        },
                        (c) =>
                        {
                            Interlocked.Add(ref fileCount, c);
                        });
                }
            }
            catch (AggregateException ae)
            {
                ae.Handle((ex) =>
                {
                    if (ex is UnauthorizedAccessException)
                    {
                        // Here we just output a message and go on.
                        Console.WriteLine(ex.Message);
                        return true;
                    }
                    // Handle other exceptions here if necessary...

                    return false;
                });
            }

            // Push the subdirectories onto the stack for traversal.
            // This could also be done before handing the files.
            foreach (string str in subDirs)
                dirs.Push(str);
        }

        // For diagnostic purposes.
        Console.WriteLine($"Processed {fileCount} files in {sw.ElapsedMilliseconds} milliseconds");
    }
}

```

In this example, the file I/O is performed synchronously. When dealing with large files or slow network connections, it might be preferable to access the files asynchronously. You can combine asynchronous I/O techniques with parallel iteration.

The example uses the local fileCount variable to maintain a count of the total number of files processed. Because the variable might be accessed concurrently by multiple tasks, access is synchronized by calling the `Interlocked.Add` method.

Note that if an exception is thrown on the main thread, the threads that are started by the ForEach method might continue to run. To stop these threads, you can set a Boolean variable in your exception handlers, and check its value on each iteration of the parallel loop. If the value indicates that an exception has been thrown, use the ParallelLoopState variable to stop or break from the loop.

## Summary

This unit focused on parallelism and the Task Parallel Library (TPL). It covers how to run asynchronous tasks in parallel using the `Task.WhenAll` method, data parallelism with `Parallel.For` and `Parallel.ForEach` methods, and the use of concurrent data structures like `ConcurrentBag`, `ConcurrentQueue`, and `ConcurrentDictionary`. The content also demonstrates how to perform multiple file I/O operations concurrently.

Key Points:

- Parallel programming in C# allows executing multiple tasks simultaneously.
- The `Task` class, `async` and `await` keywords are used for implementing parallel programming.
- `Task.WhenAll` method is used to wait for multiple tasks to complete before proceeding.
- Data parallelism is achieved using `Parallel.For` and `Parallel.ForEach` methods.
- Concurrent data structures like `ConcurrentBag`, `ConcurrentQueue`, and `ConcurrentDictionary` are optimized for concurrent access.
- `Task.WhenAll` and `Task.WhenAny` methods allow running multiple tasks in parallel and waiting for their completion.
- Multiple file I/O operations can be performed concurrently.
