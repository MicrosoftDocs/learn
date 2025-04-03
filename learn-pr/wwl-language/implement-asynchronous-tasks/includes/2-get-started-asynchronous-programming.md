Developers use asynchronous programming techniques to avoid performance bottlenecks and enhance the overall responsiveness of their applications. However, traditional techniques for writing asynchronous applications can be complicated, making them difficult to write, debug, and maintain.

C# supports a simplified async programming approach that leverages asynchronous support in the .NET runtime. The compiler does the difficult work that the developer used to do, and your application retains a logical structure that resembles synchronous code. As a result, you get all the advantages of asynchronous programming with a fraction of the effort.

Understanding how asynchronous processes work in the real world can help you understand how to use async programming in your applications.

## Examine an asynchronous process in the real world

Making breakfast is a good example of a process that benefits from performing tasks asynchronously. You can think of making breakfast as a series of tasks that can be performed either synchronously or asynchronously.

1. Get the breakfast ingredients from the pantry.
1. Pour a cup of coffee.
1. Heat a pan, then fry three slices of bacon.
1. Fry two eggs.
1. Toast two pieces of bread.
1. Spread butter and jam on the toast.
1. Pour a glass of orange juice.

If you have experience with cooking, you might complete these instructions asynchronously. You start the pan warming for the bacon and eggs, then get the ingredients from the pantry. You put the bread in the toaster, then start cooking the bacon. At each step of the process, you start a task, and then transition to other tasks that are ready for your attention.

Cooking breakfast is a good example of asynchronous work that isn't parallel. One person (or thread) can handle all the tasks. One person can make breakfast asynchronously by starting the next task before the previous task completes. Each cooking task progresses regardless of whether someone is actively watching the process. As soon as you start warming the pan, you can get ingredients from the pantry. After the bacon starts to cook, you can put the bread in the toaster.

For a parallel algorithm, you need multiple people who cook (or multiple threads). One person cooks the eggs, another fries the bacon, and so on. Each person focuses on their one specific task. Each person who is cooking (or each thread) is blocked synchronously waiting for the current task to complete: Bacon ready to flip, bread ready to pop up in toaster, and so on.

By using async programming techniques, you can improve the efficiency and responsiveness of your application, just like how you can make breakfast more efficiently by performing multiple tasks at once.

## Async improves responsiveness

Asynchrony is essential for activities that are potentially blocking, such as web access. Access to a web resource sometimes is slow or delayed. If such an activity is blocked in a synchronous process, the entire application must wait. In an asynchronous process, the application can continue with other work that doesn't depend on the web resource until the potentially blocking task finishes.

The following table shows typical areas where asynchronous programming improves responsiveness. The listed APIs from .NET and the Windows Runtime contain methods that support async programming.

| Application Area   | .NET Types with Async Methods       | Windows Runtime Types with Async Methods |
|--------------------|-------------------------------------|------------------------------------------|
| Web access         | HttpClient                         | Windows.Web.Http.HttpClient, SyndicationClient |
| Working with files | JsonSerializer, StreamReader, StreamWriter, etc. | StorageFile                              |
| Working with images|                                     | MediaCapture, BitmapEncoder, BitmapDecoder |
| WCF programming    | Synchronous and Asynchronous Operations |                                          |

## How to create and call asynchronous methods

In C#, asynchronous operations implemented using the `async` and `await` keywords. The `async` keyword is used to define an asynchronous method, while the `await` keyword is used to call an asynchronous method and wait for its result without blocking the calling thread. The asynchronous operations are typically implemented using the `Task` or `Task<T>` types, which represent an ongoing operation that can be awaited.

Here's a simple example of how to create and call an asynchronous tasks in C#:

```csharp

using System;
using System.IO;
using System.Threading.Tasks;

public class Program
{
    public static async Task Main()
    {
        string filePath = "example.txt";
        string content = await ReadFileAsync(filePath);
        Console.WriteLine(content);
    }

    public static async Task<string> ReadFileAsync(string filePath)
    {
        using (StreamReader reader = new StreamReader(filePath))
        {
            string content = await reader.ReadToEndAsync();
            return content;
        }
    }
}

```

In this example, the `ReadFileAsync` method is defined using the `async` keyword and has a return type of `Task<string>`. The `async` keyword indicates that the method contains asynchronous operations, and the return type of `Task<string>` indicates that the method returns a task that represents the asynchronous operation. The `Task<string>` type is a generic task that represents an asynchronous operation that returns a string value. The `ReadFileAsync` method takes a file path as a parameter and reads the contents of the file asynchronously.

The `Main` method is also defined as asynchronous, allowing it to call the `ReadFileAsync` method using the `await` keyword. The `await` keyword is used to indicate that the program should wait for the result of the asynchronous operation before continuing. In this case, the program waits for the file to be read before printing its contents to the console.

## Summary

In this unit, you learned about the benefits of asynchronous programming and how it can improve the responsiveness of your applications. You also learned how to create and call asynchronous methods using the `async` and `await` keywords in C#. By using these techniques, you can write more efficient and responsive applications that can handle potentially blocking operations without freezing the user interface or blocking other tasks.

Key Points:

- Asynchronous programming enhances application performance and responsiveness.
- C# provides a simplified approach to async programming.
- Async programming is beneficial in potentially blocking activities like web access.
- In C#, asynchronous methods are created using the `async` keyword and called using the `await` keyword.
- The `Task` or `Task<T>` types represent ongoing operations that can be awaited in C#.
