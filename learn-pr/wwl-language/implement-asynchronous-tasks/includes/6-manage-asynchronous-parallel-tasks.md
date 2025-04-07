For C# developers, the Task Parallel Library (TPL) provides an easier way to write parallel code. However, not all code is suitable for parallelization. For example, if a loop performs only a small amount of work on each iteration, or it doesn't run for many iterations, then the overhead of parallelization can cause the code to run more slowly. Furthermore, parallelization, like any multithreaded code, adds complexity to your program execution.

## Common pitfalls in data and task parallelism

In many cases, `Parallel.For` and `Parallel.ForEach` can provide significant performance improvements over ordinary sequential loops. However, the work of parallelizing the loop introduces complexity that can lead to problems that aren't as common in sequential code.

### Don't assume that parallel is always faster

In certain cases a parallel loop might run slower than its sequential equivalent. The basic rule of thumb is that parallel loops that have few iterations and fast user delegates are unlikely to speed up much. However, because many factors are involved in performance, we recommend that you always measure actual results.

### Avoid writing to shared memory locations

In sequential code, it's not uncommon to read from or write to static variables or class fields. However, whenever multiple threads are accessing such variables concurrently, there's a significant potential for race conditions. Even though you can use locks to synchronize access to the variable, the cost of synchronization can hurt performance. Therefore, we recommend that you avoid, or at least limit, access to shared state in a parallel loop as much as possible. The best way to do this is to use the overloads of `Parallel.For` and `Parallel.ForEach` that use a `System.Threading.ThreadLocal<T>` variable to store thread-local state during loop execution.

### Avoid over-parallelization

By using parallel loops, you incur the overhead costs of partitioning the source collection and synchronizing the worker threads. The benefits of parallelization are further limited by the number of processors on the computer. There's no speedup to be gained by running multiple compute-bound threads on just one processor. Therefore, you must be careful not to over-parallelize a loop.

The most common scenario in which over-parallelization can occur is in nested loops. In most cases, it's best to parallelize only the outer loop unless one or more of the following conditions apply:

- The inner loop is known to be long.
- You're performing an expensive computation on each order.
- The target system is known to have enough processors to handle the number of threads that are produced by parallelizing the processing.

In all cases, the best way to determine the optimum query shape is to test and measure.

## Exception handling in async and parallel tasks

When you use the Task Parallel Library (TPL) to run tasks, exceptions can occur in several different ways. The most common is when a task throws an exception. Throwing an exception can happen when the task is running on a thread pool thread or when it's running on the main thread. In either case, the exception is propagated back to the calling thread.

When you use the `Task.Wait` method to wait for a task to complete, any exceptions that were thrown by the task are propagated back to the calling thread. You can handle these exceptions using a try/catch block. If a task is the parent of attached child tasks, or if you're waiting on multiple tasks, multiple exceptions could be thrown. If one or more exceptions are thrown, they're wrapped in an `AggregateException` instance.

The `AggregateException` exception has an `InnerExceptions` property that can be enumerated to examine all the original exceptions that were thrown, and handle (or not handle) each one individually.

The following example demonstrates how to handle exceptions thrown by a task.

```csharp

public static partial class Program
{
    public static void Main()
    {
        HandleThree();
    }
    
    public static void HandleThree()
    {
        var task = Task.Run(
            () => throw new CustomException("This exception is expected!"));

        try
        {
            task.Wait();
        }
        catch (AggregateException ae)
        {
            foreach (var ex in ae.InnerExceptions)
            {
                // Handle the custom exception.
                if (ex is CustomException)
                {
                    Console.WriteLine(ex.Message);
                }
                // Rethrow any other exception.
                else
                {
                    throw ex;
                }
            }
        }
    }
}

// Define the CustomException class
public class CustomException : Exception
{
    public CustomException(string message) : base(message) { }
}
// The example displays the following output:
//        This exception is expected!

```

In this example, the `HandleThree` method creates a task that throws a `CustomException`. The `try/catch` block catches the `AggregateException` and iterates through the `InnerExceptions` collection. If the exception is of type `CustomException`, it prints the message to the console. If it's any other type of exception, it rethrows it.

You can also handle the original exceptions by using the `AggregateException.Handle` method. This method takes a delegate that's called for each exception in the `InnerExceptions` collection. If the delegate returns true, the exception is considered handled and is removed from the collection. If it returns false, the exception is rethrown.

The following example demonstrates how to use the `Handle` method to handle exceptions thrown by a task.

```csharp

public static partial class Program
{
    public static void HandleFour()
    {
        var task = Task.Run(
            () => throw new CustomException("This exception is expected!"));

        try
        {
            task.Wait();
        }
        catch (AggregateException ae)
        {
            ae.Handle(ex =>
            {
                // Handle the custom exception.
                if (ex is CustomException)
                {
                    Console.WriteLine(ex.Message);
                    return true;
                }
                // Rethrow any other exception.
                return false;
            });
        }
    }
}

```

In this example, the `HandleFour` method creates a task that throws a `CustomException`. The `try/catch` block catches the `AggregateException` and calls the `Handle` method. The delegate checks if the exception is of type `CustomException`. If the exception is of type `CustomException`, the delegate prints the message to the console and returns `true`. A response of `true` indicates that the exception has been handled. If the exception is any other type of exception, the delegate returns `false`, causing the exception to be rethrown.

## Summary

This unit describes situations when code isn't suitable for parallelization and discusses common pitfalls in data and task parallelism. For example, assuming parallel is always faster, writing to shared memory locations, and over-parallelization. The content also explains how to handle exceptions in async and parallel tasks, including how to use the `Task.Wait` method and the `AggregateException.Handle` method.

## Key points

- Not all code is suitable for parallelization. Testing and measuring performance is essential before parallelizing code.
- Common pitfalls in data and task parallelism include assuming parallel is always faster, writing to shared memory locations, and over-parallelization.
- Exceptions in async and parallel tasks can be handled using the `Task.Wait` method and the `AggregateException.Handle` method.
- The `AggregateException` exception has an `InnerExceptions` property that can be enumerated to examine all the original exceptions that were thrown.
