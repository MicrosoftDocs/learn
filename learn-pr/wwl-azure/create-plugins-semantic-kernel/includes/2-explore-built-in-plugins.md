Plugins are one of the core components of the Semantic Kernel SDK. A plugin defines the task for the kernel to perform as it interfaces with the large language model (LLM). Plugins can be composed of native code and prompts to the LLM. The Semantic Kernel SDK also offers some built-in plugins for common tasks that are ready for use in your applications.

## What is a plugin?

In the Semantic Kernel SDK, a plugin is a class that contains functions that can be run by the kernel. A plugin function can be made from a semantic prompt or native function code. To use a plugin, you add it to the kernel and then call the desired function using the `InvokeAsync` method. The kernel accesses the plugin, locates and runs the function, then returns the result. Let's take a look at some predefined plugins.

## Built-in plugins

The Semantic Kernel SDK offers an extra package with predefined plugins for common tasks. These are available in the `Plugins.Core` package that you can install with NuGet: `dotnet add package Microsoft.SemanticKernel.Plugins.Core --version 1.2.0-alpha` The package includes the following plugins:

- `ConversationSummaryPlugin` - Summarizes conversation
- `FileIOPlugin` - Reads and writes to the filesystem
- `HttpPlugin` - Makes requests to HTTP endpoints
- `MathPlugin` - Performs mathematical operations
- `TextPlugin` - Performs text manipulation
- `TimePlugin` - Gets time and date information
- `WaitPlugin` - Pauses execution for a specified amount of time

To use a core plugin, you can add it to your kernel builder using the `AddFromType` method. For example, to add the `TimePlugin` to your kernel, you can use the following code:

```c#
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Plugins.Core;
    
var builder = Kernel.CreateBuilder();
builder.AddAzureOpenAIChatCompletion(
    "your-deployment-name",
    "your-endpoint",
    "your-api-key",
    "deployment-model");
builder.Plugins.AddFromType<TimePlugin>();
var kernel = builder.Build();
var currentDay = await kernel.InvokeAsync("TimePlugin", "DayOfWeek");
Console.WriteLine(currentDay);
```

This code adds the `TimePlugin` to the kernel and then calls the `DayOfWeek` function to get the current day of the week. The output is the current day of the week.

These readily available plugins can be used to quickly add functionality to your project. In the next exercise, you'll learn how the `ConversationSummaryPlugin` can be used to get a summary of a conversation, or the action items from a block of text.